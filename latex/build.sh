#!/usr/bin/env bash
# Build a single PDF (and combined .tex) from the Markdown chapters in content/.
#
# Strategy:
#   1. Concatenate chapter markdown files in order (skipping cover, which
#      is generated separately as the title page).
#   2. Preprocess: strip HTML comments but keep the LaTeX labels they
#      contain; pandoc will pass \label{} and \autoref{} through as raw
#      LaTeX because we enable raw_tex in the input format.
#   3. Run pandoc twice: once to produce build/thesis.tex (combined
#      LaTeX source), once to produce build/thesis.pdf via xelatex.
#
# Usage:  bash latex/build.sh

set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CONTENT="$ROOT/content"
BUILD="$ROOT/build"
LATEX="$ROOT/latex"

mkdir -p "$BUILD"

# ---------------------------------------------------------------------------
# 1. Preprocess: strip the wrapping HTML comments around LaTeX labels.
#    `<!-- \label{foo} -->`  ->  `\label{foo}`
# ---------------------------------------------------------------------------
PREP="$BUILD/_combined.md"
: > "$PREP"

# Inject List of Figures and List of Tables immediately after the TOC.
# Pandoc places \tableofcontents from the template before the body; these
# raw-LaTeX lines land as the very first thing in the body, i.e. right
# after the TOC.
cat >> "$PREP" << 'HEREDOC'
\listoffigures
\listoftables
\clearpage

HEREDOC

# Order matters: abstract first, then numbered chapters.
ORDERED=(
  "00-abstract.md"
  "01-introduction.md"
  "02-state-of-the-art.md"
  "03-methodology.md"
  "04-results.md"
  "05-budget.md"
  "06-environmental-impact.md"
  "07-conclusions-future-work.md"
  "08-bibliography.md"
  "09-appendices.md"
)

for f in "${ORDERED[@]}"; do
  src="$CONTENT/$f"
  if [[ ! -f "$src" ]]; then
    echo "WARNING: $src not found, skipping" >&2
    continue
  fi
  # Strip comment wrapper around \label{...}; drop other HTML comments.
  sed -E \
      -e 's@<!--[[:space:]]*(\\label\{[^}]*\})[[:space:]]*-->@\1@g' \
      -e 's@<!--.*-->@@g' \
    "$src" >> "$PREP"
  printf '\n\n' >> "$PREP"
done

# ---------------------------------------------------------------------------
# 1b. Mark frontmatter chapter headings as unnumbered so they appear in the
#     TOC without a chapter number. Pandoc honours the {.unnumbered} class
#     on ATX headings and emits \chapter*{} + \addcontentsline{}.
# ---------------------------------------------------------------------------
sed -i -E \
  -e 's/^(# Abstract)[[:space:]]*$/\1 {.unnumbered}/' \
  -e 's/^(# Dedication)[[:space:]]*$/\1 {.unnumbered}/' \
  -e 's/^(# Acknowledgements)[[:space:]]*$/\1 {.unnumbered}/' \
  -e 's/^(# Cover Page)[[:space:]]*$/\1 {.unnumbered}/' \
  -e 's/^(# Revision History)[[:space:]]*$/\1 {.unnumbered}/' \
  -e 's/^(# [0-9]+\. Bibliography.*)[[:space:]]*$/\1 {.unnumbered}/' \
  -e 's/^(# [0-9]+\. Appendices?)[[:space:]]*$/\1 {.unnumbered}/' \
  "$PREP"

