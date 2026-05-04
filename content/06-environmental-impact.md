# 6. Sustainability
<!-- \label{ch:sustainability} -->
<!-- \label{ch:environmental-impact} -->

The UPC Master Thesis template lists an environmental-impact section
as optional. This thesis treats sustainability as essential and
broader than the environmental dimension alone, because the three
contributions of the work — the OpenWrt mesh recipe, the
refurbished-endpoint pipeline, and the open Community Network
Handbook — are sustainability choices before they are technical
ones. They were chosen because each of them defers, distributes, or
amortises a cost that a conventional commercial deployment would
incur in full and in cash, in carbon, or in displaced labour.

This chapter therefore covers three dimensions in turn:
**environmental** (§6.2), **social and governance** (§6.3) and
**economic** (§6.4), followed by the indirect effects of producing
the work as an open handbook (§6.5), the SDG mapping (§6.6) and the
honest limits of the assessment (§6.7).

---

## 6.1 A holistic frame for a small deployment
<!-- \label{sec:sustainability-frame} -->

The deployment described in this thesis is small: nine refurbished
laptops, seven access points, one gateway, one switch, one school of
roughly 300 pupils. Headline figures expressed in tonnes of CO₂
avoided or thousands of euros saved are easy to write at this scale
and difficult to defend; the chapter therefore prefers per-unit
figures with explicit sources, treats the fleet-level totals as
illustrative, and reports social and economic indicators
qualitatively or as clearly-flagged order-of-magnitude estimates.

The framing borrows its scaffolding from a recent peer-reviewed
study of computer reuse for digital inclusion by the same UPC
research circle that supports this thesis [Roura et al., 2026].
That paper develops an LCA-based calculation criterion for
refurbished ICT in digital-inclusion programmes and characterises
sustainability through three complementary indicators: *GHG
emissions* (kg CO₂eq) for the environmental dimension, *ICT access
hours* as a proxy for digital inclusion (social), and *technician
labour hours* as a proxy for local economic contribution. It also
introduces a comparative scenario apparatus — a baseline (one user
served, one excluded), a reuse scenario (the donated device is
refurbished and reaches a previously unconnected user), and a
new-provision scenario (both users get new devices) — and a
functional unit of *one hour of digital service*, which normalises
across scenarios that deliver different volumes of access.

The Namibia deployment is precisely the kind of low-income,
community-scale empirical case that paper identifies as
under-represented in its own data. This chapter does not attempt
the formal life-cycle assessment that would discharge that gap
(§1.4 places LCA-grade work explicitly out of scope, §6.7 returns
to the limits) but it adopts the three-dimension framing, the
per-hour-of-service intuition, and the triage logic for refurbished
devices, because they let the thesis say things about the
deployment that an environmental-only chapter could not.

A boundary note is in order. Software-side sustainability — the
energy footprint of the cloud and on-premises services running on
top of the network, the OS-lifecycle question for the services
stack, the long-term support burden of the application layer — is
treated in the companion thesis [Motje, 2026]. The present chapter
stays on the hardware side: the network fabric, the endpoint fleet,
the donor pipeline, and the handbook recipe that ties them
together.

---

## 6.2 Environmental dimension
<!-- \label{sec:environmental-dimension} -->

The environmental case rests on a single arithmetic asymmetry
between manufacturing-phase and use-phase emissions, which §6.2.1
develops; on the per-hour-of-access reframing of §6.2.2; on the
operational footprint of the deployed system in the Namibian grid
(§6.2.3); and on the WEEE / end-of-life argument of §6.2.4.

### 6.2.1 Embedded carbon and the avoided-production argument
<!-- \label{sec:embedded-carbon-avoided} -->

Section 2.2 stated, without elaboration, that the manufacturing-phase
emissions of a laptop dominate its life-cycle footprint. That
observation is the foundation of the entire environmental argument
and deserves to be developed here.

