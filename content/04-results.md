# 4. Results
<!-- \label{ch:results} -->

This chapter validates the methodology of §3 against the field. It is
deliberately **visual-first**: each section is anchored by figures
drawn from the deployment record, the handbook, and the field artefacts,
with prose limited to the connecting commentary each figure needs.

Section §4.1 introduces the site and the validation strategy. Section §4.2
presents the network deployment outcome through before/after maps and
annotated challenges. Section §4.3 presents the endpoint deployment outcome
through the pipeline diagram and key metrics. Section §4.4 validates the
handbook as a knowledge artefact using screenshots of the published site.
Section §4.5 closes the methodology–results loop with the lessons that
landed as recipe amendments. Section §4.6 discusses limits.

---

## 4.1 Site context and validation strategy
<!-- \label{sec:results-strategy} -->

<
The single deployment site is **N Mutschuana Primary School** in Gochas,
Hardap Region, Namibia — a 300-pupil primary school in a remote Kalahari
Desert town of fewer than 2,000 inhabitants. The map below places Gochas in
its regional context.

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.80\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/4.1-mapa-gochas.png}
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


```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.6\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/4.1-mapa-n-mutschuana.png}
\caption*{\textit{Figure 4.2 — Satellite view of N Mutschuana Primary School. Multiple building blocks surround the sports field; the separation between blocks drove the wireless-mesh topology choice. Source: handbook case study.}}
\end{figure}
```

The school came to the project with three structural deficits (§1.2.1): no
reliable coverage across its building blocks, no usable endpoints for most
teachers, and no documentation of what existed. The team of three AUCOOP
members (Jaume Motje, Sergio Giménez Antón, and María Jover Tarancón) addressed all three over roughly fiveteen working days between March-April 2026
with a CCD grant of 5,600 € and donated hardware.

---

## 4.2 Network deployment — Gochas
<!-- \label{sec:results-network} -->

