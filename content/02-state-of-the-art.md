# 2. State of the Art
<!-- \label{ch:state-of-the-art} -->

This chapter reviews the technological and methodological landscape on
which the thesis builds. The review is organised by the same four-layer
model used in §3 (field, site, endpoint touchpoint, power and
enclosure), plus the cross-cutting domain of **living documentation**
that frames §3.C. The two terminal sections — §2.7 on documentation
practice and §2.8 on the gap addressed by this thesis — most directly
motivate the original contribution; the earlier sections establish the
technical baseline against which the deployments of §4 are measured.

The companion thesis [Motje, 2026] reviews in detail the
software-services state of the art (virtualisation, identity, file
services, monitoring, VPN). To avoid duplication, this chapter
references that review wherever the SW/HW boundary is crossed, and
the shared backbone of references named in the bibliography is used
in both volumes.

---

## 2.1 The digital divide and community networks

The ITU's annual *Measuring digital development* reports document that as of the most recent figures, leaves roughly a
third of the world's population offline, with the gap concentrated in
rural and low-income areas of low- and middle-income countries [ITU].
The classical analysis distinguishes a *first-level* divide
(infrastructure access), a *second-level* divide (skills and use), and
a *third-level* divide (the unequal benefits derived from being
online) [van Dijk, 2020].

The deployment documented in this thesis sit predominantly at the
first and second level: a primary school and a children's house in
Gochas had neither classroom Wi-Fi nor connectivity until March 2026.
To address the second level, seminars were conducted and user guides
were produced for the use and maintenance of the network and the
laptops; the choice of Linux Mint with familiar launchers (§3.B.3)
is itself a second-level intervention.

Two structural responses have emerged to a market in which commercial
ISPs do not find it profitable to serve sparsely-populated or
low-income areas. The first is *public* infrastructure: state- or
municipality-led broadband programmes with mixed track records. The
second, more relevant to this work, is the **community network**:
infrastructure built, operated, and governed by the community it
serves. Belli's edited volume *Community Networks: the Internet by
the People, for the People* [Belli, 2017] surveys the model across
continents, and APC's *Local Access Networks* report [APC] documents
the regulatory and economic conditions under which it succeeds.

Reference deployments cited throughout the literature include:

- **Guifi.net** in Catalonia — the largest community network
  worldwide, with tens of thousands of nodes and a well-developed
  legal-economic *compact*.
- **AlterMundi** in Argentina — mesh-based rural networks with
  locally-manufactured routers.
- **Rhizomatica** in Mexico — community GSM in indigenous regions.
- **Zenzeleni** in South Africa — a cooperative WISP serving the
  Eastern Cape.

These networks share a methodological commitment that is also adopted
here: the *operational knowledge* required to run the network is
treated as a public good, not as proprietary expertise.

What the literature does *not* converge on is a reproducible playbook
that a small student association can pick up and execute on a single
site without first becoming experts in regulatory negotiation,
fundraising, or hardware design. The handbook of §3.C is one attempt
to fill that practitioner-level gap.

## 2.2 ICT for development and the refurbishment ecosystem

The ICT4D field studies how information technology can be deployed in
support of development goals. Heeks' *Information and Communication
Technology for Development* [Heeks, 2017] is the canonical textbook;
Toyama's *Geek Heresy* [Toyama, 2015] is the canonical critique of
the field's tendency to over-attribute outcomes to technology. The
synthesis useful for this thesis is Toyama's *amplification thesis*:
**technology amplifies the human and institutional intent already
present at a site**, rather than substituting for it. The corollary is
that a deployment without a local champion (the school director, the
NGO partner, the teacher who actually opens the laptop) does not
survive the team's departure. The methodology of §3 is built around
this statement: every recipe identifies the role responsible for the
artefact it produces, and the handbook's contribution model (§3.C.5)
explicitly accommodates contributors who are not the original team.

On the supply side, refurbishment of business-grade laptops has
become a viable channel for low-resource sites. Three types of actor
matter here:

