# Master-Thesis editing rules

Be sure to read through the full /content folder to understand the context of each chapter.

## Default rules

1. **Tone & register**: match the existing prose in `content/01-introduction.md` — direct, slightly opinionated, first-person, no unnecessary preamble.
2. **Figures**: use raw LaTeX `{=latex}` blocks with `\begin{figure}[h!]` and `\includegraphics[width=0.75\textwidth]{...}` — never plain Markdown image syntax.
3. **Cross-references**: use `\autoref{}` for chapter/section refs and `§X.Y` for inline references, following the existing pattern in the thesis.
4. **Spelling**: no typos; proof-read every change before committing.
5. **No added comments**: do not add comments to the source unless explicitly requested.
6. shorten long sentences to make text more clear to the reader

## Consistency checking 

1. 12 laptops were deployed 9 for the school 3 in the childrens house
2. The aim of the thesis is to create an alive artefact to document Network deployments for communities with low resources, focused on the hardware part.

## Commits and Pull Requests
1. No direct commit to MAIN

2. Create brief summary for each commit you make describing the chantes done. When a commit is done run the script to generate the lates and PDF in /build

3. Create a description of the changes done when creating a pull request.

## Images and tables
when a new image or table is created be sure to create the reference for the index of figures and tables.

where it adds value to the explanation you may add place holder of images/tables. You may ask the user if the image on a specific place is a good fit for confirmation.

For chapter 3 methodology feel free to find images that relate to the explenation in project /home/mj/Community-Network-Handbook that is the output of the thesis. 