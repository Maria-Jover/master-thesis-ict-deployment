#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD="$ROOT/build/latex"
LATEXDIR="$ROOT/latex"

mkdir -p "$BUILD"


pushd "$LATEXDIR" >/dev/null

# Run xelatex several times to resolve references.
xelatex -interaction=nonstopmode -output-directory="$BUILD" main.tex
# Run bibtex from the build directory so auxiliary files are read/written
# from the same location (avoids openout_any security issues).
pushd "$BUILD" >/dev/null
bibtex main || true
popd >/dev/null

xelatex -interaction=nonstopmode -output-directory="$BUILD" main.tex
xelatex -interaction=nonstopmode -output-directory="$BUILD" main.tex

popd >/dev/null

echo "LaTeX build complete: $BUILD/main.pdf"