Published life-cycle assessments of business-grade laptops converge
on a manufacturing-phase footprint in the range of **200–300 kg
CO₂-equivalent per unit**, with extraction and processing of metals
(particularly the printed-circuit-board substrate, the display, and
the battery) accounting for the majority. Manufacturer-published
product carbon footprints — Dell, HP and Lenovo all publish them
machine by machine — sit in the same range, and the recent reuse-LCA
literature (André et al., 2019; Hischier and Böni, 2021) reports
GWP100 reductions of roughly 10–50 % when device lifetimes are
extended through reuse. The figures used in this thesis are taken
from those public datasheets and from the eReuse project's aggregated
estimates rather than from a single source, so the band is wide on
purpose.

The use-phase footprint of the same machine, by contrast, is small.
A laptop drawing 25 W on average for four hours per day consumes
roughly **36 kWh per year**. With the European average grid intensity
of around 250 g CO₂eq/kWh, that is about **9 kg CO₂eq per year**,
or **45 kg over a five-year corporate life cycle**. End-of-life
processing adds a further few kilograms.

The arithmetic is therefore stark. A new laptop is responsible for
roughly **250 kg CO₂eq before it is switched on**, and for a
further **~10 kg per year of use**. Extending the service life of
an existing machine by five years avoids the larger number entirely;
manufacturing a replacement does not. This single observation makes
refurbishment environmentally significant, and it is the reason
requirement H2 in §1.3 (endpoints must be refurbished, not new) is
written as a hard constraint rather than a preference.

Applied to the Namibia deployment, the per-unit figure scales as:

| Stream | Units | Embodied CO₂eq/unit | Avoided new production |
|---|---:|---:|---:|
| Refurbished laptops (Lenovo T460 / X260) | 9 | ~250 kg | **~2.25 t** |
| Cudy WR3000E access points | 7 | (not published) | not estimated |
| NanoPi R6S gateway | 1 | (not published) | not estimated |
| TP-Link PoE switch | 1 | (not published) | not estimated |

The 2.25-tonne figure should be read narrowly. It is the
manufacturing footprint of nine equivalent new laptops that did not
need to be produced because nine refurbished machines were sourced
from Labdoo and NexTReT. It is **not** a net life-cycle saving for
the project as a whole, because the refurbished machines themselves
carry an unamortised share of their own original manufacturing
footprint and because transport from Spain to Namibia is not netted
here (§6.7). A more rigorous accounting along the lines of
[Roura et al., 2026] would attribute that share proportionally to
the second use through a Power-On-Hours-based allocation
(*Allocation at the Point of Substitution*) and divide by the
hours of digital service actually delivered; the per-useful-hour
figure remains substantially lower than that of a new machine,
which is the point, but the headline tonnage shrinks.

The argument applies less cleanly to network hardware. A consumer
access point such as the Cudy WR3000E used in this deployment has a
substantially smaller manufacturing footprint than a laptop —
manufacturers do not publish per-unit figures, but the device
contains no display, no battery, and far less metal — and its
use-phase draw of roughly 5 W is also smaller. The environmental
case for OpenWrt on commodity hardware is therefore not primarily
a carbon argument; it is a longevity argument (firmware support
beyond the vendor's window) and a repairability argument (commodity
parts, no vendor lock-in for spares). Both extend the useful life
of the device, and both reduce the rate at which it enters the
WEEE stream.

### 6.2.2 Reuse efficiency per hour of digital access
<!-- \label{sec:reuse-efficiency} -->

The headline question — *is reuse green?* — is the wrong question
at this scale. The right question is the one [Roura et al., 2026]
formulate explicitly: *is reuse the most carbon-efficient way to
deliver an hour of digital access to a community that did not have
it?* The reframing matters because absolute emissions can mislead.
A reuse scenario that brings a previously unconnected user onto
the network *adds* operational electricity demand that the
disconnected baseline did not have; the additional kilowatt-hours
are real, and a naive comparison will conclude that reuse is worse
than not reusing. The per-hour-of-service framing absorbs this
correctly: the additional emissions are amortised over the new
service hours delivered to the additional user, and the ratio
favours reuse over new manufacture in essentially every electricity
mix that paper examines.

