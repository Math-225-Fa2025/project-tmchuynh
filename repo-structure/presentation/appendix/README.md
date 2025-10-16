# Appendix Documents: Chess Rating Analysis
_Last updated: October 2025 | Author: Tina Huynh_

## Overview

Four comprehensive R Markdown appendices analyzing chess rating data from Lichess and FIDE platforms:

- **527 Lichess users** with 7,766 games
- **950 FIDE players** (simulated data)
- **1,173 rating observations** across 5 users and 4 time controls
- **6 rating tiers** (1400–2600+)

---

## Appendix Documents

### Appendix A — Summary Analytics (Lichess vs. FIDE)
**File:** `appendix_a.rmd` (214 lines) | **📄 [Detailed README](README_APPENDIX_A.md)**

Cross-platform rating comparison with descriptive statistics, correlation analysis, and tier-level aggregation.

**Key analyses:** Rating gaps, win rates, activity patterns, correlation matrices  
**Data:** `player_summary.csv`, `lichess_clean.csv`  
**Outputs:** PDF, HTML, LaTeX

---

### Appendix B — Longitudinal Rating Growth
**File:** `appendix_b.rmd` (836 lines) | **📄 [Detailed README](README_APPENDIX_B.md)**

Time-series analysis of rating trajectories with growth patterns, volatility metrics, and activity-performance correlations.

**Key analyses:** Linear growth rates, volatility by time control, cumulative change, learning curves  
**Data:** `lichess_rating_history.csv` + Lichess API  
**Outputs:** PDF, HTML, LaTeX

---

### Appendix C — Nonlinear Growth Modeling
**File:** `appendix_c.rmd` (205 lines) | **📄 [Detailed README](README_APPENDIX_C.md)**

Exponential saturation models capturing asymptotic skill development (R = A - B×e^(-kt)).

**Key analyses:** NLS parameter estimation, ceiling prediction, learning rate quantification, Bayesian extension  
**Data:** `lichess_rating_history.csv`  
**Outputs:** PDF, HTML, LaTeX

---

### Appendix D — Interactive Dashboard
**File:** `appendix_d.rmd` (316 lines) | **📄 [Detailed README](README_APPENDIX_D.md)**

Web-based interactive exploration with plotly charts, sortable tables, and unified analytics interface.

**Key features:** Hover tooltips, zoom/pan, dynamic filtering, export to CSV/Excel  
**Data:** All datasets combined  
**Outputs:** Interactive HTML

## Quick Start

### Render Documents
```r
# Individual appendices
rmarkdown::render("appendix_a.rmd")  # PDF/HTML
rmarkdown::render("appendix_b.rmd")  # PDF/HTML
rmarkdown::render("appendix_c.rmd")  # PDF/HTML
rmarkdown::render("appendix_d.rmd")  # Interactive HTML

# All at once (bash)
for file in appendix_*.rmd; do Rscript -e "rmarkdown::render('$file')"; done
```

### Required Dependencies
```r
install.packages(c("tidyverse", "lme4", "minpack.lm", "broom", "zoo",
                   "GGally", "plotly", "DT", "flexdashboard"))
```

### Data Requirements
| Appendix | Data Files | Records |
|----------|------------|---------|
| A | `player_summary.csv`, `lichess_clean.csv` | 6 tiers, 527 users |
| B | `lichess_rating_history.csv` | 1,173 observations |
| C | `lichess_rating_history.csv` | 1,173 observations |
| D | All above | Combined |

**Generate data:** `Rscript ../../extra/scripts/data_import.R`

---

## Resources

- **Detailed Analysis:** See individual `README_APPENDIX_[A-D].md` files
- **Data Documentation:** `../../data/README.md`
- **Scripts:** `../../extra/scripts/README.md`
- **Main Project:** `../../README.md`

---

## Citation

```bibtex
@misc{huynh2025chess,
  author = {Huynh, Tina},
  title = {Chess Rating Analysis: Cross-Platform Comparison and Modeling},
  year = {2025},
  institution = {Math-225-Fa2025},
  url = {https://github.com/Math-225-Fa2025/project-tmchuynh}
}
```
