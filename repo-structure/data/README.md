# Variables & Data Schema

## 1) TRAFFIC (seizure analyses; e.g., *Skin & Bones*)

**Topic: Seizures (pressure signal)**

-   **Grain:** `country`–`year` (optionally `item`)

-   **Vars (raw/clean):**

    -   `item` (skin \| bone \| tooth \| claw \| mixed)
    -   `seizures_n`, `seizures_kg` (as available)

-   **Derived (panel):**

    -   `seizures_total` (sum by country–year)
    -   `skins`, `bones`, `teeth_claws` (by item)
    -   `seizures_per_million = 1e6 * seizures_total / pop`
    -   `log_spm = log1p(seizures_per_million)`

-   **Notes:** Use counts or weights consistently; keep a column indicating which metric you’re using.

**Topic: Live-trade proxy (if identifiable)**

-   **Vars:** `live_flag` at record level → aggregate to `live_share` (% live-animal seizures by country–year)

**Keys:** `country`, `year` (ISO3 recommended), optional `item`

## 2) CITES Trade Database (contextual reported trade)

**Topic: Reported international trade (context)**

-   **Grain:** shipment record → aggregate to `country`–`year`

-   **Vars (raw):** `exporter`, `importer`, `year`, `term`, `purpose`, `source`, `reported_qty`, `unit`

-   **Derived (panel):**

    -   `cites_records` (count per `country`–`year`)
    -   `cites_qty_total` (sum `reported_qty` where units are comparable)
    -   `cites_live_share` (share of `term == "LIV"` by `country`–`year`)

**Keys:** `country` (choose exporter or importer consistently), `year`

## 3) UNODC / Wildlife Justice Commission (WJC) — **Wholesale price indices/ranges**

**Topic: Market signal (safe aggregation)**

-   **Grain:** `region`–`year` (avoid transaction detail)

-   **Vars (cleaned):**

    -   `commodity` (tiger parts—use your controlled vocabulary)
    -   `market_stage` ("wholesale" only)
    -   `index_low_usd`, `index_high_usd` (nominal USD)
    -   `index_mid = (low + high)/2`

-   **Derived:** `index_mid_lag = lag(index_mid, 1)` (by `region`)

-   **Notes:** Do not include “how/where.” If you CPI-adjust, add `index_mid_real`.

**Keys:** `region`, `year`

## 4) IUCN Red List / Credible national sources

**Topic: Wild population context**

-   **Grain:** `country` (or landscape) **snapshot**
-   **Vars:** `wild_pop_min`, `wild_pop_max`, `wild_pop_mid`, `estimate_year`
-   **Notes:** Not annual. Store as context; do **not** interpolate yearly.

**Topic: Extinctions / functional extirpations**

-   **Grain:** `geography` (subspecies/country)
-   **Vars:** `event_type` (extinct \| functional_extirpation), `event_year`, `notes`

**Keys:** `country` or `landscape`, `estimate_year` (snapshot table)

## 5) Species360 / ZIMS / Studbooks (access-permitting)

**Topic: Ex-situ populations (snapshot)**

-   **Grain:** global or `country` snapshot for a given `ex_situ_year`
-   **Vars:** `ex_situ_count`, `facility_count` (if available), `coverage_notes`
-   **Keys:** `country` (if available), `ex_situ_year`
-   **Notes:** Document permissions; include coverage caveats.

## 6) World Bank (WDI) & Worldwide Governance Indicators (WGI)

**Topic: Demographics & income**

-   **Grain:** `country`–`year`

-   **Vars:**

    -   `pop` (population)
    -   `gdp_ppp_pc` (PPP, constant international \$)

**Topic: Poverty & employment**

-   **Vars:**

    -   `pov_215` (poverty headcount, % at \$2.15/day)
    -   `unemp` (unemployment rate, %)

**Topic: Basic services**

-   **Vars:** `clean_water` (% using at least basic drinking water) or `electricity_access` (%)

**Topic: Governance (WGI)**

-   **Vars:** `rule_of_law`, `control_of_corruption` (index scores)

