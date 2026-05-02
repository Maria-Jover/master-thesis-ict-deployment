# 7. Conclusions and Future Development

---

## 7.1 Summary of contributions

1. **A reproducible network deployment recipe** for low-resource contexts, validated in Gochas (Namibia).
2. **A reproducible endpoint deployment pipeline** (PXE + Clonezilla + AUCOOP image), validated on 9 ThinkPads.
3. **A living, open knowledge artefact** — the Community-Network-Handbook (web + PDF) — now serving as the AUCOOP standard reference.
4. **Documented field lessons** that fed back as warnings and troubleshooting entries (Secure Boot, ext4 partition-resize, IP conflicts, WPA3 compatibility, infrastructure resilience).

## 7.2 Lessons learned

- **Detection takes longer than correction** — invest in observability and logging early.
- **Defaults are dangerous** — `192.168.1.x`, Secure Boot enabled, full-disk imaging.
- **Documentation must be alive** — a PDF buried in a drive is worse than no documentation, because it gives a false sense of coverage.
- **Volunteer continuity is an engineering problem**, not just a social one.

## 7.3 Limitations

- Single field site (Namibia, March 2026) — generalisation requires more deployments.
- No long-term operational data yet (uptime, MTBF).
- The companion services-layer thesis is required to close the full ICT stack.

## 7.4 Future development

### Short-term (next AUCOOP cohort, 2026/27)

- Second field deployment to validate reproducibility outside Namibia.
- Captive portal + user management chapter (currently `2.8`/`2.9` placeholders).
- Automation with OpenWISP for fleet-wide configuration management.

### Medium-term

- Telemetry from deployed networks → evidence-based handbook iteration.
- Translation of the handbook (FR, ES, PT) for broader reach.

### Long-term

- A formal "AUCOOP Standard Network" certification of compliance.
- Federation with Guifi.net, AlterMundi, and other community-network movements.

## 7.5 Hand-over protocol for the next cohort

A short procedural section describing exactly how the next María/Jaume/Sergio picks up:

1. Read chapter 1 + §3.C of this thesis.
2. Read `AGENTS.md` and `.opencode/rules/` of the handbook.
3. Open the `develop` branch backlog of issues tagged `good-first-cohort`.
4. Pick one open chapter from the handbook nav with `!!! info "Work in Progress"`.
5. Follow the PR template; tag a current maintainer for review.
