# 3. Methodology / Project Development

> The bulk of the thesis. Three coordinated work-streams: **3.A** the network, **3.B** the endpoints, **3.C** the knowledge artefact. Maps to LaTeX section *Methodology / project development*.

---

## 3.A Network hardware deployment

Source: handbook chapters 2.1, 2.2, 2.3 + `3-Guide/Network-Planning`, `IP-Addressing`, `Wireless-Mesh`, `Antennas`, `Power-and-UPS`.

### 3.A.1 Site and internet assessment

Method to characterise an existing site:

- Internet assessment: ISP options, speed test, latency, reliability — see `3-Guide/Network-Planning/1-Internet-Assessment.md`.
- Site assessment: floorplan, signal-drop measurements, obstacle mapping — `2-Site-Assessment.md`.
- Expansion planning: what to deploy first, where to grow — `3-Expansion-Planning.md`.

### 3.A.2 Hardware selection

Decision criteria and the resulting recommended bill-of-materials:

- Affordability, OpenWrt support, sufficient RAM/flash, local availability.
- Concrete picks and their rationale: Cudy WR3000E (consumer mesh node), NanoPi R-series (gateway).

### 3.A.3 IP addressing plan

Why a non-default range matters; structure of a typical small-network plan; static vs. DHCP allocation; pitfalls (the IP conflict story from Namibia).

### 3.A.4 Wireless mesh design

- IEEE 802.11s with `wpad-mesh`, mesh-encrypted SAE.
- 2.4 GHz vs 5 GHz role split (clients vs backhaul).
- Static-IP mesh vs DHCP-based mesh; trade-offs.

### 3.A.5 Long-link antennas and inter-building bridges

(Outline — fill from `3-Guide/Antennas`.)

### 3.A.6 Boundary services kept in scope

Strictly the minimum to make the network usable:

- DHCP basics (server choice, lease ranges).
- DNS basics (forwarding, optional local resolution).
- Monitoring **overview** (deeper Zabbix work belongs to the companion thesis).

### 3.A.7 Power and UPS sizing

- Load inventory of a typical site (routers, PoE switch, mini-PC).
- Battery sizing for N hours of autonomy.
- Practical observations from Gochas (recurring outages).

---

## 3.B Endpoint reconditioning and mass deployment

Source: handbook chapter 2.22 + `3-Guide/Laptop-Deployment`.

### 3.B.1 The refurbished-hardware case

Economic and environmental argument; sourcing channels (corporate fleet refresh, Labdoo).

### 3.B.2 Intake, triage and cataloguing with DeviceHub

- Bootable diagnostic USB workflow.
- Asset record fields (CPU, RAM, storage, battery cycles, S/N).
- Integration of the inventory with the deployment plan (matching disks ↔ image variant).

### 3.B.3 Golden-master image — the AUCOOP Linux Mint

- Why Mint (recap from §2.5).
- Customisations: OnlyOffice, familiar launcher icons, removed bloat, generic hostname/user.
- Pre-capture cleanup checklist.

### 3.B.4 Image capture with Clonezilla

- Boot Clonezilla Live, `device-image` / `local_dev` / `savedisk` workflow.
- Compression and image directory layout.

### 3.B.5 The partition-resize problem (and fix)

The technical core of the chapter:

- Why ext4 metadata makes naive cross-disk restore fail (`target seek ERROR`).
- Fix: `e2fsck` → `resize2fs` → `parted resizepart` → recapture with `partclone`.
- Why `-k1` and `-icds` flags alone are insufficient.

### 3.B.6 PXE server architecture

Three services, one isolated subnet:

| Service | Port | Purpose |
|---|---|---|
| DHCP (`isc-dhcp-server`) | 67 | IP + boot file pointer |
| TFTP (`tftpd-hpa`) | 69 | GRUB EFI + kernel + initrd |
| NFS (`nfs-kernel-server`) | 2049 | Clonezilla rootfs + image repo |

GRUB EFI generation with `grub-mknetdir`. The `bootx64.efi` placement.

### 3.B.7 Auto-restore script and Secure Boot handling