- **Donor / aggregator NGOs** such as **Labdoo**, which collects and
  redeploys end-of-life corporate hardware. The deployments of §4
  rely on Labdoo as a primary sourcing channel.
- **Provenance and lifecycle tooling** such as **eReuse / DeviceHub**,
  which provides device-level inventory and traceability.
- **Regulatory baseline.** The EU **WEEE Directive 2012/19/EU**
  defines the end-of-life chain that refurbishment intervenes in,
  diverting equipment from waste streams into a second productive
  life.

The environmental case for reuse is developed in §6. It rests on the
observation that the manufacturing-phase carbon emissions of a laptop
dominate its lifecycle footprint, so a five-year-old machine kept in
service for another five years has a markedly lower per-useful-year
footprint than a new replacement.

## 2.3 The open networking stack on commodity hardware

The site-layer technical baseline of this work is **OpenWrt**, the
Linux distribution for embedded networking devices. OpenWrt's
contribution to the field is structural: it decouples the firmware
from the manufacturer and exposes a full Linux userspace on
consumer-grade routers, which makes the *same* recipe (§3.A.5) work
across hardware generations and vendors.

Three wireless mesh protocols dominate the practitioner literature:

- **IEEE 802.11s**, the standardised mesh extension of 802.11, with
  HWMP path selection. Standardisation is the reason it was chosen
  for the deployments of §4: drivers are available across vendors,
  and the recipe of §3.A.5 does not depend on any single hardware
  family.
- **B.A.T.M.A.N. advanced (`batman-adv`)** [open-mesh.org], a
  layer-2 mesh protocol popular in the Freifunk and Guifi.net
  communities. It has stronger convergence properties on large
  topologies, but a steeper learning curve and a smaller default
  driver footprint on consumer routers.
- **OLSR/OLSRv2**, a layer-3 link-state mesh protocol of historical
  importance in early community-network deployments.

The thesis adopts 802.11s for the reasons of standardisation and
recipe portability named above. `batman-adv` is acknowledged as the
right answer for larger or more dynamic topologies, and is flagged in
§7 as a future-work direction.

For inter-building point-to-point links, the practitioner standard is
the **Ubiquiti airMAX** family (NanoBeam, LiteBeam, PowerBeam), with
**MikroTik** and **TP-Link CPE** lines as alternatives. The choice is
driven by terrain profile and budget; §3.A.6 documents the
methodology without committing to a single vendor.

The reference hardware lines used in this work are:

- **Cudy WR3000E**, a consumer Wi-Fi 6 router with full OpenWrt
  support and a 12 V power input that integrates cleanly with a
  small UPS.
- **NanoPi R-series** single-board computers, used as gateways with
  capacity for boundary services (DHCP, DNS, basic monitoring) and as
  hosts for the software stack documented in [Motje, 2026].

## 2.4 Mass operating-system deployment

The endpoint work-stream of §3.B builds on a network-boot foundation
that has been stable for two decades. The relevant pieces are:

- **PXE** (Preboot eXecution Environment) [Intel PXE], the firmware
  protocol by which a UEFI or BIOS client requests a boot file via
  DHCP and TFTP. PXE is implemented by every business-class machine
  manufactured in the last fifteen years.
- **GRUB** with `grub-mknetdir` [GRUB manual], used to generate an
  EFI network-boot binary that loads a kernel and initrd from TFTP.
  The recipe of §3.B.6 pins this approach.
- **iPXE**, an open-source replacement for the firmware PXE stack
  with HTTP, iSCSI, and scripting support; not used here, because
  the built-in UEFI PXE is sufficient for the fleet sizes involved.

For the imaging step itself, the practitioner choices reduce to:

- **Clonezilla** + `partclone` [Clonezilla], the tool chosen in
  §3.B.4. Clonezilla supports per-partition, filesystem-aware
  imaging (only used blocks are copied), local-device or network
  image repositories, and a Live CD/USB workflow that is easily
  scripted. The partition-resize problem of §3.B.5 is a known
  ext4-specific failure mode that the project's documentation
  acknowledges but does not, at the time of writing, fully automate.
