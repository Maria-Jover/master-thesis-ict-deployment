# Handbook → Thesis source mapping

The Community-Network-Handbook is the empirical substrate of this thesis.

- **Repo:** https://github.com/aucoop/Community-Network-Handbook
- **Branch used:** `dev_mj_thesis`
- **Created from:** `develop`
- **Merged in (in order):**
  1. `origin/docs/laptop-deployment`
  2. `origin/WIP-docs/ip`  *(conflict in `4.1-Namibia/index.md` resolved by unifying network + laptop narratives)*
  3. `origin/docs/planning`
  4. `origin/fix/open-points`
- **Local clone path:** `/home/mj/Community-Network-Handbook` (sibling, not a submodule yet)

## Section-by-section mapping

| Thesis section | Handbook source path |
|---|---|
| §1.2.1 Motivation — external | `docs/1-Introduction/1.1-Motivation.md`, `1.2-Target-Reader.md` |
| §1.2.2 Motivation — AUCOOP continuity | (original to thesis; cites `AGENTS.md`, `.opencode/rules/`) |
| §2.5 Linux Mint choice | `docs/3-Guide/Laptop-Deployment/AUCOOP-image.md` |
| §3.A.1 Site & internet assessment | `docs/3-Guide/Network-Planning/{1-Internet,2-Site,3-Expansion}-*.md` |
| §3.A.2 Hardware selection | `docs/2-Imaginary-Use-Case/2.1-The-First-Router/2.1.1-Choosing-Hardware.md` |
| §3.A.3 IP addressing | `docs/2-Imaginary-Use-Case/2.2-Expanding-Coverage/2.2.2-IP-Addressing.md`, `docs/3-Guide/IP-Addressing/index.md` |
| §3.A.4 Wireless mesh | `docs/3-Guide/Wireless-Mesh/{index,1-Static-IP-Mesh,2-DHCP-Mesh}.md` |
| §3.A.5 Antennas | `docs/3-Guide/Antennas/index.md`, `docs/2-Imaginary-Use-Case/2.3-The-Other-Building/2.3.1-Antennas.md` |
| §3.A.6 DHCP/DNS basics | (extracted from mesh + IP guides; boundary services) |
| §3.A.7 Power & UPS | `docs/3-Guide/Power-and-UPS/index.md` |
| §3.B.1 Refurbishment case | `docs/2-Imaginary-Use-Case/2.22-Equipping-the-community/2.22.1-The-Refurbished-Advantage.md` |
| §3.B.2 Cataloguing | `2.22.2-Cataloging-Your-Hardware.md` |
| §3.B.3 AUCOOP Mint image | `2.22.3-Adding-Operating-System.md`, `docs/3-Guide/Laptop-Deployment/AUCOOP-image.md` |
| §3.B.4–§3.B.7 PXE+Clonezilla pipeline | `docs/3-Guide/Laptop-Deployment/index.md` (Phases 1–4) |
| §3.B.8 Quality control | `2.22.4-Scaling-the-Deployment.md` |
| §3.C Knowledge artefact | `mkdocs.yml`, `AGENTS.md`, `README.md`, `.opencode/rules/*` |
| §4 Results — Namibia | `docs/4-Real-Use-Cases/4.1-Namibia/index.md` (unified version) |
| Appendix B (configs) | `docs/3-Guide/Laptop-Deployment/index.md` (Phase 4 code blocks) |
| Appendix D (diagrams) | `docs/4-Real-Use-Cases/4.1-Namibia/images/`, `docs/3-Guide/IP-Addressing/images/` |
| Appendix F (governance) | `AGENTS.md`, `.opencode/rules/{general,chapter2-story,chapter3-guide,mkdocs-nav}.md` |

## Updating the pin

When new PRs land, re-run:

```bash
cd /home/mj/Community-Network-Handbook
git fetch origin
git checkout dev_mj_thesis
git merge origin/<feature-branch>
# resolve conflicts, commit
```

Then update the commit hash recorded here:

- **Current pin commit:** `a5fc80b26368fe6cf1475994a12cc8f1967b84f0` (created 2026-05-02)
