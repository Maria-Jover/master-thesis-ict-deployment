# Build — Markdown to LaTeX

When a Markdown section is locked, port it to LaTeX with Pandoc. The LaTeX template lives in `../latex/`.

## Per-section conversion

```bash
# from project root
pandoc content/01-introduction.md \
  -f markdown -t latex \
  --top-level-division=section \
  -o latex/_intro_body.tex
```

Then in `latex/main.tex`, replace the placeholder content with `\input{_intro_body.tex}` (or splice manually, preserving the cover/revision/abstract blocks).

## Build the PDF

```bash
cd latex
pdflatex main.tex
bibtex main
pdflatex main.tex
pdflatex main.tex
```

## One-shot script (TBD)

`scripts/build-pdf.sh` — to be written once content is stable.
