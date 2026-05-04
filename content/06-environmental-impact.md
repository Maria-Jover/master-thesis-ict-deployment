# 6. Environmental Impact
<!-- \label{ch:environmental-impact} -->

The deployment described in
this thesis is small: nine refurbished laptops, seven access points,
one gateway, one switch. Headline figures expressed in tonnes of CO₂
avoided are easy to write and difficult to defend at this scale, so the
chapter prefers per-unit estimates with explicit sources, and treats
the fleet-level totals as illustrative rather than as a life-cycle
assessment.

---

## 6.1 Why the manufacturing phase dominates

Section 2.2 stated, without elaboration, that the manufacturing-phase
carbon emissions of a laptop dominate its life-cycle footprint. That
observation is the foundation of the entire environmental argument and
deserves to be developed here.

Published life-cycle assessments of business-grade laptops converge on
a manufacturing-phase footprint in the range of **200–300 kg
CO₂-equivalent per unit**, with extraction and processing of metals
(particularly the printed-circuit-board substrate, the display, and
the battery) accounting for the majority. Manufacturer-published
product carbon footprints — Dell, HP and Lenovo all publish them
machine by machine — sit in the same range; the figures used in this
thesis are taken from those public datasheets and from the eReuse
project's aggregated estimates rather than from a single source, so
the band is wide on purpose.

The use-phase footprint of the same machine, by contrast, is small.
A laptop drawing 25 W on average for four hours per day consumes
roughly **36 kWh per year**. With the European average grid intensity
of around 250 g CO₂eq/kWh, that is about **9 kg CO₂eq per year**, or
**45 kg over a five-year corporate life cycle**. End-of-life processing
adds a further few kilograms.

The arithmetic is therefore stark. A new laptop is responsible for
roughly **250 kg CO₂eq before it is switched on**, and for a further
**~10 kg per year of use**. Extending the service life of an existing
machine by five years avoids the larger number entirely; manufacturing
a replacement does not. This is the single observation that makes
refurbishment environmentally significant, and it is the reason
requirement R3 in §1.1 (endpoints must be refurbished, not new) is
written as a hard constraint rather than a preference.

