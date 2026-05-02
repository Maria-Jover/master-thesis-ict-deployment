# 4. Results

> Maps to `latex/result.tex`. Data, findings, and validation evidence.

---

## 4.1 Reference field deployment — Gochas, Namibia (March 2026)

Full case study mirrored from `4-Real-Use-Cases/4.1-Namibia/index.md` (handbook). Highlights to extract:

- **Network before / after** topology diagrams.
- **Coverage**: 7 access points covering all school buildings vs. previous 2 ADSL routers with major gaps.
- **IP plan**: `192.168.70.0/24`, gateway `.1`, mesh routers `.2`–`.7`, DHCP `.100`–`.200`.
- **Throughput / latency** measurements (TBD — to be added from field data).
- **Endpoints**: 9 refurbished ThinkPads provisioned in ~1 h via PXE + Clonezilla.

## 4.2 Endpoint deployment metrics

Quantitative table:

| Metric | Value |
|---|---|
| Machines processed | 9 |
| Image size (compressed) | ~3.6 GB |
| Deployment time (parallel) | ~1 h total |
| Time saved vs. manual install | ~7 h |
| Failures encountered | TBD |
| Secure Boot incidents | TBD |

## 4.3 Cost comparison

| Item | New | Refurbished (this work) | Savings |
|---|---|---|---|
| 1× business laptop | €600–900 | €0–150 | 80–100 % |
| 9× laptops | €5,400+ | ~€500 (logistics + spares) | ~90 % |
| Mesh network (7 APs) | €700–1400 (commercial APs) | ~€350 (Cudy + OpenWrt) | ~50 % |

(Refine with actual receipts in §5.)

## 4.4 Validation of reproducibility — the handbook artefact

- Public site URL.
- GitHub repo metrics during the thesis period: stars, PRs merged, contributors, branches.
- Independent followers: anyone who built using only the handbook (TBD).
- PDF release downloads (TBD).

## 4.5 Lessons consolidated back into the handbook

Each lesson learned in the field that flowed back into the handbook as a documented warning/admonition. List with permalinks.

## 4.6 Discussion

- Strengths: low-cost, reproducible, validated.
- Limits: single field site so far, single school context, no long-term operations data yet.
- Threats to reproducibility: hardware obsolescence (OpenWrt support drops), upstream tool changes (Clonezilla format evolution).