### 4.2.1 The initial situation

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.92\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/4.1-network-before.png}
\caption*{\textit{Figure 4.3 — Network state on arrival. Two independent government-supplied ADSL routers with no IP plan and overlapping factory defaults. ADSL Router 1 (principal's office area) broadcast a Wi-Fi signal but was not connected to the ISP — its Ethernet cable was wrapped around an unplugged power outlet. ADSL Router 2 (main classroom block) had a working uplink but classroom-scale dead zones. Most teaching spaces had no usable Wi-Fi. Source: handbook case study.}}
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

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.88\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/network-planning-site-mapping.png}
\caption*{\textit{Figure 4.5 — Site survey map methodology: overhead imagery annotated with building locations, obstacles, distances, and power-outlet positions. The Gochas school map was produced by this method. This versioned artefact drove every subsequent placement decision. Source: Network Planning guide, handbook.}}
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

**Sufficiency outcome.** Within roughly 30 minutes of the mesh going live on
Day 6, every teacher in the staff room had the new Wi-Fi password — the
network *spread like wildfire*, the informal sign that real demand existed
and the deployment met it. The mesh backhaul has substantial headroom; the
bottleneck is the ADSL uplink, not the wireless fabric.

### 4.2.4 IP addressing — design and execution

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.88\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/namibia/IP-Addressing-ip-plan-example.png}
\caption*{\textit{Figure 4.7 — IP addressing plan spreadsheet template, as shipped in the handbook. The Gochas deployment used range 192.168.70.0/24, gateway at .1, mesh routers at .2–.7, DHCP pool .100–.200. A Day-8 IP conflict on a newly-added router (Challenge 2) was resolved in five minutes once the spreadsheet was consulted — the canonical example of why the plan is a deliverable, not a side-effect. Source: IP Addressing guide, handbook.}}
\end{figure}
```

### 4.2.5 Challenges encountered and their map

Four challenges arose during the network work-stream; each is annotated
below against the deployment map.

**Challenge 1 — The inoperative router.** ADSL Router 1, in the
principal's office area, was broadcasting Wi-Fi but not connected to the
ISP. Its Ethernet cable was wrapped around an unplugged power outlet. The
school staff had no awareness of this failure. Resolution: the router was
decommissioned; its radio was replaced by Mesh Router 4. *Coverage lens:*
the map accurately described what existed; the recipe's site-assessment
step worked as intended.

**Challenge 2 — IP conflict (Day 8).** A newly added router entered the
mesh with a factory-default address that collided with Mesh Router 3. An
hour of debugging was reduced to five minutes once the IP spreadsheet was
opened and the conflict identified. The lesson — *the IP plan is a
deliverable, not a side-effect* — landed as a `!!! warning` admonition in
the IP Addressing recipe. *Adaptation lens: the spreadsheet was written and
consulted by different team members, proving the artefact portable.*

**Challenge 3 — WPA3-only incompatibility.** One team member's
phone could not associate to the mesh while it was running WPA3-SAE only.
Resolution: reconfigured to WPA2/WPA3 mixed mode; every client connected
immediately. The handbook recipe now recommends mixed mode as the default
for any site with unknown client hardware. *Sufficiency lens: the fix took
minutes; the mesh met the load throughout.*


**Adaptation outcome.** The recipe was executed by three team members who
rotated across sub-tasks. The mesh setup of Iteration 1 was led by one
member while a second followed the written guide and a third captured the
photos that became the recipe images. Every failure mode that cost more than
a few minutes of field time produced a recipe-level admonition, which is
precisely the signal that the procedure was transferable enough to be
*followed*, and detailed enough to surface real gaps.

---

## 4.3 Endpoint deployment — Gochas
<!-- \label{sec:results-endpoint} -->

### 4.3.1 The deployment pipeline

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.95\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/diagrams/fig3-1-pxe-boot-sequence.png}
\caption*{\textit{Figure 4.8 — PXE network boot sequence used during the endpoint deployment at Gochas. The client exchanges DHCP to obtain an IP and the boot-file location, then fetches the GRUB EFI binary and configuration via TFTP, and finally mounts the Clonezilla live environment and disk image from the NFS server. Nine ThinkPads were restored in parallel on an isolated 10.0.0.0/24 switch. Source: figure 3.1, reproduced here for completeness.}}
\end{figure}
```

Twelve machines were processed in total: nine Lenovo ThinkPads (T460 /
X260) from Labdoo and three laptops from NexTReT. All twelve received the
AUCOOP Linux Mint 22.3 Cinnamon image and were handed over in working
condition. No machine was set aside as unprovisionable.

### 4.3.2 The partition-resize problem — the key technical challenge

The single technically significant episode of the endpoint work-stream was
the cross-disk restore failure. Its cause, fix, and visual impact are shown
in Figure 4.9.

```{=latex}
\begin{figure}[H]
\centering
\begin{tikzpicture}[
  font=\small,
  box/.style={draw, rounded corners=3pt, minimum width=3.6cm, minimum height=0.7cm, align=center},
  redbox/.style={box, fill=red!15, draw=red!60},
  greenbox/.style={box, fill=green!12, draw=green!50!black},
  graybox/.style={box, fill=gray!10},
  arrow/.style={->, thick},
  label/.style={font=\footnotesize\itshape, text width=3.8cm, align=center}
]

%% --- Column headers ---
\node[font=\bfseries\small] at (0,0)    {Source disk};
\node[font=\bfseries\small] at (4.2,0)  {Target (238 GB SSD)};
\node[font=\bfseries\small] at (8.4,0)  {Resized image};
\node[font=\bfseries\small] at (12.6,0) {Any target $\geq$22 GB};

%% --- Source disk ---
\node[graybox, minimum height=0.65cm] (src-efi)  at (0,-0.9)  {EFI ~~~512 MB};
\node[graybox, minimum height=3.2cm] (src-root) at (0,-2.85) {\parbox{3.2cm}{\centering ext4 root\\466 GB partition\\$\sim$12 GB used\\{\color{red!70!black}metadata at end}}};

%% --- Target (fail) ---
\node[graybox, minimum height=0.65cm] (tgt-efi)  at (4.2,-0.9)  {EFI ~~~512 MB};
\node[redbox, minimum height=3.2cm] (tgt-root) at (4.2,-2.85) {\parbox{3.2cm}{\centering ext4 root\\238 GB partition\\{\color{red!70!black}\textbf{FAIL}}\\\texttt{target seek ERROR}}};

%% --- Resized image ---
\node[graybox, minimum height=0.65cm] (res-efi)  at (8.4,-0.9)  {EFI ~~~512 MB};
\node[greenbox, minimum height=1.5cm] (res-root) at (8.4,-2.05) {\parbox{3.2cm}{\centering ext4 root\\20 GB partition\\$\sim$12 GB used}};
\node[graybox, minimum height=1.6cm] (res-free) at (8.4,-3.55) {\parbox{3.2cm}{\centering(recaptured\\$\sim$3.6 GB compressed)}};

%% --- Any target (ok) ---
\node[graybox, minimum height=0.65cm] (ok-efi)  at (12.6,-0.9)  {EFI ~~~512 MB};
\node[greenbox, minimum height=1.5cm] (ok-root) at (12.6,-2.05) {\parbox{3.2cm}{\centering ext4 root\\restored at 20 GB\\expanded by \texttt{-k1}}};
\node[graybox, minimum height=1.6cm] (ok-free) at (12.6,-3.55) {\parbox{3.2cm}{\centering free space\\filled to disk end}};

%% --- Arrows ---
\draw[arrow, red!60] (src-root.east) -- node[above, font=\scriptsize, text=red!70!black]{direct restore} (tgt-root.west);
\draw[arrow, green!50!black] (res-root.east) -- node[above, font=\scriptsize]{restore + \texttt{-k1}} (ok-root.west);

%% --- Phase 3 brace label ---
\draw[decorate, decoration={brace, amplitude=6pt}, thick, gray]
  ([xshift=1.95cm]src-root.east) -- ([xshift=1.95cm]src-efi.east)
  node[midway, right=8pt, font=\scriptsize\itshape, text width=2.2cm, align=center]{Phase 3\\resize\\(off-line)};

\end{tikzpicture}
\caption*{\textit{Figure 4.9 — Partition-resize problem and fix. A Clonezilla image captured from a 466 GB HDD fails when restored to a 238 GB SSD because ext4 scatters metadata across the entire 466 GB partition boundary. Phase 3 of the recipe shrinks the filesystem to 20 GB and recaptures the image; the resulting artefact restores cleanly to any disk ≥ 22 GB and is expanded by Clonezilla's \texttt{-k1} flag to fill the target.}}
\end{figure}
```

The resize is performed once, off-line, before the imaging session. The
recipe gates it behind a clearly-marked "skip if all disks are the same
size" admonition so operators do not incur the work when it is
unnecessary. After the resize, parallel PXE restore of nine machines on a
gigabit switch takes approximately one hour end-to-end — against the
estimated seven hours a sequential manual install would require.

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

## 4.4 Handbook validation — the knowledge artefact
<!-- \label{sec:results-handbook} -->

The handbook is the most original deliverable of this thesis (§3.C). Its
validation is reported on its own terms: *was it produced, is it public, does
it cover what it claims to cover, and did the deployment use it?*

### 4.4.1 The published artefact

```{=latex}
\begin{figure}[H]
\centering
\includegraphics[width=0.96\textwidth]{/home/mj/Documents/Master-Thesis/assets/images/diagrams/community_network_webpage.png}
\caption*{\textit{Figure 4.10 — Landing page of the Community Network Handbook, published at \url{https://aucoop.github.io/Community-Network-Handbook/}. The site is built from the same Markdown source as the downloadable PDF expedition copy; both outputs are regenerated on every merge to \texttt{main} by the Zensical pipeline.}}
\end{figure}
```

By the time of submission the handbook content in scope for this thesis
sits on branch `dev_mj_thesis` at commit `a5fc80b`. Four feature branches
were merged in sequence: `docs/laptop-deployment`, `WIP-docs/ip`,
`docs/planning`, and `fix/open-points`. Together they deliver:

- The full `3-Guide/Network-Planning/` recipe family.
- The `3-Guide/IP-Addressing/` recipe.
- The two-iteration `3-Guide/Wireless-Mesh/` recipe family.
- The `3-Guide/Laptop-Deployment/` recipe with four phases and the
  `AUCOOP-image.md` subchapter.
- The unified `4-Real-Use-Cases/4.1-Namibia/index.md` case study.
- Stub/WIP `3-Guide/Antennas/` and `3-Guide/Power-and-UPS/` sections,
  visibly marked as Work in Progress per the governance rule of §3.C.6.

### 4.4.2 The handbook structure — a visual overview

The diagram below shows the information architecture of the handbook and the
1-to-1 mapping between the narrative (Ch 2) and recipe (Ch 3) streams that
is the defining structural rule of §3.C.2.

```{=latex}
\begin{figure}[H]
\centering
\begin{tikzpicture}[
  font=\small,
  chap/.style={draw, rounded corners=4pt, fill=gray!8, minimum width=3.5cm, minimum height=0.8cm, align=center},
  section/.style={draw, rounded corners=2pt, fill=white, minimum width=3.5cm, minimum height=0.65cm, align=center, font=\footnotesize},
  arrow/.style={->, thick, gray!60},
  link/.style={<->, dashed, thick, blue!50}
]

%% --- Chapter boxes ---
\node[chap] (ch1) at (0, 0)     {\textbf{Ch 1} Introduction};
\node[chap] (ch2) at (0,-1.4)   {\textbf{Ch 2} Imaginary Use Case};
\node[chap] (ch3) at (6,-1.4)   {\textbf{Ch 3} Guide (recipes)};
\node[chap] (ch4) at (3,-4.5)   {\textbf{Ch 4} Real Use Cases};

%% --- Ch2 sections ---
\node[section] (s21) at (0,-2.4)  {2.1 The first router};
\node[section] (s22) at (0,-3.2)  {2.2 Expanding coverage};
\node[section] (s2x) at (0,-4.0)  {2.22 Equipping the community};

%% --- Ch3 sections ---
\node[section] (s31) at (6,-2.4)  {3-Guide/Network-Planning};
\node[section] (s32) at (6,-3.2)  {3-Guide/Wireless-Mesh};
\node[section] (s3x) at (6,-4.0)  {3-Guide/Laptop-Deployment};

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

%% --- Ch4 feeds back ---
\draw[arrow, bend right=20] (ch4.west) to node[left, font=\scriptsize]{field evidence} (ch2.south west);
\draw[arrow, bend left=20]  (ch4.east) to node[right, font=\scriptsize]{recipe amendments} (ch3.south east);

%% --- Ch1 to Ch2/3 ---
\draw[arrow] (ch1.south) -- (ch2.north);

\end{tikzpicture}
\caption*{\textit{Figure 4.11 — Handbook information architecture. Every section in Chapter 2 (narrative, second-person voice) has a 1:1 cross-link to the corresponding recipe in Chapter 3 (imperative, step-by-step). The Namibia case study in Chapter 4 flows field evidence back into both streams through recipe amendments (§4.5).}}
\end{figure}
```

### 4.4.3 Coverage / Sufficiency / Adaptation applied to the handbook

- **Coverage.** Every methodology section of §3 has a matching recipe in
  the handbook; every recipe has a matching story section (the 1-to-1
  invariant). The one acknowledged gap — `Antennas/` and `Power-and-UPS/`
  stubs — is *visibly* marked rather than silently absent, which is the
  governance behaviour of §3.C.6 working as intended.
- **Sufficiency.** The handbook's information depth was enough to drive the
  Gochas deployment: the operator on the endpoint work-stream followed the
  written recipe on the day (§4.3). Where depth was insufficient, the gap
  surfaced as a field-time amendment that was looped back into the recipe
  (§4.5).
- **Adaptation.** Full adaptation by a *different* team at a *different*
  site remains the open question. The handbook is structurally ready for it
  (open licence, public repository, PR workflow, AI-assisted authoring
  agents, dual web/PDF output) but the empirical signal requires a second
  cohort. This is named as an explicit limit in §4.6 and as a future-work
  direction in §7.

---

## 4.5 Lessons consolidated back into the handbook
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
\draw[arrow, bend right=30] (E.south) to node[below, font=\scriptsize]{next deployment} (A.south);
\end{tikzpicture}
\caption*{\textit{Figure 4.12 — The field-to-handbook feedback loop. Every debugging episode that cost time on site produced a handbook artefact; that artefact is what the next operator reads. The loop is the operational mechanism of the validation strategy.}}
\end{figure}
```

The ten lessons produced by this loop are listed below. Each entry names the
source episode and the resulting handbook artefact.

**IP plan as deliverable.** Source: Day-8 IP conflict (Challenge 2).
Result: `IP-Addressing/index.md` opens with a "why a non-default range
matters" admonition; every router recipe asks the reader to update the
spreadsheet at the moment of provisioning.

**Two-iteration mesh design.** Source: observation that operators who
attempted the DHCP-based design first lost time on link-formation failures
unrelated to DHCP. Result: `Wireless-Mesh/` is split into
`1-Static-IP-Mesh` and `2-DHCP-Mesh`, with an overview that prescribes the
order.

**Pin OpenWrt and `wpad-mesh` versions.** Source: two days of early
bring-up lost to a snapshot regression on the Cudy WR3000E 5 GHz driver.
Result: `Wireless-Mesh/1-Static-IP-Mesh/index.md` carries a *Used Versions*
table and a "newer is not necessarily better" note.

**WPA2/WPA3 mixed mode by default.** Source: Day-6 WPA3-only
incompatibility on a single laptop (Challenge 3). Result: the recipe
recommends mixed mode whenever the client device population is unknown.

**Power for graceful shutdown, not ride-through.** Source: recurring
multi-hour power cuts (Challenge 4). Result: the intent of the
`Power-and-UPS/` recipe stub is reframed; NUT integration is handed to
[Motje, 2026].

**Secure Boot as inventory-time check.** Source: hours lost on Day 4 to
silent UEFI rejection of the unsigned `bootx64.efi`. Result: Step 14
(Disable Secure Boot) in the PXE recipe and a `!!! warning` admonition
promoted to the inventory step of §3.B.2.

**Phase 3 — partition resize — deserves its own phase.** Source: the
`target seek ERROR` on the first cross-disk restore. Result: the recipe
is reorganised into four phases; operators with uniform disks skip Phase 3
entirely. (See Figure 4.9.)

**`tftpd-hpa --secure` does not follow symlinks.** Source: silent TFTP
failure when symlinking Clonezilla files into the TFTP root. Result:
`!!! warning` under Step 11 of the PXE recipe.

**Auto-detect the target disk.** Source: failure on the first NVMe
ThinkPad with hard-coded `/dev/sda`. Result: `auto-restore.sh` with
`nvme0n1`/`sda`/`vda` probing.

**`-k1 -icds -scr` flag combination with a resized image.** Source: hours
chasing `ocs-sr` flag combinations before the ext4 metadata layout was
identified as root cause. Result: the recipe states the flags and their
rationale explicitly under the `ocs-sr` flag table.

---

## 4.6 Discussion
<!-- \label{sec:results-discussion} -->

### 4.6.1 Strengths

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

### 4.6.2 Limits

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

### 4.6.3 Threats to reproducibility

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
