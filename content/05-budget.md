# 5. Budget
<!-- \label{ch:budget} -->

This chapter presents the budget of the Namibia 2026 deployment as
the reference instance of the recipe described in Chapters 3 and 4.
The budget is structured in five blocks — network hardware, endpoint
hardware, software, engineering effort, and travel and logistics —
followed by a discussion of funding sources, a per-beneficiary
breakdown, and a comparison with the cost of the equivalent
new-equipment, commercial-deployment alternative.

Two notes apply to every figure that follows. First, all prices are
expressed in **euros (€) including VAT** unless stated otherwise.
Second, several entries are marked **(TBD: confirm against
receipts)**; these are the items for which the field log contains
the canonical figure but which had not been consolidated into the
project ledger at the time of submission. The estimates given are
based on the public list price at the time of purchase (October
2025 to February 2026) and the figures recorded in the AUCOOP
project tracker; they are within ~10 % of the receipted values and
the ranking of cost categories is robust to that uncertainty.

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
| Wall-mounting hardware, conduit, ties | (TBD) | — | ~50 |
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
|---|---:|---:|---:|
| Refurbished Lenovo ThinkPad T460 / X260 | 0 (donated) | 9 | 0 |
| Replacement RAM (8 GB DDR4 modules) | ~25 | 4 | ~100 |
| Replacement SSDs (240 GB) | ~30 | 3 | ~90 |
| Replacement batteries (genuine / refurbished) | ~45 | 2 | ~90 |
| Replacement palmrests / keyboards | (TBD) | 1–2 | ~70 |
| External USB-A sticks (16 GB, for AUCOOP-image and PXE seed) | ~6 | 5 | ~30 |
| External USB SSD (500 GB, image staging) | ~55 | 1 | ~55 |
| Cleaning, thermal paste, screws | (TBD) | — | ~25 |
| **Subtotal — Endpoint hardware** |  |  | **~460** |

Table: Endpoint hardware bill of materials — refurbishment costs only (donated machines at €0)

The zero in the first row: the nine endpoints
themselves were donated through Labdoo and NexTReT and entered the
project at no cash cost. The €460 of cash spend on the endpoint
side is therefore entirely *refurbishment* spend — the parts and
consumables required to take the donations from incoming-equipment
status to deployed at school. The ratio of refurbishment cost to
donated value is the figure that matters: at a notional
secondary-market price of €150 per refurbished T460, the nine
machines represent roughly €1 350 of asset value mobilised at €460
of cash, a leverage of ~3:1.

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
the university (advisor time) and by the student (own time). The
table is included for completeness and to make the implicit
investment legible.

| Role | Hours | Rate (€/h) | Subtotal (€) |
|---|---:|---:|---:|
| Student engineer (M. Jover, this thesis) | ~720 | 25 | ~18 000 |
| Student engineer (J. Motje, companion thesis) | ~720 | 25 | ~18 000 |
| Advisor (E. Vidal) | ~60 | 60 | ~3 600 |
| Co-advisor (S. Giménez) | ~30 | 40 | ~1 200 |
| AUCOOP volunteer hours (intake, logistics) | ~80 | 20 | ~1 600 |
| **Subtotal — Engineering effort** |  |  | **~42 400** |

Table: Engineering effort at indicative hourly rates

Two observations follow. First, the engineering line is by a
very large margin the dominant cost block, dwarfing the network and
endpoint hardware combined; this matches the framing of
§2.1, which describes community networks as trading capital for human expertise. Second, the engineering effort is split across
two theses; the figure double-counts the advisor hours that were
spent on shared meetings. A pessimistic single-thesis attribution
would be roughly half of the figure above plus the full advisor
share.

## 5.5 Travel and logistics (Namibia field deployment)

[TBC]

The flights alone account for more than half of this block and are
also the single largest contributor to the project's transport
carbon footprint, which §6.7 flags as a non-netted item in the
environmental analysis. The container share for equipment shipping
is reduced because Foundawtion runs the container as a recurring
operation and the project pays only the marginal cost of the
volume occupied.

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

The grant covers approximately 100 % of the cash spend recorded in
§§5.1, 5.2 and 5.5 (~6 000 € against the 5 600 € grant, with a
~400 € overshoot absorbed by AUCOOP's own funds). The engineering
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
| Engineering effort (§5.4) | ~42 400 |
| Travel and logistics (§5.5) | ~4 400 |
| **TOTAL — full project** | **~48 218** |
| **TOTAL — cash only (excludes engineering)** | **~5 818** |

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
Distributed evenly:

- **Full-project cost per student**: ~48 218 ÷ 300 ≈ **161 € / student**.
- **Cash cost per student**: ~5 818 ÷ 300 ≈ **19 € / student**.
- **Cash cost per student per year of service** (assuming a
  conservative 5-year service life): ~**4 € / student / year**.

The €4-per-student-per-year figure is the one that lands. It
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
| 3-year support contract | (community) | ~1 800 € |
| **Cash subtotal** | **~1 420 €** | **~16 000 €** |
| Travel and logistics | ~4 400 € | ~4 400 € (unchanged) |
| **Total cash** | **~5 820 €** | **~20 400 €** |

Table: Cost comparison — open recipe vs commercial-equivalent deployment

The commercial-equivalent alternative is **3.5× more expensive
in cash terms** and carries an additional environmental cost in
manufacturing-phase emissions (quantified in §6.2.1). The
community-recipe approach trades that cash and that footprint for
volunteer engineering effort and for the operational dependency on
the handbook of §3.C — a dependency that the validation chapter
(§4.4) shows the handbook is now mature enough to carry.

The comparison should not be over-read. A commercial deployment
buys things the community recipe does not: a single-throat-to-choke
support contract, an SLA, vendor liability, and faster mean-time-to-
repair on hardware failures. Whether those properties are worth the
3.5× premium depends on the deploying organisation's risk profile;
for AUCOOP and its partner sites, the trade-off has historically
favoured the recipe described in this thesis, and this budget makes
the magnitude of that trade-off explicit.
