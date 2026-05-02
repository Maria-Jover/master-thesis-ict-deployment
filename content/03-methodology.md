# 3. Methodology / Project Development

> The bulk of the thesis. Three coordinated work-streams: **3.A** the network, **3.B** the endpoints, **3.C** the knowledge artefact. Maps to LaTeX section *Methodology / project development*.

---

## 3.A Network hardware deployment

This part of the chapter describes the hardware-network work-stream: how the
physical and link layers of a small community network are designed,
specified, and brought up in a low-resource site. The narrative is
deliberately ordered as a deployment would be ordered in the field, but it
is grouped under a four-layer model — *field*, *site*, *endpoint
touchpoint*, *power and enclosure* — borrowed from the functional layering
proposed in the companion thesis [Motje, 2026]. Adopting the same layer
vocabulary on the hardware side and on the software/services side keeps the
two theses, and the handbook that backs them, internally coherent: every
recipe in `docs/3-Guide/` of the handbook can be located in exactly one
layer, and every artefact named below has a one-to-one counterpart in the
handbook.

The material is also organised around three validation lenses that recur in
§4: **coverage** (does the layer reach where it needs to reach?),
**sufficiency** (does it carry the expected load with margin?), and
**adaptation** (does the recipe survive being executed by a different team
in a different site?). Where a design choice trades one lens against
another, the trade-off is named explicitly.

### 3.A.1 The four-layer model

The hardware deployment is decomposed into four functional layers. Each
layer owns a small set of decisions, a recommended bill of materials, and a
matching family of recipes in the handbook.

| Layer | Owns | Handbook section | Examples of artefacts |
|---|---|---|---|
| **Field** | Inter-building radio links, long-distance bridges, outdoor antennas | `3-Guide/Antennas/` | Point-to-point Ubiquiti links, line-of-sight surveys |
| **Site** | Indoor coverage, mesh backbone, IP plan, switching, boundary L3/L4 services | `3-Guide/Network-Planning/`, `IP-Addressing/`, `Wireless-Mesh/` | OpenWrt routers, 802.11s mesh, DHCP/DNS on the gateway |
| **Endpoint touchpoint** | The network-side of laptop/desktop provisioning | `3-Guide/Laptop-Deployment/` (network parts only) | Isolated PXE subnet, deployment switch, on-site DHCP/TFTP/NFS |
| **Power & enclosure** | Mains, UPS, surge protection, mounting, cabling, labelling | `3-Guide/Power-and-UPS/` | UPS sizing, cable management, panel labelling |

The endpoint-touchpoint layer is intentionally split from the *endpoint*
work-stream described in §3.B. Section §3.B owns the laptop as a managed
asset (image, partitions, user account); §3.A only owns the network plumbing
that is required during a mass deployment. The split mirrors the SW/HW
split between this thesis and the companion thesis: a deployment is a
single event, but the underlying responsibilities can be assigned cleanly.

The remainder of §3.A walks through these four layers in the order in which
they are typically commissioned: a *site assessment* that constrains all
later choices (§3.A.2), the **site layer** itself (§3.A.3 to §3.A.5), the
**field layer** (§3.A.6), the **endpoint touchpoint** (§3.A.7), the
**power and enclosure layer** (§3.A.8), and the **boundary services** that
are kept in scope (§3.A.9). The part closes with the cross-cutting
practices that experience showed are not optional (§3.A.10) and the
explicit lessons-to-handbook flow that motivated the recipes
(§3.A.11).

### 3.A.2 Site and internet assessment

No layer can be designed without first characterising the site. The method
codified in `3-Guide/Network-Planning/` has three phases, each with a
corresponding deliverable:

1. **Internet assessment.** What ISP options exist, what speed and latency
   the existing uplink actually delivers, and whether a different
   technology (fibre, cable, ADSL, 4G/5G, LEO satellite) is reachable at
   reasonable cost. The deliverable is a comparison table scored against
   the eight criteria in `1-Internet-Assessment.md` (download/upload,
   data cap, reliability, latency, local support, contract length, budget
   fit, expected user load). The Namibia deployment inherited a
   government-supplied ADSL link and skipped the change-of-provider
   branch; the methodology still required documenting the alternatives,
   which is what allows a future team to revisit the choice.
2. **Site assessment.** A walkthrough with a Wi-Fi analyser
   (LinSSID/WiFiman) producing a coverage heatmap with three bands
   (≥ −50 dBm, −70 to −80 dBm, ≤ −80 dBm), a baseline speed test repeated
   at different times of day, and an annotated site map (overhead imagery
   plus on-site sketch) marking entry point, target rooms, obstacles,
   distances, and power outlets. This map is the single most important
   artefact produced before any equipment is purchased.
3. **Expansion planning.** A decision tree (Ethernet + APs vs mesh vs
   point-to-point antennas) driven by *building topology, cabling
   feasibility, and inter-building distance*, not by personal preference.

The methodological commitment is that the site survey produces a written
record, not a recollection. Every later decision in §3.A.3 to §3.A.8 cites
this record. This is the first concrete answer to the *knowledge
volatility* problem named in §1.2: the site assessment of one team becomes
the starting context of the next.

### 3.A.3 Hardware selection at the site layer

The bill of materials for the site layer is constrained by four criteria,
applied in order:

1. **OpenWrt support** with mesh-capable Wi-Fi packages. The router must be
   on the OpenWrt Table of Hardware with a current snapshot or release,
   and it must have enough flash and RAM to host `wpad-mesh-wolfssl`
   alongside the default LuCI stack (in practice ≥ 16 MB flash, ≥ 128 MB
   RAM, dual-band radios).
2. **Affordability and local availability.** Equipment that can be replaced
   in country, or shipped without customs friction, beats marginally
   better equipment that cannot.
3. **Power flexibility.** 12 V / USB-C devices integrate with a small UPS
   without a per-router AC brick.
4. **Footprint.** A consumer plastic enclosure that mounts on a wall with
   two screws is preferred over a 19" rack device for primary-school
   environments.

The default pick that satisfies all four criteria at the time of writing is
the **Cudy WR3000E** (Wi-Fi 6, dual-band, OpenWrt-supported, ~45 €/unit,
12 V input). For deployments that need a more capable gateway with two
Ethernet interfaces, USB 3.0, and headroom for VPN and on-router services,
the **NanoPi R-series** is the chosen alternative; it is the same family
that the companion thesis uses for service hosting [Motje, 2026], which
keeps the on-site hardware vocabulary uniform across the two work-streams.

A pitfall worth naming: a router that *technically* supports OpenWrt at
release N may be impractical if the snapshot images regress on the model's
specific Wi-Fi driver. Two days were lost in early bring-up to a snapshot
build that broke 5 GHz on the WR3000E; the recipe in
`Wireless-Mesh/1-Static-IP-Mesh/index.md` therefore pins the tested
versions of OpenWrt and `wpad-mesh-wolfssl` and cautions the reader that
"newer is not necessarily better".

### 3.A.4 IP addressing plan

The IP plan is the most under-valued artefact of a small network, and the
one whose absence costs the most when something breaks. The handbook
recipe `3-Guide/IP-Addressing/index.md` codifies four methodological
commitments:

- **Use a non-default `/24`** (the deployments documented here use
  `192.168.70.0/24`). Default ranges (`192.168.1.0/24`, `192.168.0.0/24`)
  collide the moment a second consumer router is plugged in for tests, or
  a contractor's device with the same default range is brought to site.
  RFC 1918 leaves an enormous private space; using it removes a recurring
  source of accidental conflicts.
- **Reserve the low part of the range for infrastructure** (`.1` for the
  gateway, `.2`–`.20` for routers and APs, `.21`–`.99` for fixed servers
  and printers) and the high part for DHCP-assigned client devices
  (`.100`–`.200`). The split is arbitrary but stable, and a single glance
  at an IP tells the operator what kind of device they are dealing with.