- Disk auto-detection (`/dev/sda` vs `/dev/nvme0n1`).
- `ocs-sr` invocation with `-k1 -icds -scr -p reboot`.
- Why Secure Boot must be disabled (unsigned GRUB binary) — single biggest field-debugging cost.

### 3.B.8 Quality control and user handover

User account verification, first-boot checks, end-user training note.

---

## 3.C The AUCOOP Handbook as a knowledge artefact

The two preceding parts of this chapter (§3.A and §3.B) describe *what* was
deployed in the field. This third part describes *how the deployment knowledge
itself is preserved* so that the next student, the next volunteer, or the next
partner association does not have to start again from a blank page. It is the
most original contribution of this thesis: not a single network or a single
classroom of refurbished laptops, but a reusable instrument — the **Community
Network Handbook** — capable of producing many of them.

The handbook is hosted at <https://github.com/aucoop/Community-Network-Handbook>
and published as a static website plus a downloadable PDF. The thesis writes
*about* the handbook; the handbook itself is the durable deliverable.

### 3.C.1 Why a living handbook

§1.2 framed the problem of *knowledge volatility* in a volunteer association.
AUCOOP runs on bachelor and master students who join, contribute for one or two
academic years, graduate, and leave. Every project — Namibia 2024, Namibia
2026, the local pilots in Barcelona — produced internal documents (PDFs,
slide decks, hand-written field notes) that ended up in shared drives that
nobody opens once the contributors are gone. The next team rediscovers the
same DHCP option, the same OpenWrt mesh quirk, the same Clonezilla
`partclone target seek ERROR`, and pays the same debugging tax.

A living handbook reverses this dynamic by making three structural commitments:

1. **The artefact is the documentation, not a side-effect of it.** Contributors
   write directly into the handbook during the project, not into private notes
   that *might* be transcribed afterwards.
2. **The artefact is publicly readable.** External collaborators (NGO partners,
   future host schools, other student associations) can consult it without
   asking permission, which removes the friction that kills internal wikis.
3. **The artefact is editable through a low-ceremony, version-controlled
   workflow** (Git + Markdown + pull request), so corrections from the field
   are cheap to land.

Compared with the realistic alternatives — a Google Drive folder, a Notion
workspace, a wiki on a self-hosted server that nobody patches — the chosen
model trades convenience (no rich WYSIWYG editor) for longevity (plain text
under version control survives platform changes and credential losses).

### 3.C.2 Information architecture

The handbook is organised in four top-level chapters, each with a clear
epistemic role:

| Chapter | Role | Voice |
|---|---|---|
| `1-Introduction` | Why the handbook exists, who it is for | Editorial |
| `2-Imaginary-Use-Case` | A fictional community network, told as a story; one section per challenge | Narrative, second-person, italic question titles |
| `3-Guide` | Step-by-step recipes; one folder per technology | Instructional, imperative |
| `4-Real-Use-Cases` | Concrete deployments (Namibia, …) used as case studies | Reporting |

The defining design rule is the **1-to-1 mapping between Chapter 2 and Chapter
3**: every story section in Chapter 2 must have a matching recipe in Chapter 3,
and vice versa, with explicit cross-links in both directions. The intent is
twofold. A reader who is *learning the domain* enters through the story and
follows the link to the recipe when they want to act. A reader who is
*executing a deployment* enters through the recipe and follows the link to the
story when they need to understand the trade-offs. Neither audience is
penalised. The constraint is enforced at review time and is mechanical enough
that it can be audited (see §3.C.5).

Inside a section folder, content is co-located with its images:

```
docs/3-Guide/Laptop-Deployment/
├── index.md
├── AUCOOP-image.md
└── images/
    ├── pxe-architecture.webp
    └── clonezilla-savedisk.webp
```

Image filenames are prefixed with the owning section (`Cudy-WR3000E-luci.webp`,
`2.1-router-front-panel.webp`) so that a file moved or renamed without its
section is immediately recognisable as orphaned. All raster images use WebP at
quality 85, chosen as the smallest format that still renders well in the PDF
build.

