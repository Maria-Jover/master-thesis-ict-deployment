# 4. Results
<!-- \label{ch:results} -->

This chapter validates the methodology of §3 against the field. It is
deliberately **visual-first**: each section is anchored by figures
drawn from the deployment record, the handbook, and the field artefacts,
with prose limited to the connecting commentary each figure needs.

Section §4.1 introduces the site and the validation strategy. Section §4.2
presents the network deployment outcome through before/after maps, annotated
challenges, and field photographs of the mesh nodes installed in the
classrooms. Section §4.3 presents the endpoint deployment outcome through
the pipeline diagram, the field rig, and key metrics. Section §4.4 reports
the knowledge-transfer outcome — the teacher seminar at N Mutschuana and the
post-deployment evidence that the receiving community internalised both the
operation and the underlying concepts of the new infrastructure. Section
§4.5 validates the handbook as a knowledge artefact using screenshots of
the published site. Section §4.6 closes the methodology–results loop with
the lessons that landed as recipe amendments. Section §4.7 discusses limits.


## 4.1 Site context and validation strategy
<!-- \label{sec:results-strategy} -->


The single deployment site is **N Mutschuana Primary School** in Gochas,
Hardap Region, Namibia — a 300-pupil primary school in a remote Kalahari
Desert town of fewer than 2,000 inhabitants. The map below places Gochas in
its regional context.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.70\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/4.1-mapa-gochas.png}
\caption*{\textit{Figure 4.1 — Gochas in the Hardap Region of Namibia. The town sits in the Kalahari Desert, roughly 250 km south-east of Mariental. Source: handbook case study, reproduced with permission.}}
\end{figure}
```

The validation is **qualitative**, framed along three lenses shared with
the companion thesis [Motje, 2026]:

- **Coverage** — did the system reach every part of the site it was
  designed to reach?
- **Sufficiency** — did it carry the intended load with margin?
- **Adaptation** — did the recipe survive execution by a team member
  who was *not* its original author, and without undocumented
  field-time amendments?

The school came to the project with three structural deficits (§1.2.1): no
reliable coverage across its building blocks, no usable endpoints for most
teachers, and no documentation of what existed. The team of three AUCOOP
members (Jaume Motje, Sergio Giménez Antón, and María Jover Tarancón) addressed all three over roughly fiveteen working days between March-April 2026
with a CCD grant of 5,600 € and donated hardware.


## 4.2 Network deployment — Gochas
<!-- \label{sec:results-network} -->

### 4.2.1 The initial situation

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.92\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/4.1-network-before.png}
\caption*{\textit{Figure 4.3 — Network state on arrival. Two independent government-supplied ADSL routers with no IP plan and overlapping factory defaults. ADSL Router 1 (principal's office area) broadcast a Wi-Fi signal but was not connected to the ISP — its Ethernet cable was wrapped around an unplugged power outlet. ADSL Router 2 (main classroom block) had a working uplink but classroom-scale dead zones. Most teaching spaces had no usable Wi-Fi.}}
\end{figure}
```

The initial situation exposed all three failure patterns the methodology
anticipates (§3.A.3): no internet assessment existed, no site map had been
produced, and no IP plan governed the two routers. The first field day was
spent documenting what was actually present — which revealed the inoperative
ADSL Router 1, a fact the school staff did not know (Challenge 1 of the case
study).

### 4.2.2 Site assessment artefacts

Before any new equipment was deployed, the team walked the school with a
Wi-Fi analyser, produced a coverage sketch, and documented the uplink.
Two artefacts from this step are reproduced below.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=1\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/network-planning-wifi-signal-drop.webp}
\caption*{\textit{Figure 4.4 — Wifi signal power drop captured by LinSSID when moving between classes. Source: Network Planning guide, handbook.}}
\end{figure}
```


### 4.2.3 The deployed network

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.92\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/4.1-network-after.png}
\caption*{\textit{Figure 4.6 — Network state after the deployment. Seven access points (one gateway + six Cudy WR3000E mesh nodes) form a single 802.11s mesh covering all classroom blocks, the principal's office, the staff room, and the preprimary classrooms. One SSID, seamless client roaming. The ADSL uplink (gateway at 192.168.70.1) feeds the entire mesh; the 4 Mbps ceiling is upstream of the school gate. Source: handbook case study.}}
\end{figure}
```