For the Namibia deployment, the order-of-magnitude estimate runs
as follows. Nine refurbished laptops, used in classrooms during
school hours at roughly 15 hours per week over a 36-week academic
year, deliver indicatively **~4 860 hours of supervised digital
access per academic year** — a figure that scales with rotation
patterns and cannot be defended to two significant figures, but
which sits in the correct order of magnitude (10³–10⁴ h/yr).
Distributing the avoided-manufacturing footprint of §6.2.1 over
the conservative five-year service life used elsewhere in this
thesis gives roughly **~24 300 service-hours per fleet-life**, and
roughly **~90 g CO₂eq per service-hour avoided** at the per-laptop
~250 kg / fleet-life embedded carbon. The figure is indicative
only — it ignores allocation across successive users in the eReuse
sense, and it does not net transport — but it has the right
shape: refurbishment moves the per-hour-of-access emissions
intensity well below what new provision would produce in any
electricity mix.

The same logic informs a practical operational rule that
[Roura et al., 2026, §6.6] make explicit: *not every donated device
should be refurbished*. Devices with very long first-use
histories — heavy Power-On-Hours counters, accumulated wear — can
reach a point where the additional use-phase emissions during the
second life cancel the avoided production emissions, especially in
carbon-intensive electricity grids. The donor pipeline this thesis
relies on (Labdoo, NexTReT) already practises such triage
informally, by rejecting machines whose components do not meet a
minimum spec; the present chapter notes that the same triage has a
defensible environmental rationale, and that future cohorts using
the handbook recipe should treat the donor-side triage threshold as
a parameter to be revisited as the local grid decarbonises.

### 6.2.3 Operational energy in the Namibian grid

The use-phase footprint of the deployed system is small but
calculable. The estimates below assume the school operates the
network during teaching hours and powers the laptops down outside
those hours.

| Device | Units | Power (avg) | Hours/day | kWh/year |
|---|---:|---:|---:|---:|
| Cudy WR3000E AP | 7 | ~5 W | 12 | ~153 |
| NanoPi R6S gateway | 1 | ~4 W | 24 | ~35 |
| TP-Link PoE switch | 1 | ~15 W (with 7 PoE loads) | 12 | ~66 |
| Refurbished laptops in use | 9 | ~25 W | 4 | ~329 |
| **Total** | | | | **~583 kWh/year** |

At the European grid intensity of ~250 g CO₂eq/kWh the operational
footprint is roughly **150 kg CO₂eq per year**. The Namibian grid
is considerably more carbon-intensive — the country imports a
significant share of its electricity from coal-heavy South Africa,
and country-level grid-intensity datasets [Our World in Data, 2025]
report values above 700 g CO₂eq/kWh — so the local figure is
closer to **400 kg CO₂eq per year**. Either number is dwarfed by
the manufacturing footprint of a single new laptop, which
reinforces the argument of §6.2.1: at this class of deployment, the
lever that matters is hardware longevity, not operational
efficiency. The regional sensitivity is also exactly the one
[Roura et al., 2026] document at country scale: reuse benefits are
robust everywhere but largest where grids are already low-carbon,
and decarbonisation of the supply side amplifies them further.

The operational figure also exposes a design assumption that the
handbook records explicitly: the network is sized for the school's
teaching schedule, not for 24/7 operation. The seven access points
draw about 35 W collectively; running them around the clock would
add roughly 150 kWh per year, a third of the laptop usage above.
The recipe therefore recommends that sites with constrained power
schedule the APs down during off-hours where doing so does not
break legitimate overnight uses (for example, a teacher uploading
content from home in the evening). This is the kind of operational
detail that only emerges from running a real deployment and that
the handbook is the right place to capture.

### 6.2.4 E-waste, WEEE, and end-of-life

