Project proposal
================
Tina Huynh

- [1 Executive Summary](#1-executive-summary)
  - [1.1 Scope](#11-scope)
  - [1.2 Objective](#12-objective)
- [2 Background and Problem
  Statement](#2-background-and-problem-statement)
  - [2.1 The Problem](#21-the-problem)
  - [2.2 The History of the *Panthera tigris*
    Population](#22-the-history-of-the-panthera-tigris-population)
  - [2.3 Existing Research](#23-existing-research)
- [3 Research Questions](#3-research-questions)
  - [3.1 Core Research Questions](#31-core-research-questions)
  - [3.2 Sub-Questions](#32-sub-questions)
- [4 Data](#4-data)
  - [4.1 Data Sources](#41-data-sources)
  - [4.2 Variables & Data Schema](#42-variables--data-schema)
    - [4.2.1 TRAFFIC — Seizures (pressure
      signal)](#421-traffic--seizures-pressure-signal)
    - [4.2.2 CITES Trade Database — Reported trade
      (context)](#422-cites-trade-database--reported-trade-context)
    - [4.2.3 UNODC / WJC — **Wholesale price
      indices/ranges**](#423-unodc--wjc--wholesale-price-indicesranges)
    - [4.2.4 IUCN / National sources — Population
      context](#424-iucn--national-sources--population-context)
    - [4.2.5 Species360 / ZIMS / Studbooks — Ex-situ
      (snapshot)](#425-species360--zims--studbooks--ex-situ-snapshot)
    - [4.2.6 WDI & WGI — Socioeconomics &
      governance](#426-wdi--wgi--socioeconomics--governance)
    - [4.2.7 WDPA / GFW](#427-wdpa--gfw)
    - [4.2.8 Public-health proxies](#428-public-health-proxies)
    - [4.2.9 Tourism anchors
      (site-level)](#429-tourism-anchors-site-level)
    - [4.2.10 Keys & Joins](#4210-keys--joins)
- [5 Methodology](#5-methodology)
  - [5.1 Data Analysis Plan](#51-data-analysis-plan)
    - [5.1.1 Data Quality & Bias
      Controls](#511-data-quality--bias-controls)
    - [5.1.2 Prices → Pressure
      (associations)](#512-prices--pressure-associations)
    - [5.1.3 Populations & Extinctions](#513-populations--extinctions)
    - [5.1.4 Socioeconomic Drivers & Dependency
      Cycle](#514-socioeconomic-drivers--dependency-cycle)
    - [5.1.5 Live-Trade & Public-Health
      Risk](#515-live-trade--public-health-risk)
    - [5.1.6 Ecotourism Revenue & Jobs](#516-ecotourism-revenue--jobs)
  - [5.2 Statistical Tests](#52-statistical-tests)
    - [5.2.1 Algorithms](#521-algorithms)
  - [5.3 Software](#53-software)
- [6 Ethics, Risks, Communication & Privacy Concerns
  Addressed](#6-ethics-risks-communication--privacy-concerns-addressed)
- [7 Deliverables](#7-deliverables)
  - [7.1 Visualizations](#71-visualizations)
    - [7.1.1 F1 — Tiger-part seizures over time
      (total)](#711-f1--tiger-part-seizures-over-time-total)
    - [7.1.2 F2 — Seizures by commodity (skins, bones,
      teeth/claws)](#712-f2--seizures-by-commodity-skins-bones-teethclaws)
    - [7.1.3 F3 — Seizure hot-spots map](#713-f3--seizure-hot-spots-map)
    - [7.1.4 F4 — Lagged wholesale index vs. seizures (“price” →
      pressure
      association)](#714-f4--lagged-wholesale-index-vs-seizures-price--pressure-association)
    - [7.1.5 F5 — Wild vs. ex-situ populations
      (context)](#715-f5--wild-vs-ex-situ-populations-context)
    - [7.1.6 F6 — Extinction / extirpation timeline (historic +
      recent)](#716-f6--extinction--extirpation-timeline-historic--recent)
    - [7.1.7 F7 — Pressure vs. loss
      overlay](#717-f7--pressure-vs-loss-overlay)
    - [7.1.8 F8 — Country case cards (e.g., Cambodia,
      Laos)](#718-f8--country-case-cards-eg-cambodia-laos)
    - [7.1.9 F9 — Poverty vs. recorded
      pressure](#719-f9--poverty-vs-recorded-pressure)
    - [7.1.10 F10 — Governance vs. recorded
      pressure](#7110-f10--governance-vs-recorded-pressure)
    - [7.1.11 F11 — Live-trade risk indicator (spillover
      proxy)](#7111-f11--live-trade-risk-indicator-spillover-proxy)
    - [7.1.12 F12 — Socioeconomic
      quartet](#7112-f12--socioeconomic-quartet)
    - [7.1.13 F13 — Tiger tourism value (site
      anchor)](#7113-f13--tiger-tourism-value-site-anchor)
    - [7.1.14 F14 — “What if sightings fall?” scenario (revenue & local
      earnings
      losses)](#7114-f14--what-if-sightings-fall-scenario-revenue--local-earnings-losses)
    - [7.1.15 F15 — Wildlife-tourism jobs context
      (macro)](#7115-f15--wildlife-tourism-jobs-context-macro)
    - [7.1.16 F16 — Reputation & governance
      (callout)](#7116-f16--reputation--governance-callout)
  - [7.2 Models](#72-models)
  - [7.3 Reports](#73-reports)
- [8 Significance & Expected
  Outcomes](#8-significance--expected-outcomes)
- [9 Conclusion](#9-conclusion)
- [10 Appendices](#10-appendices)
  - [10.1 A. Package/session info](#101-a-packagesession-info)
  - [10.2 B. Hot-spot map scaffold](#102-b-hot-spot-map-scaffold)
  - [10.3 C. Lagged wholesale index vs. seizures
    (regional)](#103-c-lagged-wholesale-index-vs-seizures-regional)

# 1 Executive Summary

This project examines the illegal trade in tiger parts and its
consequences for biodiversity, human communities, and public health. We
will quantify seizure trends and trade signals, place them in the
context of wild versus ex-situ (zoo/facility) populations, and integrate
socioeconomic and governance indicators that shape poaching incentives
and enforcement capacity. We will also address the historic loss of
tiger subspecies/populations and the risks of zoonotic spillover
associated with unregulated live-animal trade.

Results will be presented as a reproducible data analysis (R/Quarto), a
compact dataset, and a short report linking empirical findings to
policy-relevant implications: conservation effectiveness, community
livelihoods, and public-health prevention.

## 1.1 Scope

- **Focal taxon**: Panthera tigris (tigers).

- **Spatial unit**: country (aggregate to sub-regions where needed).

- **Temporal scope**: 2010–2024 (or longest consistent overlap across
  sources).

## 1.2 Objective

- **Trade/Enforcement**: Quantify and visualize tiger-part seizure
  trends over time and geography; compare item types (skins, bones,
  teeth/claws).

- **Prices (carefully handled)**: Use vetted wholesale price
  ranges/indices to explore whether market signals correlate with
  recorded pressure (seizures).

- **Populations**: Contextualize trends with wild population estimates
  and, where access permits, ex-situ counts (snapshot).

- **Extinctions**: Document historic subspecies/population extinctions
  and recent country-level functional extirpations, acknowledging
  multiple interacting drivers.

- **Socioeconomics & Governance**: Test associations between poverty,
  governance, and recorded poaching pressure; articulate the dependency
  cycle of illegal income.

- **Public Health**: Highlight how unregulated live-animal trade
  elevates spillover risk and burdens human health systems.

# 2 Background and Problem Statement

## 2.1 The Problem

Illegal trade in tiger parts (bones, skins, teeth/claws) and live
animals continues to exert pressure on already small, fragmented wild
populations. Poaching is reinforced by poverty, weak governance, and
organized-crime supply chains; in some landscapes, snaring for
commercial bushmeat and parts has become pervasive. Beyond biodiversity
loss, this crime undermines the rule of law, corrodes public
institutions, and erodes nature-based tourism revenues and jobs that
would otherwise finance conservation and local livelihoods.

Segments of the trade move live wildlife through multi-species, crowded,
and unsanitary holding/transport. These conditions heighten the risk of
zoonotic spillover by increasing close contact and pathogen shedding,
and they bypass veterinary and quarantine controls—creating costs for
public health as well as conservation. The risk is well documented
across intergovernmental guidance and reviews and is relevant to any
policy discussion on wildlife crime.

The economic stakes are material. Tiger-viewing tourism can generate
substantial site-level revenue and local employment; poaching-driven
declines in sightings or access jeopardize those flows and can push
households back toward illegal harvest, reinforcing a negative
income–poaching loop. Countries that do not control poaching also incur
reputational harms that affect destination branding, investor
confidence, and international cooperation.

## 2.2 The History of the *Panthera tigris* Population

**From continental giant to fragmented remnant.**  
Historically, tigers ranged from the forests and river systems of
Anatolia/Central Asia through the Indian subcontinent and Southeast Asia
to the Russian Far East and the Sunda Islands. By the early 1900s they
occupied a mosaic of habitats—tropical moist forests, dry deciduous
forests, mangroves, temperate/boreal forests, and grass–shrub
systems—supported by abundant wild ungulates.

**1900–1970: Rapid contraction and three extinctions.**  
- **Persecution & sport hunting:** Colonial/royal hunting, bounty
programs, and better firearms drove sustained offtake of tigers and
their prey.  
- **Land conversion:** Large-scale clearing for agriculture, timber,
plantations, and transport infrastructure fragmented habitat and severed
corridors.  
- **Outcome:** Island subspecies **Bali** and **Javan** tigers, and the
**Caspian** tiger on the mainland, disappeared during the mid-to-late
20th century as small, isolated populations collapsed under combined
hunting pressure, prey loss, and habitat conversion.

**1970s–1990s: International controls and uneven responses.**  
- **Policy era:** The 1970s–80s brought protected-area expansion and
international trade controls; India launched **Project Tiger (1973)**,
which created a dedicated reserve network and specialized protection.  
- **Shifting demand:** Illegal trade in **skins** and **bones** (for
luxury and traditional medicine uses) escalated; some countries
strengthened enforcement while others struggled with weak institutions
and porous borders.  
- **Regional contrasts:** The **Amur (Siberian)** tiger hovered near the
brink but began recovering under stricter protection; parts of mainland
Southeast Asia saw steep declines as snaring proliferated.

**2000s: The “snaring crisis” and national extirpations.**  
- **Low-cost mass killing:** Industrial-scale deployment of cheap wire
snares by commercial and subsistence actors removed both tigers and
their prey.  
- **National losses:** Tigers vanished from **Cambodia** (declared
functionally extinct later, with reintroduction now planned) and from
key landscapes in **Laos** and **Viet Nam**. **Malaysia** began a sharp
decline despite substantial forest cover, while **Indonesia’s**
**Sumatran** tiger persisted under high pressure.  
- **Bright spots:** **India** and **Nepal** expanded camera-trap
monitoring, boosted protection, and saw gradual increases; **Bhutan**
remained relatively stable; the **Russian Far East** consolidated gains.

**2010s–2020s: TX2 ambitions, taxonomy update, cautious optimism.**  
- **TX2 commitment (2010):** Range states endorsed the goal to **double
wild tiger numbers by 2022**, catalyzing funding, monitoring, and
anti-poaching partnerships.  
- **Taxonomy (2017):** Formal revision consolidated tigers into two
subspecies—**continental** (*P. t. tigris*) and **Sunda** (*P. t.
sondaica*)—while retaining the conservation significance of historically
recognized forms (e.g., Bali, Javan, Caspian).  
- **Status (recent):** The latest global assessment reports
**~3.7k–5.6k** wild tigers. Gains in **India, Nepal, Bhutan, Russia**
and re-occupancy into parts of **northeast China** contrast with ongoing
declines or very low numbers in portions of mainland Southeast Asia. The
**South China** tiger remains **likely extinct in the wild**.

**Structure today: small, isolated, corridor-dependent populations.**  
Most surviving subpopulations are small and geographically isolated,
connected—if at all—by narrow, human-dominated corridors. Priority
landscapes (e.g., **Terai Arc**, **Western Ghats–Central India**,
**Sundarbans**, **Russian Far East–NE China**) function as
meta-populations where connectivity, prey recovery, and conflict
mitigation determine long-term viability. Fragmentation raises risks of
**genetic erosion**, **demographic stochasticity**, and site-level
extirpation.

**Threat matrix (persistent and interacting):**  
- **Illegal killing & trade:** Targeted poaching for **skins and
bones**, opportunistic killing via **snares**, and retaliatory conflict
killings.  
- **Prey depletion:** Overhunting of deer, wild pig, and other ungulates
undermines carrying capacity even where habitat remains.  
- **Habitat loss & fragmentation:** Agricultural expansion, plantation
estates, logging, linear infrastructure, and settlements sever movement
pathways.  
- **Governance & poverty:** Weak enforcement capacity, corruption, and
limited rural livelihoods fuel participation in illegal supply chains.  
- **Emerging risks:** **Climate change** threatens coastal/mangrove
habitats (e.g., **Sundarbans** via sea-level rise and cyclones);
expanding road/rail networks elevate mortality and open access for
poachers.

**What has worked (evidence-backed levers):**  
- **Site protection & patrol quality:** Skilled, well-resourced patrols
(SMART, informant networks), rapid response, and judicial follow-through
reduce poaching.  
- **Prey base recovery:** Community co-management and hunting controls
that allow ungulates to rebound increase tiger carrying capacity.  
- **Corridor protection:** Securing key linkages, regulating linear
infrastructure, and targeted restoration maintain meta-population
function.  
- **Community benefits:** Genuine local income from **ecotourism**,
conservation jobs, and performance-based payments improves tolerance and
reduces incentives to poach.  
- **Demand reduction & market controls:** Visible enforcement,
cross-border cooperation, and sustained demand-reduction campaigns
shrink margins for traffickers.  
- **Transboundary collaboration:** Joint monitoring and coordinated
enforcement in shared landscapes (e.g., India–Nepal Terai, Russia–China
Far East) address cross-border movement of wildlife and offenders.

**Bottom line.**  
Tigers can rebound rapidly where **protection is credible**, **prey is
abundant**, and **communities see real benefits**. But the same factors
that drove the 20th-century collapse—illegal killing, prey loss, and
habitat fragmentation—still operate. Without continuous, well-governed
effort that pairs **livelihoods and governance** with **enforcement and
demand reduction**, local recoveries remain fragile and reversible.

## 2.3 Existing Research

Wildlife crime, governance, and impacts. The UNODC World Wildlife Crime
Report (2024) documents the scale of wildlife trafficking, its
convergence with corruption and organized crime, and harms to
governance, development, and public health—framing wildlife crime as a
cross-cutting development and security issue, not just a conservation
problem.

Poverty, livelihoods, and poaching. Reviews in conservation and
development literatures show that illegal hunting is often rooted in
poverty, limited legal opportunities, and weak state presence; snaring
in Southeast Asia is repeatedly highlighted as a low-cost, high-impact
method linked to commercial demand and household income needs. The
evidence cautions against simplistic narratives and emphasizes
structural drivers (poverty, markets, governance).

Population status and trends. The IUCN Red List reassessment (Goodrich
et al., 2022) provides the current global estimate and Endangered
status; WWF/Global Tiger Forum syntheses note stabilization or increases
in some range states since 2010 (TX2), alongside declines
elsewhere—indicating heterogeneous outcomes linked to protection and
pressure.

Snaring and recent extirpations. Peer-reviewed field studies from Laos
(Nam Et-Phou Louey) document the disappearance of tigers by 2014, with
snares implicated; WWF and news summaries align with those findings.
These cases are used as cautionary examples of how trade-driven killing,
coupled with habitat and prey loss, can rapidly eliminate small
populations.

Health risk from live trade. Intergovernmental guidelines (WOAH) and
UNODC communication during COVID-19 underline that unregulated
live-animal trade elevates spillover risk through high-contact,
unsanitary interfaces across the supply chain. This evidence underpins
the project’s public-health framing (associational, not causal claims).

Tourism, jobs, and finance. WWF and site-level studies report
substantial tiger-linked tourism value and local capture of benefits;
declines in wildlife or access translate into measurable revenue and
employment losses, weakening incentives for protection and local buy-in.
These findings justify including an ecotourism/jobs lens alongside
biological and enforcement metrics.

# 3 Research Questions

## 3.1 Core Research Questions

- **Q:** Where wild population snapshots exist, is wild_pop_mid
  negatively correlated with seizures per million (signaling depletion
  pressure) or uncorrelated (detection bias)?  
  **H:** Weak negative correlation overall, with wide uncertainty.

- **Q:** Do persistent poaching signals plausibly damage destination
  brand and cooperation prospects?  
  **H:** High, sustained illegal trade indicators correlate with
  reputational risk narratives.

- **Q:** What economic losses (revenue/jobs) are implied when tiger
  sightings/access fall (e.g., from poaching)?  
  **H:** Reduced sightings/access materially cuts reserve-level revenue
  and local earnings; at scale, this undermines sustainable employment,
  reinforcing the poverty–poaching loop.

- **Q:** Do improvements (Δ) in governance indices correlate with
  subsequent decreases in seizures per million (lead–lag association)?
  **H:** Positive Δ rule-of-law in year t associates with lower seizures
  per million in t+1.

- **Q:** Are poverty, unemployment, basic services, and governance
  associated with recorded poaching pressure?  
  **H:** Higher poverty and weaker rule-of-law align with higher
  seizures per capita.

- **Q:** Are year-over-year changes in poverty/unemployment correlated
  with changes in seizures per million (Δ–Δ analysis)?  
  **H:** Worsening poverty/unemployment associates with rising seizures
  per million.

- **Q:** How do trade/enforcement trends relate to wild population
  context and (if available) ex-situ counts?  
  **H:** Areas with historically depleted wild populations show weaker
  elasticity of seizures to price signals (fewer animals to poach), but
  trafficking routes persist.

## 3.2 Sub-Questions

- **Q:** How have tiger-part seizures changed over time and where are
  hot spots?  
  **H:** Seizures show clustered hot spots and non-linear trends driven
  by enforcement and market dynamics.

- **Q:** Do wholesale price indices/ranges align with subsequent changes
  in seizures?  
  **H:** Higher prior-year wholesale indices correlate with higher
  current seizures (association, not causal proof).

- **Q:** What does the subspecies/population extinction timeline
  indicate about illegal trade alongside habitat/prey loss?  
  **H:** Extirpation events coincide with periods of high poaching
  pressure and weak governance, with habitat/prey loss as interacting
  drivers.

- **Q:** Is the poverty ↔ seizures correlation heterogeneous by region
  (South Asia vs. mainland Southeast Asia vs. Russia/China)?  
  **H:** Strongest in mainland Southeast Asia, weaker in
  higher-income/high-governance regions.

- **Q:** Where live-animal seizures occur, do indicators suggest
  elevated spillover risk?  
  **H:** Higher shares of live-trade seizures co-occur with weaker
  services/governance.

# 4 Data

## 4.1 Data Sources

- **CITES Trade Database** — official, country-reported international
  trade in CITES-listed species; filter for Panthera tigris and relevant
  product terms.

- **TRAFFIC (e.g., “Skin and Bones” series)** — consolidated seizure
  analyses (counts/weights by year/country/item).

- **Protected areas / habitat context** — WDPA; forest-loss layers
  (Global Forest Watch/Hansen).

- **IUCN Red List (Panthera tigris)** — status, range, best-available
  global population context.

- **UNODC World Wildlife Crime Reports** — trafficking flows, valuation
  methods, wholesale price ranges/indices (use only as ranges/indices;
  no granular detail).

- **Wildlife Justice Commission (WJC)** — carefully collected wholesale
  price intelligence (use as indices/ranges, aggregated by year/region).

- **Species360 / ZIMS & studbooks** — ex-situ snapshots
  (access-controlled; use if permission is granted).

- **Socioeconomics/Governance** — World Bank (WDI), Worldwide Governance
  Indicators (WGI).

- **Public-health** — aggregated country-year counts from official
  reporting where available (used illustratively, not for causal
  claims).

## 4.2 Variables & Data Schema

### 4.2.1 TRAFFIC — Seizures (pressure signal)

- **Grain:** `country`–`year` (optionally `item`)
- **Vars (raw/clean):** `item` (skin\|bone\|tooth\|claw\|mixed),
  `seizures_n`, `seizures_kg`
- **Derived:** `seizures_total`, `skins`, `bones`, `teeth_claws`,
  `seizures_per_million = 1e6 * seizures_total / pop`,
  `log_spm = log1p(seizures_per_million)`
- **Live-trade proxy:** `live_flag` → `live_share` (% by country–year)

### 4.2.2 CITES Trade Database — Reported trade (context)

- **Grain:** record → aggregate to `country`–`year`
- **Variables:** `exporter`, `importer`, `year`, `term`, `purpose`,
  `source`, `reported_qty`, `unit`
- **Derived:** `cites_records`, `cites_qty_total`, `cites_live_share`

### 4.2.3 UNODC / WJC — **Wholesale price indices/ranges**

- **Grain:** `region`–`year`
- **Variables:** `commodity`, `market_stage="wholesale"`,
  `index_low_usd`, `index_high_usd`, `index_mid`, `index_mid_lag`
- **Note:** Optional CPI-deflated `index_mid_real`

### 4.2.4 IUCN / National sources — Population context

- **Wild pop (snapshot):** `wild_pop_min|max|mid`, `estimate_year`
  (country/landscape)
- **Extinction / extirpation events:** `geography`, `event_type`,
  `event_year`, `notes`

### 4.2.5 Species360 / ZIMS / Studbooks — Ex-situ (snapshot)

- **Variables:** `ex_situ_count`, `facility_count`, `ex_situ_year`,
  `coverage_notes`

### 4.2.6 WDI & WGI — Socioeconomics & governance

- **Demographics & income:** `pop`, `gdp_ppp_pc`
- **Poverty & employment:** `pov_215`, `unemp`
- **Basic services:** `clean_water` or `electricity_access`
- **Governance:** `rule_of_law`, `control_of_corruption`
- **Plus:** `region` (for joining to price indices)

### 4.2.7 WDPA / GFW

- **Protection coverage:** `pa_coverage_pct`
- **Habitat loss:** `forest_loss_pct`, `baseline_forest_cover`

### 4.2.8 Public-health proxies

- **Live trade:** `live_share`
- **Health signal:** `outbreak_count` (coarse)

### 4.2.9 Tourism anchors (site-level)

- **Variables:** `reserve`, `anchor_value_usd`, `local_share`,
  `gate_fees_usd`, `reserve_budget_usd`, `year`
- **Scenarios:** `visitation_decline_{10,20,30}`, `revenue_loss`,
  `local_earnings_loss`

### 4.2.10 Keys & Joins

- **Primary panel key:** `country` (ISO3) + `year`
- **Regional joins:** map `country → region` for price indices
- **Snapshots:** keep separate with their own year columns; do **not**
  annualize

# 5 Methodology

## 5.1 Data Analysis Plan

### 5.1.1 Data Quality & Bias Controls

- Harmonize ISO3 country codes and region mapping; explicit missingness
  handling.
- Use per-capita and log transforms for skewed outcomes (seizures).
- Seizures are detection-biased; population estimates are
  ranges/snapshots.
- Price data used **only** as aggregated **wholesale** ranges/indices.

### 5.1.2 Prices → Pressure (associations)

- **Unit:** region–year (or country aggregated to region).
- **Spec:**
  $\text{spm}_t = \alpha + \beta\,\text{index\_mid}_{t-1} + \gamma_t + \varepsilon$
  (OLS on SPM; GLM on counts with offset log(pop)).
- Readout: sign/CI of β; LOESS overlay. Associations only.

### 5.1.3 Populations & Extinctions

- Timeline of historic subspecies/population losses and recent country
  extirpations; overlay regional seizure trends.
- Place seizure trends alongside wild population context; interpret
  descriptively.

### 5.1.4 Socioeconomic Drivers & Dependency Cycle

- **Unit:** country–year.
- Bivariate plots: poverty, unemployment, basic services, governance vs
  $\log(1+\text{SPM})$.
- Light regression with lagged covariates and year FE:
  $\text{Seizures}_{c,t} = \beta_0 + \beta_1 \text{Poverty}_{c,t-1} + \beta_2 \text{RuleOfLaw}_{c,t-1} + \beta_3 \text{GDPpc}_{c,t-1} + \gamma_t + \varepsilon_{c,t}$

### 5.1.5 Live-Trade & Public-Health Risk

- **Unit:** country–year (subset with `live_share`).
- **Spec:** `live_share ~ services + governance + year FE` (OLS or beta
  regression).
- Use panels to illustrate elevated spillover risk where live-trade
  share is high.

### 5.1.6 Ecotourism Revenue & Jobs

- Site-level anchor(s); scenario analysis (10–30% visitation drop) →
  revenue and local-earnings losses.
- Contextualize with macro wildlife-tourism jobs figures (qualitative).

## 5.2 Statistical Tests

**Associations & correlation**

- Pearson/Spearman between `log_spm` and predictors (`pov_215`,
  `gdp_ppp_pc`, `rule_of_law`, `index_mid_lag`,
  `clean_water`/`electricity_access`).
- Kendall’s τ for small-N regional series.

**Group/comparative**

- t-test or Wilcoxon for high vs low poverty (or governance) on
  `log_spm`.
- ANOVA or Kruskal–Wallis across quartiles; Dunn (Holm) post-hoc if
  nonparametric.

**Trend & structural change**

- Mann–Kendall + Theil–Sen for monotonic trends in yearly seizures.
- Change-points (CUSUM, Bai–Perron) on seizures or price-index series.

**Count-model diagnostics**

- Overdispersion test (Cameron–Trivedi); switch to Negative Binomial if
  needed.
- Vuong/LR to compare Poisson vs NB vs zero-inflated.

**Panel & regression diagnostics**

- Breusch–Pagan (heteroskedasticity) → HC3 or cluster-robust SE.
- VIF (multicollinearity); Moran’s I on residuals; Ramsey RESET;
  residual plots.

**Proportions & live-trade**

- Two-proportion z-tests or χ² for binarized comparisons; rely on beta
  regression for continuous `live_share`.

**Multiple comparisons & uncertainty**

- FDR control (Benjamini–Hochberg).
- Bootstrap CIs for medians and coefficients where needed.

### 5.2.1 Algorithms

**Core models (panel/cross-section)**

- **OLS with fixed effects**:

  - `log_spm_ct ~ poverty_{t-1} + rule_of_law_{t-1} + gdp_ppp_pc_{t-1} + year_FE`
    (country–year panel).
  - Robust **HC3** or **clustered SE** (by country or region).

- **GLM for counts** (when modeling raw seizures):

  - **Poisson / Negative Binomial** with `offset = log(pop)`; choose
    **NB** if overdispersion; consider **ZINB** if many zeros.

**Nonlinearity & robust effects**

- **GAM (splines)** for potential curvature in `poverty`, `rule_of_law`,
  or `index_mid_lag`.
- **Quantile regression** (e.g., τ = 0.5) to estimate median
  associations robust to outliers.

**“Price → pressure” association (regional)**

- Regional aggregation + **lagged regressor**:

  - `spm_region_t ~ index_mid_{t-1} + year_FE`, OLS with HAC
    (Newey–West) SE for serial correlation.

- **LOESS** smoother in scatterplots for visualization (no inference).

**Event/Policy analyses (descriptive, not causal claims)**

- **Interrupted time series (ITS)** / segmented regression around major
  policy shocks, with **Newey–West** errors.
- **Event-study plots** (two-way FE if sample permits) to visualize
  pre/post patterns; interpret cautiously.

**Live-trade risk modeling**

- **Beta regression** (or **quasi-binomial**) for
  `live_share ~ services + governance + year`

**Spatial sanity**

- If Moran’s I flags spatial autocorrelation, use **cluster-robust SE by
  region**, or add **regional FE**; full spatial lag/error models are
  optional stretch goals.

**Predictive/importance (optional, clearly labeled exploratory)**

- **Regularized regression** (**LASSO / Elastic Net**) to gauge variable
  importance among many correlated covariates; k-fold CV for tuning.
- **Random Forest / Gradient Boosting** to obtain **permutation
  importance** and **partial dependence** plots; stress **non-causal**,
  exploratory nature.

**Smoothers & decomposition (EDA)**

- **STL decomposition** on longer regional series (seizures or price
  indices) to separate trend/seasonal/irregular components (if
  periodicity exists).
- **Theil–Sen** lines on bivariate plots as robust trend depiction.

## 5.3 Software

**Core data work:** `tidyverse` (dplyr, tidyr, readr, ggplot2),
`lubridate`, `stringr` **Fast I/O & large files:** `duckdb`, `DBI`,
`arrow` **Statistics & econometrics:** `fixest`, `sandwich`, `lmtest`,
`clubSandwich`, `MASS`, `glmmTMB`, `pscl` (optional), `mgcv`, `betareg`,
`car`, `performance`, `DescTools`, `Kendall`, `trend`, `strucchange`,
`changepoint` **Geospatial & maps:** `sf`, `rnaturalearth`,
`rnaturalearthdata`, `tmap` (optional), `classInt`, `viridis`,
`spdep`/`sfdep` **Reporting & reproducibility:** `rmarkdown`, `knitr`,
`renv`

# 6 Ethics, Risks, Communication & Privacy Concerns Addressed

- **Purpose:** academic analysis of drivers/impacts; **no operational
  guidance**.
- **Price data:** use aggregated **wholesale** ranges/indices; no
  procurement details.
- **Bias & uncertainty:** seizures are detection-biased; population
  estimates are ranges; clearly label uncertainty.
- **Community framing:** avoid victim-blaming; emphasize structural
  drivers and solutions (livelihoods, governance, demand reduction,
  sanitary controls on live trade).
- **Public-health:** discuss live-trade spillover risk as
  **associational**.
- **Causality:** present associations; avoid over-claiming.
- **Ex-situ data:** document permissions; omit if unavailable.
- **Attribution:** cite TRAFFIC, CITES, IUCN, UNODC, WJC, and others;
  respect licenses and access terms.

# 7 Deliverables

## 7.1 Visualizations

### 7.1.1 F1 — Tiger-part seizures over time (total)

**Purpose**: Show overall pressure trend.

**Inputs (TRAFFIC → Seizures)**: country, year, seizures_total.
(Optionally sum to global/regional with region from WDI/WGI.)

**Chart**: Column (year on x, total on y). Optional 3–5-year moving
average.

Recorded tiger-part seizures fluctuate over time, reflecting shifts in
market dynamics, enforcement effort, and reporting capacity.

### 7.1.2 F2 — Seizures by commodity (skins, bones, teeth/claws)

**Purpose**: Identify which commodities dominate.

**Inputs (TRAFFIC)**: year, item splits: skins, bones, teeth_claws (or
long format item, n).

**Chart**: Small-multiples columns (one panel per item), aligned axes if
feasible.

Different product types exhibit distinct trajectories, indicating
heterogeneous demand and supply chains.

### 7.1.3 F3 — Seizure hot-spots map

**Purpose**: Where enforcement encounters occur.

**Inputs (TRAFFIC + WDI/WGI)**: country, last 5-yr sum seizures_total;
join ISO3 to map; optional rate = per million (seizures_per_million).

**Chart**: Choropleth (country fill by value). Optional labels for top
5.

Seizures cluster geographically, highlighting priority corridors and
jurisdictions for coordinated responses.

### 7.1.4 F4 — Lagged wholesale index vs. seizures (“price” → pressure association)

**Purpose**: Test if prior wholesale signals align with subsequent
pressure.

**Inputs (UNODC/WJC + TRAFFIC + WDI/WGI)**: region, year, index_mid_lag;
regional seizures_per_million.

**Chart**: Scatter with LOESS (x = index_mid_lag, y = regional
seizures_per_million).

Higher prior-year wholesale indices are associated with higher recorded
pressure; results are correlational, not causal.

### 7.1.5 F5 — Wild vs. ex-situ populations (context)

**Purpose**: Contrast conservation states.

**Inputs (IUCN + ZIMS/studbooks)**: wild_pop_min\|max\|mid,
estimate_year; ex_situ_count, ex_situ_year, coverage_notes.

**Chart**: Two bars/lines with error whiskers (wild range vs. ex-situ
snapshot). Prominent caveat footnote.

Wild populations remain limited relative to ex-situ holdings; estimates
are ranges with substantial uncertainty.

### 7.1.6 F6 — Extinction / extirpation timeline (historic + recent)

**Purpose**: Place losses in time.

**Inputs (IUCN / literature)**: event_type (extinct \|
functional_extirpation), event_year, notes.

**Chart**: Timeline with labeled markers; panels for (historic
subspecies) vs (recent country losses).

Historic subspecies losses and recent country-level extirpations reflect
interacting drivers, including illegal killing, habitat conversion, and
prey depletion.

### 7.1.7 F7 — Pressure vs. loss overlay

**Purpose**: Visual association between elevated pressure and loss
events.

**Inputs (TRAFFIC + events)**: Regional/yearly seizures_total and
extirpation markers.

**Chart**: Line (seizures) with vertical lines/flags at event_year.

Extirpation milestones coincide with periods of elevated recorded
pressure in parts of the range (descriptive, not causal).

### 7.1.8 F8 — Country case cards (e.g., Cambodia, Laos)

**Purpose**: Succinct narrative for key cases.

**Inputs**: country, last camera-trap year (narrative), event_year,
5–10-yr regional seizures_total sparkline; 2–3 policy milestones.

**Chart**: Two mini cards with sparkline and bullets.

Case studies illustrate how poaching and governance conditions can
culminate in functional extirpation.

### 7.1.9 F9 — Poverty vs. recorded pressure

**Purpose**: Socioeconomic association.

**Inputs (WDI/WGI + TRAFFIC)**: pov_215, log_spm, region.

**Chart**: Scatter (x = poverty headcount %, y = log(1+SPM)), color by
region, LOESS.

Higher poverty aligns with greater recorded pressure; association only,
and subject to detection bias.

### 7.1.10 F10 — Governance vs. recorded pressure

**Purpose**: Governance association.

**Inputs (WGI + TRAFFIC)**: rule_of_law, log_spm.

**Chart**: Scatter with linear fit; optionally facet by region.

Stronger rule of law is associated with lower recorded pressure.

### 7.1.11 F11 — Live-trade risk indicator (spillover proxy)

**Purpose**: Track unregulated live-animal trade share.

**Inputs (TRAFFIC/CITES)**: live_share by country–year; optional
regional mean.

**Chart**: Line by region; or bars by country for latest year.

Where live-animal seizures comprise a larger share, spillover risk from
unsanitary holding/transport conditions is of greater concern.

### 7.1.12 F12 — Socioeconomic quartet

**Purpose**: Side-by-side drivers view.

**Inputs (WDI/WGI + TRAFFIC)**: pov_215, unemp, clean_water or
electricity_access, rule_of_law, all vs log_spm.

**Chart**: 4 small-multiple scatters with identical axes scales.

Poverty, employment, basic services, and governance show distinct
associations with recorded pressure.

### 7.1.13 F13 — Tiger tourism value (site anchor)

**Purpose**: Ground economic stakes at reserve level.

**Inputs (Tourism valuation study)**: reserve, anchor_value_usd,
gate_fees_usd, reserve_budget_usd, local_share.

**Chart**: Single “value card” bar; inset comparing gate fees
vs. budget.

Tiger tourism at key reserves generates substantial revenue, often
helping finance protection and local livelihoods.

### 7.1.14 F14 — “What if sightings fall?” scenario (revenue & local earnings losses)

**Purpose**: Illustrate sensitivity to poaching shocks.

**Inputs (Tourism + scenario)**: anchor_value_usd, local_share,
visitation_decline\_{10,20,30}, computed revenue_loss,
local_earnings_loss.

**Chart**: Tornado/interval bar showing loss under 10–30% declines;
annotate assumptions.

Reduced sightings/access can quickly erode reserve revenue and local
earnings; values shown are illustrative scenarios.

### 7.1.15 F15 — Wildlife-tourism jobs context (macro)

**Purpose**: Put site-level numbers in labor-market perspective.

**Inputs (WTTC/credible synthesis)**: global and Asia–Pacific
wildlife-tourism jobs (headline stats).

**Chart**: Two bars or a small multiple comparing totals.

Wildlife tourism supports millions of jobs; declines in flagship species
jeopardize broader employment and development gains.

### 7.1.16 F16 — Reputation & governance (callout)

**Purpose**: Communicate non-market, strategic costs.

**Inputs (UNODC / synthesis)**: short bullets on governance harms,
organized crime links, brand risk.

**Chart**: Text-forward callout; optional icons; no data plot required.

Persistent poaching undermines governance and international reputation,
with knock-on effects for investment and destination branding.

**Notes on joins and readiness per figure**:

- By-country figures: F1–F3, F8–F12 use country–year (ISO3), with region
  as a cosmetic or grouping field.

- By-region figures (price linkage): F4 requires country → region
  mapping to join index_mid_lag. Aggregate seizures to region-year
  first.

- Snapshot/context figures: F5 (populations) and F13–F14 (tourism
  anchors) are not merged into the panel; keep as separate tables with
  clear years and caveats.

- Event overlays: F6–F7 add an events table (event_year, event_type,
  geography) to annotate timelines.

## 7.2 Models

- **Panel OLS (FE):**
  `fixest::feols(log_spm ~ lag(pov_215,1) + lag(rule_of_law,1) + lag(gdp_ppp_pc,1) | year, vcov="HC3")`
- **Counts (NB):**
  `MASS::glm.nb(seizures_total ~ lag(pov_215,1)+lag(rule_of_law,1)+lag(gdp_ppp_pc,1)+factor(year) + offset(log(pop)))`
- **Beta regression (live_share):**
  `betareg::betareg(live_share01 ~ clean_water + rule_of_law + factor(year))`
- **Regional price model:**
  `feols(seizures_pm ~ index_lag | year, vcov="NW")`

## 7.3 Reports

- **Format:** This R Markdown renders to **GitHub Markdown**, **PDF**,
  and **HTML** with a single source file (this `.Rmd`).
- **Reproducibility:** Pin package versions with `renv`. Include session
  info in the appendix.
- **Artifacts:** Save `output/figs/` and an analysis-ready panel CSV in
  `output/data/`.

# 8 Significance & Expected Outcomes

- A clean, analysis-ready **country–year panel** combining seizures,
  price indices (wholesale ranges), socioeconomic/governance indicators,
  and live-trade proxies.
- Transparent **figures (F1–F16)** suitable for a policy-facing brief.
- Clear statements of **associations** (not causal claims), with ethics
  and uncertainty front-and-center.
- Practical **scenario analysis** quantifying potential ecotourism
  revenue and local-earnings losses from reduced sightings/access.

# 9 Conclusion

Illegal tiger trade is not only a biodiversity crisis; it is a
governance, development, and public-health challenge. By integrating
enforcement signals, market context, socioeconomic conditions, and
tourism economics, this project provides a reproducible evidence base
for interventions that pair **livelihoods and governance** with
**enforcement and demand reduction**.

# 10 Appendices

## 10.1 A. Package/session info

``` r
sessionInfo()
```

    ## R version 4.2.2 Patched (2022-11-10 r83330)
    ## Platform: x86_64-pc-linux-gnu (64-bit)
    ## Running under: Debian GNU/Linux 12 (bookworm)
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.11.0
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.11.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] compiler_4.2.2    fastmap_1.2.0     cli_3.6.5         tools_4.2.2      
    ##  [5] htmltools_0.5.8.1 yaml_2.3.10       rmarkdown_2.29    knitr_1.50       
    ##  [9] xfun_0.53         digest_0.6.37     rlang_1.1.6       evaluate_1.0.5

## 10.2 B. Hot-spot map scaffold

``` r
library(sf); library(rnaturalearth); library(ggplot2); library(viridis)
world <- rnaturalearth::ne_countries(scale = "medium", returnclass = "sf") |>
  dplyr::select(iso_a3, geometry)

# last5y_panel must contain: country_iso3, seizures_per_million
mapdat <- world |> dplyr::left_join(last5y_panel, by = c("iso_a3" = "country_iso3"))

ggplot(mapdat) +
  geom_sf(aes(fill = seizures_per_million), color = NA) +
  scale_fill_viridis_c(option = "C") +
  labs(fill = "Seizures / 1M", title = "Tiger-part seizure hot spots (last 5 years)") +
  theme_minimal()
```

## 10.3 C. Lagged wholesale index vs. seizures (regional)

``` r
library(dplyr); library(ggplot2)
regdat <- region_year |>
  mutate(seizures_pm = 1e6 * seizures_total / pop,
         index_lag   = dplyr::lag(index_mid, 1)) |>
  tidyr::drop_na(seizures_pm, index_lag)

ggplot(regdat, aes(index_lag, seizures_pm)) +
  geom_point(alpha = 0.7) +
  geom_smooth(method = "loess", se = FALSE, color = "black") +
  labs(x = "Wholesale index (lagged 1y)", y = "Seizures per million",
       title = "Wholesale signal (lagged) vs. recorded pressure") +
  theme_minimal()
```
