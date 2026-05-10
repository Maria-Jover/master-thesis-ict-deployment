# 5. Budget
<!-- \label{ch:budget} -->

This chapter presents the actual budget of the Namibia 2026 deployment as the
reference instance of the recipe described in Chapters 3 and 4.
All figures are **receipted values in euros (€) including VAT**, converted from
Namibian dollars (NAD) at the rate of **1 € = 18.68 NAD** (mid-market,
January 2026). The deployment involved three engineers on site for **15 working
days** at N Mutschuana Primary School, Gochas.

---

## 5.1 Network hardware

| Item | Unit (€) | Qty | Subtotal (€) |
|---|---:|---:|---:|
| Cudy WR300 mesh-capable AP — first unit | 43.70 | 1 | 43.70 |
| Cudy WR300 mesh-capable AP — second batch | 38.71 | 10 | 391.26 |
| TP-Link 4G LTE router | 54.99 | 1 | 54.99 |
| 8-port Gigabit switch (×2) | 24.99 | 2 | 49.98 |
| **Subtotal — Network hardware** | | | **539.93** |

Table: Network hardware bill of materials — Namibia 2026 deployment

The nine Lenovo ThinkPad laptops (T460 / X260 generation) were donated through
Labdoo and NexTReT and entered the project at **€0 cash cost**; no
repairs or part replacements were required. Their notional secondary-market
value (~€150 each) represents roughly €1 350 of assets mobilised at zero
additional spend.

## 5.2 Software

All software is free and open source (OpenWrt, Linux Mint Cinnamon, ISC
`dhcpd`, Clonezilla, OnlyOffice community edition, MkDocs Material).
**Subtotal — Software: €0.**

## 5.3 Engineering effort

| Role | Hours | Rate (€/h) | Subtotal (€) |
|---|---:|---:|---:|
| Student engineer (M. Jover, this thesis) | ~720 | 25 | ~18 000 |
| Student engineer (J. Motje, companion thesis) | ~720 | 25 | ~18 000 |
| Advisor (E. Vidal) | ~60 | 60 | ~3 600 |
| Co-advisor (S. Giménez) | ~30 | 40 | ~1 200 |
| AUCOOP volunteer hours (intake, logistics) | ~80 | 20 | ~1 600 |
| **Subtotal — Engineering effort** | | | **~42 400** |

Table: Engineering effort at indicative hourly rates (not externally funded)

## 5.4 Travel and field logistics

Three engineers travelled to Namibia and worked on site for 15 working days.

| Item | € |
|---|---:|
| Flights — 3 people, BCN–WDH return | 2 904.81 |
| Car rental — BCN airport (equipment transport) | 788.83 |
| Fuel — Gochas round trip | 22.50 |
| Fuel — Windhoek airport | 30.07 |
| SIM cards — Jaume & Maria (NAD 620) | 33.20 |
| SIM card — Sergio (NAD 290) | 15.53 |
| Mobile data / internet (NAD 100) | 5.35 |
| **Subtotal — Travel** | **3 800.29** |

| Item | € |
|---|---:|
| Accommodation — Stoneys Lodge, Gochas (NAD 5 945 deposit + NAD 21 215 balance) | 1 454.22 |
| Additional meals — Stoneys (NAD 1 215) | 65.05 |
| Working-capital allowances — 3 × NAD 1 600 | 257.01 |
| **Subtotal — Accommodation & living** | **1 776.28** |

| Item | € |
|---|---:|
| Projector (NAD 5 999) | 321.20 |
| Extension cords / Agrimark (NAD 391.96) | 20.99 |
| Double plug adapters (NAD 376.74) | 20.17 |
| Power adapters NAM→EU (NAD 146.94) | 7.87 |
| Contact cleaner and alcohol | 10.80 |
| Customs / import duties (NAD 582.62) | 31.20 |
| Bubble wrap (packing) | 9.55 |
| First-aid kit | 18.55 |
| Drill bits / Agrimark (NAD 79.97) | 4.28 |
| **Subtotal — Equipment & consumables** | **444.61** |

**Subtotal — Travel and field logistics: 6 021.18 €**

## 5.5 Funding sources

| Source | Amount | Type |
|---|---:|---|
| UPC CCD competitive grant | 5 600 € | Cash |
| Labdoo / NexTReT laptops (9 units) | ~1 350 € | In kind |
| AUCOOP (coordination, staging space, volunteer hours) | — | In kind |

The CCD grant covered the bulk of cash spend. The total recorded cash
expenditure was **6 561 €**, leaving an overshoot of ~961 € absorbed by
AUCOOP's contingency fund.

## 5.6 Summary

| Block | € |
|---|---:|
| Network hardware (§5.1) | 540 |
| Laptop fleet (donated) | 0 |
| Software (§5.2) | 0 |
| Engineering effort (§5.3) | ~42 400 |
| Travel & field logistics (§5.4) | 6 021 |
| **TOTAL — full project** | **~48 961** |
| **TOTAL — cash only (excl. engineering)** | **~6 561** |

Table: Total project budget

**Cost per beneficiary** (300 students, N Mutschuana Primary School):

- Cash cost per student: 6 561 ÷ 300 ≈ **21.87 €**
- Cash cost per student per year (5-year service life): ≈ **4.37 €**

## 5.7 Comparison with commercial-equivalent alternative

| Block | This project | Commercial equivalent |
|---|---:|---:|
| Network hardware | 540 € | ~3 500 € (vendor mesh APs) |
| Endpoints | 0 € | ~7 200 € (9 × ~800 € new laptops) |
| Software / licensing | 0 € | ~1 000 € (9 seats) |
| Installation labour | volunteer | ~2 500 € (contractor) |
| 3-year support | community | ~1 800 € |
| Travel & logistics | 6 021 € | ~6 000 € |
| **Total cash** | **~6 561 €** | **~22 000 €** |

Table: Open recipe vs commercial-equivalent deployment

The commercial-equivalent alternative is roughly **3.4× more expensive**
in cash terms and carries a higher manufacturing-phase carbon footprint.
The community recipe trades that premium for volunteer engineering effort
and operational reliance on the handbook (§3.C), which the validation
chapter (§4.4) shows is now mature enough to carry independently.