The European Union's **WEEE Directive 2012/19/EU** sets the
framework within which refurbishment operates. The directive
establishes a hierarchy — prevention, preparation for reuse,
recycling, recovery, disposal — and obliges member states to
maximise the upstream tiers. *Preparation for reuse* is the tier
into which the work described in this thesis falls: the laptops
were collected before they entered the recycling stream, tested,
repaired where necessary, and returned to service.

The contribution at deployment scale is modest in mass terms — nine
laptops weigh roughly 15 kg, plus a few kilograms of network
hardware — but the contribution at *system* scale is what matters.
Every refurbished machine sourced from Labdoo or NexTReT is one
fewer unit that needs WEEE processing this year, and one further
year before the unit eventually does enter that stream. The
deployment is therefore better understood as a node in an existing
reuse network than as a standalone intervention; the network is
the unit of analysis, not this particular shipment.

A second-order effect, harder to quantify but worth naming, is the
**deferral** of e-waste rather than its prevention. The
refurbished laptops will eventually fail and will need to be
processed. The recipe captured in the handbook does not currently
address that end-of-life moment for community-network sites that
lack access to formal WEEE infrastructure — Namibia, in
particular, has no EU-equivalent collection scheme. Section 7.4
lists this as an open research direction.

---

## 6.3 Social and governance dimension
<!-- \label{sec:social-governance} -->

A sustainable deployment is one that *outlasts the team that
deployed it*. The social and governance dimension captures the
mechanisms by which this work is intended to do so: by delivering
measurable digital access (§6.3.1), by planning for knowledge
continuity through the open handbook and the volunteer pipeline
(§6.3.2), and by building local capacity and a partner network
that does not require the original team's continued presence
(§6.3.3). These mechanisms are the social analogue of the
*technician labour hours* indicator [Roura et al., 2026] use to
trace local economic contribution; they are reported here
qualitatively because, at one school and one season of operation,
quantitative claims would be unsafe.

### 6.3.1 Digital inclusion delivered

The *coverage* and *sufficiency* lenses of §4.2 and §4.3 give the
qualitative answer: every classroom that the deployment intended to
reach is now reached, every endpoint that the deployment intended
to provision is now in service, and the school's teaching staff
adopted the network within roughly thirty minutes of it going live
(§4.2.3). The order-of-magnitude estimate of §6.2.2
(~4 860 hours of supervised digital access per academic year)
expresses the same fact in a different unit: classroom access at a
scale that did not exist before the deployment.

The structural claim is stronger than the per-school number. The
recipe, the donor pipeline, and the handbook together form a
*reproducible pathway* from "this school has no usable network
and no usable endpoints" to "this school has both, and a partner
organisation that knows how to maintain them". The single-school
validation does not prove this generalises (§4.6.2, §7.3) but it
makes a cohort-level claim defensible: applying the same recipe
to a second school of comparable size in the same partner
network would be expected to produce comparable digital access on
broadly the same effort budget.

### 6.3.2 Knowledge continuity and the volunteer pipeline

AUCOOP's structural fragility — students join, contribute for one
to three academic years, graduate, leave — was the *internal*
motivation of §1.2.2 and is the social-sustainability problem
this thesis attacks most directly. The *living artefact* (§3.C)
is the engineering response: knowledge that lives in a
version-controlled, public Markdown repository, with a low
contribution barrier and a published governance contract, is
knowledge that does not leave the association when its current
maintainers do. The hand-over protocol of §7.5 is the operational
expression of this commitment: it tells the next cohort exactly
where to start, which makes the cost of taking over lower than the
cost of starting from scratch — which is, in turn, the only
condition under which a volunteer organisation actually achieves
intergenerational continuity.

The handbook is therefore a *governance instrument* as well as a
technical artefact. Its sustainability claim is not "the
documentation is current" — that is true of every wiki on the
day it is set up and false of most of them six months later — but
"the rules of the game make it cheaper to update the
documentation than to bypass it". That property is what §3.C.6
calls the contribution contract, and it is what §4.4 validates by
showing that the deployment itself authored against the same
rules.

