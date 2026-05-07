# 7. Conclusions and Future Work
<!-- \label{ch:conclusions} -->

This chapter draws conclusions from the work described in the
preceding chapters. The structure follows the framework adopted in
the companion thesis [Motje, 2026]: §7.1 checks the work against
each of the five objectives stated in §1.1; §7.2 draws broader
conclusions that do not map onto a single objective; §7.3 records
the limitations honestly and in the same place as the conclusions
they qualify; §7.4 lists future-work directions; §7.5 documents a
hand-over protocol for the next AUCOOP cohort.

---

## 7.1 Conclusions against the stated objectives

The five objectives of §1.1 were formulated jointly with the
companion thesis. Each is checked here against the evidence assembled
in Chapters 3 to 6.

**Objective 1 — To create a living document** that any contributor
with basic technical literacy can update, so that the knowledge it
contains can grow with the projects that produce it. *Met.* The
AUCOOP Community-Network-Handbook (§3.C, Appendix A) is a public
Git repository whose Markdown sources build to both a public website
and a downloadable PDF, and whose contribution rules
(`.opencode/rules/`, `AGENTS.md`) are explicit enough that a
volunteer who has never seen the project can open a pull request the
same day. The validation lens here is whether the artefact
*continued to grow during the deployment*, and §4.4 records the
quantitative answer: commits and pull requests merged during the
field phase, with the Namibia case study itself authored against the
handbook's own contribution conventions.

**Objective 2 — To develop a high-level guide** usable by people
with basic technical knowledge — not a reference manual aimed at
networking specialists. *Met, with reservations recorded for the
recipes that remain stubs.* The Diátaxis-inspired Ch2 (imaginary
use case) / Ch3 (recipe guide) split (§3.C.4) is the structural
expression of this objective: Ch2 reads as a story for the
non-specialist, Ch3 reads as a how-to for the volunteer doing the
work. The reservations are concrete and named in §3.A.11 and §3.B.9:
the *Antennas* and *Power-and-UPS* recipes remain stubs, and the
laptop chapter would benefit from a richer photographic walkthrough
of the BIOS-configuration step. None of these reservations
invalidate the structural claim; they identify the next contribution
window.

**Objective 3 — To ensure that the guide is useful** for
organisations such as AUCOOP whose volunteers rotate frequently and
whose deployments are geographically distributed. *Met for AUCOOP;
externally untested.* The handbook is now the AUCOOP standard
reference for new cohorts (the hand-over protocol of §7.5
operationalises this), and the deployment validated in §4 was
executed by a team that used the handbook as its primary reference
during the field phase. External validation — adoption by a sister
organisation, a fork by a different community-network group — is the
honest gap and is listed in §7.4.

**Objective 4 — To validate the guide** by applying it in a real
deployment, specifically the Namaqua Kalahari Children Hope project
in Namibia. *Met.* Chapter 4 reports the validation in detail using
three lenses (coverage, sufficiency, adaptation). The headline is
that the handbook covered the deployment, was sufficient for the
operational decisions taken in the field, and absorbed the
adaptations required without structural rewrites. The validation is
intentionally qualitative (§4.6.1) because the recipe is intended to
support volunteer decision-making rather than to deliver a
quantitative performance contract; a quantitative complement is
listed in §7.4.

**Objective 5 — To centralise**, in a single openly maintained
artefact, the knowledge built up over previous AUCOOP projects, so
that future cohorts inherit it rather than reconstruct it. *Met for
the chapters this thesis covers; partially met for the association
as a whole.* The hardware chapters of the handbook now consolidate
operational knowledge from the Namibia 2026 deployment, the prior
Senegal-Hahatay engagement on the network-planning side, and several
AUCOOP-internal lab exercises that previously lived only in personal
notebooks. Knowledge from older AUCOOP projects (pre-Hahatay)
remains uncentralised and is the natural next backlog. The
centralisation claim is therefore directional rather than complete:
the handbook is the artefact toward which AUCOOP knowledge is now
moving, not the artefact in which all of it has already arrived.

---

## 7.2 Broader conclusions

Beyond the per-objective check, three broader conclusions deserve to
be stated in their own right because they cut across the technical,
documentary and organisational dimensions of the work.

**Knowledge continuity is an engineering problem, not just an
organisational one.** The thesis's structural choice — to deliver
a *recipe in a living artefact* rather than a *one-off deployment
report* — is the operational expression of this conclusion. The
literature on volunteer-driven organisations diagnoses the
continuity problem (§2.3); the contribution of this work is to
treat it with the same tooling discipline as any other engineering
problem: version control, contribution rules, automated build, CI,
explicit governance. The Namibia deployment is the validation
instance, but the durable contribution is the workflow that
produced it.

