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