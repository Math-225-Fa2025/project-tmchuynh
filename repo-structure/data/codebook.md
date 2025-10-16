# Comprehensive Chess Data Analysis Codebook (v4)
_Last updated: 2025-10-15_
_Sample size: 527 Lichess users, 950 FIDE players_

## Overview
This dataset contains comprehensive chess performance data collected from Lichess.org and simulated FIDE data for comparative analysis across all rating tiers.

## Data Collection Methodology
- **Lichess Sampling**: Random sample of 548 users from multiple leaderboards (bullet, blitz, rapid, classical)
- **Rating Coverage**: Users from all skill levels (800-3000+ rating)
- **Rate Limiting**: Implemented exponential backoff and progress tracking
- **Reproducibility**: Seed set to 42 for consistent results

## Files Generated

### lichess_clean.csv (527 users)
User-level aggregated statistics from Lichess games
- `user`: Lichess username
- `avg_rating`: Mean rating across all games
- `min_rating/max_rating`: Rating range
- `rating_volatility`: Standard deviation of ratings
- `win_rate`: Proportion of games won (0-1)
- `total_games`: Number of rated games played
- `pct_bullet/blitz/rapid/classical`: Proportion of games by time control
- `days_active`: Days between first and last game
- `rating_tier`: Categorical skill level (Beginner/Novice/Intermediate/Advanced/Expert)
- `preferred_time_control`: Most frequently played time format

### fide_clean.csv (950 players)
Simulated FIDE player database with realistic distributions
- `fide_id`: 8-digit player identifier
- `player_name`: Generated player name
- `title`: Chess title (None/CM/FM/IM/GM/W*)
- `country`: Player federation
- `rating_standard/rapid/blitz`: Official ratings by time control
- `games_played`: Tournament games in rating calculation
- `age`: Player age
- `active_status`: Active/Inactive based on recent play

### lichess_games_raw.csv (7765 games)
Individual game records for detailed analysis
- `user`: Player username
- `rating_pre/post`: Rating before/after game
- `speed`: Time control (bullet/blitz/rapid/classical)
- `result`: Game outcome from user perspective (1=win, 0.5=draw, 0=loss)
- `color`: Pieces played (White/Black)
- `datetime`: Game timestamp

### player_summary.csv (Cross-platform Analysis)
Comparative statistics by rating group
- `rating_group`: Standardized rating brackets
- `lichess_*`: Lichess platform statistics
- `fide_*`: FIDE statistics for comparison
- `rating_gap_*`: Platform rating differences
- `activity_ratio`: Relative game activity
- `platform_preference`: Categorical platform usage

## Key Insights
- **Rating Coverage**: 969 - 3380 (Lichess), 801 - 3169 (FIDE)
- **Platform Differences**: Cross-platform rating analysis available
- **Time Controls**: Full spectrum from bullet (1-2 min) to classical (90+ min)
- **Activity Levels**: 0% users classified as high/very high activity

## Usage Notes
- All ratings are Elo-based but may have different scales across platforms
- FIDE data is simulated but follows realistic distributions
- Rate limiting ensures ethical API usage
- Missing data handled with appropriate filters

## Reproducibility
```r
# To reproduce this analysis:
source('data_import.R')
# All randomization uses seed=42
```
