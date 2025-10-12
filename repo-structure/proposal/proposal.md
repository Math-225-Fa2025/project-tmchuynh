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
### Summary
## References
