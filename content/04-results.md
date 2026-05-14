# 4. Results
<!-- \label{ch:results} -->

This chapter validates the methodology of §3 against the field. Section
§4.1 introduces the validation strategy — a deliberately qualitative
assessment along three lenses, applied to a single primary deployment
site — and explains why this framing is adequate given the scope of
the thesis. Sections §4.2 and §4.3 present the network-side and
endpoint-side outcomes of the Gochas deployment of March 2026 against
those lenses. Section §4.4 reports the validation of the handbook
itself as a knowledge artefact. Section §4.5 closes the
methodology-results loop by listing the lessons learned that landed as
recipe changes in the handbook. Section §4.6 discusses limits and
threats to validity.

The case material in this chapter draws on the unified Namibia
write-up in `docs/4-Real-Use-Cases/4.1-Namibia/index.md` of the
handbook (pinned to the `dev_mj_thesis` branch at commit
`a5fc80b`) and on the project record. Where a quantitative claim
depends on data not yet consolidated at the time of writing, the value
is marked **(TBD)** and the source of truth is named so it can be
filled at submission.

---

## 4.1 Validation strategy — three lenses, one site
<!-- \label{sec:results-strategy} -->

The deployment was carried out at one site (N Mutschuana Primary
School in Gochas, Namibia, March 2026). A single site cannot support
statistical validation of the methodology; what it can and does
support is a *qualitative* validation framed along three lenses,
adopted from the companion thesis [Motje, 2026] so that both volumes
report against the same vocabulary:

- **Coverage.** Did the deployed system reach every part of the site
  it was designed to reach (every classroom, every target laptop)?
  This lens audits *completeness* against the plan.
- **Sufficiency.** Did the deployed system carry the load it was
  designed to carry, with margin? This lens audits *fitness* against
  the use-case.
- **Adaptation.** Did the recipe survive *being executed by a
  different team in a different site*? Within a single deployment,
  this lens is approximated by asking whether sub-parts of the
  recipe were executed by team members other than the recipe's
  original author, and whether the documented procedure required
  field-time amendment.

The choice of lenses is deliberate. None of the three is inherently
quantitative; all three can be answered from a written field record
and direct observation. This avoids the mistake — common in
small-deployment write-ups — of inflating a single-site case study
into a quantitative claim it cannot support. Where quantitative
evidence is available (e.g., counts of laptops processed, time-to-
deploy, signal-strength readings), it is reported alongside the
qualitative judgement, not instead of it.

The validation material is presented in two **What was done /
Adaptation / Observations** tables — one for the network work-stream
(§4.2.1), one for the endpoints (§4.3.1) — which match in structure
the equivalent tables in [Motje, 2026]. The shared format is intended
to make the SW/HW boundary visible to an examining committee reading both
volumes.

### Site context recap

A short context recap, reproduced from §1.4 and the handbook case
study, anchors the rest of the chapter:

- **Site.** N Mutschuana Primary School, Gochas, Hardap Region,
  Namibia. 300+ pupils, separated catchment areas (the central town
  and "the Location"), part of a community served by the Namaqua
  Kalahari Children's Hope.
- **Initial situation.** Two old government-supplied ADSL routers,
  one of them not connected to the ISP at all and the other with
  classroom-scale coverage gaps; no IP plan; no documentation; no
  unified network.
