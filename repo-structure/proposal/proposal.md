---
title: "Final Project Proposal: Statistical Analysis of Chess Performance and Player Progression"
author: "Tina Huynh"
date: "`r Sys.Date()`"
output: html_document
---

# Statistical Analysis of Chess Performance and Player Progression

## Information

### Research Questions


---

### Data Information

#### Lichess Public API and Game Database

The **Lichess API** is an open data service provided by Lichess.org, a free online chess platform.  
It offers access to detailed, anonymized game records, including metadata such as player ratings, time controls, openings, and results.  
The **Lichess Database** also publishes monthly bulk archives of millions of games in PGN format, which can be converted into CSV or JSON for analysis.

##### Variables

- `player_id`: unique user identifier  
- `rating_pre` and `rating_post`: player ratings before and after the game  
- `game_type`: categorical variable (e.g., "blitz", "rapid", "classical", "bullet")  
- `opening_name`: chess opening name (e.g., "Sicilian Defense")  
- `winner`: categorical ("white", "black", or "draw")  
- `color`: player's color for the game  
- `avg_move_time`: average time per move (seconds)  
- `accuracy`: move accuracy score (from Lichess analysis)  
- `datetime`: UTC timestamp of game  
- `moves`: total number of moves per game  

---

#### FIDE Player Rating Lists

The **FIDE (Fédération Internationale des Échecs)** rating lists contain official Elo ratings, federation, title, age, and gender for all registered players worldwide.  
These data provide demographic and global context to the Lichess dataset and allow calibration of player strength and rating dynamics.

##### Variables

- `player_name`: player's full name  
- `fide_id`: unique identifier  
- `country`: player's national federation  
- `rating_standard`, `rating_rapid`, `rating_blitz`: ratings across formats  
- `title`: player title (GM, IM, FM, WGM, etc.)  
- `games_played`: total games considered in rating calculation  
---
---

## Data Analysis Plan

### Variable and Function Naming Conventions

Variables will use lowercase snake_case naming (e.g., `rating_diff`, `win_rate`, `avg_move_time`).  
Custom functions will follow similar naming conventions, such as `calc_win_rate()` and `normalize_rating_change()`.  
Data will be stored in tibbles and manipulated with `dplyr` and `tidyr`.
library(broom)
### Data Analysis Methods & Strategies
### Expected Outcomes & Limitations

#### Expected Outcomes
#### Limitations

1. **Sampling Bias**: 
   - Overrepresentation of active, higher-rated players
   - Platform-specific playing styles may not generalize
   - Self-selection bias in analyzed games

2. **Technical Constraints**:
   - API rate limits restrict sample sizes per user
   - Missing accuracy data for non-analyzed games
   - Potential data quality issues in automated parsing

3. **Statistical Limitations**:
   - Correlation vs. causation in performance factors
   - Limited temporal data for robust time series analysis  
   - Multiple testing concerns with numerous comparisons

4. **External Validity**:
   - Results specific to Lichess platform and user base
   - May not generalize to over-the-board tournament play
   - Time period and meta-game effects not controlled

### Summary
## References

- **Lichess.org Database & API Documentation.** (2025). *Lichess API Reference & Data Archives.*  
  Retrieved from [https://lichess.org/api](https://lichess.org/api)  
  and [https://database.lichess.org/](https://database.lichess.org/)  
  Licensed under the Creative Commons CC0 Public Domain Dedication.

- **Fédération Internationale des Échecs (FIDE).** (2025). *FIDE Rating Lists.*  
  Retrieved from [https://ratings.fide.com/download_lists.phtml](https://ratings.fide.com/download_lists.phtml)

- **Chess.com.** (2025). *Published Data API.*  
  Retrieved from [https://www.chess.com/news/view/published-data-api](https://www.chess.com/news/view/published-data-api)

- **Lichess Open Database Project.** (2025). *Monthly Game Archives.*  
  Retrieved from [https://database.lichess.org/](https://database.lichess.org/)

- **FIDE Handbook.** (2024). *Regulations for the Rating System.*  
  Retrieved from [https://handbook.fide.com/chapter/B022024](https://handbook.fide.com/chapter/B022024)

- **UCI Chess Engine Analysis.** (2025). *Lichess Accuracy Metrics Explained.*  
  Retrieved from [https://lichess.org/faq#computer-analysis](https://lichess.org/faq#computer-analysis)

- **Lichess Developer Blog.** (2023). *Analyzing Game Metadata and Player Performance.*  
  Retrieved from [https://lichess.org/blog](https://lichess.org/blog)

- **R Core Team.** (2024). *R: A Language and Environment for Statistical Computing.*  
  Vienna, Austria: R Foundation for Statistical Computing.  
  Retrieved from [https://www.R-project.org/](https://www.R-project.org/)

- **Wickham, H., François, R., Henry, L., & Müller, K.** (2023). *dplyr: A Grammar of Data Manipulation.*  
  R package version 1.1.3.  
  Retrieved from [https://CRAN.R-project.org/package=dplyr](https://CRAN.R-project.org/package=dplyr)

- **Wickham, H.** (2023). *ggplot2: Elegant Graphics for Data Analysis.*  
  Springer-Verlag New York.  
  Retrieved from [https://ggplot2.tidyverse.org/](https://ggplot2.tidyverse.org/)
