# 6. Sustainability
<!-- \label{ch:sustainability} -->
<!-- \label{ch:environmental-impact} -->

A school in rural Namibia now has classroom Wi-Fi and nine working
laptops. The cash bill came in under €6 000, the laptops were
donated rather than bought, and the recipe that produced both is
public. Each of those facts is a sustainability choice — and that
is the point of this chapter.

The three contributions of the thesis — the OpenWrt mesh, the
refurbished-laptop pipeline, and the open handbook — were not
chosen for technical elegance. They were chosen because they push
the cost of doing this work *down*: down in carbon, because no new
laptop had to be manufactured; down in money, because a single small
NGO grant covered the deployment; and down in effort for the next
team, because the lessons are written down where they can find
them. A commercial deployment would have paid all three costs in
full.

This chapter argues that case along three dimensions:
**environmental** (§6.2 — the carbon avoided when a laptop is
reused instead of replaced), **social and governance** (§6.3 — the
classroom access delivered and the knowledge made to outlast its
authors), and **economic** (§6.4 — a budget small enough to be
raised again, and a donation pipeline that multiplies what the
budget buys). Section §6.5 picks up the indirect effects of
publishing the work as an open handbook, §6.6 maps the work to
seven UN Sustainable Development Goals, and §6.7 is honest about
what a small deployment can and cannot prove.

---

## 6.1 Why three dimensions, and why this framing
<!-- \label{sec:sustainability-frame} -->

Headline numbers are easy to write at the scale of one school and
hard to defend. *Tonnes of CO₂ avoided*, *thousands of euros
saved*: at nine laptops and seven access points, both phrasings
flatter the deployment more than they describe it. The chapter
therefore works in per-unit figures with named sources, treats the
fleet totals as illustrative, and gives the social and economic
indicators in plain language or as clearly-flagged
order-of-magnitude estimates.

The three-dimension structure is not invented here. It is borrowed
from a recent paper by the same UPC research group that supports
this work [Roura et al., 2026], which proposes three indicators for
sustainability assessment of refurbished computing in
digital-inclusion programmes:

- *GHG emissions* (kg CO₂eq) — the environmental indicator;
- *ICT access hours* — a proxy for the social benefit, i.e. the
  digital inclusion actually delivered;
- *technician labour hours* — a proxy for the local economic
  contribution.

The same paper proposes a single yardstick — *one hour of digital
service* — so that scenarios delivering different volumes of access
can be compared on the same axis, and three reference scenarios:
*baseline* (one user served, one excluded), *reuse* (a donated
device is refurbished and reaches a previously unconnected user),
and *new provision* (both users get new devices). The Namibia
deployment is exactly the kind of low-income, community-scale case
that paper says is missing from its own data.

This chapter does not run the formal life-cycle assessment that
would close that gap; §1.4 places LCA-grade work out of scope, and
§6.7 returns to what that costs the analysis. What it does is
borrow the three-dimension lens, the per-hour-of-service intuition,
and the rule that *not every donated device should be reused* —
because together they let the chapter say things about the
deployment that an environment-only chapter could not.

One boundary note. Software-side sustainability — the energy used
by the services running on top of the network, the lifecycle of
the application stack, the long-term support burden of the cloud
side — is the territory of the companion thesis [Motje, 2026].
This chapter stays on the hardware side: the network, the laptops,
the donation pipeline, and the handbook recipe that ties them
together.

---

## 6.2 Environmental dimension
<!-- \label{sec:environmental-dimension} -->

The environmental case rests on a single arithmetic gap between
manufacturing-phase and use-phase emissions, which §6.2.1 develops;
on the per-hour-of-access reframing of §6.2.2; on the operational
footprint of the deployed system in the Namibian grid (§6.2.3);
and on the WEEE / end-of-life argument of §6.2.4.

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

\begin{table}[htbp]
\caption{Avoided new-production emissions by hardware stream — Namibia 2026 deployment}
\begin{tabularx}{\linewidth}{>{\raggedright\arraybackslash}p{4.8cm}>{\raggedleft\arraybackslash}p{0.8cm}>{\raggedleft\arraybackslash}p{3.0cm}>{\raggedleft\arraybackslash}p{3.0cm}}
\toprule
Stream & Units & Embodied CO\textsubscript{2}eq/unit & Avoided new production \\
\midrule
Refurbished laptops (Lenovo T460 / X260) & 9 & \textasciitilde250 kg & \textbf{\textasciitilde2.25 t} \\
Cudy WR3000E access points & 7 & (not published) & not estimated \\
NanoPi R6S gateway & 1 & (not published) & not estimated \\
TP-Link PoE switch & 1 & (not published) & not estimated \\
\bottomrule
\end{tabularx}
\end{table}