# ---------------------------------------------------------------------------
# 1c. Convert any WebP images referenced in the combined markdown into PNG
# copies under $BUILD and rewrite references to .png. xelatex/xdvipdfmx does
# not support WebP reliably, so we produce PNG fallbacks inside the build dir
# and point the markdown at them.
# ---------------------------------------------------------------------------
if grep -qE "\.webp" "$PREP"; then
  echo "==> Converting .webp images to .png for LaTeX compatibility..."
  # Collect WebP paths referenced either in Markdown (...) or LaTeX {...}
  mapfile -t webps < <( (
      grep -oP '(?<=\()([^\)]+?\.webp)(?=\))' "$PREP" || true
    ) ; (
      grep -oP '(?<=\{)([^\}]+?\.webp)(?=\})' "$PREP" || true
    ) | sort -u )

  for p in "${webps[@]:-}"; do
    # Normalize source path and destination path under $BUILD
    if [[ "$p" = /* ]]; then
      src="$p"
      rel="${p#$ROOT/}"
    else
      src="$ROOT/$p"
      rel="$p"
    fi
    dst="$BUILD/${rel%.webp}.png"
    if [[ ! -f "$src" ]]; then
      echo "WARNING: referenced image not found: $src" >&2
      continue
    fi
    mkdir -p "$(dirname "$dst")"
    if command -v convert >/dev/null 2>&1; then
      convert "$src" "$dst"
    elif command -v magick >/dev/null 2>&1; then
      magick "$src" "$dst"
    else
      # Fallback: try Python Pillow-based conversion. This will work if
      # Pillow is installed and built with WebP support.
      if python3 -c "import PIL, PIL.Image" >/dev/null 2>&1; then
        # pass src/dst as args to the inline Python converter
        python3 - "$src" "$dst" <<'PYCONV'
from PIL import Image
import sys
src = sys.argv[1]
dst = sys.argv[2]
img = Image.open(src)
img.convert('RGBA').save(dst, 'PNG')
PYCONV
      else
        echo "WARNING: ImageMagick 'convert' or 'magick' and Python Pillow not available; cannot convert $src" >&2
        continue
      fi
    fi
  done

  # Rewrite references in the combined markdown to use .png
  sed -i -E 's/\.webp/\.png/g' "$PREP"
  # If any image references are absolute (starting with the repo root), make
  # them relative so pandoc can resolve them via the build resource path.
  sed -i -E "s@${ROOT}/@@g" "$PREP"
  # For each converted WebP, rewrite only its references to point into the
  # build/ directory where the converted PNG lives. Do not rewrite other
  # existing PNG references (leave them pointing at assets/ so pandoc can
  # resolve them normally).
  for p in "${webps[@]:-}"; do
    # compute relative reference as it appears in the markdown
    rel="$p"
    rel_no_root="${rel#$ROOT/}"
    md_orig_ref="${rel_no_root%.webp}.png"
    md_new_ref="build/${rel_no_root%.webp}.png"
    # Replace occurrences of the PNG path resulting from the earlier .webp->.png
    # substitution with the build-prefixed path for this image only.
    sed -i -E "s@${md_orig_ref//@/\\@}@${md_new_ref//@/\\@}@g" "$PREP"
  done
fi

# ---------------------------------------------------------------------------
# 2. Pandoc -> combined LaTeX source (for inspection / future hand-tuning).
# ---------------------------------------------------------------------------
PANDOC_OPTS=(
  --from=markdown-yaml_metadata_block+raw_tex+pipe_tables+backtick_code_blocks+fenced_code_attributes
  --resource-path="$BUILD:$ROOT"
  --top-level-division=chapter
  --metadata=title:"ICT Network Deployment in Low Connectivity and Resource-Limited Contexts"
  --metadata=subtitle:"A reproducible, open field guide built with the AUCOOP association"
  --metadata=author:"María Jover Tarancón"
  --metadata=date:"May 2026"
  --metadata=lang:"en-GB"
  --metadata=documentclass:"report"
  --metadata=geometry:"a4paper,margin=2.5cm"
  --metadata=fontsize:"11pt"
  --metadata=colorlinks:true
  --metadata=linkcolor:"blue!50!black"
  --metadata=urlcolor:"blue!50!black"
  --metadata=toc-title:"Contents"
  --toc
  --toc-depth=3
  --include-in-header="$LATEX/pandoc-header.tex"
  --include-before-body="$LATEX/cover.tex"
  --include-before-body="$LATEX/pandoc-frontmatter.tex"
  --pdf-engine=xelatex
)

echo "==> Generating combined .tex ..."
pandoc "${PANDOC_OPTS[@]}" --standalone -o "$BUILD/thesis.tex" "$PREP"

echo "==> Generating PDF ..."
# Generate .tex, then inject a small file to switch to mainmatter after
# the TOC/LoF/LoT. Pandoc's location for the TOC is template dependent,
# but the simplest approach is to generate the PDF directly: include
# pandoc-mainmatter.tex after the TOC using --include-after-body.
pandoc "${PANDOC_OPTS[@]}" --include-after-body="$LATEX/pandoc-mainmatter.tex" -o "$BUILD/thesis.pdf" "$PREP"

echo
echo "Done."
echo "  - $BUILD/thesis.tex"
echo "  - $BUILD/thesis.pdf"