**Coverage outcome.** Every building block and outdoor connecting space
listed in the site assessment is reached at usable signal. The coverage lens
is met against documented intent.

**Sufficiency outcome.** Within roughly 30 minutes of the mesh going live, every teacher in the staff room had the new Wi-Fi password — the
network *spread like wildfire*, the informal sign that real demand existed
and the deployment met it. The mesh backhaul has substantial headroom; the
bottleneck is the ADSL uplink, not the wireless fabric.

### 4.2.4 Mesh nodes in the classrooms

The seven mesh nodes were not installed in a server room. They were mounted
on classroom walls, in occupied teaching spaces, while normal school life
continued around the install crew. Two photographs from the install day
make this concrete.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.45\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.2-mesh-install-mounting.jpg}
\caption*{\textit{Figure 4.7 — Mesh node install in an upper-primary classroom. The crew (Jaume Motje and María Jover, with the school's former Director) The class teacher (right) supervises the work in her own room. Source: field photograph, Gochas, March 2026.}}
\end{figure}
```


```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.45\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.2-mesh-install-classroom.jpg}
\caption*{\textit{Figure 4.8 — Final node instalation, in service. The Cudy WR3000E shares wall space with the Nama vocabulary posters. Source: field photograph, Gochas, March 2026.}}
\end{figure}
```

This embedding has a downstream consequence picked up in §4.4: the people
who will live with the equipment — the teachers — see the access points
every day, in their own rooms, next to their own teaching materials. The internet is now a real tool to bring their teaching to the next level.


## 4.3 Endpoint deployment — Gochas
<!-- \label{sec:results-endpoint} -->

### 4.3.1 The deployment pipeline

The endpoint work-stream is organised as a four-phase pipeline (Figure 4.9):
prepare a golden master on a single reference machine, capture it as a
Clonezilla image, resize the image so it can be restored onto smaller target
disks, and finally PXE-deploy the resized image to all target machines in
parallel. The four phases are sequential; only Phase 4 fans out across the
fleet.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.95\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.3-pipeline-diagram.png}
\caption*{\textit{Figure 4.9 — The four-phase endpoint deployment pipeline. Phases 1–3 happen once per image; Phase 4 fans out across all target machines simultaneously over the local PXE network. Source: handbook, \texttt{3-Guide/Laptop-Deployment/}.}}
\end{figure}
```

The four-phase split is itself a result of the trip — see Lesson 7 in §4.6,
where the partition-resize step was promoted from a parenthetical inside the
PXE phase to its own phase after the first cross-disk restore failed.

### 4.3.2 Field execution

The pipeline above is what the recipe says. The two photographs below are
what executing it on the ground actually looked like.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.85\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.3-thinkpads-provisioning.jpeg}
\caption*{\textit{Figure 4.10 — Phase 4 in execution: seven Lenovo ThinkPads (T460 / X260) being PXE-provisioned in parallel from a single power strip in the school's storeroom. The machine in the foreground (left) has already finished and is at the Labdoo first-boot login screen; the others are at various points of the Clonezilla restore. Source: field photograph, Gochas, March 2026.}}
\end{figure}
```

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.55\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.3-pxe-switches.jpeg}
\caption*{\textit{Figure 4.11 — The PXE rig: two stacked TP-Link TL-SG108 unmanaged gigabit switches dedicated to the deploy network, isolated from the school's production mesh. The PXE server (laptop, right) serves DHCP, TFTP, and the Clonezilla image over this isolated segment; target ThinkPads boot off it. Source: field photograph, Gochas, March 2026.}}
\end{figure}
```

Two things in these images are worth naming explicitly. First, the
deploy rig is *minimal* — two consumer switches, one laptop, and a power
strip. The recipe was deliberately written against equipment that fits in
hand luggage. Second, the install environment is *not a workshop* — it is
a corner of a primary-school storeroom, with stone walls, a single mains
outlet, and the laptops resting wherever there was floor space. The
$\sim$1 h end-to-end figure in §4.3.3 is measured under these conditions,
not under lab conditions.

Twelve machines were processed in total: nine Lenovo ThinkPads (T460 /
X260) from Labdoo and three laptops from NexTReT. All twelve received the
AUCOOP Linux Mint 22.3 Cinnamon image and were handed over in working
condition. No machine was set aside as unprovisionable.

### 4.3.3 Key metrics

| Metric | Value |
|---|---|
| Machines provisioned | 9 ThinkPads (Labdoo) + 3 laptops (NexTReT) = **12 endpoints** |
| Master OS | Linux Mint 22.3 Cinnamon |
| Image size — original capture | $\sim$4 GB compressed (466 GB source) |
| Image size — after Phase 3 resize | $\sim$3.6 GB compressed (20 GB partition) |
| Parallel deploy time, 9 machines | $\sim$1 h end-to-end |
| Manual-install equivalent | $\sim$7 h (45 min/machine) |
| Secure-Boot silent-fail incidents | Multiple on Day 4; **zero** after inventory-time BIOS check |
| Machines handed over in working order | **12 of 12** |

Table: Endpoint deployment metrics — Gochas, March 2026

**Coverage outcome.** Every machine inventoried was provisioned and passed
the quality-control checklist (boot from disk, login, Wi-Fi, OnlyOffice
render, hostname match). The coverage lens is met.

**Sufficiency outcome.** The deployed image carried the school's actual
first-day workload: document and presentation work in OnlyOffice, Wi-Fi
via the new mesh, web browsing. The hardware class (i5-6200U, 8 GB RAM) is
comfortably above the working load. The bottleneck is again the ADSL uplink,
not the endpoints.

**Adaptation outcome.** The endpoint recipe was run largely by team members
who were *not* its original author. The partition-resize problem in
particular surfaced because the operator on the day was following the written
recipe from the handbook rather than working from the author's memory. This
is the strongest single-deployment signal of recipe portability the trip
produced.

---

## 4.4 Knowledge transfer — the teacher seminar
<!-- \label{sec:results-seminar} -->

A network and a stack of laptops handed over without a transfer of
understanding produces a one-trip dependency: the next time anything
changes, the school is back to waiting for an external visitor. The
methodology of §3 treats the seminar with the receiving teaching staff as
a deployment artefact in its own right, on the same level as the network
and the endpoints. This section reports its outcome.

### 4.4.1 The seminar at N Mutschuana

The seminar was held in the school's staff room on 4 days before end of the deployment so there was time for the teachers to do some hand's on work and be able to come back to us if some issues were found.
It was covered: The computer specification basics, Wi-Fi configuration, OnlyOffice,
download / antivirus, document creation, network configuration, password
hygiene, and remote support. Every teacher in service that week attended.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.65\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.4-seminar-network-map.jpg}
\caption*{\textit{Figure 4.16 — Plenary segment of the seminar. Jaume Motje walks the teachers through the deployed network map (projected, left) Explaining how the access points should "see" each other to be able to get to the Internet Gateway. Source: field photograph, Gochas, March 2026.}}
\end{figure}
```

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.65\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.4-seminar-hands-on.jpg}
\caption*{\textit{Figure 4.17 — Hands-on segment. María Jover works through OnlyOffice and the Wi-Fi join procedure with a group of teachers on the freshly-provisioned ThinkPads (§4.3). Source: field photograph, Gochas, March 2026.}}
\end{figure}
```

### 4.4.2 Hands-on with the configuration layer

For the two teachers who showed sustained interest on the technical side —
Mr Isak (the school's de facto IT contact) and Meester Basson — the
seminar continued one layer deeper, into the OpenWrt admin UI of one of
the secondary mesh routers. This was not about turning teachers into
network engineers; it was about ensuring at least one person on site
could reach the router's settings page, identify a connected client, and
read off an IP address when asked over WhatsApp.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.4\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.4-seminar-openwrt.jpg}
\caption*{\textit{Figure 4.18 — Configuration-layer walk-through. Sergio Gimenez shows the Director of the School and the Head of the children's home the set up of their computers. As the mesh was not deployed in the Children's House the team explained and created a guide on how the insntallation should be done once the ISP router was available. Source: field photograph, Gochas, March 2026.}}
\end{figure}
```

### 4.4.3 Post-deployment evidence

The strongest validation signal of a knowledge-transfer intervention is not
attendance at the session — it is what the recipients do *unprompted*
weeks later. Two episodes from the project's WhatsApp group, both initiated
by the school side, carry that signal.

**Conceptual uptake.** A week after the deployment, Meester Basson
forwarded an "Internet is like a Road System" infographic into the AUCOOP
project group, on his own initiative. The infographic frames bandwidth as
lanes, latency as travel time, packets as cargo trucks, routers as
traffic-control towers, congestion as traffic jams, and signal quality as
road condition. The exchange that followed (Figure 4.19) is the point:
Sergio responds by extending the *teacher's own analogy* to the Gochas
situation — *"the ministry only gave us a small lane. We are all sharing
it, hence there is often traffic jams."* This is a teacher, not a network
engineer, reaching for a mental model that *correctly identifies the ADSL
uplink as the bottleneck* (the same conclusion drawn formally in §4.2.3),
and an AUCOOP team member confirming the analogy in the teacher's own
vocabulary. The infrastructure is now describable from inside the school.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.45\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.4-whatsapp-roads-analogy.jpg}
\caption*{\textit{Figure 4.19 — WhatsApp exchange in the AUCOOP $\leftrightarrow$ N Mutschuana group "Internet is like a Road System"}}
\end{figure}
```

**Operational uptake.** When we were getting to the plain, the network monitoring
infrastructure deployed in the companion thesis [Motje, 2026] flagged a
printer disconnection. The AUCOOP team reached the school via the same
WhatsApp group; Mr Isak responded; the fault was diagnosed and repaired
remotely, with a hand-drawn diagram of the printer / router / LAN-port
wiring serving as the shared reference (Figure 4.20). Two specific
behaviours in this exchange are worth flagging. First, the school side
*acted on the diagnostic*.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.45\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/field/4.4-whatsapp-printer-support.jpg}
\caption*{\textit{Figure 4.20 — Remote-support exchange triggered by the monitoring system in [Motje, 2026]. Top: the AUCOOP-side diagnostic ("the cable connecting the printer to the router is not well connected"). Source: project chat.}}
\end{figure}
```

### 4.4.4 Coverage / Sufficiency / Adaptation

- **Coverage.** Every teacher in service that week attended the plenary;
  the configuration-layer walk-through reached the two technically-engaged
  staff members the school was likely to rely on.
- **Sufficiency.** The agenda covered the eight Index topics on the actual
  deployed equipment, with the deployed network as the live medium. No
  topic on the index went uncovered.
- **Adaptation — by the recipients.** The §4.3.3 reading of *Adaptation*
  was about whether an AUCOOP team member who was not the recipe's author
  could execute it. The reading here is more demanding: whether the
  school's own staff can *operate and reason about* the system without the
  AUCOOP team present. The two WhatsApp episodes above are the empirical
  signal that this transfer at least began. The conceptual episode shows
  the teachers acquiring a mental model that survives without us; the
  operational episode shows them organising an internal contact line and
  acting on remote diagnostics. Both are unprompted, and both happened
  weeks after the team had left the country.

This is, on the evidence available, the strongest single outcome of the
deployment in the long-run sense: the network and the laptops will
eventually wear out, but the seminar produced *people* who can talk about,
operate, and ask the right questions about the system. The handbook
(§4.5) is what those people — and their successors — will read when
something breaks.

---

## 4.5 Handbook validation — the knowledge artefact
<!-- \label{sec:results-handbook} -->

The handbook is the most original deliverable of this thesis (§3.C). Its
validation is reported on its own terms: *was it produced, is it public, does
it cover what it claims to cover, and did the deployment use it?*

### 4.5.1 The published artefact

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.96\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/diagrams/community_network_webpage.png}
\caption*{\textit{Figure 4.21 — Landing page of the Community Network Handbook, published at \url{https://aucoop.github.io/Community-Network-Handbook/}. The site is built from the same Markdown source as the downloadable PDF expedition copy; both outputs are regenerated on every merge to \texttt{main} by the Zensical pipeline.}}
\end{figure}
```


### 4.5.2 The handbook structure — a visual overview

The diagram below shows the information architecture of the handbook and the
1-to-1 mapping between the narrative (Ch 2) and recipe (Ch 3) streams that
is the defining structural rule of §3.C.2.

```{=latex}
\begin{figure}[H]
\centering
\begin{tikzpicture}[
  font=\small,
  chap/.style={draw, rounded corners=4pt, fill=gray!8, minimum width=3.5cm, minimum height=0.8cm, align=center},
  section/.style={draw, rounded corners=2pt, fill=white, minimum width=4.2cm, minimum height=0.85cm, align=center, font=\footnotesize},
  arrow/.style={->, thick, gray!60},
  link/.style={<->, dashed, thick, blue!50}
]

%% --- Chapter boxes ---
\node[chap] (ch1) at (1.5, 0)     {\textbf{Ch 1} Introduction};
\node[chap] (ch2) at (1.5,-2.0)   {\textbf{Ch 2} Imaginary Use Case};
\node[chap] (ch3) at (7.5,-2.0)   {\textbf{Ch 3} Guide (recipes)};
\node[chap] (ch4) at (4.5,-8.5) {\textbf{Ch 4} Real Use Cases};

%% --- Ch2 sections ---
\node[section] (s21) at (1.5,-3.4)  {2.1 The first router};
\node[section] (s22) at (1.5,-4.7)  {2.2 Expanding coverage};
\node[section] (s2x) at (1.5,-6.0)  {2.22 Equipping the community};

%% --- Ch3 sections ---
\node[section] (s31) at (7.5,-3.4)  {3-Guide/Network-Planning};
\node[section] (s32) at (7.5,-4.7)  {3-Guide/Wireless-Mesh};
\node[section] (s3x) at (7.5,-6.0)  {3-Guide/Laptop-Deployment};

%% --- Arrows from Ch2 header to section stubs ---
\draw[arrow] (ch2.south) -- (s21.north);
\draw[arrow] (s21.south) -- (s22.north);
\draw[arrow] (s22.south) -- (s2x.north);

\draw[arrow] (ch3.south) -- (s31.north);
\draw[arrow] (s31.south) -- (s32.north);
\draw[arrow] (s32.south) -- (s3x.north);

%% --- 1-to-1 links ---
\draw[link] (s21.east) -- node[above, font=\scriptsize]{1:1 link} (s31.west);
\draw[link] (s22.east) -- (s32.west);
\draw[link] (s2x.east) -- (s3x.west);

%% --- Ch4 feeds back to Ch2 and Ch3 (routed outside the column stacks) ---
\draw[arrow, rounded corners=10pt]
  (ch4.north west) -- ++(-3.5,0) |- node[pos=0.25, left, font=\scriptsize]{field evidence} (ch2.west);
\draw[arrow, rounded corners=10pt]
  (ch4.north east) -- ++(3.5,0)  |- node[pos=0.25, right, font=\scriptsize]{recipe amendments} (ch3.east);

%% --- Ch1 to Ch2/3 ---
\draw[arrow] (ch1.south) -- (ch2.north);

\end{tikzpicture}
\caption*{\textit{Figure 4.22 — Handbook information architecture. Every section in Chapter 2 (narrative, second-person voice) has a 1:1 cross-link to the corresponding recipe in Chapter 3 (imperative, step-by-step). The Namibia case study in Chapter 4 flows field evidence back into both streams through recipe amendments (§4.6).}}
\end{figure}
```

### 4.5.3 Coverage / Sufficiency / Adaptation applied to the handbook

- **Coverage.** Every methodology section of §3 has a matching recipe in
  the handbook; every recipe has a matching story section (the 1-to-1
  invariant). The one acknowledged gap — `Antennas/` and `Power-and-UPS/`
  stubs — is *visibly* marked rather than silently absent, which is the
  governance behaviour of §3.C.6 working as intended.
- **Sufficiency.** The handbook's information depth was enough to drive the
  Gochas deployment: the operator on the endpoint work-stream followed the
  written recipe on the day (§4.3). Where depth was insufficient, the gap
  surfaced as a field-time amendment that was looped back into the recipe
  (§4.6).
- **Adaptation.** Full adaptation by a *different* team at a *different*
  site remains the open question. The handbook is structurally ready for it
  (open licence, public repository, PR workflow, AI-assisted authoring
  agents, dual web/PDF output) but the empirical signal requires a second
  cohort. This is named as an explicit limit in §4.7 and as a future-work
  direction in §7.

---

### 4.5.4 Lessons consolidated back into the handbook
<!-- \label{sec:lessons-consolidated} -->

The pattern that emerged from the Gochas trip is structural: every field
debugging episode that cost more than a handful of minutes produced either a
new admonition, a new troubleshooting row, or a new section in the handbook.
The §3 → field → handbook loop is the *operational form* of the validation
strategy.

```{=latex}
\begin{figure}[H]
\centering
\begin{tikzpicture}[
  font=\small,
  node distance=1.6cm,
  box/.style={draw, rounded corners=3pt, fill=gray!8, minimum width=3.0cm, minimum height=0.8cm, align=center},
  arrow/.style={->, thick}
]
\node[box] (A) {Field episode\\(cost $>$ minutes)};
\node[box, right=2.2cm of A] (B) {Root cause\\identified on site};
\node[box, right=2.2cm of B] (C) {Handbook\\artefact updated};
\node[box, below=1.4cm of C] (D) {Next operator\\follows recipe};
\node[box, left=2.2cm of D]  (E) {Validation signal:\\adaptation confirmed};

\draw[arrow] (A) -- (B);
\draw[arrow] (B) -- (C) node[midway, above, font=\scriptsize]{PR merged};
\draw[arrow] (C) -- (D);
\draw[arrow] (D) -- (E);
\draw[arrow, rounded corners=10pt]
  (E.west) -- ++(-1.5,0) |- node[pos=0.25, left, font=\scriptsize]{next deployment} (A.south);
\end{tikzpicture}
\caption*{\textit{Figure 4.23 — The field-to-handbook feedback loop. Every debugging episode that cost time on site produced a handbook artefact; that artefact is what the next operator reads. The loop is the operational mechanism of the validation strategy.}}
\end{figure}
```


---

## 4.7 Discussion
<!-- \label{sec:results-discussion} -->

### 4.7.1 Strengths

**Low-cost, reproducible stack.** The Cudy WR3000E mesh and the
Clonezilla/PXE pipeline use consumer or refurbished hardware and
open-source software exclusively. The Gochas deployment cost a fraction of
the equivalent commercial-AP-plus-new-laptop alternative (developed in §5).

**Field-validated procedures.** Every recipe in scope was exercised in the
field; every recipe was amended at least once based on what happened there.

**Explicit knowledge-continuity contribution.** The handbook — with its
rule files, subagents, custom commands, and governance contract — is the
part most likely to outlive any particular deployment.

**Companion-thesis coherence.** The shared layer vocabulary, shared
validation lenses, and clean SW/HW boundary make the two volumes legible
as a single documentation backbone.

### 4.7.2 Limits

**One field site.** Only the Gochas deployment has been documented under
the methodology of §3. A quantitative claim about portability requires a
second site.

**Single institution type.** The receiving institution is a primary school.
Secondary schools, community centres, or NGO offices may surface
constraints not exercised here.

**No long-term operations data.** The deployment is days old at writing.
Remote-support infrastructure (VPN, monitoring) sits in [Motje, 2026]; the
multi-month field-life of the equipment is future evidence.

**Field-layer antenna recipe untested.** The point-to-point antenna recipe
(§3.A.6) was not exercised at Gochas — the school is within mesh range.

**WIP sections in the handbook.** The `Antennas/` and `Power-and-UPS/`
recipe families are visibly marked Work in Progress. They are open
invitations to the next contributor, but they are gaps.

### 4.7.3 Threats to reproducibility

**Hardware obsolescence.** The Cudy WR3000E may leave the OpenWrt support
list; the Lenovo T460/X260 generation will eventually exit the
refurbishment pipeline. The recipe is written to be device-agnostic where
possible but still pins tested hardware.

**Upstream tool changes.** Clonezilla's image format, OpenWrt's package
set, and GRUB's network-boot binaries can evolve in ways that break a
pinned recipe. The `Used Versions` tables partially mitigate this; the
broader mitigation is the active-maintainer rotation of §3.C.6.

**The volunteer-handover assumption.** The handbook only delivers on its
continuity promise if the next maintainer picks it up. The governance
contract is necessary but not sufficient; the thesis cannot validate this
beyond the next cohort transition.

The next chapter (§5) develops the cost and budget side of the deployment
in detail. §6 develops the sustainability case. §7 returns to the
per-objective check and the future-work directions implied by the limits
above.
