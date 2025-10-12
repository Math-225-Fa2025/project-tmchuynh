# Codebook: Lichess API and FIDE Ratings API
_Last updated: April 2025_  
_Author: Tina Huynh_

## 1. Overview

This document provides metadata and variable definitions for datasets obtained from the **Lichess Public API** and the **FIDE Ratings API**.
The codebook outlines dataset dimensions, field types, and example values to ensure analytical reproducibility and transparency.

---

## 2. Lichess Public API Dataset

### 2.1 General Description

The **Lichess API** is a RESTful interface that provides public access to millions of chess games, player profiles, and rating histories.
Data were retrieved via the endpoint: [https://lichess.org/api/games/user/{username}?max=100&analysed=true](https://lichess.org/api/games/user/{username}?max=100&analysed=true)


This dataset contains **game-level records** for a single player, including metadata such as ratings, results, openings, and timestamps.
All data are published under the **Creative Commons CC0 Public Domain license**.


### 2.2 Dataset Dimensions

| Dimension                | Description                                                        |
|--------------------------|--------------------------------------------------------------------|
| **Unit of observation:** | Individual game                                                    |
| **Granularity:**         | Game-level metadata (1 record per completed game)                  |
| **Typical sample size:** | 100–10,000 games per player (depending on request parameters)      |
| **Number of variables:** | ~15–20 structured fields                                           |
| **Time coverage:**       | User-defined (e.g., last 12 months)                                |
| **Source format:**       | JSON (converted to tabular form using `jsonlite::fromJSON()` in R) |


### 2.3 Variable Dictionary

| Variable Name | Type      | JSON Path                                                | Description                                                      | Example      |
|---------------|-----------|----------------------------------------------------------|------------------------------------------------------------------|--------------|
| `game_id`     | Character | `id`                                                     | Unique identifier for each game.                                 | `"3n8y6FzQ"` |
| `rated`       | Logical   | `rated`                                                  | Indicates whether the game affected player ratings.              | `TRUE`       |
| `speed`       | Factor    | `speed`                                                  | Time control category (`bullet`, `blitz`, `rapid`, `classical`). | `"blitz"`    |
| `time_limit`  | Integer   | `clock.initial`                                          | Initial time control per player (seconds).                       | `180`        |
| `increment`   | Integer   | `clock.increment`                                        | Time increment per move (seconds).                               | `2`          |
| `color`       | Factor    | Derived                                                  | Player’s color in this game (`White`, `Black`).                  | `"White"`    |
| `winner`      | Factor    | `winner`                                                 | Color of the winner (`white`, `black`), or missing for draws.    | `"white"`    |
| `result`      | Numeric   | Derived                                                  | Binary variable (1 = win, 0 = loss/draw).                        | `1`          |
| `rating_pre`  | Integer   | `players.white.rating` or `players.black.rating`         | Player’s rating before game.                                     | `1850`       |
| `rating_diff` | Integer   | `players.white.ratingDiff` or `players.black.ratingDiff` | Rating change from the game.                                     | `+4`         |
| `rating_post` | Integer   | Derived                                                  | Rating after game (`rating_pre + rating_diff`).                  | `1854`       |
| `opponent_rating` | Integer | Opponent’s pre-game rating. | `1830` |
| `opening_name` | Character | `opening.name` | ECO classification of opening. | `"Sicilian Defense: Najdorf Variation"` |
| `eco_code` | Character | `opening.eco` | ECO (Encyclopaedia of Chess Openings) code. | `"B90"` |
| `moves` | Integer | `moves` | Number of full moves played. | `67` |
| `accuracy` | Numeric | `analysis.accuracy` | Engine-calculated accuracy percentage. | `88.7` |
| `avg_move_time` | Numeric | Derived | Average time per move (seconds). | `2.3` |
| `datetime` | POSIXct | `createdAt` | Timestamp of game (UTC). | `"2024-05-23 17:42:00"` |


- Missing fields for unanalysed or aborted games.  
- Rate limits apply: max 100 games per call unless using bulk PGN archives.  
- Accuracy scores may differ slightly based on version of Lichess analysis engine.  
- Some users have private accounts that limit accessible data.

---

## 3. FIDE Ratings API Dataset

### 3.1 General Description

The **FIDE Ratings API** (and downloadable monthly rating lists) provide official player-level data for all registered international players.  
Data include rating history, titles, federation, gender, and number of games used in the rating period.

Data were collected from: [https://ratings.fide.com/download_lists.phtml](https://ratings.fide.com/download_lists.phtml) or via the API endpoint (for recent ratings): [https://ratings.fide.com/api_list_players](https://ratings.fide.com/api_list_players)


### 3.2 Dataset Dimensions

| Dimension                | Description                         |
|--------------------------|-------------------------------------|
| **Unit of observation:** | Individual player per rating period |
| **Granularity:**         | Player-level monthly rating record  |
| **Typical sample size:** | ~400,000 players per month          |
| **Number of variables:** | 8–10 structured fields              |
| **Time coverage:**       | Monthly updates since 2001          |
| **Source format:**       | CSV / XLSX                          |


### 3.3 Variable Dictionary

| Variable Name     | Type      | Source Field      | Description                               | Example             |
|-------------------|-----------|-------------------|-------------------------------------------|---------------------|
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



- Name matching between FIDE and Lichess is approximate; usernames do not always correspond.  
- Ratings represent different pools (online vs. over-the-board), so direct comparison must be normalized.  
- Some players are missing gender or title information.  
- Data availability varies month-to-month due to federation updates.

---

## 4. Combined Dataset Summary

| Dataset      | Observation Unit | # Records (Typical Sample) | # Variables | Primary Join Key           |
|--------------|------------------|----------------------------|-------------|----------------------------|
| Lichess API  | Game             | 10,000                     | 18          | `player_id`                |
| FIDE Ratings | Player           | 400,000                    | 10          | `player_name` or `country` |

---

## 5. Citation and Licensing

- **Lichess Data:** © Lichess.org. Public Domain (CC0). [https://lichess.org/api](https://lichess.org/api)  
- **FIDE Data:** © Fédération Internationale des Échecs. Public Data for Research Use. [https://ratings.fide.com/download_lists.phtml](https://ratings.fide.com/download_lists.phtml)

---

## 6. Reproducibility Notes

All datasets were cleaned and documented using R (version 4.3.2) with the following packages:
- `tidyverse` (data wrangling and visualization)
- `jsonlite` (API parsing)
- `lubridate` (datetime conversion)
- `skimr` (data profiling)

Scripts are available in `/extra/scripts/data_cleaning.R` and `/extra/scripts/data_import.R`.