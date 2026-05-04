# 1. Introduction

## 1.1 Statement of purpose: objectives
<!-- \label{sec:objectives} -->

This thesis is one of two coordinated master's theses on the same
project. The companion thesis [Motje, 2026] covers the **software**
side (gateway firmware, services, authentication, monitoring, and the
application stack). The present document covers the **hardware** side
(the network fabric and the endpoint fleet) and the **knowledge
artefact** that ties both halves together.

The five objectives below were defined jointly with the companion
thesis. They are common to both documents; what differs is the
dimension of each objective that each author addresses.

1. **Create a living document** that any contributor with basic
   technical literacy can update, so that the knowledge it contains
   grows with the projects that produce it.
2. **Develop a high-level guide** for readers with basic technical
   knowledge — not a reference manual aimed at networking specialists.
3. **Make the guide useful** for organisations such as AUCOOP, whose
   volunteers rotate frequently and whose deployments are
   geographically distributed.
4. **Validate the guide** by applying it in a real deployment:
   specifically, the Namaqua Kalahari Children Hope project at
   N Mutschuana Primary School, Gochas, Namibia.
5. **Centralise**, in a single openly maintained artefact, the
   knowledge accumulated from previous AUCOOP projects, so that future
   cohorts inherit it rather than reconstruct it.

The present document covers the **hardware dimension** of these
objectives: the chapters of the handbook that deal with the wireless
network fabric (planning, IP addressing, mesh backhaul, antennas,
power, and enclosure) and with the endpoint pipeline (refurbished
laptop intake, AUCOOP golden-master image, and PXE/Clonezilla mass
deployment). It also reports the validation of those chapters through
the network and endpoint deployment in Namibia (March 2026).

## 1.2 Motivation
<!-- \label{sec:motivation} -->

