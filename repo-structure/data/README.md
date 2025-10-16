# Comprehensive Chess Data Analysis Codebook (v4)
_Last updated: October 2025
_Sample size: 527 Lichess users, 950 FIDE players_

## Overview
This document provides metadata and variable definitions for datasets obtained from the **Lichess Public API** and the **FIDE Ratings API**.
The codebook outlines dataset dimensions, field types, and example values to ensure analytical reproducibility and transparency.

## Data Collection Methodology
- **Lichess Sampling**: Random sample of 548 users from multiple leaderboards (bullet, blitz, rapid, classical)
- **Rating Coverage**: Users from all skill levels (800-3000+ rating)
- **Rate Limiting**: Implemented exponential backoff and progress tracking
- **Reproducibility**: Seed set to 42 for consistent results

## 1. Lichess Public API Dataset

### 1.1 General Description

The **Lichess API** is a RESTful interface that provides public access to millions of chess games, player profiles, and rating histories.
Data were retrieved via the endpoint: [https://lichess.org/api/games/user/{username}?max=100&analysed=true](https://lichess.org/api/games/user/{username}?max=100&analysed=true)


This dataset contains **game-level records** for a single player, including metadata such as ratings, results, openings, and timestamps.
All data are published under the **Creative Commons CC0 Public Domain license**.

### 1.2 Dataset Dimensions

| Dimension                | Description                                                        |
| ------------------------ | ------------------------------------------------------------------ |
| **Unit of observation:** | Individual game                                                    |
| **Granularity:**         | Game-level metadata (1 record per completed game)                  |
| **Typical sample size:** | 100–10,000 games per player (depending on request parameters)      |
| **Number of variables:** | ~15–20 structured fields                                           |
| **Time coverage:**       | User-defined (e.g., last 12 months)                                |
| **Source format:**       | JSON (converted to tabular form using `jsonlite::fromJSON()` in R) |

### 1.3 Variable Dictionary

| Variable Name     | Type      | JSON Path                                                | Description                                                      | Example                                 |
| ----------------- | --------- | -------------------------------------------------------- | ---------------------------------------------------------------- | --------------------------------------- |
| `game_id`         | Character | `id`                                                     | Unique identifier for each game.                                 | `"3n8y6FzQ"`                            |
| `rated`           | Logical   | `rated`                                                  | Indicates whether the game affected player ratings.              | `TRUE`                                  |
| `speed`           | Factor    | `speed`                                                  | Time control category (`bullet`, `blitz`, `rapid`, `classical`). | `"blitz"`                               |
| `time_limit`      | Integer   | `clock.initial`                                          | Initial time control per player (seconds).                       | `180`                                   |
| `increment`       | Integer   | `clock.increment`                                        | Time increment per move (seconds).                               | `2`                                     |
| `color`           | Factor    | Derived                                                  | Player’s color in this game (`White`, `Black`).                  | `"White"`                               |
| `winner`          | Factor    | `winner`                                                 | Color of the winner (`white`, `black`), or missing for draws.    | `"white"`                               |
| `result`          | Numeric   | Derived                                                  | Binary variable (1 = win, 0 = loss/draw).                        | `1`                                     |
| `rating_pre`      | Integer   | `players.white.rating` or `players.black.rating`         | Player’s rating before game.                                     | `1850`                                  |
| `rating_diff`     | Integer   | `players.white.ratingDiff` or `players.black.ratingDiff` | Rating change from the game.                                     | `+4`                                    |
| `rating_post`     | Integer   | Derived                                                  | Rating after game (`rating_pre + rating_diff`).                  | `1854`                                  |
| `opponent_rating` | Integer   | Opponent’s pre-game rating.                              | `1830`                                                           |
| `opening_name`    | Character | `opening.name`                                           | ECO classification of opening.                                   | `"Sicilian Defense: Najdorf Variation"` |
| `eco_code`        | Character | `opening.eco`                                            | ECO (Encyclopaedia of Chess Openings) code.                      | `"B90"`                                 |
| `moves`           | Integer   | `moves`                                                  | Number of full moves played.                                     | `67`                                    |
| `accuracy`        | Numeric   | `analysis.accuracy`                                      | Engine-calculated accuracy percentage.                           | `88.7`                                  |
| `avg_move_time`   | Numeric   | Derived                                                  | Average time per move (seconds).                                 | `1.3`                                   |
| `datetime`        | POSIXct   | `createdAt`                                              | Timestamp of game (UTC).                                         | `"2024-05-23 17:42:00"`                 |

### 1.4 Data Processing Notes

- Converted timestamps using `lubridate::ymd_hms()`.  
- Derived `rating_post = rating_pre + rating_diff`.  
- Created binary field `result = ifelse(winner == color, 1, 0)`.  
- Filtered games where `rated == TRUE` and `speed %in% c("blitz", "rapid", "classical")`.  
- Some games may lack `accuracy` data if engine analysis was unavailable.  
- All variables converted to lowercase snake_case naming convention.


### 1.5 Limitations

- Missing fields for unanalysed or aborted games.  
- Rate limits apply: max 100 games per call unless using bulk PGN archives.  
- Accuracy scores may differ slightly based on version of Lichess analysis engine.  
- Some users have private accounts that limit accessible data.


## 2. FIDE Ratings API Dataset

### 2.1 General Description

The **FIDE Ratings API** (and downloadable monthly rating lists) provide official player-level data for all registered international players.  
Data include rating history, titles, federation, gender, and number of games used in the rating period.

Data were collected from: [https://ratings.fide.com/download_lists.phtml](https://ratings.fide.com/download_lists.phtml) or via the API endpoint (for recent ratings): [https://ratings.fide.com/api_list_players](https://ratings.fide.com/api_list_players)


### 2.2 Dataset Dimensions

| Dimension                | Description                         |
| ------------------------ | ----------------------------------- |
| **Unit of observation:** | Individual player per rating period |
| **Granularity:**         | Player-level monthly rating record  |
| **Typical sample size:** | ~400,000 players per month          |
| **Number of variables:** | 8–10 structured fields              |
| **Time coverage:**       | Monthly updates since 2001          |
| **Source format:**       | CSV / XLSX                          |


### 2.3 Variable Dictionary

| Variable Name     | Type      | Source Field      | Description                               | Example             |
| ----------------- | --------- | ----------------- | ----------------------------------------- | ------------------- |
| `fide_id`         | Character | `fideid`          | Unique identifier assigned by FIDE.       | `"1503014"`         |
| `player_name`     | Character | `name`            | Player’s full name (surname, given name). | `"CARLSEN, Magnus"` |
| `title`           | Factor    | `title`           | FIDE title: GM, IM, FM, WGM, WIM, etc.    | `"GM"`              |
| `country`         | Factor    | `country`         | Three-letter country code (ISO/FIDE).     | `"NOR"`             |
| `gender`          | Factor    | `sex`             | Player gender: M / F.                     | `"M"`               |
| `rating_standard` | Integer   | `rating_standard` | Standard rating (classical).              | `2830`              |
| `rating_rapid`    | Integer   | `rating_rapid`    | Rapid rating.                             | `2820`              |
| `rating_blitz`    | Integer   | `rating_blitz`    | Blitz rating.                             | `2885`              |
| `games_played`    | Integer   | `games`           | Number of rated games in that period.     | `12`                |
| `birth_year`      | Integer   | `birth_year`      | Player’s birth year.                      | `1990`              |
| `inactive_flag`   | Logical   | `inactive_flag`   | TRUE if player is currently inactive.     | `FALSE`             |


### 2.4 Data Processing Notes

- Downloaded `.csv` file from FIDE monthly list (April 2025).  
- Renamed all fields to lowercase snake_case.  
- Removed inactive players for primary analysis.  
- Calculated `age = 2025 - birth_year` for correlation analyses.  
- Joined to Lichess dataset using derived `player_name` or country-level aggregation.  
- Filtered to titles `GM`, `IM`, `FM`, `CM` for focused skill-level comparisons.


### 2.5 Limitations

- Name matching between FIDE and Lichess is approximate; usernames do not always correspond.  
- Ratings represent different pools (online vs. over-the-board), so direct comparison must be normalized.  
- Some players are missing gender or title information.  
- Data availability varies month-to-month due to federation updates.

## 3. Data Files

### 3.1. `lichess_clean.csv` (527 records)

**Description:** User-level aggregated statistics from Lichess games  
**Unit of Observation:** Individual Lichess user  
**Time Period:** October 2025  

**Key Variables:**
- `user` - Lichess username
- `avg_rating` - Mean rating across all games
- `min_rating`, `max_rating` - Rating range
- `rating_volatility` - Standard deviation of ratings
- `win_rate` - Proportion of games won
- `total_games` - Number of games in sample
- `pct_bullet`, `pct_blitz`, `pct_rapid`, `pct_classical` - Time control distribution
- `days_active` - Activity duration
- `rating_tier` - Skill classification (e.g., Expert, Master)
- `activity_level` - Low/Medium/High based on games played
- `preferred_time_control` - Dominant time format

**Use Cases:**
- Cross-sectional analysis of rating distributions
- Activity patterns by skill level
- Time control preferences

### 3.2. `lichess_games_raw.csv` (7,766 records)

**Description:** Individual game-level data from Lichess API  
**Unit of Observation:** Single chess game  
**Time Period:** October 12-15, 2025  

**Key Variables:**
- `user` - Player username
- `id` - Unique game identifier
- `rated` - Whether game affected ratings (TRUE/FALSE)
- `speed` - Time control (bullet/blitz/rapid/classical)
- `color` - Player's color (White/Black)
- `winner` - Game outcome (white/black/draw)
- `result` - Binary win indicator (1=win, 0=loss/draw)
- `rating_pre` - Rating before game
- `rating_diff` - Rating change from game
- `rating_post` - Rating after game
- `opponent_rating` - Opponent's pre-game rating
- `datetime` - Game timestamp (UTC)

**Use Cases:**
- Game-level outcome analysis
- Rating trajectory modeling
- Win probability vs. rating differential
- Temporal activity patterns

### 3.3. `lichess_rating_history.csv` (1,173 records)

**Description:** Longitudinal rating data for sample users across multiple time controls  
**Unit of Observation:** User-category-week combination  
**Time Period:** Starting January 2013  

**Key Variables:**
- `user` - Player username (Magnus_Carlsen, Hikaru, GothamChess, Anna_Chess, ChessNetwork)
- `category` - Time control (Blitz/Rapid/Bullet/Classical)
- `date_index` - Sequential week number (relative to 2013-01-01)
- `rating` - Rating at that time point
- `date` - Calculated date (2013-01-01 + `date_index` weeks)

**Use Cases:**
- Longitudinal growth curve modeling (Appendix B)
- Rating volatility over time
- Learning trajectory analysis
- Cross-category skill transfer

**Note:** This file contains sample/simulated data for users where API data was unavailable.

### 3.4. `fide_clean.csv` (950 records)

**Description:** FIDE (over-the-board) player ratings and metadata  
**Unit of Observation:** Individual FIDE-registered player  
**Rating Period:** Current (simulated for comparison)  

**Key Variables:**
- `fide_id` - Unique FIDE identifier
- `player_name` - Player name (format: "Player_[tier]_[number]")
- `title` - FIDE title (GM/IM/FM/None)
- `country` - Federation code
- `gender` - M/F
- `birth_year` - Year of birth
- `rating_standard` - Classical rating
- `rating_rapid` - Rapid rating
- `rating_blitz` - Blitz rating
- `games_played` - Number of rated games in period
- `federation_rating` - Weighted federation average
- `rating_group` - Tier classification (Under 1600, 1600-1999, 2000-2399, etc.)
- `age` - Calculated age
- `active_status` - Active/Inactive
- `performance_category` - Skill description (Club Player, Expert, Master, etc.)

**Use Cases:**
- Cross-platform rating comparison with Lichess
- Title attainment analysis
- Age-performance relationships
- Federation-level statistics

### 3.5. `player_summary.csv` (6 records)

**Description:** Aggregated comparison statistics by rating tier  
**Unit of Observation:** Rating tier group  
**Dimensions:** Rating groups × platform comparison metrics  

**Key Variables:**

**Lichess Metrics:**
- `lichess_players` - Count of users in tier
- `lichess_avg_rating` - Mean rating
- `lichess_rating_sd` - Standard deviation
- `lichess_avg_games` - Average games per user
- `lichess_avg_win_rate` - Mean win percentage
- `pct_high_activity`, `avg_days_active` - Activity metrics
- `pct_prefer_blitz`, `pct_prefer_rapid`, `pct_prefer_bullet` - Time control preferences

**FIDE Metrics:**
- `fide_players` - Count of players in tier
- `fide_avg_rating_standard` - Mean classical rating
- `fide_avg_rating_blitz` - Mean blitz rating
- `fide_rating_sd` - Standard deviation
- `fide_avg_games` - Average games played
- `fide_pct_titled` - Proportion with titles (GM/IM/FM)
- `fide_pct_active` - Proportion currently active
- `fide_avg_age` - Mean age of players

**Comparison Metrics:**
- `total_players` - Combined count across platforms
- `rating_gap_standard` - Difference (Lichess - FIDE classical)
- `rating_gap_blitz` - Difference in blitz ratings
- `activity_ratio` - Lichess games / FIDE games
- `platform_preference` - Classification (Lichess-Heavy, Balanced, FIDE-Heavy)

**Use Cases:**
- Summary statistics for presentations (Appendix A)
- Rating inflation comparison
- Platform activity patterns
- Demographic differences

## 4. Key Insights
- **Rating Coverage**: 969 - 3380 (Lichess), 801 - 3169 (FIDE)
- **Platform Differences**: Cross-platform rating analysis available
- **Time Controls**: Full spectrum from bullet (1-2 min) to classical (90+ min)
- **Activity Levels**: 0% users classified as high/very high activity

## 5. Citation and Licensing

- **Lichess Data:** © Lichess.org. Public Domain (CC0). [https://lichess.org/api](https://lichess.org/api)  
- **FIDE Data:** © Fédération Internationale des Échecs. Public Data for Research Use. [https://ratings.fide.com/download_lists.phtml](https://ratings.fide.com/download_lists.phtml)

## 6. Reproducibility Notes

All datasets were cleaned and documented using R (version 4.3.2) with the following packages:
- `tidyverse` (data wrangling and visualization)
- `jsonlite` (API parsing)
- `lubridate` (datetime conversion)
- `skimr` (data profiling)

Scripts are available in `/extra/scripts/data_cleaning.R` and `/extra/scripts/data_import.R`.
