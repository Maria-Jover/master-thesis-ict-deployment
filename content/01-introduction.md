# 1. Introduction

> Maps to `latex/introduction.tex` (will be split / extended).
> The template requires this section to clearly state the rationale and contain: (1) Statement of purpose, (2) Requirements & specifications, (3) Methods & procedures (including reuse of prior work), (4) Work plan with Gantt, (5) Deviations from the initial plan.

---

## 1.1 Statement of purpose (objectives)

Three coupled objectives:

1. **Network.** Design and deploy a community wireless network suitable for low-connectivity, resource-limited contexts, using affordable, locally repairable hardware (OpenWrt-supported routers, mesh backhaul, basic boundary services).
2. **Endpoints.** Build a repeatable pipeline to give a second life to corporate-donated laptops: cataloguing, golden-master image creation, and mass deployment via PXE + Clonezilla.
3. **Knowledge artefact.** Consolidate both flows into a living, open, GitHub-hosted handbook (web + downloadable PDF) — the "standard AUCOOP" — so that future student cohorts can build *on top of* the work instead of restarting from scratch.

## 1.2 Motivation

The motivation for this thesis comes from two distinct but reinforcing
sources. The first is *external*: the persistent gap in basic connectivity
and usable computing equipment in the communities where AUCOOP works. The
second is *internal*: a recurring failure of knowledge continuity inside
AUCOOP itself, which has caused the association to re-solve the same
problems with each new cohort of volunteers. Either of the two would justify
a thesis on its own; together they explain why the deliverable of this work
is not a single deployment but a *reusable instrument* — the handbook
described in §3.C — built and validated through a real field deployment.

### 1.2.1 External motivation — connectivity and usable endpoints as preconditions for everything else

Reliable connectivity is no longer a luxury for the communities AUCOOP
partners with. Schools, health posts, and local administrations increasingly
depend on online services for curricula, record-keeping, and communication
with regional authorities. In the contexts AUCOOP has worked in over the
last decade — rural Senegal, the Namibian Hardap region, and several pilots
inside Catalonia — the obstacle is rarely a single missing piece. It is the
combination of three deficits that reinforce each other:

1. **No usable network.** Either there is no infrastructure at all, or there
   is a single ADSL/4G uplink at one building with no way to reach the
   classrooms that need it. Commercial mesh kits exist but are priced and
   warrantied for European homes, not for sites where a replacement part takes
   six weeks to arrive.
2. **No usable endpoints.** Even when connectivity is solved, the school
   often has fewer than five working computers, all aged, often with broken
   storage or pirated operating systems that cannot be patched. New hardware
   is unaffordable; donations of refurbished hardware exist but require
   expertise to receive, image, and deploy at scale.
3. **No usable documentation.** The reference material that does exist
   assumes a level of bandwidth, budget, and expertise that the field site
   does not have. Vendor manuals presume current firmware and online
   activation. Academic papers describe ideal architectures but skip the
   thirty practical decisions a deployment team faces in an afternoon.

This thesis attacks the first two deficits directly — through the network
work in §3.A and the endpoint reconditioning pipeline in §3.B — and
attacks the third deficit by producing the handbook described in §3.C as a
genuine, opinionated, field-tested alternative to the documentation that is
currently missing.

### 1.2.2 Internal motivation — knowledge continuity at AUCOOP