The argument applies less cleanly to network hardware. A consumer
access point such as the Cudy WR3000E used in this deployment has a
substantially smaller manufacturing footprint than a laptop —
manufacturers do not publish per-unit figures, but the device contains
no display, no battery, and far less metal — and its use-phase draw of
roughly 5 W is also smaller. The environmental case for OpenWrt on
commodity hardware is therefore not primarily a carbon argument; it
is a longevity argument (firmware support beyond the vendor's window)
and a repairability argument (commodity parts, no vendor lock-in for
spares). Both extend the useful life of the device, and both reduce
the rate at which it enters the WEEE stream.

---

## 6.2 Embedded carbon avoided in the Namibia deployment
<!-- \label{sec:embedded-carbon-avoided} -->

Applying the per-unit figures of the previous section to the Namibia
deployment produces the following first-order estimate.

| Stream | Units | Embodied CO₂eq per unit | Avoided |
|---|---:|---:|---:|
| Refurbished laptops (Lenovo T460 / X260) | 9 | ~250 kg | **~2.25 t** |
| Cudy WR3000E access points | 7 | (not published) | not estimated |
| NanoPi R6S gateway | 1 | (not published) | not estimated |
| TP-Link PoE switch | 1 | (not published) | not estimated |

The 2.25-tonne figure should be read narrowly. It is the manufacturing
footprint of nine equivalent new laptops that did not need to be
produced because nine refurbished machines were sourced from Labdoo
and NexTReT and provisioned with the AUCOOP image. It is **not** a net
life-cycle saving for the project as a whole, because the refurbished
machines themselves carry an unamortised share of their own original
manufacturing footprint. A more rigorous accounting would attribute
that share to the refurbishment, count only the *additional* years of
service gained, and divide; the per-useful-year figure remains
substantially lower than that of a new machine, which is the point,
but the headline tonnage shrinks.

Two further qualifications apply. First, the deployment is small;
nine units is not a fleet, and reading 2.25 tonnes as a programmatic
outcome would over-claim. Second, the figure ignores transport. The
laptops were collected in Spain, packed into the Foundawtion
container, shipped to Walvis Bay and trucked inland; the per-unit
transport footprint is non-negligible at that distance and partially
offsets the avoided manufacturing. A full LCA would net the two; this
chapter does not, and flags the omission.

The figure is reported here not as a definitive number but as an
order-of-magnitude check: the avoided emissions from refurbishing
nine laptops are in the **single tonnes**, not in the kilograms and
not in the tens of tonnes. That order of magnitude is what justifies
the refurbishment requirement, and it is what scales when the recipe
is reused across cohorts.

---

## 6.3 E-waste prevented and the regulatory frame

The European Union's **WEEE Directive 2012/19/EU** sets the framework
within which refurbishment operates. The directive establishes a
hierarchy — prevention, preparation for reuse, recycling, recovery,
disposal — and obliges member states to maximise the upstream tiers.
*Preparation for reuse* is the tier into which the work described in
this thesis falls: the laptops were collected before they entered the
recycling stream, tested, repaired where necessary, and returned to
service.

The contribution at deployment scale is modest in mass terms — nine
laptops weigh roughly 15 kg, plus a few kilograms of network hardware
— but the contribution at *system* scale is what matters. Every
refurbished machine sourced from Labdoo or NexTReT is one fewer unit
that needs WEEE processing this year, and one further year before the
unit eventually does enter that stream. The deployment is therefore
better understood as a node in an existing reuse network than as a
standalone intervention; the network is the unit of analysis, not
this particular shipment.

A second-order effect, harder to quantify but worth naming, is the
**deferral** of e-waste rather than its prevention. The refurbished
laptops will eventually fail and will need to be processed. The
recipe captured in the handbook does not currently address that
end-of-life moment for community-network sites that lack access to
formal WEEE infrastructure — Namibia, in particular, has no
EU-equivalent collection scheme. Section 7.4 lists this as an open
research direction.

---

## 6.4 Operational energy footprint of the deployment

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
footprint is roughly **150 kg CO₂eq per year**. The Namibian grid is
considerably more carbon-intensive (the country imports a significant
share of its electricity from coal-heavy South Africa, with reported
intensities above 700 g CO₂eq/kWh), so the local figure is closer to
**400 kg CO₂eq per year**. Either number is dwarfed by the
manufacturing footprint of a single new laptop, which reinforces the
argument of §6.1: at this class of deployment, the lever that matters
is hardware longevity, not operational efficiency.

The operational figure also exposes a design assumption that the
handbook records explicitly: the network is sized for the school's
teaching schedule, not for 24/7 operation. The seven access points
draw about 35 W collectively; running them around the clock would add
roughly 150 kWh per year, a third of the laptop usage above. The
recipe therefore recommends that sites with constrained power schedule
the APs down during off-hours where doing so does not break legitimate
overnight uses (for example, a teacher uploading content from home in
the evening). This is the kind of operational detail that only
emerges from running a real deployment and that the handbook is the
right place to capture.

---

## 6.5 Indirect environmental effects of the open handbook

A second category of environmental impact is harder to quantify but
worth stating, because it is intrinsic to the choice of producing a
public, versioned handbook rather than a single project report.

**Avoided travel for know-how transfer.** The handbook is asynchronous
and self-service. A second cohort attempting a similar deployment
does not need a Barcelona-based engineer to fly out to brief them; the
material is there to read. For an AUCOOP-scale operation that is one
or two long-haul flights per project saved, which at typical
intercontinental footprints translates to roughly **1–2 t CO₂eq per
avoided trip** — an order of magnitude larger than the per-unit
manufacturing figure of §6.1.

**Reduced duplication of lab work.** The decisions documented in the
handbook — Cudy WR3000E over alternative APs, OpenWrt 24.10.x over
snapshot, the resized AUCOOP image rather than the original — were
made at the cost of bench time and, in some cases, bricked or reset
hardware. A second cohort reading the handbook does not repeat those
costs. The energy and material savings per avoided wrong turn are
small individually but accumulate across the lifetime of the
artefact.

**Avoided over-specification.** The handbook's bias toward
sufficiency — sizing antennas to the link budget rather than to the
catalogue, choosing the smaller AP where coverage allows it — is an
environmental choice as much as an economic one. Every AP not
deployed is a manufacturing footprint not incurred and an
operational draw not added. The bias is captured in the
*Network-Planning* and *Antennas* recipes and is reinforced in §3.A.

These effects cannot be totalled credibly. They are listed here so
that the environmental argument for the handbook is not silently
omitted; the argument for the handbook stands or falls on
reproducibility (§3.C, §4.4), and the environmental dimension is a
bonus rather than the primary motivation.

---

## 6.6 Alignment with the UN Sustainable Development Goals

The deployment intersects six of the seventeen UN Sustainable
Development Goals. The mapping below is included for completeness;
SDG-alignment statements are easy to over-claim and are written here
narrowly, restricted to mechanisms that are concretely instantiated
in the work described in §3 and §4.

| SDG | Mechanism in this work |
|---|---|
| **4 — Quality Education** | Connectivity and endpoints delivered to a primary school in a low-connectivity context (§4.2, §4.3). |
| **9 — Industry, Innovation & Infrastructure** | A reproducible community-network recipe published as an open handbook (§3.C, §4.4). |
| **10 — Reduced Inequalities** | The deployment targets a school with limited prior ICT access; the open handbook lowers the barrier for similar sites to follow (§3.C). |
| **12 — Responsible Consumption & Production** | Endpoint requirement R3 (refurbishment over new), commodity network hardware, sufficiency bias in design (§6.1, §6.2, §6.5). |
| **13 — Climate Action** | Embedded-carbon avoidance through refurbishment and lifetime extension (§6.1, §6.2). |
| **17 — Partnerships for the Goals** | The deployment is the product of a partnership chain — UPC CCD, AUCOOP, Foundawtion, Labdoo, NexTReT, the local school authority — that the handbook documents and makes legible to future partners (§4.4). |

The list is shorter than is conventional in SDG-alignment exercises;
goals that the deployment does not concretely address (water,
hunger, gender equality, marine ecosystems) are deliberately omitted
rather than stretched to fit. The point of the table is to locate
the work in the international policy frame, not to claim credit for
it.

---

## 6.7 Limits of this analysis
<!-- \label{sec:env-limits} -->

This chapter is not a life-cycle assessment. It uses per-unit figures
from public sources, applies them to a small deployment, and states
the result as an order-of-magnitude check rather than as a defensible
inventory. Three limitations should be made explicit before any of
its numbers are reused.

First, **transport is not netted**. Shipping nine laptops from Spain
to Namibia carries a per-unit footprint that partially offsets the
avoided manufacturing; this chapter does not estimate it. The
omission matters less for in-region deployments (which AUCOOP also
runs) and more for inter-continental ones such as Namibia.

Second, **the refurbishment process itself has a footprint**.
Replacement parts (storage, batteries, the occasional palmrest), the
energy used during testing and imaging, and the human travel to
collect and consolidate donations all carry costs that this chapter
does not enumerate. The eReuse project has done some of this
accounting at programmatic scale; this thesis does not reproduce it.

Third, **the figures are one-shot**. Section 6.5 argues that the
handbook compounds environmental savings by enabling reuse; quantifying
that compounding requires data on how often the recipe is reused, by
whom, and at what scale. That data does not yet exist, because the
handbook is new. Section 7.4 lists longitudinal measurement of
recipe reuse as one of the future-work directions, and §4.4
identifies the corresponding metrics — repository activity, downstream
forks, citations — that would feed such a measurement.

The honest summary is that the environmental argument of this thesis
is qualitatively strong and quantitatively conservative. The
direction is unambiguous: refurbishment over new manufacture,
commodity over proprietary, sufficiency over over-specification, open
documentation over private capture. The magnitudes deserve a more
thorough LCA than this chapter provides, and the handbook is the
right place to host that work as it matures.
