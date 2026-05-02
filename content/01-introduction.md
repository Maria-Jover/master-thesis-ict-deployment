# 1. Introduction

> Maps to `latex/introduction.tex` (will be split / extended).
> The template requires this section to clearly state the rationale and contain: (1) Statement of purpose, (2) Requirements & specifications, (3) Methods & procedures (including reuse of prior work), (4) Work plan with Gantt, (5) Deviations from the initial plan.

---

## 1.1 Statement of purpose: objectives

This thesis is presented as one of two coordinated master's theses on the
same project; the companion thesis [Motje, 2026] covers the **software**
side (gateway firmware, services, authentication, monitoring, application
stack), and the present document covers the **hardware** side (the
network fabric and the endpoint fleet) and the **knowledge artefact**
that ties both halves together.

The five objectives below were formulated jointly with the companion
thesis. They are common to both documents; what differs between them
is the dimension of each objective that each author addresses.

1. **To create a living document** that any contributor with basic
   technical literacy can update, so that the knowledge it contains
   can grow with the projects that produce it.
2. **To develop a high-level guide** usable by people with basic
   technical knowledge — not a reference manual aimed at networking
   specialists.
3. **To ensure that the guide is useful** for organisations such as
   AUCOOP whose volunteers rotate frequently and whose deployments are
   geographically distributed.
4. **To validate the guide** by applying it in a real deployment,
   specifically the Namaqua Kalahari Children Hope project at N
   Mutschuana Primary School, Gochas, Namibia.
5. **To centralise**, in a single openly maintained artefact, the
   knowledge accumulated from previous AUCOOP projects, so that future
   cohorts inherit it rather than reconstruct it.

The present document covers the **hardware dimension** of these
objectives: the chapters of the handbook concerned with the wireless
network fabric (planning, IP addressing, mesh backhaul, antennas,
power and enclosure) and with the endpoint pipeline (refurbished-laptop
intake, AUCOOP golden-master image, PXE/Clonezilla mass deployment),
as well as the validation of those chapters through the network and
endpoint deployment in Namibia (March 2026).

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

## 1.4 Methods and procedures — relation to prior and concurrent work

This thesis is **methodologically integrated** with two adjacent bodies
of work and explicitly delimited from a third. Naming each is part of
the contribution, because the value of the thesis lies as much in
*what it does not re-do* as in what it adds.

**Prior work — the AUCOOP Community-Network-Handbook.** The handbook
exists as a public Git repository [AUCOOP, 2026] and predates this
thesis only marginally; the author has been a co-maintainer since the
first chapter was committed. The thesis treats the handbook as both
input and output: input, because much of the network-planning,
IP-addressing and OpenWrt material was authored before the Namibia
deployment and was used to plan it; output, because every operational
lesson from Namibia was committed back into the handbook in real time.
The handbook is pinned for citation purposes to branch
`dev_mj_thesis` at commit `a5fc80b` (recorded in
`sources/handbook-mapping.md`); §3.C describes the artefact in
detail and §4.4 reports its validation.

**Concurrent work — the companion software thesis.** The companion
thesis [Motje, 2026] covers the services layer (Proxmox virtualisation,
Nextcloud collaborative platform, RADIUS authentication, captive
portal, Zabbix monitoring, VPN backhaul, backup procedures). The two
theses share Chapter 1 introduction, Chapter 2 state of the art, and
Chapter 3 methodology in their respective formulations; they share the
Namibia deployment as a common validation site; and they share a
bibliography backbone (entries marked `[shared]` in §8). They diverge
in the technical contribution: the present document does not describe
the services running on top of the network, and the companion thesis
does not describe the network or the endpoints they run on. Where
the boundary is operationally fuzzy — DHCP, DNS, basic monitoring —
this thesis treats those services as boundary infrastructure required
for the hardware to function and describes only what is necessary for
that purpose; the deeper services treatment is in [Motje, 2026].

**External tooling reused, not implemented.** The thesis claims no
novel implementation of the following components, all of which are
used as published: OpenWrt 24.10.x and the `mac80211` mesh stack;
Clonezilla and `partclone`; GRUB 2 and `pxelinux`; Linux Mint
Cinnamon 22.3 as the AUCOOP image base; ISC `dhcpd`; `tftpd-hpa`;
NFS kernel server; the eReuse / DeviceHub provenance toolchain;
Zensical and the MkDocs Material theme; GitHub Actions for CI.
The author's contribution lies in the **integration**, **field
validation**, **operational distillation**, and **knowledge-artefact**
layers; co-authorship of individual handbook chapters is recorded
per-commit in the handbook git history.