The 2.25-tonne figure should be read narrowly. It is the
manufacturing footprint of nine equivalent new laptops that did not
need to be produced because nine refurbished machines were sourced
from Labdoo and NexTReT. It is **not** a net life-cycle saving for
the project as a whole: the refurbished machines themselves carry
an unaccounted share of their own original manufacturing footprint,
and shipping from Spain to Namibia is not netted here (§6.7). A
more rigorous accounting along the lines of [Roura et al., 2026]
would split that share across the second use through a Power-On-
Hours-based rule (*Allocation at the Point of Substitution*) and
divide by the hours of digital service actually delivered. The
per-useful-hour figure stays well below that of a new machine —
which is the point — but the headline tonnage shrinks.

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
ask directly: *is reuse the most carbon-efficient way to deliver
an hour of digital access to a community that did not have it?*
The reframing matters because absolute emissions can mislead. A
reuse scenario that brings a previously unconnected user onto the
network *adds* electricity demand that the disconnected baseline
did not have; a naïve comparison concludes that reuse is worse than
not reusing. The per-hour-of-service framing fixes this: the
extra emissions are spread over the new service hours delivered to
the new user, and the ratio favours reuse over new manufacture in
essentially every electricity mix that paper looks at.

For the Namibia deployment the order-of-magnitude estimate runs as
follows. Nine refurbished laptops, used in classrooms during school
hours at roughly 15 hours per week over a 36-week academic year,
deliver roughly **~4 860 hours of supervised digital access per
academic year** — a figure that scales with rotation patterns and
cannot be defended to two significant figures, but which sits in
the right order of magnitude (10³–10⁴ h/yr). Spreading the
avoided-manufacturing footprint of §6.2.1 over the conservative
five-year service life used elsewhere in this thesis gives roughly
**~24 300 service-hours per fleet-life**, and roughly **~90 g
CO₂eq per service-hour avoided** at the per-laptop ~250 kg /
fleet-life embedded carbon. The figure is indicative only — it
ignores allocation across successive users in the eReuse sense,
and it does not net transport — but the shape is right:
refurbishment pushes the per-hour-of-access emissions well below
what new provision would produce in any electricity mix.

The same logic informs a practical operational rule that
[Roura et al., 2026, §6.6] state plainly: *not every donated device
should be refurbished*. Devices with very long first-use histories
— heavy Power-On-Hours counters, accumulated wear — can reach a
point where the extra use-phase emissions during the second life
cancel the avoided production emissions, especially in
carbon-intensive electricity grids. The donor pipeline this thesis
relies on (Labdoo, NexTReT) already does this kind of triage
informally, by rejecting machines whose components do not meet a
minimum spec; the chapter notes that the same triage has a sound
environmental rationale, and that future cohorts using the
handbook recipe should treat the donor-side threshold as a
parameter to be revisited as the local grid decarbonises.

### 6.2.3 Operational energy in the Namibian grid

The use-phase footprint of the deployed system is small but
calculable. The estimates below assume the school operates the
network during teaching hours and powers the laptops down outside
those hours.

\begin{table}[htbp]
\caption{Estimated annual operational energy consumption — Namibia deployment}
\begin{tabularx}{\linewidth}{>{\raggedright\arraybackslash}p{4.0cm}>{\raggedleft\arraybackslash}p{0.8cm}>{\raggedleft\arraybackslash}p{3.0cm}>{\raggedleft\arraybackslash}p{1.5cm}>{\raggedleft\arraybackslash}p{2.0cm}}
\toprule
Device & Units & Power (avg) & Hours/day & kWh/year \\
\midrule
Cudy WR3000E AP & 7 & \textasciitilde5 W & 12 & \textasciitilde153 \\
NanoPi R6S gateway & 1 & \textasciitilde4 W & 24 & \textasciitilde35 \\
TP-Link PoE switch & 1 & \textasciitilde15 W (with 7 PoE loads) & 12 & \textasciitilde66 \\
Refurbished laptops in use & 9 & \textasciitilde25 W & 4 & \textasciitilde329 \\
\textbf{Total} & & & & \textbf{\textasciitilde583 kWh/year} \\
\bottomrule
\end{tabularx}
\end{table}

