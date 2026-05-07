# 1. Introduction

## 1.1 Statement of purpose: objectives
<!-- \label{sec:objectives} -->

This thesis is one of two coordinated master's theses on the same
project. The companion thesis [Motje, 2026] covers the **software**
side (gateway firmware, services, authentication, monitoring, and the
application stack). The present document covers the **hardware** side
(the network fabric and the endpoint fleet) and the **Community Network Handbook** developped by the two parts that ties them together.

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
   specifically, the Namaqua Kalahari Children Hope project in Gochas, Namibia.
5. **Centralise**, in a single openly maintained artefact, the
   knowledge built up over previous AUCOOP projects, so that future
   cohorts inherit it rather than start over.

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
connectivity and usable ICT equipment in the communities where technological resources are scarce. The second is *internal*: a recurring pain point in the
association, namely the loss of knowledge between volunteer cohorts.
This loss forces members to re-solve the same problems with each new
generation of volunteers.


### 1.2.1 External motivation — connectivity and usable endpoints as preconditions for everything else

Reliable connectivity is no longer a luxury for the communities AUCOOP *(Associació d'Universitaris per la Cooperació)*
partners with: it is a transformative tool that creates new
opportunities for individuals. Schools, health posts, community
centres, and NGOs increasingly depend on online services for
curricula, record-keeping, and communication with regional
authorities. In the contexts AUCOOP brings students together to deploy ready to use projects. Over a decade there have been +40 projects in +15 countries between Europe, America, Africa and Asia. The obstacle all those communities found was never a single piece, normally it was the combination of three deficits that reinforced each other.

1. **No usable network.** Either there is no infrastructure at all,
   or there is a single ADSL/4G uplink at one location, with no
   capacity to cover the area that requires connectivity.
2. **No usable endpoints.** Even when connectivity is solved, the
   community often has only a handful of computers, slow and aged.  New hardware is unaffordable. Donations of refurbished
   hardware exist, but they require process to deploy at scale.
3. **No usable documentation.** The reference material that does
   exist assumes a level of bandwidth, budget, and expertise that the
   field site does not have. Vendor manuals presume current firmware
   and online activation.

This thesis attacks the first two deficits directly — through the
network work in \autoref{sec:methodology-network} and the endpoint
reconditioning pipeline in \autoref{sec:methodology-endpoint}. It
attacks the third deficit by producing the handbook described in
\autoref{sec:handbook}: a genuine, opinionated, field-tested
alternative to the documentation that is currently missing.

### 1.2.2 Internal motivation — knowledge continuity at AUCOOP
<!-- \label{sec:motivation-internal} -->

[AUCOOP](https://aucoop.upc.edu) is a student volunteer association at
UPC. Its strength is also its structural weakness: it is formed by
bachelor and master students, who join and  contribute for
one to three academic years, graduate, and pass the batton. Over more than three
years inside the association, the author has watched the same
pattern play out again and again:

- A project ends. Its deliverable — a working network, a configured
  server, a refurbished classroom — exists physically, but its
  *knowledge* exists only in the heads of the students who built it
  and in scattered private notes (chat messages, PDF report, Markdown
  files, hand-drawn diagrams in field notebooks).
- Those students graduate within twelve months. The institutional
  memory of the project leaves with them.
- The next cohort, picking up either a follow-up project at the same
  site or a similar project elsewhere, start from the left documentation in the shared
  drive of AUCOOP — but there is no clear way to apply it. They start from a blank page,
  rediscover the same way of deploying things, the same issues and
  pay the same debugging cost the previous cohort already paid.
- Two to three years later, the cycle repeats.

The cause is the absence of a *living artefact*
in which contribution is the natural side-effect of doing the work.
PDFs in a shared drive are not such an artefact: they are written
*after* the project, by people already mentally checked out, and read
by nobody.

This thesis takes the position that this internal problem is solvable,
and that solving it is itself a worthwhile engineering contribution.
The chosen solution — an open Git repository of Markdown sources that
builds to a public [website](https://aucoop.github.io/Community-Network-Handbook/) *and* a downloadable PDF, governed by
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
attempt to break that pattern — to leave behind
something that the next person can stand on,  so the impact of each project can cascade to the next one.

## 1.3 Requirements and specifications
<!-- \label{sec:requirements} -->

The handbook — the deliverable must satisfy five
requirements. These follow from the problem statement of
\autoref{sec:motivation} and the objectives of
\autoref{sec:objectives}. They are common to this thesis and the
companion software thesis [Motje, 2026], and are listed adapted to the
hardware-side of the project.

**R1 — Living and contributor-friendly.** The artefact must be
*easier to update than to discard*. Having a low barrier to
contribution: short pull requests, lightweight review, and
contribution rules small enough to read in one sitting. This
requirement is the direct technical answer to the volunteer-rotation
problem of \autoref{sec:motivation-internal}: if updating the artefact
is more expensive than reinventing the knowledge it contains, no
rational volunteer will update it.

**R2 — Openly accessible.** The handbook must be reachable from the
field with intermittent connectivity, and consultable when there is
no connectivity at all. Public web hosting alone is therefore
insufficient: an exportable form (a downloadable full PDF, EPUB). The dual-output build pipeline
(\autoref{sec:handbook} and \autoref{appendix:online-handbook})
implements this requirement.

**R3 — Pedagogically progressive.** The handbook must serve readers
ranging from those without prior exposure to community networks
through to volunteers needing a recipe for a specific task. A single linear document cannot serve both
audiences. The handbook addresses this
through two complementary tracks: a narrative *Imaginary Use Case*
(Chapter 2 of the handbook) that introduces the domain through a
story, and a topical *Guide* (Chapter 3) organised as recipes. 

**R4 — Free and open-source software (FOSS) where the recipe
controls the stack.** The deployments of the handbook must be
reproducible without commercial licences and maintainable by future
cohorts using only freely available tooling. 

**R5 — Field-validated.** The recommendations the handbook contains
must be traceable to a real deployment, not invented from
documentation alone. Every recipe in Chapter 3 of the handbook that
this thesis covers, is paired with an entry in
Chapter 4 of the handbook that records where it was exercised
in the field.

A sixth, more conventional set of hardware-recipe requirements
applies to the deployments themselves rather than to the handbook as
artefact:

| # | Hardware-recipe requirement | Why |
|---|---|---|
| H1 | Network gear must be supported by OpenWrt or an equivalent FOSS firmware | Auditability, longevity beyond vendor support window |
| H2 | Endpoints must be sourced from refurbishment, not new manufacture | \autoref{sec:embedded-carbon-avoided} (carbon) and \autoref{sec:budget-comparison} (cost) |
| H3 | Mass-deployment time per endpoint must be field-viable  | The deployment window is one-two work days |
| H4 | The total per-site cash BOM must be raisable from a single small NGO grant | Replicability inside AUCOOP and similar associations (cf. \autoref{sec:budget-funding}) |

Table: Hardware-recipe requirements (H1–H4)


## 1.4 Methods and procedures — relation to prior work
<!-- \label{sec:methods} -->


**Prior work — the Hahatay deployment in Senegal and other AUCOOP Projects.** The work
presented here is, takes as its origin, the documetation created by an AUCOOP team — including the author — carried out in Hahatay
(Senegal) over more than three years of sustained engagement. Hahatay
is one of the flagship projects of the association: a multi-site
community network built incrementally, without a structured guide, in
a rural Senegalese context. Experience from other projects has been captured through interviews and consolidation of stand alone documentation. All put toghether has been the principal source of the operational knowledge
captured in the Community Network Handbook.



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

Table: Project work plan phases (P1–P7)

> Source: `plan/gantt.md`. Render via `latex/gantt_diagrama.tex` (template uses `pgfgantt`).

*[insert Gantt diagram here]*



## 1.6 Deviations from the initial plan
<!-- \label{sec:deviations} -->

The plan submitted at the start of the project (September 2025) held
in its broad outline — the deployment site, the division of labour
with the companion thesis, and the core objectives are unchanged.
Three deviations of real consequence occurred and are worth recording
honestly, because each one changed what was built and why.

**D1 — Router hardware revision forced a full access-point swap.**
The network recipe was originally designed around the Cudy WR3000,
which had established OpenWrt community support at the time of
planning. Between procurement and deployment Cudy released a V2
board revision under the same product name and code with different
internal hardware; the new board was not supported by OpenWrt, and
there was no way to distinguish V1 from V2 units before opening the
box. With less than three weeks to the departure date, the entire
access-point selection had to be reconsidered. The Cudy WR3000E
AX3000 was identified as a supported alternative with comparable
spec. The episode is the reason the *Wireless-Mesh*
recipe (\autoref{sec:methodology-network}) leads with the warning to
cross-check board revision against the OpenWrt Table of Hardware
before purchasing.

**D2 — Endpoint software scope expanded: AUCOOP image and PXE
pipeline added.** The original plan assumed the donated laptops
would be deployed with the Labdoo image already installed — a
standard Ubuntu-based system that Labdoo ships on all its devices.
During pre-deployment user consultation it became clear that the
Labdoo image was too unfamiliar for the teaching staff and students
at the school: the desktop environment, application set did not match what they had previously used.
Rather than deploy a system the users would not be comfortable with,
the project developed the AUCOOP image together with the PXE
network-boot pipeline that allows laptops to be imaged in
parallel from a single server connected through ethernet. Neither the image
nor the PXE infrastructure was in the original scope; both are now
first-class outputs of the thesis, described in
\autoref{sec:methodology-endpoint} and documented in the
*Laptop-Deployment* recipe.

**D3 — Children's Home deployment deferred: mesh left plug-and-play.**
The project was scoped to cover two sites: N Mutschuana Primary
School and a children's home that was inaugurated in January 2026.
When the team arrived in March 2026, the children's home did not yet
have an internet connection — the government provider had not yet
sent a technician to install the ADSL line. Deploying a local
network without an uplink was possible but would have left the site
with a system the staff could not put into service. The decision taken on the ground was to leave it ready: the mesh access points were pre-configured,
labelled, and packaged together with step-by-step setup instructions
written for non-technical staff, so that the network can be brought
up by the site staff on the day the ADSL line is activated.
