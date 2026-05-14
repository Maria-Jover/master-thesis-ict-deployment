# 5. Budget
<!-- \label{ch:budget} -->

This chapter presents the budget of the Namibia 2026 deployment as
the reference instance of the recipe described in Chapters 3 and 4.
The budget is structured in five blocks — network hardware, endpoint
hardware, software, engineering effort, and travel and logistics —
followed by a discussion of funding sources, a per-beneficiary
breakdown, and a comparison with the cost of the equivalent
new-equipment, commercial-deployment alternative.

The numbers given are
based on the public list price at the time of purchase (October
2025 to February 2026) and the figures recorded in the AUCOOP
project tracker

---

## 5.1 Network hardware

| Item | Unit cost (€) | Qty | Subtotal (€) |
|---|---:|---:|---:|
| Cudy WR3000E mesh-capable AP | ~55 | 7 | ~385 |
| NanoPi R6S gateway (8 GB) | ~110 | 1 | ~110 |
| TP-Link 8-port Gigabit PoE switch | ~95 | 1 | ~95 |
| Cat-6 patch cables and connectors | ~3 | 30 | ~90 |
| Outdoor-rated Ethernet (per metre) | ~1.20 | 50 | ~60 |
| 24 V / 12 V PoE injectors and splitters | ~12 | 4 | ~48 |
| Lithium UPS (small, for gateway + switch) | ~120 | 1 | ~120 |
| Wall-mounting hardware, conduit, ties | — | — | ~50 |
| **Subtotal — Network hardware** |  |  | **~958** |

Table: Network hardware bill of materials — Namibia 2026 deployment

These prices cover what was procured for the deployment;
they do not include the spare AP and the spare PoE injector kept on
the bench in Barcelona, both of which were existing AUCOOP stock.
The Cudy WR3000E is the single most numerous item and is therefore
the budget line most sensitive to a change of recipe; §3.A.4
documents the rationale for that choice and §6.2.1 the environmental
side of it.

## 5.2 Endpoint hardware

| Item | Unit cost (€) | Qty | Subtotal (€) |
|:------------------------------------------------------|----------:|----:|-----------:|
| Refurbished Lenovo ThinkPad T460 / X260 | 0 (donated) | 9 | 0 |
| External USB-A sticks (16 GB, for AUCOOP-image and PXE seed) | ~6 | 2 | ~12 |
| **Subtotal — Endpoint hardware** |  |  | **~12** |

Table: Endpoint hardware bill of materials — refurbishment costs only (donated machines at €0)

The nine endpoints were donated through Labdoo and NexTReT and entered the
project at no cash cost. No repairs or part replacements were required. USB sticks used for imaging and PXE seeding. At a notional secondary-market
price of ~€150 per refurbished T460, the nine machines represent roughly
€1 350 of asset value mobilised at negligible cost.

## 5.3 Software

All software used in the deployment is free and open source:
OpenWrt, Linux Mint Cinnamon, ISC `dhcpd`, `tftpd-hpa`, NFS, GRUB,
`pxelinux`, Clonezilla, `partclone`, OnlyOffice (community edition),
Zensical, MkDocs Material, GitHub Actions on a public repository.

**Subtotal — Software: €0.**

The zero is itself part of the recipe. Section 3.B.5 (AUCOOP
image), §3.A.4 (OpenWrt) and §3.C (handbook tooling) all rely on
software whose licensing imposes no per-unit cost and whose source
is auditable. The economic implication is that the recipe's cash
cost scales with hardware quantity only; the software cost of
deploying a second school is the same as the first, namely zero.

## 5.4 Engineering effort

The thesis budget accounts for engineering effort using indicative
hourly rates rather than market rates; the real cost is borne by
the university (advisor time) and by the student (own time).

| Role | Hours | Rate (€/h) | Subtotal (€) |
|---|---:|---:|---:|
| Student engineer (M. Jover, this thesis) | ~720 | 25 | ~18 000 |
| Student engineer (J. Motje, companion thesis) | ~720 | 25 | ~18 000 |
| Advisor (E. Vidal) | ~20 | 60 | ~1 200 |
| Co-advisor (S. Giménez) | ~100 | 40 | ~4 000 |
| AUCOOP volunteer hours (intake, logistics) | ~80 | 20 | ~1 600 |
| **Subtotal — Engineering effort** |  |  | **~42 800** |

Table: Engineering effort at indicative hourly rates

Two observations follow. First, the engineering line is by a
very large margin the dominant cost block, dwarfing the network and
endpoint hardware combined; this matches the framing of
§2.1, which describes community networks as trading capital for human expertise. Second, the engineering effort is split across
two theses; the figure double-counts the advisor hours that were
spent on shared meetings. The Co-advisor, supported also on the deployment of the network in Namibia.

## 5.5 Travel and logistics (Namibia field deployment)

Three engineers travelled to Namibia for a 15-working-day deployment.
NAD figures converted at **1 € = 18.68 NAD**.

| Item | € |
|:-------------------------------------------------------------|----------:|
| Flights — 3 people, BCN–WDH return | 2 904.81 |
| Car rental — Barcelona airport (equipment transport) | 788.83 |
| Fuel — Gochas round trip (NAD 420.15) | 22.50 |
| Fuel — Windhoek airport (NAD 561.58) | 30.07 |
| SIM cards — Jaume & Maria (NAD 620) | 33.20 |
| SIM card — Sergio (NAD 290) | 15.53 |
| Mobile data / internet (NAD 100) | 5.35 |
| Accommodation — Stoneys Lodge, Gochas (NAD 27 160) | 1 454.22 |
| Additional meals — Stoneys (NAD 1 215) | 65.05 |
| Working-capital allowances — 3 × NAD 1 600 | 257.01 |
| **Subtotal — Travel and logistics** | **5 576.57** |

