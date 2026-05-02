# 2. State of the Art

> The template requires a comprehensive review of the literature. Maps to LaTeX section *State of the art of the technology used or applied in this thesis*.

---

## 2.1 Digital divide and community networks

- Definitions and ITU statistics on global connectivity gaps (2020–2025).
- Community networks as a third model alongside commercial ISPs and public infrastructure: Guifi.net (Catalonia), AlterMundi (Argentina), Rhizomatica (Mexico), Zenzeleni (South Africa).
- Regulatory and policy context: APC, ISOC community networking reports.

## 2.2 ICT4D and the refurbishment ecosystem

- Information and Communication Technology for Development — frameworks and critiques.
- Circular economy in IT: extending device lifespan vs. embedded carbon emissions.
- Key players: **Labdoo**, **eReuse / DeviceHub**, Reboot Project, Donate-a-PC programmes.

## 2.3 Open networking stack on commodity hardware

- **OpenWrt**: history, hardware support model, package ecosystem.
- Mesh protocols: IEEE 802.11s, batman-adv, OLSR; trade-offs.
- Wireless backhaul: long-link CPEs (Ubiquiti, MikroTik, TP-Link).
- Reference hardware lines used in this work: **Cudy** (consumer), **NanoPi R-series** (SBC routers).

## 2.4 Mass operating-system deployment

- Network boot foundations: PXE, iPXE, GRUB EFI netboot.
- Imaging tools: Clonezilla / `partclone`, FOG Project, MDT (Windows), DRBL.
- Trade-off analysis: full DRBL vs. minimal Clonezilla-Live + DHCP/TFTP/NFS (the choice made in this work).

## 2.5 Linux distributions for low-end hardware

- Comparison: Ubuntu, **Linux Mint**, LXLE, antiX, Lubuntu.
- Why Mint won for AUCOOP (UI familiarity, lightness, Office-equivalent stack) — see `latex` mapping to `Laptop-Deployment/AUCOOP-image.md`.

## 2.6 Power systems for unreliable grids

- UPS sizing principles for small networks.
- Solar + battery hybrids; lead-acid vs. LiFePO₄.
- Field experience reference: outages observed in Gochas (8 PM grid cut).

## 2.7 Living documentation as an engineering practice

- **Docs-as-code**: rationale, history, adoption (Stripe, GitLab handbook, Arch Wiki, RFC editor as precedents).
- Static-site generators for technical documentation: MkDocs, **Zensical**, Hugo, Docusaurus.
- Dual-output pipelines (web + PDF/EPUB) for low-bandwidth distribution.
- Contribution models: PR-based review, issue-driven roadmap, AI-assisted authoring (the OpenCode `AGENTS.md` pattern used by AUCOOP).
- Why this matters for ICT4D: knowledge continuity in volunteer organisations.

## 2.8 Gap addressed by this thesis

A short paragraph synthesising the gaps:

- Existing community-network literature is fragmented across academic papers, vendor docs, and tribal wiki knowledge.
- Refurbishment guides exist but rarely cover *integrated* network + endpoint deployments.
- No published artefact specifically targets **volunteer-cohort handover** in university student associations.

This thesis closes those three gaps simultaneously through the AUCOOP handbook + a real Namibia validation.