At the European grid intensity of ~250 g CO₂eq/kWh the operational
footprint is roughly **150 kg CO₂eq per year**. The Namibian grid
is much more carbon-intensive — the country imports a large share
of its electricity from coal-heavy South Africa, and country-level
grid-intensity datasets [Our World in Data, 2025] report values
above 700 g CO₂eq/kWh — so the local figure is closer to **400 kg
CO₂eq per year**. Either number is dwarfed by the manufacturing
footprint of a single new laptop, which reinforces the point of
§6.2.1: at this size of deployment, the lever that matters is
hardware longevity, not operational efficiency. The regional
sensitivity is also exactly the one [Roura et al., 2026] document
at country scale: reuse benefits are robust everywhere but largest
where grids are already low-carbon, and grid decarbonisation
amplifies them further.

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

A sustainable deployment is one that *outlasts the team that built
it*. The social and governance dimension covers the mechanisms by
which this work is meant to do so: by delivering measurable digital
access (§6.3.1), by planning for knowledge continuity through the
open handbook and the volunteer pipeline (§6.3.2), and by building
local capacity and a partner network that does not depend on the
original team being there (§6.3.3). These are the social side of
the *technician labour hours* indicator [Roura et al., 2026] use to
trace local economic contribution; they are reported here in plain
language because, with one school and one season of operation,
quantitative claims would be unsafe.

### 6.3.1 Digital inclusion delivered

The *coverage* and *sufficiency* lenses of §4.2 and §4.3 give the
qualitative answer: every classroom the deployment was meant to
reach is now reached, every laptop it was meant to provision is
now in service, and the school's teaching staff adopted the
network within roughly thirty minutes of it going live (§4.2.3).
The order-of-magnitude estimate of §6.2.2 (~4 860 hours of
supervised digital access per academic year) says the same thing
in a different unit: classroom access at a scale that did not
exist before the deployment.

The structural claim is stronger than the per-school number. The
recipe, the donor pipeline, and the handbook together form a
*reproducible pathway* from "this school has no usable network and
no usable endpoints" to "this school has both, and a partner
organisation that knows how to maintain them". The single-school
validation does not prove this generalises (§4.6.2, §7.3) but it
makes a cohort-level claim defensible: applying the same recipe
to a second school of comparable size in the same partner network
should produce comparable digital access on broadly the same
effort budget.

### 6.3.2 Knowledge continuity and the volunteer pipeline

AUCOOP's structural fragility — students join, contribute for one
to three academic years, graduate, leave — was the *internal*
motivation of §1.2.2 and is the social-sustainability problem this
thesis attacks most directly. The *living artefact* (§3.C) is the
engineering response: knowledge that lives in a version-controlled,
public Markdown repository, with a low contribution barrier and a
written governance contract, is knowledge that does not leave the
association when its current maintainers do. The hand-over
protocol of §7.5 is the operational form of this commitment: it
tells the next cohort exactly where to start, which makes the
cost of taking over lower than the cost of starting from scratch
— which is, in turn, the only condition under which a volunteer
organisation actually achieves intergenerational continuity.

The handbook is therefore a *governance instrument* as well as a
technical artefact. Its sustainability claim is not "the
documentation is current" — that is true of every wiki on the day
it is set up and false of most of them six months later — but
"the rules of the game make it cheaper to update the
documentation than to bypass it". That property is what §3.C.6
calls the contribution contract, and it is what §4.4 validates by
showing that the deployment itself was authored against the same
rules.

### 6.3.3 Local capacity and the partner network