**Out of scope.** Custom firmware development, novel routing
protocols, formal performance modelling of mesh throughput, and
academic-grade life-cycle assessment of refurbishment are all out of
scope. The thesis is an integration and validation effort, not a
research contribution to any one of those sub-fields. §6.7 makes
the LCA limitation explicit; §7.4 lists the others as future-work
directions.

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

## 1.7 Document structure

The remainder of this document is organised as follows. **Chapter 2**
surveys the relevant state of the art across community networks, ICT
for development, refurbishment, the OpenWrt ecosystem, mass
deployment of operating systems, and knowledge management in
volunteer organisations. **Chapter 3** describes the methodology in
three parts: §3.A the network hardware deployment, §3.B the endpoint
reconditioning and mass-deployment pipeline, and §3.C the AUCOOP
Handbook as a knowledge artefact. **Chapter 4** reports the results
of applying the methodology at N Mutschuana Primary School, Gochas
(Namibia) in March 2026, with the validation organised through three
analytical lenses (coverage, sufficiency, adaptation). **Chapter 5**
presents the budget. **Chapter 6** addresses environmental impact,
with particular attention to the manufacturing-phase carbon
dominance that justifies refurbishment. **Chapter 7** draws
conclusions against each of the five objectives and outlines future
work. The bibliography (**Chapter 8**) marks shared entries with
the companion thesis. **Appendix A** documents the online handbook,
**Appendix B** is the glossary of acronyms, and Appendices C–G
collect the budget detail (BOM and costs), the deployment field log,
configuration excerpts, and the data-sheet for the Namibia case.

## 1.8 Deviations from the initial plan

The plan submitted at the start of the project (September 2025) has
held in its broad outline. The five objectives stated in §1.1, the
deployment site (Namibia, March 2026), and the division of labour with
the companion thesis are all unchanged. Six deviations of varying
magnitude are worth recording explicitly, both for honesty and because
each one is a data point about the realities of deploying ICT in
low-connectivity contexts.

**D1 — Partition resize added to the endpoint pipeline.** The
original plan assumed all donated laptops would have storage at least
as large as the source machine the AUCOOP image was captured from.
On intake of the Namibia batch it became apparent that target disks
ranged from 238 GB (SSD) to 466 GB (HDD), and that `partclone` fails
with a `target seek ERROR` when restoring an ext4 partition onto a
smaller disk regardless of whether the data fits. A partition-resize
phase was added to the pipeline (shrink source `/`, recapture image,
expand target `/` post-restore), described in §3.B.6 and documented
as a first-class step in the *Laptop-Deployment* recipe. The episode
shifted the laptop-chapter timeline by approximately two weeks.

**D2 — Secure Boot blocker.** The plan underestimated the difficulty
of PXE-booting Lenovo machines with Secure Boot enabled in the
factory configuration. The blocker is documented as the headline
troubleshooting entry in the *Laptop-Deployment* recipe and in
§3.B.4; it had no effect on the project schedule but absorbed
roughly a day of bench time per machine class until the BIOS
settings were standardised.

**D3 — Branch fragmentation in the handbook repository.** Several
handbook chapters lived on long-running pull requests that had not
been merged into `develop` by the time the thesis write-up began.
Rather than force premature merges, a thesis-source branch
`dev_mj_thesis` was created to consolidate the chapters in the
form actually used during the deployment, and the thesis cites that
branch and commit hash. The fragmentation is itself a data point
about volunteer-driven repositories and is reflected in the
governance discussion of §3.C.

**D4 — Documentation tooling switch (Zensical for MkDocs).** The
initial repository was scaffolded on MkDocs Material; mid-project the
project switched to Zensical, which provides a richer admonition
vocabulary and better PDF export for the same Markdown sources. The
migration was non-trivial (navigation file format, theme overrides,
build-pipeline rewrite) but cleaner than continuing with the older
toolchain. The episode is referenced in §3.C.

**D5 — OpenWrt snapshot regression on Cudy WR3000E.** During lab
preparation, an OpenWrt snapshot build for the WR3000E presented
intermittent failures on the 5 GHz radio that the stable 24.10.x
branch did not exhibit. The decision to pin the deployment to
24.10.x is recorded in §3.A.4 and in the *Wireless-Mesh* recipe;
it has the side-effect that the recipe is reproducible only on a
specific OpenWrt minor version, which is acceptable but adds a
maintenance dependency.

**D6 — Quantitative validation deferred.** The plan contemplated
both qualitative validation (coverage, sufficiency, adaptation) and a
quantitative throughput characterisation of the mesh (per-link
iperf, per-AP association counts, latency under load). The
quantitative measurements were partially collected in the field but
are not consolidated in this document at submission time; §4.6
flags this as a limitation and §7.4 identifies the corresponding
future-work item. The validation chapter (§4) consequently leans
qualitative, in line with what the recipe is actually intended to
prove.
