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
# 2. Pandoc -> combined LaTeX source (for inspection / future hand-tuning).
# ---------------------------------------------------------------------------
PANDOC_OPTS=(
  --from=markdown+raw_tex+pipe_tables+backtick_code_blocks+fenced_code_attributes+yaml_metadata_block
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
