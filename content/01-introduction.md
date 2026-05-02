# 1. Introduction

> Maps to `latex/introduction.tex` (will be split / extended).
> The template requires this section to clearly state the rationale and contain: (1) Statement of purpose, (2) Requirements & specifications, (3) Methods & procedures (including reuse of prior work), (4) Work plan with Gantt, (5) Deviations from the initial plan.

---

## 1.1 Statement of purpose (objectives)

Three coupled objectives:

1. **Network.** Design and deploy a community wireless network suitable for low-connectivity, resource-limited contexts, using affordable, locally repairable hardware (OpenWrt-supported routers, mesh backhaul, basic boundary services).
2. **Endpoints.** Build a repeatable pipeline to give a second life to corporate-donated laptops: cataloguing, golden-master image creation, and mass deployment via PXE + Clonezilla.
3. **Knowledge artefact.** Consolidate both flows into a living, open, GitHub-hosted handbook (web + downloadable PDF) — the "standard AUCOOP" — so that future student cohorts can build *on top of* the work instead of restarting from scratch.

## 1.2 Motivation

### 1.2.1 External motivation — the digital divide

Connectivity is a right, not a luxury. AUCOOP's prior work in Senegal and Namibia confirmed two recurring patterns: (a) communities lack reliable connectivity *and* the endpoints to use it; (b) most reference material assumes resources or expertise unavailable on the ground.

### 1.2.2 Internal motivation — knowledge continuity at AUCOOP

[AUCOOP](https://aucoop.upc.edu) is a UPC volunteer association where students rotate every 1–3 years. For >3 years the author has observed the same anti-pattern: each new cohort restarts projects because know-how lives only in peer conversations and personal notes. There is no living artefact. The thesis fixes this by producing a reviewable, versioned, contributable handbook published in two formats.

## 1.3 Requirements and specifications

| # | Requirement | Why |
|---|---|---|
| R1 | Network gear must be supported by OpenWrt | Auditable, no vendor lock-in |
| R2 | Total per-site BOM ≤ €X (TBD) | Replicable by NGO budgets |
| R3 | Endpoints must be refurbished, not new | Sustainability + cost |
| R4 | Mass-deployment time per machine ≤ 10 min | Field viability |
| R5 | Documentation must build to both web and PDF | Connectivity-poor consumers |
| R6 | All artefacts public on GitHub | Living, contributable |
| R7 | Validated by ≥1 real field deployment | Beyond lab proof |

*Refine numeric targets after field metrics are consolidated.*

## 1.4 Methods and procedures — and prior work this builds upon

This thesis builds upon and contributes back to the **Community-Network-Handbook** (AUCOOP), pinned in `sources/` to branch `dev_mj_thesis` (commit hash recorded in `sources/handbook-mapping.md`).

External tooling reused (no novel implementation): OpenWrt, Clonezilla / `partclone`, GRUB, Linux Mint, ISC DHCP, tftpd-hpa, NFS kernel server, DeviceHub (eReuse), Zensical (docs site), MkDocs material theme, GitHub Actions.

The author's contribution is the **integration**, **field validation**, and **knowledge-artefact** layers; co-authorship of multiple handbook chapters is documented per-commit in the handbook git history.

A companion thesis (in parallel) covers the **services layer** (Proxmox, Nextcloud, RADIUS, captive portal, monitoring) — explicitly out of scope here, except for the boundary services strictly required for hardware operation (DHCP, DNS basics, monitoring overview).

## 1.5 Work plan and Gantt

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

## 1.7 Deviations from the initial plan

To be filled retrospectively. Known deviations so far:

- **Partition-resize discovery.** Initial plan assumed identical disk sizes; discovered mid-deployment that ext4 metadata layout breaks `partclone` restore on smaller disks. Required adding Phase 3 (resize) to the deployment pipeline.
- **Secure Boot blocker.** Underestimated; documented as the #1 troubleshooting entry.
- **Branch fragmentation.** Several handbook chapters lived on long-running PRs not merged into `develop`; created `dev_mj_thesis` branch to consolidate them as the thesis source.