- **Team.** Three AUCOOP members on site (Jaume Motje, María Jover
  Tarancón, Sergio Giménez Antón) plus academic supervision (Eva
  Vidal). Local partners: Gerda (school director), Theo Pauline
  (children's home), Mr. Isaak and the school staff.
- **Resources.** UPC-CCD grant of 5 600 €, nine ThinkPads from
  Labdoo, three laptops and two mini-PC servers from NexTReT.
- **Deployment window.** Roughly the first week of March 2026, with
  the bulk of the network and endpoint work concentrated on
  Days 4–8 of the trip.

---

## 4.2 Network deployment — Gochas
<!-- \label{sec:results-network} -->

### 4.2.1 What was done, what was adapted, what was observed

| Recipe step (handbook source) | What was done in Gochas | Adaptation needed | Observations against the three lenses |
|---|---|---|---|
| Internet assessment (`Network-Planning/1`) | Inherited the existing government-supplied ADSL link; documented its speed and the absence of a realistic alternative provider. | None: the ISP-change branch was deliberately not exercised because the link is institutional and not under the school's control. | **Coverage:** complete (the assessment captured what existed). **Sufficiency:** the uplink is the bottleneck for everything downstream; flagged. **Adaptation:** the recipe survived a constraint it does not normally have. |
| Site assessment (`Network-Planning/2`) | Walked the school with a Wi-Fi analyser, measured signal drop between buildings, mapped buildings/obstacles/power outlets onto a satellite-imagery plan. | The on-site sketch was annotated by hand on the printed satellite view; this matched the recipe but added a step. | **Coverage:** every building entered. **Sufficiency:** the map drove every later placement decision. **Adaptation:** done. |
| Hardware selection (§3.A.3) | Cudy WR3000E mesh nodes; the gateway role was filled by the existing ADSL router's LAN side. | None on the mesh nodes. The NanoPi R-series gateway planned in the recipe was deferred (no need to displace the institutional router). | **Sufficiency:** acknowledged limit — the institutional router remains the gateway and cannot be re-flashed; documented as future work. |
| IP plan (§3.A.4, `IP-Addressing/`) | `192.168.70.0/24`; gateway `.1`; mesh routers `.2`–`.7`; DHCP pool `.100`–`.200`. | None at design time. | **Coverage:** complete spreadsheet. **Adaptation:** an IP-conflict episode on Day 8 (Challenge 2 of the case study) led to a "common mistakes" addition in the recipe — see §4.5. |
| Wireless mesh, Iteration 1 — static-IP (`Wireless-Mesh/1-Static-IP-Mesh`) | Six mesh routers + one gateway. 5 GHz `802.11s` backhaul (channel 44, 20 MHz, WPA3-SAE). 2.4 GHz client AP shared across nodes. | One day of early bring-up was lost to an OpenWrt snapshot regression on the WR3000E 5 GHz driver; rolled back to a known-good release. The recipe now pins the tested versions. | **Coverage:** all classroom blocks reached at usable signal. **Sufficiency:** mesh links stable; client roaming worked across APs. **Adaptation:** the rollback experience drove the *Used Versions* and *No link forming?* admonitions. |
| Wireless mesh, Iteration 2 — DHCP-based (`Wireless-Mesh/2-DHCP-Mesh`) | Satellites converted to DHCP clients of the gateway, WAN+firewall disabled, addresses pinned by static lease. | None. | **Adaptation:** the staged Iteration-1→Iteration-2 path was followed exactly, validating the decision (§3.A.5) to layer the recipes rather than present them as alternatives. |
| Field-layer point-to-point links (§3.A.6, `Antennas/`) | Not exercised — the school's buildings sit within mesh range. | n/a | **Coverage:** the lens is honestly inapplicable here; the recipe is documented but not validated by this deployment. |
| Endpoint touchpoint subnet (§3.A.7) | Dedicated `10.0.0.0/24` on an isolated unmanaged switch for the imaging session. | None. | **Coverage:** all nine target laptops connected. **Adaptation:** done. |
| Power and enclosure (§3.A.8) | Wall-mount above head height; surge-protected outlets where available; UPS-class load planning. | The recurring multi-hour power cuts at the site (and the 20:00 grid-tower shutdown) shifted the goal from ride-through to graceful shutdown — see §4.5. | **Sufficiency:** the deployment survives a sudden cut without data loss; longer outages are accepted as out-of-scope. |
| Boundary services (§3.A.9) | `dnsmasq` on the gateway for DHCP+DNS forwarding; LuCI status pages for monitoring overview. | None. | **Sufficiency:** met the minimum to make the network usable; full monitoring is owned by [Motje, 2026]. |

Table: Network deployment steps at N Mutschuana Primary School — validation against coverage, sufficiency, and adaptation lenses

Before the deployment, the school had two government-supplied ADSL
routers: ADSL Router 1 in the principal's office area, broadcasting a
Wi-Fi signal but in fact not connected to the ISP at all (its Ethernet
cable was found wrapped around an unplugged power outlet — Challenge 1
of the case study), and ADSL Router 2 near the main classroom blocks,
connected to the internet but with classroom-scale dead zones. Most
classrooms had no usable Wi-Fi.

After the deployment, the school has **seven access points** (one
gateway + six mesh routers) covering all classroom blocks, the
principal's office, the staff room, the preprimary classrooms, and
the connecting outdoor spaces. The mesh forms a single SSID with
seamless client roaming. The Coverage lens is met against the
documented intent.

### 4.2.3 Sufficiency outcome

The qualitative sufficiency signal is reported in the case study and
recurred in the field: within roughly 30 minutes of the deployment
going live on Day 6, every teacher in the staff room had the new
Wi-Fi password — the network "spread like wildfire", which is the
informal sign that there was real demand at the site and the
deployment met it. Quantitatively, the load is bounded by the ADSL
uplink rather than by the mesh backhaul; the mesh has substantial
headroom and the bottleneck moves upstream of the school's gate. The
specific upstream throughput and latency figures observed at Gochas
are recorded in the project field log and to be inserted at
submission **(TBD: speedtest captures from Days 5–8)**.

### 4.2.4 Adaptation outcome

The deployment was executed by a three-person team in which the
recipe authors were also the operators. Within that team, recipe
sub-parts were rotated: the mesh setup of Iteration 1 was led by one
member while a second member followed the written guide and a third
captured the photos that became the recipe images. This is a *weak*
adaptation signal — true adaptation requires a different team in a
different site — but it is the strongest signal available within a
single deployment, and the specific failure modes observed
(OpenWrt-snapshot regression, IP-conflict, WPA3-only incompatibility)
became recipe-level admonitions precisely because the team that hit
them was *not* in all cases the team that wrote the original step.

---

## 4.3 Endpoint deployment — Gochas
<!-- \label{sec:results-endpoint} -->

### 4.3.1 What was done, what was adapted, what was observed

| Recipe step (handbook source) | What was done in Gochas | Adaptation needed | Observations against the three lenses |
|---|---|---|---|
| Intake and inventory (§3.B.2) | Twelve machines processed (9 ThinkPads from Labdoo + 3 laptops from NexTReT). Per-machine inventory captured with model, S/N, CPU/RAM, disk type and size, battery health, BIOS posture. | The BIOS-posture step (Secure Boot off, network boot on) was elevated to inventory-time after the Day-4 silent-fail incidents — see §4.5. | **Coverage:** every machine inventoried. **Adaptation:** the recipe gained a "BIOS posture as inventory check" line. |
| Golden master (§3.B.3, `AUCOOP-image.md`) | Linux Mint 22.3 Cinnamon, `aucoop` user, OnlyOffice, familiar launchers, generic hostname, pre-capture cleanup. | None at deployment time (the master had been prepared in Barcelona before travel). | **Sufficiency:** the master matched the school's actual usage on first day. |
| Image capture with Clonezilla (§3.B.4) | Captured from the master HDD (~466 GB, ~12 GB used), gzip-compressed image directory ~4 GB. | None. | **Coverage:** capture succeeded on first attempt. |
| Partition resize (§3.B.5) | Source ext4 partition shrunk from 466 GB to 20 GB; partition resized to ~22.1 GB; image recaptured with `partclone`, ~3.6 GB compressed. | The resize was performed off-line on a `qcow2` copy on a workstation. The recipe codifies this off-line workflow precisely because the on-site workflow had failed earlier with the `target seek ERROR`. | **Sufficiency:** the resized image restores cleanly to both 238 GB SSDs and 466 GB HDDs. **Adaptation:** the entire Phase-3 of the recipe is the consolidation of this lesson. |
| PXE server (§3.B.6) | One ThinkPad reassigned as PXE host on `10.0.0.1`. `isc-dhcp-server` + `tftpd-hpa` (`--secure`) + `nfs-kernel-server`. GRUB EFI binary generated with `grub-mknetdir`, placed as `bootx64.efi` at the TFTP root. | The TFTP `--secure` mode caused symlinked Clonezilla files to fail silently; resolved by placing the kernel/initrd inside the TFTP root directly — now a `!!! warning` in the recipe. | **Coverage:** all nine target laptops booted via PXE. **Adaptation:** the recipe gained the *Symlinks and `--secure` mode* warning. |
| Auto-restore + Secure Boot (§3.B.7) | `auto-restore.sh` with `/dev/nvme0n1` → `/dev/sda` → `/dev/vda` probing; `ocs-sr -k1 -icds -scr -p reboot`. Secure Boot disabled per machine before PXE attempt. | The Secure-Boot silent-fail was the single largest field-debugging cost of the trip; resolution is now an inventory-time check. | **Sufficiency:** auto-detect handled the SATA/NVMe mix without per-machine intervention. **Adaptation:** the recipe gained Step 14 (Disable Secure Boot) and a Troubleshooting entry. |
| Quality control + handover (§3.B.8) | Per-machine boot-from-disk check, login as `aucoop`, Wi-Fi association, OnlyOffice render, hostname match. | None. | **Coverage:** every machine passed. **Adaptation:** the QC checklist itself was a deployment-time codification that landed in the recipe. |

Table: Endpoint deployment steps at N Mutschuana Primary School — validation against coverage, sufficiency, and adaptation lenses

| Metric | Value |
|---|---|
| Machines provisioned (this trip) | 9 ThinkPads (Labdoo) + 3 laptops (NexTReT) = 12 endpoints |
| Master OS | Linux Mint 22.3 Cinnamon |
| Captured image size (uncompressed master) | ~466 GB allocated, ~12 GB used |
| Captured image size (compressed, original) | ~4 GB (gzip) |
| Resized image size (compressed, deployable) | ~3.6 GB (gzip after Phase-3 resize) |
| Parallel deployment time, 9 machines on a gigabit switch | ~1 h end-to-end **(TBD: confirm against field log)** |
| Manual-install equivalent (estimate, ~45 min/machine) | ~7 h |
| Time saved vs manual install | ~6 h on the nine-machine batch |
| Failures during PXE phase | All resolved; root causes captured in §4.5 |
| Secure-Boot silent-fail incidents before BIOS audit | Multiple on Day 4; zero after the inventory-time check was introduced |

Table: Endpoint deployment metrics — Gochas, March 2026

All twelve endpoints intended for deployment received the AUCOOP image
and were handed over to the school in working condition. No machine
was set aside as unprovisionable.

### 4.3.4 Sufficiency outcome

The deployed image carried the school's actual usage on first day:
classroom-style document and presentation work in OnlyOffice,
classroom Wi-Fi access via the new mesh, web browsing, occasional
video. The hardware class (i5-6200U, 8 GB RAM) is comfortably above
the working load. The bottleneck on day-to-day usage is again the
ADSL uplink rather than the endpoints themselves.

### 4.3.5 Adaptation outcome

The endpoint recipe was largely run by team members who
were *not* its original author; the partition-resize problem in
particular surfaced because the operator on the day was working from
the written recipe rather than from the author's recollection. This
is the strongest single-deployment signal of recipe portability that
the trip produced. The recipe changes that resulted are listed in
§4.5.

---

## 4.4 Validation of the handbook as a knowledge artefact
<!-- \label{sec:results-handbook} -->

The handbook itself (§3.C) is the durable deliverable of this thesis;
its validation is reported on its own terms.

### 4.4.1 What was produced

By the time of submission, the handbook content corresponding to this
thesis sits on branch `dev_mj_thesis` at commit `a5fc80b` of the
public repository <https://github.com/aucoop/Community-Network-Handbook>.
The branch consolidates four feature branches merged in order:
`docs/laptop-deployment`, `WIP-docs/ip`, `docs/planning`, and
`fix/open-points`. Together they land:

- The full `3-Guide/Network-Planning/` recipe family (internet
  assessment, site assessment, expansion planning).
- The `3-Guide/IP-Addressing/` recipe.
- The two-iteration `3-Guide/Wireless-Mesh/` recipe family.
- The `3-Guide/Laptop-Deployment/` recipe with its four phases and
  the `AUCOOP-image.md` subchapter.
- The unified `4-Real-Use-Cases/4.1-Namibia/index.md` case study.
- Stub/WIP `3-Guide/Antennas/` and `3-Guide/Power-and-UPS/` sections,
  visibly marked as Work in Progress per the governance rule of
  §3.C.6.

### 4.4.2 Public availability

The handbook is published as a website built from `main` on every
merge, and as a downloadable PDF (the *expedition copy* of §3.C.4)
released alongside each tagged version. Both outputs are produced
from the same Markdown source by **Zensical**; the dual-output
property is mechanically enforced by the build pipeline. The PDF
download URL is surfaced from the website navigation.

### 4.4.3 Repository activity during the thesis period

The metrics below characterise the contribution flow during the
thesis period and are to be filled at submission from `git shortlog`,
`gh pr list`, and the GitHub repository statistics:

| Metric | Value |
|---|---|
| Commits on `dev_mj_thesis` (this thesis) | **(TBD)** |
| Pull requests merged into `develop` | 4 |
| Feature branches merged | 4 (named above) |
| Distinct contributors active during the period | **(TBD)** |
| Stars / watchers at submission | **(TBD)** |
| Tagged releases of the PDF | **(TBD)** |

Table: Handbook repository activity metrics during the thesis period

### 4.4.4 The Coverage / Sufficiency / Adaptation lenses, applied to the handbook

- **Coverage.** Every methodology section of §3 has a matching
  recipe in the handbook (the Ch3 mapping); every recipe has a
  matching story section in Ch2 (the 1-to-1 invariant of §3.C.2). The
  one acknowledged gap — the WIP `Antennas/` and `Power-and-UPS/`
  sections — is *visibly* marked rather than silently missing, which
  is the governance behaviour of §3.C.6 working as intended.
- **Sufficiency.** The handbook's information depth is enough to
  drive an actual deployment, as evidenced by the Gochas trip itself:
  the operator on the day worked from the written recipes (§4.3.5).
  Where the depth was *not* sufficient, the gap surfaced as a
  field-time amendment that landed back in the recipe (§4.5).
- **Adaptation.** True adaptation by a different team in a different
  site is the open question. The handbook is structured to support
  it (open licence, public repository, PR workflow, OpenCode
  contribution conventions, dual web/PDF output) but the empirical
  validation requires a second cohort or a second association
  picking up the work. This is named as an explicit limit in §4.6
  and as a future-work direction in §7.

---

## 4.5 Lessons consolidated back into the handbook
<!-- \label{sec:lessons-consolidated} -->

Each lesson learned in the field that flowed back into the handbook
as a documented recipe change is listed below. Each entry names the
source episode and the resulting handbook artefact.

**The IP plan is a deliverable, not a side-effect.** Source: Day-8
IP-conflict on a newly-added router (Challenge 2 of the case study).
Result: `IP-Addressing/index.md` opens with a "why a non-default
range matters" admonition; every router recipe asks the reader to
update the spreadsheet at the moment of provisioning.

**Mesh setup is two iterations, not one.** Source: early-bring-up
observation that operators who tried the DHCP-based design first
lost time on link-formation failures unrelated to DHCP. Result: the
`Wireless-Mesh/` recipe family is split into `1-Static-IP-Mesh` and
`2-DHCP-Mesh`, with an overview that prescribes the order.

**Pin the OpenWrt and `wpad-mesh` versions.** Source: two days lost
to an OpenWrt snapshot regression on the Cudy WR3000E 5 GHz driver.
Result: `Wireless-Mesh/1-Static-IP-Mesh/index.md` carries a *Used
Versions* table and a "newer is not necessarily better" note.

**Mixed-mode WPA2/WPA3 by default.** Source: Day-6 WPA3-only
incompatibility on a single laptop (Challenge 3). Result: the
recipe's *Wireless Security* section recommends mixed mode whenever
the client device population is unknown.

**Power planning is for graceful shutdown, not ride-through.**
Source: recurring multi-hour power cuts at Gochas, the 20:00
grid-tower shutdown by design (Challenge 4). Result: the (still
WIP) `Power-and-UPS/` section's intent is reframed; the integration
with NUT for graceful shutdown is handed off to [Motje, 2026].

**Secure Boot is an inventory-time check.** Source: hours lost on
Day 4 to silent UEFI rejection of unsigned `bootx64.efi`. Result:
`Laptop-Deployment/index.md` Step 14 (Disable Secure Boot) and a
`!!! warning` admonition at the top of the PXE recipe; the BIOS
posture is checked at intake (§3.B.2).

**The partition-resize problem deserves its own phase.** Source:
the `target seek ERROR` failure on the first cross-disk restore
attempt. Result: the recipe was reorganised into four explicit
phases (prepare, capture, *resize*, deploy); operators with
uniform-disk fleets skip Phase 3 entirely.

**`tftpd-hpa --secure` does not follow symlinks.** Source: silent
TFTP failure when symlinking Clonezilla files into the TFTP root.
Result: `!!! warning` admonition under Step 11 of the PXE recipe.

**Auto-detect the target disk.** Source: failure on the first NVMe
ThinkPad with hard-coded `/dev/sda`. Result: the `auto-restore.sh`
script with `nvme0n1`/`sda`/`vda` probing.

**Use `-k1 -icds -scr -p reboot` together with a resized image, not
instead of one.** Source: hours spent chasing flag combinations
before the ext4 metadata layout was correctly identified as the
root cause. Result: the recipe states this explicitly under the
`ocs-sr` flag table.

**The site survey is a versioned artefact.** Source: the general
observation that no later decision could be defended without
referring to a written assessment. Result: the rule is repeated in
`Network-Planning/index.md`.

The pattern that emerges from the list is structural: every field
debugging episode that cost more than a handful of minutes produced
either a new admonition, a new troubleshooting row, or a new section
in the handbook. The §3 → field → handbook loop is the *operational
form* of the validation strategy of §4.1.

---

## 4.6 Discussion
<!-- \label{sec:results-discussion} -->

### 4.6.1 Strengths

- **Low-cost, reproducible network and endpoint stack.** The
  bill-of-materials of §3.A.3 and the imaging stack of §3.B.6 use
  consumer or refurbished hardware and open-source software
  exclusively; the Gochas deployment cost a small fraction of the
  equivalent commercial-AP-plus-new-laptop alternative (developed
  in §5).
- **Field-validated procedures.** Every recipe in scope was
  exercised in the field; every recipe in scope was amended at
  least once based on what happened there.
- **Explicit knowledge-continuity contribution.** The handbook
  itself, with its rule files, subagents, custom commands, and
  governance contract, is the part most likely to outlive any
  particular deployment.
- **Companion-thesis coherence.** The clean SW/HW boundary with
  [Motje, 2026], the shared layer vocabulary, and the shared
  validation lenses make the two volumes legible as a single
  documentation backbone.

### 4.6.2 Limits

- **One field site.** Only the Gochas deployment has been carried
  out and documented under the methodology of §3. The validation is
  intentionally qualitative for that reason; a quantitative claim
  about the methodology's portability requires a second site.
- **Single school context.** The receiving institution is a
  primary school. Deployments at secondary schools, community
  centres, or NGO offices may surface constraints (scale, user
  population, security posture) not exercised here.
- **No long-term operations data yet.** The deployment is days
  old, not years old, at the time of writing. The remote-support
  setup (VPN, monitoring) sits in [Motje, 2026]; the multi-month
  field-life of the equipment is future evidence.
- **Field-layer recipe untested in this trip.** The point-to-point
  antenna recipe (§3.A.6) is documented from planning context but
  was not exercised at Gochas (the school is within mesh range).
- **WIP sections in the handbook.** Two recipe families
  (`Antennas/`, `Power-and-UPS/`) are visibly marked Work in
  Progress per the governance rule of §3.C.6. They are open
  invitations to the next contributor, but they are gaps.

### 4.6.3 Threats to reproducibility

- **Hardware obsolescence.** The Cudy WR3000E may drop off the
  OpenWrt support list at some point; the Lenovo T460/X260 generation
  will eventually leave the refurbishment pipeline. The recipe is
  written to be device-agnostic where possible (the four selection
  criteria of §3.A.3) but still pins specific tested hardware.
- **Upstream tool changes.** Clonezilla's image format, OpenWrt's
  package set, GRUB's network-boot binaries can all evolve in ways
  that break a recipe pinned to a specific version. The handbook's
  `Used Versions` tables partially mitigate this; the broader
  mitigation is the active-maintainer rotation of §3.C.6.
- **The volunteer-handover assumption.** The handbook only delivers
  on its continuity promise if the next maintainer actually picks it
  up. The governance contract is necessary but not sufficient. The
  thesis cannot validate this beyond the next cohort transition; it
  is left as an explicit open question for §7.

The next chapter (§5) develops the cost and budget side of the same
deployment in detail; §6 develops the sustainability case along
environmental, social-and-governance, and economic dimensions; §7
returns to the per-objective check and the future-work directions
implied by the limits above.
