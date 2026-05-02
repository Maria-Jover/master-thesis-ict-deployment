# 9. Appendices

> Optional per template; recommended given the volume of configuration data.

---

## Appendix A — Full Bill of Materials

Detailed BOM with manufacturer part numbers, suppliers, prices at time of purchase, and equivalent-substitution notes.

## Appendix B — PXE server configuration files

Verbatim:

- `/etc/dhcp/dhcpd.conf`
- `/etc/default/isc-dhcp-server`
- `/etc/default/tftpd-hpa`
- `/etc/exports`
- `/tftpboot/nbi_img/grub/grub.cfg`
- `/home/partimag/auto-restore.sh`

(Source: handbook `3-Guide/Laptop-Deployment/index.md`.)

## Appendix C — DeviceHub sample inventory

CSV export of the cataloged batch from the Namibia deployment (anonymised serial numbers).

## Appendix D — Network diagrams (Namibia)

- Pre-deployment topology.
- Post-deployment topology.
- IP plan visualisation.

(Source: handbook `4-Real-Use-Cases/4.1-Namibia/images/`.)

## Appendix E — Repository branch and commit map

Snapshot of the handbook's git state at thesis submission:

- Branch: `dev_mj_thesis`
- Base commit: `<HASH>`
- Merged feature branches: `docs/laptop-deployment`, `WIP-docs/ip`, `docs/planning`, `fix/open-points`.
- Per-chapter authorship table extracted from `git shortlog`.

## Appendix F — AUCOOP Handbook governance

- `AGENTS.md` reproduced.
- `.opencode/rules/general.md`, `chapter2-story.md`, `chapter3-guide.md` reproduced.
- Custom command definitions (`/new-section`, `/review-chapter`, `/add-diagram`, `/audit`, `/guide-from-steps`).