### 3.C.3 Toolchain

The handbook is built with **Zensical**, a static-site generator that consumes
Markdown plus a `mkdocs.yml` navigation manifest and produces both the website
and the PDF. The relevant configuration choices are:

- **Theme.** Material for MkDocs in `navigation.sections` mode, with
  light/dark/system palette toggles. The teal accent matches the AUCOOP
  branding.
- **Markdown extensions.** `pymdownx.superfences` (with a Mermaid custom
  fence), `admonition`, `pymdownx.details`, `pymdownx.highlight`,
  `pymdownx.tabbed`, `pymdownx.arithmatex`, `attr_list`, `tables`,
  `md_in_html`. These cover the four expressive needs of a deployment guide:
  diagrams, side notes, code with line numbers, and tabular data.
- **Diagram pipeline.** Mermaid is rendered client-side from fenced code
  blocks, which keeps diagrams in plain text inside the source repository and
  reviewable in pull requests. PlantUML is available for the rarer cases that
  need it, served by `build_plantuml` against the public PlantUML server.
- **PDF target.** The repository's release pipeline produces a single
  `Community-Network-Handbook.pdf` artefact; the website surfaces it through
  the `extra.book_download_url` setting. Both outputs are generated from the
  same Markdown source, so there is no risk of the printable copy and the web
  copy drifting apart.

The build commands are deliberately wrapped: contributors run `zensical serve`
for local preview and `zensical build` for production, never `mkdocs` directly.
Documenting this in the project's `AGENTS.md` removes a common source of
confusion when a new contributor's local environment behaves differently from
CI.

### 3.C.4 Dual output — web and PDF

A handbook intended for low-connectivity contexts cannot be a website-only
artefact. During the Gochas deployment, the school's uplink was unusable for
hours at a time, and the team relied on the offline PDF copy carried on a
laptop. Conversely, an NGO evaluating AUCOOP from Barcelona benefits from a
searchable, linkable web version. The dual output is not a redundancy; it
serves two distinct usage modes:

- The **web** version is the canonical, evolving document. It is
  search-indexed, link-friendly, and updated on every merge to `main`.
- The **PDF** version is the *expedition copy*. It is produced as a GitHub
  release artefact, pinned to a specific commit, and intended to be downloaded
  before travelling.

Pinning the PDF to a release tag means a field team can reference *the exact
version of the handbook they took with them* months later, even if the website
has moved on. This addresses a classic reproducibility problem in deployment
documentation: the recipe that worked in March may have been silently rewritten
by July.

### 3.C.5 Contribution model and AI-assisted authoring

The handbook is written by a rotating set of contributors of unequal
experience: senior PhD students, master students writing their thesis (this
thesis among them), and bachelor students contributing for a single semester.
The contribution model has to be strict enough that quality does not collapse
between cohorts, but light enough that a one-semester contributor can land a
useful change in their first week. Three mechanisms make this work.

**Rule files.** The conventions that govern the handbook are not folklore;
they are version-controlled Markdown files under `.opencode/rules/`. Four
files cover, respectively, the general project rules (`general.md`), the
narrative voice required for Chapter 2 stories (`chapter2-story.md`), the
imperative structure required for Chapter 3 recipes (`chapter3-guide.md`), and
the navigation-manifest invariants for `mkdocs.yml` (`mkdocs-nav.md`). A new
contributor is told to read these once; a reviewer who finds a violation
points to the exact rule. The rules also encode operational details that are
easy to forget — the placeholder image workflow, the WIP admonition format,
the file-naming conventions for sections and images.

**OpenCode subagents.** The repository ships with five project subagents
defined in `.opencode/agents/` that can be invoked from any OpenCode-compatible
editor:

| Agent | Role | Mode |
|---|---|---|
| `@writer` | Create or expand sections; runs against the rule files; can edit and shell out | Read–write |
| `@reviewer` | Quality review of an existing section against the rules | Read-only |
| `@structure` | Refactor folder structures and synchronise `mkdocs.yml` nav | Read–write |
| `@diagrams` | Author or improve Mermaid diagrams | Read–write |
| `@consistency` | Audit cross-cutting invariants (Ch2↔Ch3 mapping, broken links, missing TODOs) | Read-only |

