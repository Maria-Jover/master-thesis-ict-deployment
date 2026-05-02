# Master Thesis — ICT Network Deployment in Low Connectivity and Resource-Limited Contexts

> *A reproducible, open field guide built with the AUCOOP association*

**Author:** María Jover Tarancón
**Master:** Master in Telecommunications Engineering (MET)
**University:** Universitat Politècnica de Catalunya — ETSETB
**Advisors:** Eva Vidal (Professor) · Sergio Giménez Antón (PhD candidate)
**Submission date:** Barcelona, 10 May 2026

---

## Repository layout

```
Master-Thesis/
├── content/          # Markdown source-of-truth, one file per thesis section
├── assets/           # Images, diagrams, logos
├── latex/            # LaTeX template populated from content/ (final PDF)
├── plan/             # Outline, Gantt sources, todo
├── sources/          # Pointers to the Community-Network-Handbook source material
└── .vscode/          # Editor config
```

## Workflow

1. Write/edit content in `content/*.md`.
2. Cross-reference Community-Network-Handbook chapters via `sources/handbook-mapping.md`.
3. When a section is locked, port it to `latex/` using `pandoc` (see `plan/build.md`).
4. Build the final PDF from `latex/` using `pdflatex` + `bibtex`.

## Building the LaTeX PDF

```bash
cd latex
pdflatex main.tex && bibtex main && pdflatex main.tex && pdflatex main.tex
```

## Source handbook

The companion documentation lives in [`Community-Network-Handbook`](https://github.com/aucoop/Community-Network-Handbook), branch **`dev_mj_thesis`** (a thesis snapshot merging `develop` + `docs/laptop-deployment` + `WIP-docs/ip` + `docs/planning` + `fix/open-points`).