**Sufficiency is a recipe property, not a hardware property.** The
choices that made the deployment work — Cudy WR3000E rather than
higher-end APs, Lenovo ThinkPads from the 2016 generation, the
AUCOOP Linux Mint image rather than a vendor stack — were all
sufficiency choices: pick the smallest thing that does the job,
document why, leave room for the next site to size differently. The
*Antennas* and *Network-Planning* recipes encode this bias
explicitly (§3.A.5, §3.A.7), and the budget chapter quantifies what
it is worth (§5.9: ~3.5× cash multiple over the commercial
alternative). Sufficiency is the property that makes the recipe
travel; over-specification is the property that prevents it from
being adopted. It is also a sustainability property along all three
dimensions (§6.5): every component not deployed is manufacturing
carbon not incurred, cash not raised, and operational burden not
placed on the partner organisation.

**Sustainability is the integrating frame, not an add-on chapter.**
The three contributions of the thesis are sustainability choices
before they are technical ones: refurbishment defers
manufacturing-phase emissions (§6.2), the open handbook engineers
knowledge continuity into a volunteer association (§6.3), and the
donation-leveraged budget makes the recipe replicable on a small
NGO grant (§6.4). The three-dimension reading proposed by
[Roura et al., 2026] for refurbished-ICT digital-inclusion
programmes maps cleanly onto the AUCOOP case and gives the work an
analytical vocabulary that an environment-only chapter could not
have provided.

**The hardware/software split with the companion thesis is itself
methodological evidence.** Two students working on overlapping
infrastructure typically produce either redundant deliverables or a
joint document with unclear authorship. The split adopted here —
shared introduction, state of the art, methodology framing,
deployment site, and bibliography backbone; divergent technical
contributions tied to a clean scope boundary — is, in retrospect,
the model that a third coordinated thesis (services + applications +
fieldwork) could replicate without renegotiating the boundary. The
boundary itself is documented in §1.4 of both theses and in the
shared bibliography markers of §8.

---

## 7.3 Limitations

The limitations recorded here are the same ones flagged at the
points in the preceding chapters where they originated; they are
collected in this chapter so that an evaluator does not have to
search for them.

**Single field site.** The recipe is validated in exactly one
deployment, at one school, in one country, in one season. Coverage,
sufficiency and adaptation are all read against that single run.
A second deployment under different constraints — a different
climate, a different building geometry, a different funding profile,
a different volunteer team — is the obvious generalisation test and
is listed in §7.4. Until that test is run, the validation should be
read as *existence-of-recipe-that-works-once*, not as
*generalisation-across-contexts*.

**Qualitative validation rather than quantitative.** Chapter 4
deliberately presents the validation through the qualitative lenses
of coverage, sufficiency and adaptation (§4.6.1). Quantitative
characterisation of the deployed network — per-link iperf, per-AP
association counts, latency under load, longitudinal uptime — was
partially measured in the field but is not consolidated in this
document at submission time. The quantitative complement is listed in §7.4.

**Engineering effort excluded from the cash budget.** The €5.8 k
cash figure of §5.7 is the figure an organisation actually has to
raise to reproduce the recipe; the €48 k full-project figure is
what the same recipe would cost at indicative engineering rates.
The recipe's apparent cost-effectiveness depends on the availability
of volunteer engineering effort; sites without an equivalent
volunteer pool would face the larger figure. The budget chapter
makes the trade-off explicit but does not solve it.

**Refurbishment supply is dependency on a partner network.** The
endpoint pipeline of §3.B presupposes a working donation pipeline
(Labdoo, NexTReT, the Foundawtion container). Sites without access
to that pipeline would face either a higher cost (commercial
refurbishment market) or a longer collection lead time. The recipe
documents what to do with the donations; it does not document how
to bootstrap the donation pipeline itself. That work is upstream
of this thesis and is owned by AUCOOP at the organisational level.

**Sustainability analysis is below the device-level scenario LCA
standard.** Chapter 6 uses per-unit figures from public sources,
applies them to the deployment, and reports the result as an
order-of-magnitude check across environmental, social and economic
dimensions. A proper study along the device-level scenario LCA
lines set by [Roura et al., 2026] would net transport,
refurbishment-process energy, end-of-life processing, and would
allocate manufacturing emissions across successive users via a
Power-On-Hours-based rule; it would also measure supervised ICT
access hours and technician labour hours rather than estimate them.
The omission is documented in §6.7.

**External adoption of the handbook is not yet measured.** The
handbook validation of §4.4 is internal to AUCOOP. Adoption by a
sister organisation — a fork, a citation, a derivative recipe —
would be the strongest single signal that the centralisation
objective (Objective 5) generalises, and is the validation that the
present thesis cannot deliver because the handbook is too new.

---

## 7.4 Future work
<!-- \label{sec:future-work} -->

The future-work items below are grouped by horizon. Each item names
the limitation or open thread it addresses.

### Short-term (the 2026/27 AUCOOP cohort)