The `@writer` agent is the most-used. Its rule of operation is informative:
it must read the relevant rule file *before* editing, present a compact plan,
wait for explicit human approval (unless invoked through a custom command,
which counts as approval), and only then write. This pattern — *plan, approve,
execute* — keeps the human reviewer in the loop on every change while
absorbing the mechanical cost of conforming to the rules.

**Custom commands.** Five slash-commands package recurring workflows so that
they are issued the same way every time:

- `/new-section` — create a paired Ch2 story stub and Ch3 recipe stub, plus
  the `mkdocs.yml` nav entries.
- `/review-chapter` — invoke `@reviewer` against a chapter and produce a
  review report.
- `/add-diagram` — drop a Mermaid block in the right place with the right
  fencing.
- `/audit` — run `@consistency` across the whole repository.
- `/guide-from-steps` — turn a contributor's raw shell history or field notes
  into a Chapter 3 recipe that conforms to the structural template.

The combination is what enables a master-thesis contribution like this one to
add four merged feature branches over a few weeks while keeping the handbook's
voice and structure intact. The cost of consistency is paid by tooling, not
by reviewer fatigue.

It should be stated openly that AI assistance is part of the workflow.
The handbook is not generated by AI — every page is reviewed and approved by
a human contributor — but the mechanical conformance work (filling templates,
synchronising the nav, regenerating tables, applying tone rules) is delegated
to subagents. This is itself a contribution: it documents a viable model for
small-association open documentation projects that have neither paid editors
nor a stable maintainer pool.

### 3.C.6 Governance for continuity

Tooling alone does not guarantee survival. The handbook also needs an
explicit governance contract. The following elements are proposed and are in
force on the `dev_mj_thesis` branch at the time of writing:

- **Maintainer rotation.** At any time the handbook has at least one
  *maintainer* (currently the AUCOOP project lead) and at least one *active
  contributor* whose thesis depends on the project. The active contributor is
  expected to take over maintainer duties at the end of their thesis if no
  successor has joined. A short hand-over document accompanies each
  transition.
- **Definition of Done for a chapter.** A chapter is considered "done for
  this iteration" when (i) every section has at least one paragraph of body
  text, (ii) the Ch2↔Ch3 cross-links exist in both directions, (iii) all
  images are real (no placeholders), (iv) `/audit` reports zero structural
  errors, and (v) `zensical build` succeeds without warnings.
- **Picking up an open chapter.** A new contributor opens the chapter folder,
  reads its `index.md`, runs `/audit` to see the outstanding TODOs and WIP
  markers, and chooses one. The combination of `!!! info "Work in Progress"`
  admonitions and `<!-- TODO: ... -->` comments is dual on purpose: the first
  is visible to readers of the rendered site and signals that they should not
  rely on the section yet; the second is invisible to readers but `grep`-able
  by contributors.

This governance is light by design. Heavier processes — RFC documents,
formal release schedules, CODEOWNERS — would not survive the next volunteer
rotation. The chosen mechanisms degrade gracefully: even if the rules and
agents fall out of use for a semester, the resulting damage is limited to
inconsistent voice, not a broken build or a corrupted history.

### 3.C.7 What this contributes beyond the deployment

The Namibia deployment described in §4 will eventually be one row in the
handbook's `4-Real-Use-Cases` chapter. The handbook itself will outlive it.
The contribution claimed here is therefore not "documenting Namibia" but
*producing the instrument that makes Namibia documentable in a form the next
team can act on*. The thesis treats this instrument with the same rigour as
the network and endpoint work: as a designed system with explicit
requirements (continuity, dual output, low contributor onboarding cost),
explicit components (rule files, subagents, custom commands, governance
contract), and a measurable acceptance criterion (the four merged branches
of `dev_mj_thesis`, which collectively land a complete first version of the
hardware-network and laptop-deployment material).