- **Document the plan in a versioned spreadsheet** with one row per device:
  hostname, role, location, MAC, IP, allocation method (static / DHCP
  reservation / DHCP pool). The spreadsheet lives in the project repository
  and is updated *at the moment of provisioning*, not afterwards.
- **Prefer DHCP reservations over hand-coded static IPs** wherever the
  device supports DHCP-client mode. This is the substance of the second
  iteration of the mesh setup (§3.A.5): static IPs survive only as long
  as the team that wrote them is around, while a DHCP table on the
  gateway is self-documenting and survives turnover.

The IP-conflict episode of Day 8 in Gochas, in which a newly added router
silently misrouted traffic until a missing static-route entry was found,
is the empirical justification for these commitments. It cost roughly an
hour of debugging for what was a five-minute fix once the problem was
named — the handbook recipe explicitly calls this out under
"Common Mistakes" so that the next operator skips the hour.

### 3.A.5 Wireless mesh design at the site layer

Indoor coverage of a multi-room or multi-building site without trenching
cable is met with an IEEE 802.11s mesh on OpenWrt. The handbook codifies
the design as **two iterations** that are meant to be done in sequence,
not chosen between (`3-Guide/Wireless-Mesh/index.md`):

- **Iteration 1 — static-IP mesh.** Each satellite router gets a unique
  static LAN IP, its DHCP server is disabled, the default `wpad-basic-*`
  package is replaced with `wpad-mesh-wolfssl`, and a 5 GHz 802.11s
  backhaul is brought up alongside a shared 2.4 GHz access point. This is
  the simplest configuration that confirms the mesh links form, that
  satellites bridge correctly, and that clients roam between APs sharing
  the same ESSID, encryption, and key. Iteration 1 is the recommended
  starting point for *every* deployment because it isolates the
  link-formation problem from the IP-management problem.
- **Iteration 2 — DHCP-based mesh.** Once the mesh is stable, each
  satellite is converted to a DHCP client of the main router, with WAN
  and the firewall disabled, and its address pinned by a static lease on
  the gateway. This centralises IP management on one device, makes
  onboarding new satellites a matter of plugging them in, and removes a
  whole class of long-term operational problems caused by hand-edited IP
  tables drifting out of date.

The methodological choice of *layering* the iterations rather than
presenting them as alternatives is itself a deliberate didactic device:
new operators learn the system by building it incrementally, and they
acquire diagnostic intuition (what fails when DHCP is misconfigured vs
when the mesh ID is mistyped) that they would not acquire by copy-pasting
the final state.

The radio design splits the two bands by role:

- **5 GHz** carries the mesh backhaul on a fixed channel (typically 44),
  20 MHz or 40 MHz wide, in 802.11s mode with WPA3-SAE encryption.
  Narrower channels penetrate walls better at the cost of throughput; in
  small primary-school deployments the throughput ceiling is set by the
  uplink, not the backhaul, so 20 MHz is the safe default.
- **2.4 GHz** carries the client access point on a non-overlapping channel
  (1, 6, or 11) with WPA2-PSK by default, escalating to WPA2/WPA3 mixed
  mode only after the client device population is known. The Gochas
  deployment hit a WPA3-only incompatibility on a single laptop on Day 6
  and was reconfigured to mixed mode within minutes; the handbook now
  recommends mixed mode by default for any site with unknown client
  hardware.

### 3.A.6 Field-layer point-to-point links

When two buildings are more than ~50 m apart or separated by structures
that block 2.4/5 GHz, the mesh stops being adequate and a dedicated
point-to-point (PtP) link at the field layer takes over. The handbook
section `3-Guide/Antennas/` is currently a stub and is one of the
deliberate WIP markers acknowledged in §1.4. The methodological intent,
already fixed, is:

- Use Ubiquiti airMAX or LiteBeam-class equipment (or equivalent) chosen
  by Ubiquiti Design Center / LinkPlanner against a real terrain profile
  rather than a rule of thumb.
- Conduct an explicit line-of-sight visibility test before mounting,
  including Fresnel-zone clearance.
- Mount, align, and link-test in two passes — coarse alignment from the
  signal-strength meter, fine alignment from the throughput test.
- Document the link as a pair of devices with their own subnet entries in
  the IP plan of §3.A.4.

The Gochas deployment did not exercise this layer (the school's buildings
are within mesh range), so the recipe is documented from the network
planning context and from the literature rather than from a fresh field
event. This honest framing is part of the validation discussion of §4.

### 3.A.7 Endpoint touchpoint — the deployment subnet

A laptop mass-deployment (§3.B) requires its own short-lived network: an
isolated Ethernet segment carrying DHCP, TFTP, and NFS for PXE boot, plus
the Clonezilla rootfs and the disk image. From the §3.A perspective, this
network has three hardware requirements:

1. A **gigabit unmanaged switch** with one port per target machine plus
   one port for the PXE server. Nine ThinkPads in Gochas were served by a
   single 16-port switch.
2. **Strict isolation from the production LAN** during the imaging
   window. The deployment subnet runs its own DHCP server (the PXE
   server's `isc-dhcp-server`) which would conflict with the gateway's
   DHCP if both were reachable on the same broadcast domain.
3. **A planned IP range that does not overlap the production plan**
   (`10.10.10.0/24` was used in Gochas against the production
   `192.168.70.0/24`), so a misconnected cable does not silently bridge
   the two networks.

The corresponding services (DHCP scope, TFTP root, NFS export) belong to
§3.B; their hardware substrate belongs here.

### 3.A.8 Power and enclosure

Power is the failure mode that no software can mitigate. The site
assessment of §3.A.2 records a load inventory for each candidate
deployment site:

- Mesh router: ~5 W steady, ~10 W peak (per node).
- PoE switch (if used): ~10–20 W plus per-port PoE budget.
- Mini-PC / NanoPi gateway: ~5–15 W steady.
- Optional UPS standby loss: ~5 W.

At a small site (one gateway, one switch, four to seven mesh nodes), the
total steady draw is in the 50–100 W range, which puts a 600–800 VA
consumer UPS in the right size class for ~30 min of bridging during short
outages and, more importantly, for graceful shutdown on longer outages.
The recurring power cuts in Gochas (sometimes lasting days, with the
town's communication tower turning off at 20:00 by design) confirmed that
*riding through* outages is not a realistic goal at this site class; the
realistic goal is *graceful shutdown and clean restart*, which the chosen
sizing supports. The companion thesis [Motje, 2026] develops the
graceful-shutdown integration on the services side via NUT; §3.A only
guarantees that the hardware can survive a sudden cut without data loss
on the network devices themselves (OpenWrt's flash layout makes this
trivially true on the router side; the gateway PC is the device that
needs the UPS).

Enclosure and mounting are mundane and decisive. The convention adopted
in the handbook recipe (currently a stub at `3-Guide/Power-and-UPS/`) is:
mount above head height to clear furniture and people; choose locations
with a power outlet within ~2 m to avoid extension-cord chains; label
every cable on both ends with a printed tag bearing the device hostname;
photograph the panel after every change.

### 3.A.9 Boundary services kept in scope

The hardware work-stream owns the *minimum* set of L3/L4 services without
which the network is not usable. Three services qualify:

- **DHCP on the gateway.** A single `dnsmasq` instance (the OpenWrt
  default) serving the production scope, with static leases for every
  infrastructure device named in §3.A.4. The SW/HW boundary is drawn
  here: configuration of `dnsmasq` on the gateway is in scope; richer
  DHCP servers, DHCP relays across VLANs, and IPAM tooling are in
  [Motje, 2026].
- **DNS forwarding on the gateway.** Again `dnsmasq` in its forwarder
  role, with the gateway's own DNS servers (typically `1.1.1.1` and
  `9.9.9.9`) as upstream. Local-name resolution for the infrastructure
  devices is configured by the same static-lease entries.
- **A monitoring overview on the gateway.** Only the *minimum* needed to
  answer "is the mesh up, are the satellites reachable, is the uplink
  alive": LuCI's built-in `Status → Wireless` and `Status → Routes`,
  plus ping-based checks scriptable from the gateway. Full Zabbix
  agentful monitoring is software work and is owned by [Motje, 2026]; the
  hardware-side commitment is to expose the SNMP and ping endpoints that
  the monitoring stack consumes.

This boundary is drawn explicitly so that no aspect of the deployment
falls between the two theses uncovered.

### 3.A.10 Cross-cutting operational practices

A handful of practices are not specific to any one layer but apply across
all of them. They are codified in the handbook's general rules and
repeated in the site-deployment recipes because their cost of omission is
high:

- **Label every cable on both ends.** A two-letter site code plus the
  destination hostname is enough.
- **Photograph every panel** before and after a change. The photo is
  attached to the project log entry.
- **Keep a one-page outage runbook** at the site (laminated A4),
  containing: gateway IP and admin credentials reset procedure, the IP
  plan, the wiring diagram, and the contact of the maintainer of record.
- **Carry a spares kit** sized to one of each critical device
  (one router, one switch, one PoE injector if applicable, two pre-made
  Ethernet cables of common lengths). The kit lives at the site, not
  in Barcelona.
- **Pin firmware and package versions** in the recipe and verify them
  during bring-up. The "newer is not necessarily better" rule of §3.A.3
  applies here too.

These practices are mundane on purpose. Their value is exactly that they
do not require the operator to remember anything in the moment.

### 3.A.11 Lessons learned and inputs to the handbook

The hardware-network deployments described in §4 produced a set of
lessons that landed directly as recipes, admonitions, or cross-references
in the handbook. Naming them here makes the §3 → handbook → §4 loop
explicit.

**The IP plan is a deliverable, not a side-effect.** The Day-8 conflict
episode in Gochas is the reason `3-Guide/IP-Addressing/index.md` opens
with a "why a non-default range matters" section and why every router
recipe asks the reader to update the spreadsheet *at the moment of
provisioning*.

**Mesh setup is two iterations, not one.** The decision to split the
mesh recipe into a static-IP first pass and a DHCP-based second pass
came directly from the observation that operators who tried to go to
the DHCP-based design first lost time on link-formation failures that
were not in fact caused by DHCP. The two recipes
(`Wireless-Mesh/1-Static-IP-Mesh/`, `Wireless-Mesh/2-DHCP-Mesh/`) are
the codification of that lesson.

**Pin the OpenWrt and `wpad-mesh` versions.** The `Used Versions` table
at the top of the static-IP-mesh recipe exists because two days of early
bring-up were lost to a snapshot regression. Future operators are warned
that they may need to roll back if a fresh snapshot misbehaves, and they
are pointed to the issue tracker.

**Mixed-mode WPA2/WPA3 by default until clients are known.** The Day-6
WPA3-only incompatibility is named in the recipe under "Wireless
Security" so the next deployment does not repeat it.

**Power planning is for graceful shutdown, not ride-through.** The
recurring outages in Gochas reframed the UPS goal and that reframing is
now embedded in the (still stub) `3-Guide/Power-and-UPS/` section. The
handover to [Motje, 2026] for NUT integration is explicit.

**The site survey is a versioned artefact.** The methodological
commitment that "every later decision cites this record" is inherited
from §3.A.2 and is repeated as a rule in `Network-Planning/index.md`.
A site survey kept only in someone's head does not count.

These lessons are revisited in §4 against the three validation lenses
(coverage, sufficiency, adaptation) and in §7 as part of the
per-objective check.

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

The two preceding parts of this chapter (§3.A and §3.B) describe *what* was
deployed in the field. This third part describes *how the deployment knowledge
itself is preserved* so that the next student, the next volunteer, or the next
partner association does not have to start again from a blank page. It is the
most original contribution of this thesis: not a single network or a single
classroom of refurbished laptops, but a reusable instrument — the **Community
Network Handbook** — capable of producing many of them.

The handbook is hosted at <https://github.com/aucoop/Community-Network-Handbook>
and published as a static website plus a downloadable PDF. The thesis writes
*about* the handbook; the handbook itself is the durable deliverable.

### 3.C.1 Why a living handbook

§1.2 framed the problem of *knowledge volatility* in a volunteer association.
AUCOOP runs on bachelor and master students who join, contribute for one or two
academic years, graduate, and leave. Every project — Namibia 2024, Namibia
2026, the local pilots in Barcelona — produced internal documents (PDFs,
slide decks, hand-written field notes) that ended up in shared drives that
nobody opens once the contributors are gone. The next team rediscovers the
same DHCP option, the same OpenWrt mesh quirk, the same Clonezilla
`partclone target seek ERROR`, and pays the same debugging tax.

A living handbook reverses this dynamic by making three structural commitments:

1. **The artefact is the documentation, not a side-effect of it.** Contributors
   write directly into the handbook during the project, not into private notes
   that *might* be transcribed afterwards.
2. **The artefact is publicly readable.** External collaborators (NGO partners,
   future host schools, other student associations) can consult it without
   asking permission, which removes the friction that kills internal wikis.
3. **The artefact is editable through a low-ceremony, version-controlled
   workflow** (Git + Markdown + pull request), so corrections from the field
   are cheap to land.

Compared with the realistic alternatives — a Google Drive folder, a Notion
workspace, a wiki on a self-hosted server that nobody patches — the chosen
model trades convenience (no rich WYSIWYG editor) for longevity (plain text
under version control survives platform changes and credential losses).

### 3.C.2 Information architecture

The handbook is organised in four top-level chapters, each with a clear
epistemic role:

| Chapter | Role | Voice |
|---|---|---|
| `1-Introduction` | Why the handbook exists, who it is for | Editorial |
| `2-Imaginary-Use-Case` | A fictional community network, told as a story; one section per challenge | Narrative, second-person, italic question titles |
| `3-Guide` | Step-by-step recipes; one folder per technology | Instructional, imperative |
| `4-Real-Use-Cases` | Concrete deployments (Namibia, …) used as case studies | Reporting |

The defining design rule is the **1-to-1 mapping between Chapter 2 and Chapter
3**: every story section in Chapter 2 must have a matching recipe in Chapter 3,
and vice versa, with explicit cross-links in both directions. The intent is
twofold. A reader who is *learning the domain* enters through the story and
follows the link to the recipe when they want to act. A reader who is
*executing a deployment* enters through the recipe and follows the link to the
story when they need to understand the trade-offs. Neither audience is
penalised. The constraint is enforced at review time and is mechanical enough
that it can be audited (see §3.C.5).

Inside a section folder, content is co-located with its images:

```
docs/3-Guide/Laptop-Deployment/
├── index.md
├── AUCOOP-image.md
└── images/
    ├── pxe-architecture.webp
    └── clonezilla-savedisk.webp
```

Image filenames are prefixed with the owning section (`Cudy-WR3000E-luci.webp`,
`2.1-router-front-panel.webp`) so that a file moved or renamed without its
section is immediately recognisable as orphaned. All raster images use WebP at
quality 85, chosen as the smallest format that still renders well in the PDF
build.

### 3.C.3 Toolchain

The handbook is built with **Zensical**, a static-site generator that consumes
Markdown plus a `mkdocs.yml` navigation manifest and produces both the website
and the PDF. The relevant configuration choices are:

- **Theme.** Material for MkDocs in `navigation.sections` mode, with
  light/dark/system palette toggles. The teal accent matches the AUCOOP
  branding.
- **Markdown extensions.** `pymdownx.superfences` (with a Mermaid custom
  fence), `admonition`, `pymdownx.details`, `pymdownx.highlight`,
  `pymdownx.tabbed`, `pymdownx.arithmatex`, `attr_list`, `tables`,
  `md_in_html`. These cover the four expressive needs of a deployment guide:
  diagrams, side notes, code with line numbers, and tabular data.
- **Diagram pipeline.** Mermaid is rendered client-side from fenced code
  blocks, which keeps diagrams in plain text inside the source repository and
  reviewable in pull requests. PlantUML is available for the rarer cases that
  need it, served by `build_plantuml` against the public PlantUML server.
- **PDF target.** The repository's release pipeline produces a single
  `Community-Network-Handbook.pdf` artefact; the website surfaces it through
  the `extra.book_download_url` setting. Both outputs are generated from the
  same Markdown source, so there is no risk of the printable copy and the web
  copy drifting apart.

The build commands are deliberately wrapped: contributors run `zensical serve`
for local preview and `zensical build` for production, never `mkdocs` directly.
Documenting this in the project's `AGENTS.md` removes a common source of
confusion when a new contributor's local environment behaves differently from
CI.

### 3.C.4 Dual output — web and PDF

A handbook intended for low-connectivity contexts cannot be a website-only
artefact. During the Gochas deployment, the school's uplink was unusable for
hours at a time, and the team relied on the offline PDF copy carried on a
laptop. Conversely, an NGO evaluating AUCOOP from Barcelona benefits from a
searchable, linkable web version. The dual output is not a redundancy; it
serves two distinct usage modes:

- The **web** version is the canonical, evolving document. It is
  search-indexed, link-friendly, and updated on every merge to `main`.
- The **PDF** version is the *expedition copy*. It is produced as a GitHub
  release artefact, pinned to a specific commit, and intended to be downloaded
  before travelling.

Pinning the PDF to a release tag means a field team can reference *the exact
version of the handbook they took with them* months later, even if the website
has moved on. This addresses a classic reproducibility problem in deployment
documentation: the recipe that worked in March may have been silently rewritten
by July.

### 3.C.5 Contribution model and AI-assisted authoring

The handbook is written by a rotating set of contributors of unequal
experience: senior PhD students, master students writing their thesis (this
thesis among them), and bachelor students contributing for a single semester.
The contribution model has to be strict enough that quality does not collapse
between cohorts, but light enough that a one-semester contributor can land a
useful change in their first week. Three mechanisms make this work.

**Rule files.** The conventions that govern the handbook are not folklore;
they are version-controlled Markdown files under `.opencode/rules/`. Four
files cover, respectively, the general project rules (`general.md`), the
narrative voice required for Chapter 2 stories (`chapter2-story.md`), the
imperative structure required for Chapter 3 recipes (`chapter3-guide.md`), and
the navigation-manifest invariants for `mkdocs.yml` (`mkdocs-nav.md`). A new
contributor is told to read these once; a reviewer who finds a violation
points to the exact rule. The rules also encode operational details that are
easy to forget — the placeholder image workflow, the WIP admonition format,
the file-naming conventions for sections and images.

**OpenCode subagents.** The repository ships with five project subagents
defined in `.opencode/agents/` that can be invoked from any OpenCode-compatible
editor:

| Agent | Role | Mode |
|---|---|---|
| `@writer` | Create or expand sections; runs against the rule files; can edit and shell out | Read–write |
| `@reviewer` | Quality review of an existing section against the rules | Read-only |
| `@structure` | Refactor folder structures and synchronise `mkdocs.yml` nav | Read–write |
| `@diagrams` | Author or improve Mermaid diagrams | Read–write |
| `@consistency` | Audit cross-cutting invariants (Ch2↔Ch3 mapping, broken links, missing TODOs) | Read-only |

The `@writer` agent is the most-used. Its rule of operation is informative:
it must read the relevant rule file *before* editing, present a compact plan,
wait for explicit human approval (unless invoked through a custom command,
which counts as approval), and only then write. This pattern — *plan, approve,
execute* — keeps the human reviewer in the loop on every change while
absorbing the mechanical cost of conforming to the rules.

**Custom commands.** Five slash-commands package recurring workflows so that
they are issued the same way every time:

- `/new-section` — create a paired Ch2 story stub and Ch3 recipe stub, plus
  the `mkdocs.yml` nav entries.
- `/review-chapter` — invoke `@reviewer` against a chapter and produce a
  review report.
- `/add-diagram` — drop a Mermaid block in the right place with the right
  fencing.
- `/audit` — run `@consistency` across the whole repository.
- `/guide-from-steps` — turn a contributor's raw shell history or field notes
  into a Chapter 3 recipe that conforms to the structural template.

The combination is what enables a master-thesis contribution like this one to
add four merged feature branches over a few weeks while keeping the handbook's
voice and structure intact. The cost of consistency is paid by tooling, not
by reviewer fatigue.

It should be stated openly that AI assistance is part of the workflow.
The handbook is not generated by AI — every page is reviewed and approved by
a human contributor — but the mechanical conformance work (filling templates,
synchronising the nav, regenerating tables, applying tone rules) is delegated
to subagents. This is itself a contribution: it documents a viable model for
small-association open documentation projects that have neither paid editors
nor a stable maintainer pool.

### 3.C.6 Governance for continuity

Tooling alone does not guarantee survival. The handbook also needs an
explicit governance contract. The following elements are proposed and are in
force on the `dev_mj_thesis` branch at the time of writing:

- **Maintainer rotation.** At any time the handbook has at least one
  *maintainer* (currently the AUCOOP project lead) and at least one *active
  contributor* whose thesis depends on the project. The active contributor is
  expected to take over maintainer duties at the end of their thesis if no
  successor has joined. A short hand-over document accompanies each
  transition.
- **Definition of Done for a chapter.** A chapter is considered "done for
  this iteration" when (i) every section has at least one paragraph of body
  text, (ii) the Ch2↔Ch3 cross-links exist in both directions, (iii) all
  images are real (no placeholders), (iv) `/audit` reports zero structural
  errors, and (v) `zensical build` succeeds without warnings.
- **Picking up an open chapter.** A new contributor opens the chapter folder,
  reads its `index.md`, runs `/audit` to see the outstanding TODOs and WIP
  markers, and chooses one. The combination of `!!! info "Work in Progress"`
  admonitions and `<!-- TODO: ... -->` comments is dual on purpose: the first
  is visible to readers of the rendered site and signals that they should not
  rely on the section yet; the second is invisible to readers but `grep`-able
  by contributors.

This governance is light by design. Heavier processes — RFC documents,
formal release schedules, CODEOWNERS — would not survive the next volunteer
rotation. The chosen mechanisms degrade gracefully: even if the rules and
agents fall out of use for a semester, the resulting damage is limited to
inconsistent voice, not a broken build or a corrupted history.

### 3.C.7 What this contributes beyond the deployment

The Namibia deployment described in §4 will eventually be one row in the
handbook's `4-Real-Use-Cases` chapter. The handbook itself will outlive it.
The contribution claimed here is therefore not "documenting Namibia" but
*producing the instrument that makes Namibia documentable in a form the next
team can act on*. The thesis treats this instrument with the same rigour as
the network and endpoint work: as a designed system with explicit
requirements (continuity, dual output, low contributor onboarding cost),
explicit components (rule files, subagents, custom commands, governance
contract), and a measurable acceptance criterion (the four merged branches
of `dev_mj_thesis`, which collectively land a complete first version of the
hardware-network and laptop-deployment material).