[AUCOOP](https://aucoop.upc.edu) is a student volunteer association at UPC.
Its strength is also its structural weakness: it is staffed by bachelor and
master students, who join enthusiastic, contribute for one to three academic
years, graduate, and leave. Over more than three years inside the
association, the author has observed the same anti-pattern repeatedly:

- A project ends. Its deliverable — a working network, a configured server,
  a refurbished classroom — exists physically but its *knowledge* exists
  only in the heads of the students who built it and in scattered private
  notes (chat messages, personal Markdown files, hand-drawn diagrams in
  field notebooks).
- Those students graduate within twelve months. The institutional memory of
  the project leaves with them.
- The next cohort, picking up either a follow-up project at the same site or
  a similar project elsewhere, finds nothing actionable in the shared drive.
  They start from a blank page, rediscover the same OpenWrt mesh quirks, run
  into the same DHCP option, hit the same Clonezilla `partclone target seek
  ERROR`, and pay the same debugging cost the previous cohort already paid.
- Three years later, the cycle repeats.

The cause is not laziness; it is the absence of a *living artefact* in which
contribution is the natural side-effect of doing the work. PDFs in a
shared drive are not such an artefact: they are written *after* the project,
by people already mentally checked out, and read by nobody. Internal wikis
on self-hosted servers are not such an artefact either: they go unmaintained
the moment the volunteer who set them up leaves, and they are invisible to
external partners.

The thesis takes the position that this internal problem is solvable, and
that solving it is itself a worthwhile engineering contribution. The
solution adopted — an open Git repository of Markdown sources that builds
to a public website *and* a downloadable PDF, governed by lightweight
contribution rules and assisted by AI-driven authoring tooling — is
described in §3.C and is demonstrably already in use: this thesis was
written against it, the Namibia 2026 deployment was documented in it, and
the next AUCOOP student to pick up a project will find a non-empty starting
point.

### 1.2.3 Personal motivation

A note on personal motivation, kept short. The author has been involved
with AUCOOP since the bachelor years and has been on the receiving end of
both deficits described above: arriving at a project with no documentation
and leaving a project knowing the documentation she wrote would probably
not be read. This thesis is the deliberate attempt to break that pattern
on the way out — to leave behind something that the next person can stand
on rather than start beside.

## 1.3 Requirements and specifications

| # | Requirement | Why |
|---|---|---|
| R1 | Network gear must be supported by OpenWrt | Auditable, no vendor lock-in |
| R2 | Total per-site BOM ≤ €X (TBD) | Replicable by NGO budgets |
| R3 | Endpoints must be refurbished, not new | Sustainability + cost |
| R4 | Mass-deployment time per machine ≤ 10 min | Field viability |
| R5 | Documentation must build to both web and PDF | Connectivity-poor consumers |
| R6 | All artefacts public on GitHub | Living, contributable |
| R7 | Validated by ≥1 real field deployment | Beyond lab proof |

*Refine numeric targets after field metrics are consolidated.*

## 1.4 Methods and procedures — and prior work this builds upon

This thesis builds upon and contributes back to the **Community-Network-Handbook** (AUCOOP), pinned in `sources/` to branch `dev_mj_thesis` (commit hash recorded in `sources/handbook-mapping.md`).

External tooling reused (no novel implementation): OpenWrt, Clonezilla / `partclone`, GRUB, Linux Mint, ISC DHCP, tftpd-hpa, NFS kernel server, DeviceHub (eReuse), Zensical (docs site), MkDocs material theme, GitHub Actions.

The author's contribution is the **integration**, **field validation**, and **knowledge-artefact** layers; co-authorship of multiple handbook chapters is documented per-commit in the handbook git history.

A companion thesis (in parallel) covers the **services layer** (Proxmox, Nextcloud, RADIUS, captive portal, monitoring) — explicitly out of scope here, except for the boundary services strictly required for hardware operation (DHCP, DNS basics, monitoring overview).

## 1.5 Work plan and Gantt

See [`gantt`](#16-gantt-diagram) below.

### Phases

| Phase | Description | Period |
|---|---|---|
| P1 | Bootstrap handbook repository, conventions, CI | Sep 2025 – Oct 2025 |
| P2 | Network chapters (planning, IP, mesh, antennas, power) | Oct 2025 – Jan 2026 |
| P3 | Laptop chapters (refurbishment, AUCOOP image, PXE/Clonezilla) | Jan 2026 – Mar 2026 |
| P4 | Field deployment — Namibia (Gochas) | Mar 2026 |
| P5 | Real-use case write-up + handbook consolidation | Mar 2026 – Apr 2026 |
| P6 | Thesis write-up | Apr 2026 – May 2026 |
| P7 | Defence preparation | May 2026 |

## 1.6 Gantt diagram

> Source: `plan/gantt.md`. Render via `latex/gantt_diagrama.tex` (template uses `pgfgantt`).

*[insert Gantt diagram here]*

## 1.7 Deviations from the initial plan

To be filled retrospectively. Known deviations so far:

- **Partition-resize discovery.** Initial plan assumed identical disk sizes; discovered mid-deployment that ext4 metadata layout breaks `partclone` restore on smaller disks. Required adding Phase 3 (resize) to the deployment pipeline.
- **Secure Boot blocker.** Underestimated; documented as the #1 troubleshooting entry.
- **Branch fragmentation.** Several handbook chapters lived on long-running PRs not merged into `develop`; created `dev_mj_thesis` branch to consolidate them as the thesis source.