- **DRBL** (Diskless Remote Boot in Linux) [DRBL], the same
  authors' larger framework that bundles PXE, NFS, and Clonezilla
  into a single managed system. DRBL is the right answer for fleets
  in the hundreds; it adds operational complexity that does not pay
  back for the nine-to-twelve-machine deployments of §4. The
  decision to use the minimal `isc-dhcp-server` + `tftpd-hpa` +
  `nfs-kernel-server` + Clonezilla Live stack is justified in §3.B.6
  and §3.B.9.
- **FOG Project**, a popular open-source imaging server with a web
  UI; comparable in capability to DRBL.
- **Microsoft Deployment Toolkit (MDT)** and **Windows Deployment
  Services (WDS)**, the equivalent in the Windows ecosystem; not
  applicable to this work.

The trade-off named in §3.B.6 — *fewer moving parts that can each be
inspected and restarted independently* over *a managed framework
with an opinionated UI* — is the methodological core of the choice
and a recurring pattern in low-resource deployments.

## 2.5 Linux distributions for low-end hardware

The endpoint OS choice of §3.B.3 selects from a well-documented field:

| Distribution | Strengths | Weaknesses for AUCOOP context |
|---|---|---|
| Ubuntu | Largest software ecosystem; LTS cadence | GNOME desktop unfamiliar to Windows users; Snap-centric |
| **Linux Mint Cinnamon** | Windows-style desktop, Ubuntu-LTS base, lightweight, Cinnamon mature | Slightly heavier than Lubuntu/antiX |
| Lubuntu | Very lightweight (LXQt) | Less polished UI |
| antiX | Runs on very old hardware | Niche, unfamiliar workflow for new users |
| LXLE | Lightweight; designed for old hardware revival | Smaller community |
| Debian + lightweight DE | Maximally stable | Heavier setup burden for a non-expert team |

Linux Mint Cinnamon is the choice justified in §3.B.3 and in the
handbook's AUCOOP-image subchapter: it combines a Windows-style
desktop, an Ubuntu LTS base (security maintenance handled upstream),
and acceptable performance on the Lenovo T460 / X260 hardware class.
**OnlyOffice** is selected as the office suite because it produces
files that round-trip reliably with the Microsoft Word/Excel/
PowerPoint formats already in use at the receiving school.

## 2.6 Power systems for unreliable grids

The site-power baseline matters because, as observed in Gochas
(§3.A.8), grid availability is not a given. Three layers of
literature are relevant:

- **UPS sizing principles** for small ICT loads (50–100 W steady,
  600–800 VA UPS class) are well covered in IEEE Std 450 and the
  ITU-T L.1200 power-feeding series. The methodological commitment
  of §3.A.8 is *graceful shutdown over ride-through*, which selects
  a smaller UPS than would be needed to bridge the multi-hour
  outages observed at the site.
- **Battery chemistry trade-offs** between sealed lead-acid (cheap,
  short cycle life, heavy) and LiFePO₄ (expensive, long cycle life,
  light) are increasingly important as LiFePO₄ prices fall; the
  recipe of §3.A.8 is chemistry-agnostic.
- **Solar + battery hybrids** for off-grid or
  worse-than-unreliable-grid sites are out of scope for this thesis
  (the deployments of §4 had a grid connection), but are flagged as
  future-work in §7.

The integration with the software side — automated graceful shutdown
via **NUT** (Network UPS Tools) — is owned by [Motje, 2026]. §3.A.8
guarantees only that the hardware can survive a sudden cut without
data loss on the network devices themselves.

## 2.7 Living documentation as an engineering practice

The most original contribution of this thesis (§3.C) sits in a
literature that is younger and less consolidated than the technical
sections above. Three threads are relevant.