Table: Travel and logistics — Namibia 2026 field deployment

The flights alone account for more than half of this block and are
also the single largest contributor to the project's transport
carbon footprint, which §6.7 flags as a non-netted item in the
environmental analysis.

## 5.6 Funding sources
<!-- \label{sec:budget-funding} -->

The project's cash needs are met from three sources, none of which
flow through the student authors directly.

- **UPC CCD (Centre de Cooperació per al Desenvolupament)**:
  **5 600 €** competitive grant covering travel, network hardware
  procurement, and refurbishment consumables. The grant is the
  largest single source and is the reason the recipe is reproducible
  inside UPC: subsequent cohorts can apply for the same grant under
  the same call.
- **Labdoo**: nine laptops in kind (T460 and X260 generation),
  delivered already provenanced through the Labdoo tracking system.
  No cash flow, ~€1 350 of asset value.
- **NexTReT**: three laptops in kind plus two mini-PC servers used
  for the services thesis; ~€500 of asset value attributable to the
  hardware-side scope.
- **AUCOOP**: coordination, intake-and-staging space at the UPC
  Campus Nord, and the volunteer hours costed in §5.4. No cash flow.

The grant covers approximately 85 % of the cash spend recorded in
§§5.1, 5.2 and 5.5 (~6 547 € against the 5 600 € grant, with a
~947 € overshoot absorbed by the spare budget of another AUCOOP project). The engineering
effort of §5.4 is explicitly not funded; it is contributed in
exchange for the academic credit of the two theses. The
sustainability reading of this funding mix — small cash outlay
leveraged through donations and volunteer effort — is treated as
the economic dimension of §6.4.

## 5.7 Total

| Block | € |
|---|---:|
| Network hardware (§5.1) | ~958 |
| Endpoint hardware (§5.2) | ~460 |
| Software (§5.3) | 0 |
| Engineering effort (§5.4) | ~42 800 |
| Travel and logistics (§5.5) | 5 577 |
| **TOTAL — full project** | **~49 347** |
| **TOTAL — cash only (excludes engineering)** | **~6 535** |

Table: Total project budget — full cost and cash-only breakdown

The full-project figure of
~48 k€ reflects the true societal cost of the deployment if every
hour of student and advisor time were paid at indicative rates; this
is the figure that makes the project comparable to a commercial
deployment. The cash-only figure of ~5.8 k€ is what an organisation
with access to a similar volunteer pool actually has to raise; this
is the figure that makes the recipe replicable inside AUCOOP and
similar associations, and it is the one against which §5.9 compares
the commercial alternative.

## 5.8 Cost per beneficiary

The N Mutschuana Primary School serves approximately **300 students**.
Distributed evenly and the Children Home 60 kids:

- **Full-project cost per student**: ~49 347 ÷ 360 ≈ **137,07 € / beneficiary**.
- **Cash cost per beneficiary**: ~6 547 ÷ 360 ≈ **18,19 € / beneficiary**.
- **Cash cost per beneficiary per year of service** (assuming a
  conservative 5-year service life): ~**3.63 € / beneficiary / year**.

The €3.63-per-student-per-year figure is the one that lands. It
includes a connected wireless network covering the school and a
fleet of nine endpoints, and it is well within the range of
cost-effectiveness benchmarks for ICT-in-education programmes
reported in the ICT4D literature surveyed in §2.3.

## 5.9 Comparison with the commercial-equivalent alternative
<!-- \label{sec:budget-comparison} -->

The point of the budget is partly comparative. A commercial
alternative — new business-grade laptops, vendor mesh access points,
contracted installer, three-year support — would price the same
deployment as follows.

| Block | Refurbished + open recipe | Commercial-equivalent |
|---|---:|---:|
| Network hardware | ~960 € | ~3 500 € (Aruba Instant On / equivalent) |
| Endpoints | ~460 € (parts) | ~7 200 € (9 × ~800 € new business laptops) |
| Software / licensing | 0 € | ~1 000 € (Windows + productivity, 9 seats) |
| Installation labour | (volunteer) | ~2 500 € (contractor, 5 days × 2 people) |
| 3-year support contract | (volunteer - community) | ~1 800 € |
| **Cash subtotal** | **~1 420 €** | **~16 000 €** |
| Travel and logistics | 5 577 € | ~5 577 € (unchanged) |
| **Total cash** | **~6 535 €** | **~21 577 €** |

Table: Cost comparison — open recipe vs commercial-equivalent deployment

The commercial-equivalent alternative is **3.5× more expensive
in cash terms** and carries an additional environmental cost in
manufacturing-phase emissions (quantified in §6.2.1). The
community-recipe approach trades that cash and that footprint for
volunteer engineering effort and for the operational dependency on
the handbook of §3.C — a dependency that the validation chapter
(§4.4) shows the handbook is now mature enough to carry.

The comparison should not be over-read. A commercial deployment
buys things the community recipe does not: available support as per contract, an SLA, vendor liability, and faster mean-time-to-
repair on hardware failures. Whether those properties are worth the
3.5× premium depends on the deploying organisation's risk profile;
for AUCOOP and its partner sites, the trade-off has historically
favoured the recipe described in this thesis, and this budget makes
the magnitude of that trade-off explicit.