The motivation for this thesis comes from two distinct but reinforcing
sources. The first is *external*: the persistent gap in basic
connectivity and usable ICT equipment in the communities where AUCOOP
(*Associació d'Universitaris per la Cooperació*) can make a
difference. The second is *internal*: a recurring pain point in the
association, namely the loss of knowledge between volunteer cohorts.
This loss forces members to re-solve the same problems with each new
generation of volunteers.

Either of the two would justify a thesis on its own. Together they
explain why the deliverable of this work is not a single deployment
but a *reusable instrument* — the handbook described in
\autoref{sec:handbook} — built and validated through a real field
deployment. The framing is deliberately a *sustainability* one along
three dimensions — environmental, social and governance, and
economic — developed in \autoref{ch:sustainability}: refurbishment
defers manufacturing-phase carbon, the open handbook engineers
knowledge continuity into a volunteer association, and the cash
budget is small enough to be raised from a single NGO grant.

### 1.2.1 External motivation — connectivity and usable endpoints as preconditions for everything else

Reliable connectivity is no longer a luxury for the communities AUCOOP
partners with: it is a transformative tool that creates new
opportunities for individuals. Schools, health posts, community
centres, and NGOs increasingly depend on online services for
curricula, record-keeping, and communication with regional
authorities. In the contexts AUCOOP has worked in over the last decade
— rural Senegal, the Namibian Hardap region, and several pilots inside
Catalonia — the obstacle is rarely a single missing piece. It is the
combination of three deficits that reinforce each other:

1. **No usable network.** Either there is no infrastructure at all,
   or there is a single ADSL/4G uplink at one location, with no
   capacity to reach the classrooms that need it.
2. **No usable endpoints.** Even when connectivity is solved, the
   community often has only a handful of working computers, all aged,
   often with broken storage or pirated operating systems that cannot
   be patched. New hardware is unaffordable. Donations of refurbished
   hardware exist, but they require expertise to receive, image, and
   deploy at scale.
3. **No usable documentation.** The reference material that does
   exist assumes a level of bandwidth, budget, and expertise that the
   field site does not have. Vendor manuals presume current firmware
   and online activation. Academic papers describe ideal architectures
   but skip the thirty practical decisions a deployment team faces in
   an afternoon.

This thesis attacks the first two deficits directly — through the
network work in \autoref{sec:methodology-network} and the endpoint
reconditioning pipeline in \autoref{sec:methodology-endpoint}. It
attacks the third deficit by producing the handbook described in
\autoref{sec:handbook}: a genuine, opinionated, field-tested
alternative to the documentation that is currently missing.

### 1.2.2 Internal motivation — knowledge continuity at AUCOOP
<!-- \label{sec:motivation-internal} -->

[AUCOOP](https://aucoop.upc.edu) is a student volunteer association at
UPC. Its strength is also its structural weakness: it is staffed by
bachelor and master students, who join enthusiastic, contribute for
one to three academic years, graduate, and leave. Over more than three
years inside the association, the author has observed the same
anti-pattern repeatedly:

- A project ends. Its deliverable — a working network, a configured
  server, a refurbished classroom — exists physically, but its
  *knowledge* exists only in the heads of the students who built it
  and in scattered private notes (chat messages, personal Markdown
  files, hand-drawn diagrams in field notebooks).
- Those students graduate within twelve months. The institutional
  memory of the project leaves with them.
- The next cohort, picking up either a follow-up project at the same
  site or a similar project elsewhere, finds something in the shared
  drive — but no clear way to apply it. They start from a blank page,
  rediscover the same OpenWrt mesh quirks, run into the same DHCP
  option, hit the same Clonezilla `partclone target seek ERROR`, and
  pay the same debugging cost the previous cohort already paid.
- Three years later, the cycle repeats.

The cause is not laziness; it is the absence of a *living artefact*
in which contribution is the natural side-effect of doing the work.
PDFs in a shared drive are not such an artefact: they are written
*after* the project, by people already mentally checked out, and read
by nobody. Internal wikis on self-hosted servers are not such an
artefact either: they go unmaintained the moment the volunteer who
set them up leaves, and they are invisible to external partners.

The thesis takes the position that this internal problem is solvable,
and that solving it is itself a worthwhile engineering contribution.
The chosen solution — an open Git repository of Markdown sources that
builds to a public website *and* a downloadable PDF, governed by
lightweight contribution rules and assisted by AI-driven authoring
tooling — is described in \autoref{sec:handbook}. It is already in
use: this thesis was written against it, the Namibia 2026 deployment
was documented in it, and the next AUCOOP student to pick up a
project will find a non-empty starting point.

### 1.2.3 Personal motivation

A short note on personal motivation. The author has been involved with
AUCOOP since the bachelor years and has been on the receiving end of
both deficits described above: arriving at a project with no
documentation, and leaving a project knowing that the documentation
she wrote would probably not be read. This thesis is the deliberate
attempt to break that pattern on the way out — to leave behind
something that the next person can stand on, rather than start
beside.

## 1.3 Requirements and specifications
<!-- \label{sec:requirements} -->

The handbook — the deliverable that ties together the network and
endpoint contributions described in this thesis — must satisfy five
requirements. These follow from the problem statement of
\autoref{sec:motivation} and the objectives of
\autoref{sec:objectives}. They are common to both this thesis and the
companion software thesis [Motje, 2026], and are reproduced here in
the formulation jointly agreed with that work, adapted where the
hardware-side framing differs.

**R1 — Living and contributor-friendly.** The artefact must be
*easier to update than to discard*. This rules out the conventional
NGO-report format — a monolithic PDF authored once by a departing
volunteer and then frozen — as the primary form of the handbook. It
points instead to a source-text format under version control
(Markdown in a public Git repository), with a low barrier to
contribution: short pull requests, lightweight review, and
contribution rules small enough to read in one sitting. This
requirement is the direct technical answer to the volunteer-rotation
problem of \autoref{sec:motivation-internal}: if updating the artefact
is more expensive than reinventing the knowledge it contains, no
rational volunteer will update it.

**R2 — Openly accessible.** The handbook must be reachable from the
field with intermittent connectivity, and consultable when there is
no connectivity at all. Public web hosting alone is therefore
insufficient: an exportable form (a downloadable full PDF, mirrored
on the same site) is required, so that a volunteer arriving in Gochas
or in rural Senegal can consult the same material on a laptop that
last saw a network three weeks ago. The dual-output build pipeline
(\autoref{sec:handbook} and \autoref{appendix:online-handbook})
implements this requirement.

**R3 — Pedagogically progressive.** The handbook must serve readers
ranging from those without prior exposure to community networks
through to volunteers needing a recipe for a specific task on a
specific morning. A single linear document cannot serve both
audiences without alienating one of them. The handbook addresses this
through two complementary tracks: a narrative *Imaginary Use Case*
(Chapter 2 of the handbook) that introduces the domain through a
story, and a topical *Guide* (Chapter 3) organised as recipes. The
two tracks are maintained in strict 1:1 correspondence, so that the
same operational content is reachable both narratively and topically.
The structural choice is described in \autoref{sec:handbook-structure}.

**R4 — Free and open-source software (FOSS) where the recipe
controls the stack.** The recommendations the handbook makes must be
reproducible without commercial licences and maintainable by future
cohorts using only freely available tooling. For the software the
recipe configures — operating systems, network firmware, services,
documentation toolchain — this requirement is strict: OpenWrt rather
than vendor firmware, Linux Mint rather than Windows, ISC `dhcpd`
rather than a commercial appliance, OnlyOffice Community rather than
a licensed suite. For the hardware the recipe *deploys onto*, the
requirement is necessarily looser: vendor BIOS firmware on Lenovo
ThinkPads and the binary radio firmware blobs that OpenWrt loads onto
Cudy access points are accepted as out-of-scope dependencies, because
no FOSS alternative exists for either at this date, and refusing the
donation pipeline on those grounds would defeat the larger
refurbishment goal. The requirement is therefore *FOSS for everything
we author or configure; vendor firmware tolerated where unavoidable,
and recorded explicitly in the relevant recipe.*

**R5 — Field-validated.** The recommendations the handbook contains
must be traceable to a real deployment, not invented from
documentation alone. Every recipe in Chapter 3 of the handbook that
this thesis covers — wireless mesh, IP addressing, network planning,
laptop deployment, AUCOOP image — is paired with an entry in
Chapter 4 of the handbook that records where it was first exercised
in the field. The validation strategy is summarised in
\autoref{sec:results-strategy}, and the eleven operational lessons
that emerged from the Namibia deployment are consolidated in
\autoref{sec:lessons-consolidated}.

A sixth, more conventional set of hardware-recipe requirements
applies to the deployments themselves rather than to the handbook as
artefact:

| # | Hardware-recipe requirement | Why |
|---|---|---|
| H1 | Network gear must be supported by OpenWrt or an equivalent FOSS firmware | Auditability, longevity beyond vendor support window |
| H2 | Endpoints must be sourced from refurbishment, not new manufacture | \autoref{sec:embedded-carbon-avoided} (carbon) and \autoref{sec:budget-comparison} (cost) |
| H3 | Mass-deployment time per endpoint must be field-viable  | The deployment window is one-two work days |
| H4 | The total per-site cash BOM must be raisable from a single small NGO grant | Replicability inside AUCOOP and similar associations (cf. \autoref{sec:budget-funding}) |

H1–H4 are operationalised in the recipes; their validation against the
Namibia deployment is reported in \autoref{sec:results-network} and
\autoref{sec:results-endpoint}.

## 1.4 Methods and procedures — relation to prior and concurrent work
<!-- \label{sec:methods} -->

This thesis is **methodologically integrated** with two adjacent
bodies of work, and explicitly delimited from a third. Naming each is
part of the contribution, because the value of the thesis lies as
much in *what it does not re-do* as in what it adds.

**Prior work — the Hahatay deployment in Senegal.** The work
presented here is, in its origin, a continuation of the deployment
that an AUCOOP team — including the author — carried out in Hahatay
(Senegal) over more than three years of sustained engagement. Hahatay
is one of the flagship projects of the association: a multi-site
community network built incrementally, without a structured guide, in
a rural Senegalese context against constraints recognisably similar
to those of the Namibia case (intermittent connectivity, refurbished
endpoints, volunteer rotation between cohorts). The Hahatay
deployment is the principal source of the operational knowledge
captured in the Community Network Handbook. The Namibia deployment
described in \autoref{ch:results} is therefore not the first exercise
of the recipes in the handbook, but the first *field validation of
the recipes after they had been written down*: the Hahatay engagement
produced the knowledge, the handbook codified it, and Namibia tested
whether the codification travelled.

**Prior work — the AUCOOP Community Network Handbook itself.** The
handbook exists as a public Git repository [AUCOOP, 2026] and was
seeded with the Hahatay knowledge described above before this thesis
began. The thesis treats the handbook as both input and output:
input, because much of the network-planning, IP-addressing, and
OpenWrt material was authored before the Namibia deployment and was
used to plan it; output, because every operational lesson from
Namibia was committed back into the handbook in real time.

**Concurrent work — the companion software thesis.** The companion
thesis [Motje, 2026] covers the services layer (Proxmox
virtualisation, Nextcloud collaborative platform, RADIUS
authentication, captive portal, Zabbix monitoring, VPN backhaul, and
backup procedures). The two theses share a common Chapter 1
(introduction), Chapter 2 (state of the art), and Chapter 3
(methodology) in their respective formulations; they share the
Namibia deployment as a common validation site; and they share a
bibliography backbone (entries marked `[shared]` in
\autoref{ch:bibliography}). They diverge in the technical
contribution: the present document does not describe the services
running on top of the network, and the companion thesis does not
describe the network or the endpoints they run on. Where the boundary
is operationally fuzzy — DHCP, DNS, basic monitoring — this thesis
treats those services as boundary infrastructure required for the
hardware to function, and describes only what is necessary for that
purpose; the deeper services treatment is in [Motje, 2026].

**External tooling reused, not implemented.** This work uses
extensively the open-source ecosystem developed by the wider
community-network movement. None of the components below are
contributions of this thesis; the contribution lies in the way they
are **integrated, configured, and explained** in the context of small
community deployments executed by volunteer teams.

- **Network firmware and stack.** OpenWrt 24.10.x as the access-point
  and gateway operating system; the `mac80211` 802.11s mesh stack;
  `hostapd`, `wpa_supplicant`, `dnsmasq`, ISC `dhcpd`, and
  `tftpd-hpa` for boundary services.
- **Endpoint provisioning.** Clonezilla and `partclone` for bit-level
  imaging and restore; GRUB 2 and `pxelinux` for the PXE boot chain;
  the NFS kernel server for image distribution.
- **Endpoint operating system.** Linux Mint Cinnamon 22.3 as the base
  of the AUCOOP golden-master image; OnlyOffice Community as the
  bundled productivity suite.
- **Refurbishment provenance.** The eReuse / DeviceHub toolchain for
  tracking donated hardware from intake to deployed.
- **Documentation toolchain.** MkDocs with the Material/Zensical
  themes for building the handbook to both web and PDF; GitHub
  Actions for continuous integration; a public GitHub repository for
  hosting and contribution governance.

The author's contribution lies in the **integration**, **field
validation**, **operational distillation**, and **knowledge-artefact**
layers; co-authorship of individual handbook chapters is recorded
per-commit in the handbook git history.

**Out of scope.** Custom firmware development, novel routing
protocols, formal performance modelling of mesh throughput, and
academic-grade life-cycle assessment of refurbishment are all out of
scope. The thesis is an integration and validation effort, not a
research contribution to any of those sub-fields.
\autoref{sec:sustainability-limits} makes the LCA limitation explicit
in the broader sustainability context — environmental, social and
economic indicators are reported as order-of-magnitude estimates,
not as a formal LCA along the lines of [Roura et al., 2026];
\autoref{sec:future-work} lists the others as future-work directions.

## 1.5 Work plan and Gantt
<!-- \label{sec:workplan} -->

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
<!-- \label{sec:document-structure} -->

The remainder of this document is organised as follows.

\autoref{ch:state-of-the-art} reviews the state of the art across
the areas relevant to the work: existing community networks
(Guifi.net, NYC Mesh, Freifunk, AlterMundi, Rhizomatica), the
ICT-for-development and refurbishment ecosystem (Labdoo, eReuse, the
WEEE regulatory frame), the OpenWrt firmware ecosystem and the
open-source mass-deployment toolchain (Clonezilla, PXE), and the
literature on knowledge management in volunteer organisations (tacit
and explicit knowledge, working knowledge, communities of practice,
the volunteer-rotation problem).

\autoref{ch:methodology} describes the methodology in three parts that
correspond to the three contributions of the thesis:
\autoref{sec:methodology-network} the network hardware deployment,
organised through a four-functional-layer model (field, site,
endpoint touchpoint, power and enclosure);
\autoref{sec:methodology-endpoint} the endpoint reconditioning and
mass-deployment pipeline (intake, AUCOOP image, PXE/Clonezilla); and
\autoref{sec:handbook} the AUCOOP Community Network Handbook itself
as a knowledge artefact, including the choice of documentation
tooling, the Diátaxis-inspired Ch2/Ch3 split, the contribution
governance, and the AI-assisted authoring workflow.

\autoref{ch:results} reports the results of applying the methodology
at N Mutschuana Primary School, Gochas (Namibia), in March - April 2026. The
validation is organised through three qualitative analytical lenses
— *coverage*, *sufficiency*, *adaptation* — and the
operational lessons it produced are consolidated in
\autoref{sec:lessons-consolidated}, together with the handbook
artefact each one fed back into.

\autoref{ch:budget} presents the budget, distinguishing the cash
outlay an organisation actually has to raise from the full project
cost at indicative engineering rates, and comparing both with the
commercial-equivalent alternative.

\autoref{ch:sustainability} addresses sustainability along three
dimensions — environmental (manufacturing-phase carbon dominance and
the avoided-production argument that justifies the refurbishment
requirement), social and governance (digital inclusion delivered and
knowledge continuity engineered into the handbook), and economic
(cash budget vs full-cost accounting and the donation-pipeline
leverage) — adopting the indicator framing of [Roura et al., 2026]
and recording explicitly the limits of the analysis (this thesis
does not constitute a formal life-cycle assessment).

\autoref{ch:conclusions} draws conclusions against each of the five
objectives stated in \autoref{sec:objectives}, records the
limitations honestly alongside the conclusions they qualify, lists
future-work directions, and documents the hand-over protocol for the
next AUCOOP cohort.

The bibliography (\autoref{ch:bibliography}) marks shared entries with
the companion thesis explicitly. \autoref{appendix:online-handbook}
points to the publicly hosted handbook (URL, build instructions,
contribution conventions); \autoref{appendix:glossary} is the
glossary of acronyms; and the remaining appendices collect the budget
detail (BOM and itemised costs), the deployment field log,
representative configuration excerpts, and the data sheet for the
Namibia case.

## 1.8 Deviations from the initial plan
<!-- \label{sec:deviations} -->

The plan submitted at the start of the project (September 2025) has
held in its broad outline. The five objectives stated in
\autoref{sec:objectives}, the deployment site (Namibia, March 2026),
and the division of labour with the companion thesis are all
unchanged. Six deviations of varying magnitude are worth recording
explicitly, both for honesty and because each one is a data point
about the realities of deploying ICT in low-connectivity contexts.

**D1 — Partition resize added to the endpoint pipeline.** The
original plan assumed all donated laptops would have storage at least
as large as the source machine the AUCOOP image was captured from. On
intake of the Namibia batch it became apparent that target disks
ranged from 238 GB (SSD) to 466 GB (HDD), and that `partclone` fails
with a `target seek ERROR` when restoring an ext4 partition onto a
smaller disk, regardless of whether the data fits. A partition-resize
phase was added to the pipeline (shrink source `/`, recapture image,
expand target `/` after restore), described in
\autoref{sec:methodology-endpoint} and documented as a first-class
step in the *Laptop-Deployment* recipe. The episode shifted the
laptop-chapter timeline by approximately two weeks.

**D2 — Secure Boot blocker.** The plan underestimated the difficulty
of PXE-booting Lenovo machines with Secure Boot enabled in the
factory configuration. The blocker is documented as the headline
troubleshooting entry in the *Laptop-Deployment* recipe and in
\autoref{sec:methodology-endpoint}; it had no effect on the project
schedule, but absorbed roughly a day of bench time per machine class
until the BIOS settings were standardised.

**D3 — Branch fragmentation in the handbook repository.** Several
handbook chapters lived on long-running pull requests that had not
been merged into `develop` by the time the thesis write-up began.
Rather than force premature merges, a thesis-source branch
`dev_mj_thesis` was created to consolidate the chapters in the form
actually used during the deployment, and the thesis cites that branch
and commit hash. The fragmentation is itself a data point about
volunteer-driven repositories, and is reflected in the governance
discussion of \autoref{sec:handbook}.

**D4 — Documentation tooling switch (Zensical for MkDocs).** The
initial repository was scaffolded on MkDocs Material; mid-project the
project switched to Zensical, which provides a richer admonition
vocabulary and better PDF export for the same Markdown sources. The
migration was non-trivial (navigation file format, theme overrides,
build-pipeline rewrite), but cleaner than continuing with the older
toolchain. The episode is referenced in \autoref{sec:handbook}.

**D5 — OpenWrt snapshot regression on Cudy WR3000E.** During lab
preparation, an OpenWrt snapshot build for the WR3000E presented
intermittent failures on the 5 GHz radio that the stable 24.10.x
branch did not exhibit. The decision to pin the deployment to
24.10.x is recorded in \autoref{sec:methodology-network} and in the
*Wireless-Mesh* recipe; it has the side-effect that the recipe is
reproducible only on a specific OpenWrt minor version, which is
acceptable but adds a maintenance dependency.

**D6 — Quantitative validation deferred.** The plan contemplated both
qualitative validation (coverage, sufficiency, adaptation) and a
quantitative throughput characterisation of the mesh (per-link iperf,
per-AP association counts, latency under load). The quantitative
measurements were partially collected in the field, but are not
consolidated in this document at submission time;
\autoref{sec:results-discussion} flags this as a limitation and
\autoref{sec:future-work} identifies the corresponding future-work
item. The validation chapter (\autoref{ch:results}) consequently
leans qualitative, in line with what the recipe is actually intended
to prove.