**A second field deployment under different constraints.** Addresses
the single-site limitation. The natural candidate is a sister
project in Senegal or in Catalonia, both for proximity (lower
travel cost, faster iteration) and because either context will
exercise the recipe along axes the Namibia deployment did not
(climate, electrical infrastructure, partner-organisation maturity).

**Completion of the stub recipes.** *Antennas* and *Power-and-UPS*
remain stubs (§3.A.11, §3.B.9). Both have field experience that
has not yet been written up; the next cohort can convert that
experience into recipes without starting from a blank page.

**Photographic walkthrough of the BIOS-configuration step.** The
single biggest comprehension gap in the *Laptop-Deployment* recipe
is the Lenovo Setup-Utility navigation; a short photographic
sequence would close it (§3.B.9).

### Medium-term

**Quantitative network characterisation.** Captures the partial
field measurements into a longitudinal monitoring
deployment. Combine with a Zabbix/Grafana stack from the companion
thesis [Motje, 2026] to publish per-deployment uptime, throughput
and association-count dashboards that feed back into the recipe.

**Captive-portal and user-management recipe.** Currently a
placeholder in the handbook navigation; the services-layer companion
thesis covers the core, but the hardware-side companion to it — the
captive-portal hardware enclosure, the user-onboarding device flow —
is unwritten and is the natural next chapter on the hardware side.

**Translation of the handbook.** English is the working language
of the current chapters; French, Spanish and Portuguese versions
would much expand the partner organisations that can use
the handbook directly. The build pipeline already supports
multi-language MkDocs and the work is incremental.

**OpenWISP for fleet-wide configuration management.** The current
recipe configures each AP individually via Luci or `uci`; at fleet
scale the operational cost of that approach grows. Integrating
OpenWISP would convert the per-site network into a centrally-managed
fleet, reducing the operational burden on the partner organisation.

### Long-term

**A proper sustainability assessment of the recipe.** Addresses
the LCA-grade limitation of §6.7. The natural shape is a
device-level scenario LCA along [Roura et al., 2026] lines —
APOS allocation, Power-On-Hours-based attribution across successive
users, per-hour-of-service functional unit — extended with the
social (measured ICT access hours) and economic (technician /
volunteer hours, donor-pipeline cash multiplier) indicators that
the same study proposes. The NMPS deployment is precisely the
low-income, community-scale empirical case that paper identifies
as under-represented in the existing data, and would benefit from
being written up as a contribution to that literature. Likely a
separate thesis or a collaboration with the eReuse project rather
than a chapter extension.

**Federation with adjacent community-network movements.** Guifi.net,
AlterMundi, Freifunk and Rhizomatica all maintain documentation
estates that overlap with the AUCOOP handbook in scope. A federated
documentation layer — shared glossary, cross-citation, common
contribution conventions — would amplify the per-recipe value of
each estate. This is an organisational rather than a technical
direction, and is the slowest-burning item on the list.

**Longitudinal measurement of recipe reuse.** Addresses the
external-adoption gap. Requires instrumenting the handbook
repository for downstream forks, citations, and derivative recipes,
and establishing a feedback channel from those downstream uses back
into the upstream handbook.

---

## 7.5 Hand-over protocol for the next cohort

The objectives of this thesis only meet their full intent if the
next María / Jaume / Sergio can pick up the work without the present
authors in the room. The protocol below is short by design and is
also committed to the handbook itself at `docs/contributing.md` so
that a contributor who finds the handbook before finding this thesis
encounters the same instructions.

1. **Read** Chapter 1 (objectives, methodology), §3.C (handbook
   architecture), and §4 (validation lessons) of the present thesis,
   and the equivalent chapters of [Motje, 2026].
2. **Read** `AGENTS.md` and `.opencode/rules/` in the handbook
   repository. These files document the tone, structure, and
   contribution conventions; they are short.
3. **Open** the `develop` branch backlog of issues tagged
   `good-first-cohort`. Each is sized for a single contributor and
   has an acceptance checklist.
4. **Pick** one open chapter from the handbook navigation that
   carries an `!!! info "Work in Progress"` admonition. Start with
   the *Antennas* or *Power-and-UPS* recipe if no specific interest
   pulls elsewhere; both have field experience waiting to be
   captured.
5. **Follow** the pull-request template. Tag a current maintainer
   for review. Expect one or two iteration rounds; the AI-assisted
   tooling described in §3.C.7 is available to help with first
   drafts.
6. **Commit** any new operational lesson back into the handbook in
   the same week it is learned, not at the end of the project. The
   single largest cause of knowledge loss in the AUCOOP history
   surveyed in §1.2 was waiting until "later" to write things down.
   Do not wait until later.

The protocol is the smallest thing the thesis can leave behind that
turns the handbook from a deliverable into an institution. If a
future cohort follows it once, the present authors will consider
the thesis to have done its job.