### 6.3.3 Local capacity and the partner network

The deployment was executed in collaboration with local
counterparts — Gerda (school director), Theo Pauline (children's
home), Mr. Isaak and the school staff (§4.1) — and with a
multi-organisation partner chain (UPC CCD, AUCOOP, Foundawtion,
Labdoo, NexTReT, the Namaqua Kalahari Children's Hope project).
Each link in that chain is itself a sustainability mechanism:
UPC CCD is the funding pathway that the next cohort can apply to
on the same call (§5.6); Foundawtion is the logistical pathway
that the next shipment can ride; Labdoo and NexTReT are the
device-supply pathways that the next batch of endpoints can come
through; AUCOOP is the volunteer pathway that the next student
can be recruited into.

None of these relationships were *created* by this thesis. Each
of them existed before; the thesis exercises them, documents how
they were exercised in §4.4 and §5.6, and leaves the partner
register in a state where the next cohort can read it rather than
reconstruct it. This is the social-sustainability analogue of
the technical-handover argument of §6.3.2: the partner network is
the thing the recipe runs on, and an undocumented partner network
is an unsustainable one.

---

## 6.4 Economic dimension
<!-- \label{sec:economic-sustainability} -->

The economic case for the recipe rests on two claims that
Chapter 5 develops in detail: that the *cash* cost of a deployment
is small enough to be raised from a single small NGO grant
(§5.6, §5.7), and that the donation-leveraged structure of the
endpoint pipeline turns a modest cash spend into a substantially
larger asset base on the ground (§5.2). This section reframes
those claims through the sustainability lens: not "is the
deployment cheap?" but "is the deployment *replicable* by an
organisation that looks like AUCOOP, in a way that does not
depend on the present team's continued personal involvement?".

### 6.4.1 Cash vs full cost and the leverage on donations

The two totals of §5.7 — **~5.8 k€ cash** and **~48 k€ full
project at indicative engineering rates** — are not in tension;
they are two answers to two different questions. The cash figure
is what an organisation actually has to *raise* to reproduce the
recipe at a comparable site; the full-project figure is what the
same recipe would *cost* if every hour of student and advisor
time were paid at market. The ~3.5× cash multiple over the
commercial-equivalent alternative (§5.9) is computed at the cash
figure, because that is the figure a cooperating association can
act on; the larger multiple at the full-project figure (~2.4×)
is the same trade-off measured against a fairer wage baseline.

The donation pipeline is the multiplier that makes either figure
possible. Nine T460 / X260 ThinkPads at a notional refurbished
secondary-market price of ~€150 each represent ~€1 350 of asset
value mobilised at ~€460 of refurbishment cash spend (§5.2): a
~3:1 leverage. The same ratio scales to the next deployment if
the donor pipeline holds, which is the real economic-
sustainability question and which §6.4.2 returns to.

The €4-per-student-per-year figure of §5.8 is the
cost-effectiveness number that lands on a funding committee's
desk. It compares favourably with the ICT-for-education
benchmarks surveyed in §2.3, and it does so without ascribing zero
cost to volunteer labour: the figure is robust across both the
cash and the full-project denominators because a primary school of
~300 pupils is a sufficiently large beneficiary base to absorb
the engineering cost over a five-year service life.

### 6.4.2 Volunteer labour, replicability, and the reuse-at-scale claim

[Roura et al., 2026] use *technician labour hours* as their
proxy for the local-economic contribution of refurbishment. The
analogue in the AUCOOP context is *volunteer engineering hours*
(§5.4: ~720 student-hours per thesis plus ~80 AUCOOP volunteer
hours for intake and logistics, two-thesis batch), with two
qualifications. First, the labour is unpaid in the cash sense
but is not free: it is paid in academic credit, in the
career-relevance of the experience, and in the network of
partner organisations the volunteer ends up embedded in. Second,
the labour is regenerative: the contribution model of §3.C.6
ensures that the marginal hour spent by the next cohort lands in
the handbook, not in a private notebook, and the handbook is
what makes the *next* cohort's hour cheaper.

The replicability question is therefore not "can a second school
be deployed for under €5 800?" — the cash figure is robust enough
to defend that claim within the AUCOOP donor and partner network
— but "can a second school be deployed without the present
authors in the room?". The handbook (§3.C, §4.4), the hand-over
protocol (§7.5), and the partner-network documentation (§6.3.3)
are the three mechanisms by which the answer is intended to be
yes; the empirical confirmation is future work (§7.4) and is
listed there honestly.

The same paper observes that scaling reuse expands ICT access
and technician labour demand together, while keeping additional
emissions moderate compared with new-device strategies. The
AUCOOP case does not attempt to verify that result at programme
scale, but it instantiates the claim at deployment scale: a
volunteer-driven reuse pathway delivered both digital access and
documented local engagement at a fraction of the cash cost of the
commercial alternative, and the recipe is structured to do so
again.

---

## 6.5 Indirect effects of the open handbook

A second category of sustainability effect is harder to quantify
but worth stating, because it is intrinsic to the choice of
producing a public, versioned handbook rather than a single
project report.

**Avoided travel for know-how transfer.** The handbook is
asynchronous and self-service. A second cohort attempting a
similar deployment does not need a Barcelona-based engineer to
fly out to brief them; the material is there to read. For an
AUCOOP-scale operation that is one or two long-haul flights per
project saved, which at typical intercontinental footprints
translates to roughly **1–2 t CO₂eq per avoided trip** — an order
of magnitude larger than the per-unit manufacturing figure of
§6.2.1.

**Reduced duplication of lab work.** The decisions documented in
the handbook — Cudy WR3000E over alternative APs, OpenWrt
24.10.x over snapshot, the resized AUCOOP image rather than the
original — were made at the cost of bench time and, in some
cases, bricked or reset hardware. A second cohort reading the
handbook does not repeat those costs. The energy and material
savings per avoided wrong turn are small individually but
accumulate across the lifetime of the artefact.

**Avoided over-specification.** The handbook's bias toward
*sufficiency* — sizing antennas to the link budget rather than
to the catalogue, choosing the smaller AP where coverage allows
it — is a sustainability choice along all three dimensions. It
is environmental (every AP not deployed is a manufacturing
footprint not incurred and an operational draw not added),
economic (every line item not procured is cash not spent and
not raised), and social (a smaller deployment is one a partner
organisation can maintain on its own resources). The bias is
captured in the *Network-Planning* and *Antennas* recipes and is
reinforced through the methodology of §3.A.

These effects cannot be totalled credibly. They are listed here
so that the sustainability argument for the handbook is not
silently omitted; the argument for the handbook stands or falls
on reproducibility (§3.C, §4.4), and the sustainability dimension
is a bonus rather than the primary motivation.

---

## 6.6 Alignment with the UN Sustainable Development Goals

The deployment intersects seven of the seventeen UN Sustainable
Development Goals. The mapping below is included for completeness;
SDG-alignment statements are easy to over-claim and are written
here narrowly, restricted to mechanisms that are concretely
instantiated in the work described in §3 and §4.

| SDG | Mechanism in this work |
|---|---|
| **4 — Quality Education** | Connectivity and endpoints delivered to a primary school in a low-connectivity context (§4.2, §4.3). |
| **8 — Decent Work and Economic Growth** | Volunteer engineering hours channelled into a regenerative knowledge artefact rather than a single-project report (§6.4.2); donor-pipeline labour quantified (§5.4). |
| **9 — Industry, Innovation & Infrastructure** | A reproducible community-network recipe published as an open handbook (§3.C, §4.4). |
| **10 — Reduced Inequalities** | The deployment targets a school with limited prior ICT access; the open handbook lowers the barrier for similar sites to follow (§3.C, §6.3.1). |
| **12 — Responsible Consumption & Production** | Endpoint requirement H2 (refurbishment over new), commodity network hardware, sufficiency bias in design (§6.2, §6.5). |
| **13 — Climate Action** | Embedded-carbon avoidance through refurbishment and lifetime extension (§6.2.1, §6.2.2). |
| **17 — Partnerships for the Goals** | The deployment is the product of a partnership chain — UPC CCD, AUCOOP, Foundawtion, Labdoo, NexTReT, the local school authority — that the handbook documents and makes legible to future partners (§4.4, §6.3.3). |

The list is shorter than is conventional in SDG-alignment
exercises; goals that the deployment does not concretely address
(water, hunger, gender equality, marine ecosystems) are
deliberately omitted rather than stretched to fit. The point of
the table is to locate the work in the international policy
frame, not to claim credit for it.

---

## 6.7 Limits of this analysis
<!-- \label{sec:env-limits} -->
<!-- \label{sec:sustainability-limits} -->

This chapter is not a life-cycle assessment, nor a social or
economic LCA in the formal sense. It uses per-unit figures from
public sources, applies them to a small deployment, and reports
the result as an order-of-magnitude check rather than as a
defensible inventory. Five limitations should be made explicit
before any of its numbers are reused.

First, **transport is not netted**. Shipping nine laptops from
Spain to Namibia carries a per-unit footprint that partially
offsets the avoided manufacturing; this chapter does not estimate
it. The omission matters less for in-region deployments (which
AUCOOP also runs) and more for inter-continental ones such as
Namibia.

Second, **the refurbishment process itself has a footprint**.
Replacement parts (storage, batteries, the occasional palmrest),
the energy used during testing and imaging, and the human travel
to collect and consolidate donations all carry costs that this
chapter does not enumerate. The eReuse project has done some of
this accounting at programmatic scale (Roura et al., 2024;
Roura et al., 2026); this thesis does not reproduce it.

Third, **the figures are one-shot**. Section 6.5 argues that the
handbook compounds sustainability across all three dimensions by
enabling reuse; quantifying that compounding requires data on how
often the recipe is reused, by whom, and at what scale. That
data does not yet exist, because the handbook is new. Section 7.4
lists longitudinal measurement of recipe reuse as one of the
future-work directions, and §4.4 identifies the corresponding
metrics — repository activity, downstream forks, citations —
that would feed such a measurement.

Fourth, **the social and economic indicators are qualitative or
indicative**. The ICT access hours of §6.3.1 / §6.2.2 and the
volunteer-hours figures of §6.4.2 are useful for ordering of
magnitude but are not derived from instrumented measurement; a
defensible study would log Power-On-Hours per device along the
lines of [Roura et al., 2026] and would distinguish supervised
classroom hours from total hours powered. The handbook does not
yet recommend such logging; adding it is a candidate future
revision.

Fifth, **the framework is borrowed, not extended**. This chapter
adopts the three-dimension indicator set and the
per-hour-of-service framing of [Roura et al., 2026] and applies
them qualitatively to the Namibia case. It does not extend the
calculation criterion the paper develops, nor does it offer the
NMPS deployment as a low-income empirical contribution to that
literature in any rigorous form. Section 7.4 names the latter
contribution as the natural shape of a follow-on study.

The honest summary is that the sustainability argument of this
thesis is qualitatively strong across all three dimensions and
quantitatively conservative in each. The direction is unambiguous:
refurbishment over new manufacture, commodity over proprietary,
sufficiency over over-specification, open documentation over
private capture, regenerative volunteer labour over one-off
deployments. The magnitudes deserve a more thorough assessment
than this chapter provides — environmentally a defensible LCA
along the eReuse / [Roura et al., 2026] lines, socially a
longitudinal study of the partner network, economically a
multi-deployment cost analysis — and the handbook is the right
place to host that work as it matures.