**Docs-as-code.** The practice of treating documentation as
version-controlled source — written in plain text, reviewed as pull
requests, built by CI — is documented as an engineering discipline
by Gentle's *Docs Like Code* [Gentle, 2022] and by widely-cited
corporate handbooks: the **GitLab Handbook**, the **Stripe
documentation**, and the **ArchWiki** contributing guidelines. The
model is mature enough that its conventions (Markdown source,
`mkdocs`/`Sphinx`/`Hugo`/`Docusaurus` generators, PR-based review)
are no longer controversial. What remains debatable is *how thick*
the editorial process should be; §3.C.5 adopts a deliberately thin
process scaled to the contributor pool of a student association.

**The Diátaxis framework** [diataxis.fr] organises documentation
into four modes — tutorials, how-to guides, reference, explanation —
chosen to serve four distinct user needs. The Ch2 (story) ↔ Ch3
(recipe) split of the AUCOOP handbook described in §3.C.2 is a
deliberate simplification of Diátaxis to two complementary modes
that cover the two most-needed user journeys at a small ICT4D
project: *learning the domain* (Ch2 stories) and *executing a task*
(Ch3 recipes). The remaining two Diátaxis modes (reference,
explanation) are folded into the recipes themselves and are flagged
as a future-work direction in §7.

**Static-site generators with dual web/PDF output.** The toolchain
choice of §3.C.3 (Zensical, building on Material for MkDocs) sits in
a field where MkDocs, Hugo, and Docusaurus are the dominant
alternatives. The relevant differentiator for a low-connectivity
context is the ability to produce a *single, self-contained PDF*
alongside the website without dual-maintaining the source; this is
why §3.C.4 elevates the dual-output property from a nice-to-have to
a methodological requirement.

**Contribution models for volunteer associations.** This is the gap.
The literature on open-source contribution (Mozilla's documentation,
Apache's mentor model, the GitLab handbook again) assumes a
contributor pool that is either professional or stable. The
volunteer-association case — contributors who join for one or two
academic years, contribute as part of a thesis, and leave — is
closer to the literature on *volunteer organisations* in non-IT
contexts [Cuskelly et al., 2006; Hager and Brudney, 2004] than to
the mainstream open-source literature. The handbook's *rule files +
subagents + custom commands* model documented in §3.C.5 is, to this
author's knowledge, the first concrete instantiation of an
AI-assisted contribution workflow targeted at this case.

## 2.8 The gap addressed by this thesis

Bringing the threads together: the literature surveyed above is
strong in each individual area, but fragmented across them. A
practitioner attempting an integrated network-plus-endpoint
deployment at a low-resource site today has to assemble the
necessary knowledge from:

- A community-network literature that is policy-rich and
  recipe-poor (§2.1).
- An ICT4D literature that is methodologically self-aware but
  technically thin (§2.2).
- An OpenWrt and Wi-Fi mesh body of documentation that is excellent
  at the per-device level but does not address the full
  site-deployment workflow (§2.3).
- A PXE/Clonezilla body of documentation that covers individual
  steps but does not address known failure modes such as the
  partition-resize problem of §3.B.5 (§2.4).
- A docs-as-code literature that does not address volunteer-cohort
  handover at the scale of a student association (§2.7).

This thesis closes those five gaps simultaneously by producing a
**single integrated artefact** — the AUCOOP Community Network
Handbook (§3.C) — that combines a network deployment methodology
(§3.A), an endpoint deployment methodology (§3.B), the lessons
learned from a real validation site (§4), and an explicit governance
contract for volunteer-cohort continuity (§3.C.5–§3.C.6). The
companion thesis [Motje, 2026] closes the symmetric set of gaps on
the software-services side. Together, the two volumes constitute the
documentation backbone that the next AUCOOP cohort, and the next
student association in their position, can pick up without starting
from a blank page.

The validation against the three lenses of *coverage*, *sufficiency*,
and *adaptation* is presented in §4.