The deployment was carried out together with local counterparts —
Gerda (school director), Theo Pauline (children's home),
Mr. Isaak and the school staff (§4.1) — and with a
multi-organisation partner chain (UPC CCD, AUCOOP, Foundawtion,
Labdoo, NexTReT, the Namaqua Kalahari Children's Hope project).
Each link in that chain is itself a sustainability mechanism:
UPC CCD is the funding pathway that the next cohort can apply to
on the same call (§5.6); Foundawtion is the logistics pathway
that the next shipment can ride; Labdoo and NexTReT are the
device-supply pathways for the next batch of endpoints; AUCOOP
is the volunteer pathway through which the next student is
recruited.

None of these relationships were *created* by this thesis. Each
of them existed before; the thesis exercises them, documents how
they were exercised in §4.4 and §5.6, and leaves the partner
register in a state where the next cohort can read it rather than
reconstruct it. This is the social-sustainability counterpart of
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
endpoint pipeline turns a modest cash spend into a much larger
asset base on the ground (§5.2). This section reframes those
claims through the sustainability lens: not "is the deployment
cheap?" but "is the deployment *replicable* by an organisation
that looks like AUCOOP, in a way that does not depend on the
present team being personally involved?".

### 6.4.1 Cash vs full cost and the leverage on donations

The two totals of §5.7 — **~5.8 k€ cash** and **~48 k€ full
project at indicative engineering rates** — are not in tension;
they answer two different questions. The cash figure is what an
organisation actually has to *raise* to reproduce the recipe at a
comparable site; the full-project figure is what the same recipe
would *cost* if every hour of student and advisor time were paid
at market rates. The ~3.5× cash multiple over the
commercial-equivalent alternative (§5.9) is computed at the cash
figure, because that is the figure a partner association can act
on; the larger multiple at the full-project figure (~2.4×) is the
same trade-off measured against a fairer wage baseline.

The donation pipeline is the multiplier that makes either figure
possible. Nine T460 / X260 ThinkPads at a notional refurbished
secondary-market price of ~€150 each represent ~€1 350 of asset
value mobilised at ~€460 of refurbishment cash spend (§5.2): a
~3:1 leverage. The same ratio scales to the next deployment if
the donor pipeline holds, which is the real economic-
sustainability question and which §6.4.2 returns to.

The €4-per-student-per-year figure of §5.8 is the
cost-effectiveness number that lands on a funding committee's
desk. It compares well with the ICT-for-education benchmarks
surveyed in §2.3, and it does so without pretending volunteer
labour is free: the figure is robust across both the cash and the
full-project denominators because a primary school of ~300 pupils
is a large enough beneficiary base to absorb the engineering cost
over a five-year service life.

### 6.4.2 Volunteer labour, replicability, and the reuse-at-scale claim

[Roura et al., 2026] use *technician labour hours* as their proxy
for the local-economic contribution of refurbishment. The
counterpart in the AUCOOP context is *volunteer engineering hours*
(§5.4: ~720 student-hours per thesis plus ~80 AUCOOP volunteer
hours for intake and logistics, two-thesis batch), with two
qualifications. First, the labour is unpaid in cash but is not
free: it is paid in academic credit, in the career relevance of
the experience, and in the network of partner organisations the
volunteer ends up embedded in. Second, the labour pays itself
back: the contribution model of §3.C.6 ensures that the marginal
hour spent by the next cohort lands in the handbook, not in a
private notebook, and the handbook is what makes the *next*
cohort's hour cheaper.

The replicability question is therefore not "can a second school
be deployed for under €5 800?" — the cash figure is robust enough
to defend that claim within the AUCOOP donor and partner network
— but "can a second school be deployed without the present
authors in the room?". The handbook (§3.C, §4.4), the hand-over
protocol (§7.5), and the partner-network documentation (§6.3.3)
are the three mechanisms by which the answer is meant to be yes;
the empirical confirmation is future work (§7.4) and is listed
there honestly.

The same paper observes that scaling reuse expands ICT access and
technician labour demand together, while keeping additional
emissions moderate compared with new-device strategies. The
AUCOOP case does not try to verify that result at programme
scale, but it instantiates the claim at deployment scale: a
volunteer-driven reuse pathway delivered both digital access and
documented local engagement at a fraction of the cash cost of the
commercial alternative, and the recipe is set up to do so again.

---

## 6.5 Indirect effects of the open handbook

A second category of sustainability effect is harder to quantify
but worth stating, because it is a direct consequence of choosing
to publish a public, versioned handbook rather than a single
project report.

**Avoided travel for know-how transfer.** The handbook is
asynchronous and self-service. A second cohort attempting a
similar deployment does not need a Barcelona-based engineer to
fly out to brief them; the material is there to read. For an
AUCOOP-scale operation that is one or two long-haul flights per
project saved, which at typical intercontinental footprints is
roughly **1–2 t CO₂eq per avoided trip** — an order of magnitude
larger than the per-unit manufacturing figure of §6.2.1.

**Reduced duplication of lab work.** The decisions documented in
the handbook — Cudy WR3000E over alternative APs, OpenWrt
24.10.x over snapshot, the resized AUCOOP image rather than the
original — were paid for in bench time and, in some cases,
bricked or reset hardware. A second cohort reading the handbook
does not pay those costs again. The energy and material savings
per avoided wrong turn are small individually but add up across
the lifetime of the artefact.

**Avoided over-specification.** The handbook's bias toward
*sufficiency* — sizing antennas to the link budget rather than to
the catalogue, choosing the smaller AP where coverage allows it
— is a sustainability choice along all three dimensions. It is
environmental (every AP not deployed is a manufacturing footprint
not incurred and an operational draw not added), economic (every
line item not procured is cash not spent and not raised), and
social (a smaller deployment is one a partner organisation can
maintain on its own resources). The bias is captured in the
*Network-Planning* and *Antennas* recipes and is reinforced
through the methodology of §3.A.

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

\begin{table}[htbp]
\caption{SDG alignment — mechanisms concretely instantiated in this work}
\begin{tabularx}{\linewidth}{>{\raggedright\arraybackslash}p{3.8cm}X}
\toprule
SDG & Mechanism in this work \\
\midrule
\textbf{4 --- Quality Education} & Connectivity and endpoints delivered to a primary school in a low-connectivity context (§4.2, §4.3). \\[4pt]
\textbf{8 --- Decent Work and Economic Growth} & Volunteer engineering hours channelled into a knowledge artefact rather than a single-project report (§6.4.2); donor-pipeline labour quantified (§5.4). \\[4pt]
\textbf{9 --- Industry, Innovation \& Infrastructure} & A reproducible community-network recipe published as an open handbook (§3.C, §4.4). \\[4pt]
\textbf{10 --- Reduced Inequalities} & The deployment targets a school with limited prior ICT access; the open handbook lowers the barrier for similar sites to follow (§3.C, §6.3.1). \\[4pt]
\textbf{12 --- Responsible Consumption \& Production} & Endpoint requirement H2 (refurbishment over new), commodity network hardware, sufficiency bias in design (§6.2, §6.5). \\[4pt]
\textbf{13 --- Climate Action} & Embedded-carbon avoidance through refurbishment and lifetime extension (§6.2.1, §6.2.2). \\[4pt]
\textbf{17 --- Partnerships for the Goals} & The deployment is the product of a partnership chain --- UPC CCD, AUCOOP, Foundawtion, Labdoo, NexTReT, the local school authority --- that the handbook documents and makes legible to future partners (§4.4, §6.3.3). \\
\bottomrule
\end{tabularx}
\end{table}

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
this accounting at programme scale (Roura et al., 2024;
Roura et al., 2026); this thesis does not reproduce it.

Third, **the figures are one-shot**. Section 6.5 argues that the
handbook compounds sustainability across all three dimensions by
enabling reuse; quantifying that compounding requires data on how
often the recipe is reused, by whom, and at what scale. That
data does not yet exist, because the handbook is new. Section 7.4
lists longitudinal measurement of recipe reuse as one of the
future-work directions, and §4.4 names the metrics — repository
activity, downstream forks, citations — that would feed such a
measurement.

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
them in plain language to the Namibia case. It does not extend
the calculation criterion the paper develops, nor does it offer
the NMPS deployment as a low-income empirical contribution to
that literature in any rigorous form. Section 7.4 names the
latter contribution as the natural shape of a follow-on study.

The honest summary is that the sustainability argument of this
thesis is qualitatively strong across all three dimensions and
quantitatively conservative in each. The direction is unambiguous:
refurbishment over new manufacture, commodity over proprietary,
sufficiency over over-specification, open documentation over
private capture, volunteer labour that pays itself forward over
one-off deployments. The magnitudes deserve a more thorough
assessment than this chapter provides — environmentally a
defensible LCA along the eReuse / [Roura et al., 2026] lines,
socially a longitudinal study of the partner network, economically
a multi-deployment cost analysis — and the handbook is the right
place to host that work as it matures.
