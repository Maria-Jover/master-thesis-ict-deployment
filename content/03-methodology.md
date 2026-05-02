# 3. Methodology / Project Development

> The bulk of the thesis. Three coordinated work-streams: **3.A** the network, **3.B** the endpoints, **3.C** the knowledge artefact. Maps to LaTeX section *Methodology / project development*.

---

## 3.A Network hardware deployment

Source: handbook chapters 2.1, 2.2, 2.3 + `3-Guide/Network-Planning`, `IP-Addressing`, `Wireless-Mesh`, `Antennas`, `Power-and-UPS`.

### 3.A.1 Site and internet assessment

Method to characterise an existing site:

- Internet assessment: ISP options, speed test, latency, reliability — see `3-Guide/Network-Planning/1-Internet-Assessment.md`.
- Site assessment: floorplan, signal-drop measurements, obstacle mapping — `2-Site-Assessment.md`.
- Expansion planning: what to deploy first, where to grow — `3-Expansion-Planning.md`.

### 3.A.2 Hardware selection

Decision criteria and the resulting recommended bill-of-materials:

- Affordability, OpenWrt support, sufficient RAM/flash, local availability.
- Concrete picks and their rationale: Cudy WR3000E (consumer mesh node), NanoPi R-series (gateway).

### 3.A.3 IP addressing plan

Why a non-default range matters; structure of a typical small-network plan; static vs. DHCP allocation; pitfalls (the IP conflict story from Namibia).

### 3.A.4 Wireless mesh design

- IEEE 802.11s with `wpad-mesh`, mesh-encrypted SAE.
- 2.4 GHz vs 5 GHz role split (clients vs backhaul).
- Static-IP mesh vs DHCP-based mesh; trade-offs.

### 3.A.5 Long-link antennas and inter-building bridges

(Outline — fill from `3-Guide/Antennas`.)

### 3.A.6 Boundary services kept in scope

Strictly the minimum to make the network usable:

- DHCP basics (server choice, lease ranges).
- DNS basics (forwarding, optional local resolution).
- Monitoring **overview** (deeper Zabbix work belongs to the companion thesis).

### 3.A.7 Power and UPS sizing

- Load inventory of a typical site (routers, PoE switch, mini-PC).
- Battery sizing for N hours of autonomy.
- Practical observations from Gochas (recurring outages).

---

## 3.B Endpoint reconditioning and mass deployment

Source: handbook chapter 2.22 + `3-Guide/Laptop-Deployment`.

### 3.B.1 The refurbished-hardware case

Economic and environmental argument; sourcing channels (corporate fleet refresh, Labdoo).

### 3.B.2 Intake, triage and cataloguing with DeviceHub

- Bootable diagnostic USB workflow.
- Asset record fields (CPU, RAM, storage, battery cycles, S/N).
- Integration of the inventory with the deployment plan (matching disks ↔ image variant).

### 3.B.3 Golden-master image — the AUCOOP Linux Mint

- Why Mint (recap from §2.5).
- Customisations: OnlyOffice, familiar launcher icons, removed bloat, generic hostname/user.
- Pre-capture cleanup checklist.

### 3.B.4 Image capture with Clonezilla

- Boot Clonezilla Live, `device-image` / `local_dev` / `savedisk` workflow.
- Compression and image directory layout.

### 3.B.5 The partition-resize problem (and fix)

The technical core of the chapter:

- Why ext4 metadata makes naive cross-disk restore fail (`target seek ERROR`).
- Fix: `e2fsck` → `resize2fs` → `parted resizepart` → recapture with `partclone`.
- Why `-k1` and `-icds` flags alone are insufficient.

### 3.B.6 PXE server architecture

Three services, one isolated subnet:

| Service | Port | Purpose |
|---|---|---|
| DHCP (`isc-dhcp-server`) | 67 | IP + boot file pointer |
| TFTP (`tftpd-hpa`) | 69 | GRUB EFI + kernel + initrd |
| NFS (`nfs-kernel-server`) | 2049 | Clonezilla rootfs + image repo |

GRUB EFI generation with `grub-mknetdir`. The `bootx64.efi` placement.

### 3.B.7 Auto-restore script and Secure Boot handling

- Disk auto-detection (`/dev/sda` vs `/dev/nvme0n1`).
- `ocs-sr` invocation with `-k1 -icds -scr -p reboot`.
- Why Secure Boot must be disabled (unsigned GRUB binary) — single biggest field-debugging cost.

### 3.B.8 Quality control and user handover

User account verification, first-boot checks, end-user training note.

---

## 3.C The AUCOOP Handbook as a knowledge artefact

This part documents the *meta* contribution.

### 3.C.1 Why a living handbook

Recap of the volunteer-rotation problem (see §1.2.2). Comparison with the alternative (PDF reports buried in Google Drive folders).

### 3.C.2 Repository structure

- Top-level: `1-Introduction`, `2-Imaginary-Use-Case` (story), `3-Guide` (recipes), `4-Real-Use-Cases`.
- The **1-to-1 mapping** rule between Chapter 2 (story) and Chapter 3 (guide).
- Co-located images (`images/*.webp`), Mermaid diagrams.

### 3.C.3 Toolchain — Zensical + MkDocs material

- Site config (`mkdocs.yml`) walkthrough.
- Plugins used: search, build_plantuml, superfences, admonition.
- Local preview workflow for contributors.

### 3.C.4 Dual output — web and PDF

- Web target: GitHub Pages.
- PDF target: book pipeline (Pandoc-based) → release artefact.
- Why both formats matter for connectivity-poor consumers.

### 3.C.5 Contribution model

- PR-based review, branch-naming conventions, `AGENTS.md`.
- AI-assisted authoring with OpenCode subagents (`@writer`, `@reviewer`, `@diagrams`, `@structure`, `@consistency`). Custom commands.
- Coding/style rules: tone (practical, second-person), admonitions, image format.

### 3.C.6 Governance for continuity

- Maintainer rotation policy (proposal).
- "Definition of Done" for a chapter.
- How a future student picks up an open chapter.