**Keys:** `country`, `year`, plus `region` (for joining to price indices)

## 7) WDPA / Global Forest Watch (optional habitat/protection)

**Topic: Protection coverage**

-   **Grain:** `country`–(year or latest)
-   **Vars:** `pa_coverage_pct` (protected-area coverage of land)

**Topic: Habitat loss**

-   **Grain:** `country`–`year` (or rolling window)
-   **Vars:** `forest_loss_pct`, `baseline_forest_cover`

**Keys:** `country`, `year`

## 8) Public-health risk proxies (optional, coarse)

**Topic: Live-trade spillover risk**

-   **From seizures/CITES:** `live_share` (already defined)
-   **Optional health signal:** `outbreak_count` (country–year, coarse indicator only; if you include it)

**Keys:** `country`, `year`

## 9) Tourism valuation anchors (site-level case studies)

**Topic: Reserve-level economic value**

-   **Grain:** `reserve`–`year` (case study; e.g., Ranthambhore)

-   **Vars:**

    -   `anchor_value_usd` (annual tourism turnover)
    -   `local_share` (fraction captured locally)
    -   `gate_fees_usd`, `reserve_budget_usd` (if available)

**Topic: Impact scenarios (illustrative)**

-   **Derived:**

    -   `visitation_decline_{10,20,30}` (assumed %),
    -   `revenue_loss = anchor_value_usd * scenario`,
    -   `local_earnings_loss = revenue_loss * local_share`

**Keys:** `reserve`, `year` (keep separate from country panel; link by `country` if needed)

## 10) Policy / Events metadata

**Topic: Enforcement & policy milestones**

-   **Grain:** `geography`–`year`
-   **Vars:** `event_year`, `event_name`, `event_type` (ban \| listing \| enforcement_drive \| closure \| reopening), `notes`
-   **Use:** figure annotations; event-study overlays.

------------------------------------------------------------------------

# Join strategy & canonical keys

-   **Primary panel key:** `country` (ISO3) + `year`
-   **Regional joins:** map `country → region` (for price indices)
-   **Snapshot tables (populations/ex-situ):** left-join by `country` and carry `estimate_year`/`ex_situ_year` as context columns; do **not** force annualization
-   **Site-level anchors:** keep **separate** (reserve-level table). Reference in text/figures; do not merge into country panel unless you create a distinct `reserve_country` mapping.

------------------------------------------------------------------------

# Naming & units conventions

-   **Text/categorical:** lowercase strings; controlled vocab for `item`, `event_type`
-   **Currencies:** `_usd` suffix; specify nominal vs. real (and base year if deflated)
-   **Rates & shares:** `_pct` for 0–100 percentages; `_share` for 0–1 fractions
-   **Transforms:** store both raw and derived (e.g., `seizures_per_million`, `log_spm`)

# Data engineering: tables, keys, variables

## Tables

-   `traf_raw` → `traf_cty_year`: clean seizures by **country–year–item**; totals and per-capita normalization.
-   `cites_tiger` (context; optional in modeling).
-   `prices_reg_year`: **wholesale** index ranges by **region–year**; derive `index_mid`.
-   `wdi_wgi_cty_year`: socioeconomic + governance + population.
-   `live_cty_year`: share of live-animal seizures.
-   `pops_context`: wild population estimates (global; country/landscape snapshots).
-   `tourism_anchor`: site-level annual tourism value and local share.

## Key derived variables

-   `seizures_total`, `skins`, `bones`, `teeth_claws`.
-   `seizures_per_million = 1e6 * seizures_total / pop`.
-   `log_spm = log1p(seizures_per_million)`.
-   `index_mid_lag = lag(index_mid, 1)` (by region).
-   `poverty_q`, `gov_q` (quartiles for descriptive contrasts).
-   `live_share` (% live-animal seizures).
-   Scenario fields: `visitation_decline_{10,20,30}`, `revenue_loss = anchor_value * scenario`, `local_earnings_loss = revenue_loss * local_share`.
