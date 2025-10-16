# Data Collection and Processing Scripts
_Last updated: October 2025_  
_Author: Tina Huynh_

## Overview

This directory contains R scripts and utilities for collecting, processing, and managing chess rating data from the Lichess API. The scripts support OAuth authentication, rate-limited API calls, and reproducible data collection workflows.

**Key Capabilities:**
- Lichess API data collection with authentication
- Random sampling across rating tiers
- Rate-limiting and exponential backoff
- Automatic data cleaning and aggregation
- FIDE data simulation for comparison

---

## Files

### 1. `data_import.R` (1,447 lines)

**Primary data collection and processing pipeline**

**Purpose:**
- Comprehensive Lichess data collection from public API
- Samples 500-900 random users across all rating tiers
- Aggregates game-level data into user summaries
- Generates cleaned datasets for analysis

**Key Features:**
- OAuth 2.0 authentication with personal access tokens
- Environment variable management via `.env` files
- Rate-limited API calls with exponential backoff
- Progress tracking and timing metrics
- Automatic path resolution for output files
- Reproducible sampling (seed = 42)

**Functions:**
- `load_dotenv()` - Loads environment variables from `.env` file
- `get_user_games()` - Fetches games for a specific user
- `sample_users_from_leaderboard()` - Random sampling from rating tiers
- `aggregate_user_stats()` - Calculates per-user summary statistics
- `generate_fide_comparison()` - Creates simulated FIDE data

**Outputs:**
- `../../data/lichess_clean.csv` - User-level aggregates (527 records)
- `../../data/lichess_games_raw.csv` - Game-level data (7,766 records)
- `../../data/fide_clean.csv` - Simulated FIDE data (950 records)
- `../../data/player_summary.csv` - Tier-level comparisons (6 records)

**Usage:**
```bash
# From extra/scripts directory
Rscript data_import.R

# Or source in R session
source("data_import.R")
```

**Requirements:**
- R 4.2+
- Packages: `tidyverse`, `httr`, `jsonlite`, `lubridate`, `digest`, `base64enc`
- Lichess personal access token (optional, for higher rate limits)

**Configuration:**
- Edit `.env` file in `extra/` directory
- Set `LICHESS_ACCESS_TOKEN=lip_your_token_here`
- See `../OAUTH_SETUP.md` for detailed instructions

---

### 2. `data_import_backup.R` (1,447 lines)

**Backup copy of data collection pipeline**

**Purpose:**
- Identical to `data_import.R`
- Serves as version control backup
- Allows testing changes without breaking working version

**Usage:**
Same as `data_import.R` - can be used interchangeably

**Note:** This file should be kept in sync with `data_import.R` or removed if using proper version control (git).

---

### 3. `oauth_helper.R` (240 lines)

**OAuth token management and validation utility**

**Purpose:**
- Interactive setup for Lichess OAuth tokens
- Token validation and testing
- Multi-location token discovery (.env, .Renviron, environment)

**Key Features:**
- Interactive token setup wizard
- Automatic token validation via API test
- Saves tokens to `.env` file
- Checks multiple configuration locations

**Functions:**
- `load_dotenv()` - Loads environment variables from multiple paths
- `test_token(token)` - Validates token against Lichess API
- `get_token()` - Discovers token from various sources
- `setup_token()` - Interactive token configuration
- `main()` - Command-line interface

**Usage:**
```bash
# Interactive setup (guides you through token creation)
Rscript oauth_helper.R setup

# Test existing token
Rscript oauth_helper.R test

# Auto-detect and test
Rscript oauth_helper.R
```

**Authentication Flow:**
1. Directs user to Lichess OAuth page
2. User creates personal access token
3. User pastes token into script
4. Script validates token via `/api/account` endpoint
5. Saves token to `.env` file

**API Scopes Required:**
- `preference:read` - Read user preferences
- `challenge:read` - Read challenge information
- `puzzle:read` - Access puzzle data
- `tournament:read` - Read tournament data
- `study:read` - Access studies
- `follow:read` - Read following/followers

---

### 4. `oauth_examples.R` (240 lines)

**Example code for OAuth authentication and API usage**

**Purpose:**
- Demonstrates token setup methods
- Shows how to use authenticated API calls
- Provides working examples for common tasks

**Contents:**
- **Example 1:** Personal access token setup
- **Example 2:** Token validation
- **Example 3:** Authenticated API requests
- **Example 4:** Rate-limited data collection
- **Example 5:** Error handling patterns

**Usage:**
```r
# Source to load examples
source("oauth_examples.R")

# Run specific example
example_personal_token()
example_authenticated_request()
```

**Use Cases:**
- Learning how to integrate OAuth into your own scripts
- Testing authentication setup
- Understanding rate limit handling
- Debugging API connection issues

---

### 5. `setup.sh` (100 lines)

**Bash script for quick environment setup**

**Purpose:**
- Automated setup of OAuth configuration
- Creates `.env` file from template
- Validates setup and tests token

**Features:**
- Directory validation
- `.env` file creation from `.env.example`
- Interactive token entry
- Cross-platform compatibility (Linux/macOS)
- Automatic token testing

**Usage:**
```bash
# From extra/scripts directory
./setup.sh

# Or with explicit bash
bash setup.sh
```

**What it does:**
1. Checks you're in correct directory
2. Creates `.env` from `.env.example` if needed
3. Prompts for Lichess token
4. Validates token format (starts with `lip_`)
5. Saves token to `.env` file
6. Tests token via `oauth_helper.R`

**Platform Support:**
- Linux (uses `sed -i`)
- macOS (uses `sed -i ''`)
- Detects OS automatically

---

## Workflow

### Initial Setup (One-time)

```bash
# 1. Navigate to scripts directory
cd extra/scripts

# 2. Run setup script
./setup.sh

# 3. Follow prompts to enter Lichess token
# Token URL: https://lichess.org/account/oauth/token
```

### Data Collection

```bash
# From extra/scripts directory
Rscript data_import.R
```

**Expected Output:**
```
✅ Loaded environment variables from .env
🚀 Starting Lichess data collection...
📊 Sampling users from leaderboards...
   ✓ Collected 150 users from Bullet leaderboard
   ✓ Collected 127 users from Blitz leaderboard
   ...
📦 Processing user games...
   Progress: [========================================] 100%
✅ Data collection complete!
   - 527 users processed
   - 7,766 games collected
   - Time elapsed: 8.3 minutes
```

### Token Management

```bash
# Test existing token
Rscript oauth_helper.R test

# Set up new token
Rscript oauth_helper.R setup

# Check token location
grep LICHESS_ACCESS_TOKEN ../.env
```

---

## Configuration Files

### `.env` (in `extra/` directory)

```bash
# Lichess API Configuration
LICHESS_ACCESS_TOKEN=lip_your_token_here

# Optional: Rate limiting
API_RATE_LIMIT=60
API_TIMEOUT=30
```

### Environment Variables

| Variable               | Description                 | Default | Required  |
| ---------------------- | --------------------------- | ------- | --------- |
| `LICHESS_ACCESS_TOKEN` | OAuth personal access token | None    | Optional* |
| `API_RATE_LIMIT`       | Max requests per minute     | 60      | No        |
| `API_TIMEOUT`          | Request timeout (seconds)   | 30      | No        |

*Required for higher rate limits and authenticated endpoints. Public API access works without token but is more limited.

---

## Output Files

All scripts write to `../../data/` directory:

| File                    | Creator         | Records | Description          |
| ----------------------- | --------------- | ------- | -------------------- |
| `lichess_clean.csv`     | `data_import.R` | 527     | User-level summaries |
| `lichess_games_raw.csv` | `data_import.R` | 7,766   | Individual games     |
| `fide_clean.csv`        | `data_import.R` | 950     | Simulated FIDE data  |
| `player_summary.csv`    | `data_import.R` | 6       | Tier comparisons     |

See `../../data/README.md` for detailed file descriptions.

---

## Error Handling

### Common Issues

**1. Token not found**
```
🔍 No token found. You need to create one.
```
**Solution:** Run `Rscript oauth_helper.R setup`

**2. Rate limit exceeded**
```
⚠️ Rate limit exceeded. Waiting 60s...
```
**Solution:** Script automatically retries with exponential backoff

**3. Invalid token**
```
❌ Token invalid or expired (HTTP 401)
```
**Solution:** Create new token at https://lichess.org/account/oauth/token

**4. API timeout**
```
❌ Error: Timeout was reached
```
**Solution:** Check internet connection, increase `API_TIMEOUT` in `.env`

### Debug Mode

Enable verbose logging:
```r
# In data_import.R
DEBUG_MODE <- TRUE
```

---

## Rate Limiting

### Default Limits (Without Token)
- **Anonymous API:** 100 requests/minute
- **Timeout:** 30 seconds per request
- **Backoff:** Exponential (2s → 4s → 8s → 16s)

### With Personal Access Token
- **Authenticated API:** 300 requests/minute
- **Higher priority** in Lichess queue
- **Access to user-specific** endpoints

### Best Practices
1. Always use exponential backoff
2. Add random jitter to retry delays
3. Monitor response headers for rate limit info
4. Use bulk endpoints when available
5. Cache results to avoid duplicate requests

---

## Reproducibility

### Seed Management
```r
# All scripts use consistent seed
set.seed(42)

# This ensures:
# - Same random user samples
# - Identical simulated FIDE data
# - Reproducible train/test splits
```

### Version Control
- Git tracking recommended for all scripts
- `.env` files should be in `.gitignore`
- Use `.env.example` as template for sharing

### Documentation
- All functions include inline comments
- Parameter descriptions in function headers
- Output formats documented in code

---

## Dependencies

### R Packages
```r
# Core
tidyverse (dplyr, ggplot2, tidyr, readr, purrr)
lubridate
jsonlite

# API
httr
curl

# Security
digest      # PKCE code challenges
base64enc   # Base64 encoding for OAuth
```

### Installation
```r
install.packages(c(
  "tidyverse", "httr", "jsonlite", 
  "lubridate", "digest", "base64enc"
))
```

---

## Security Notes

### Token Safety
- **Never commit** `.env` files to git
- **Never share** tokens in public repositories
- **Rotate tokens** regularly (every 3-6 months)
- **Use minimal scopes** required for your analysis

### `.gitignore` Recommendations
```
# OAuth tokens and sensitive data
.env
.Renviron
*.token

# Generated data (if large)
data/*.csv
```

### Token Revocation
If token is compromised:
1. Go to https://lichess.org/account/oauth/token
2. Delete the compromised token
3. Create new token with `setup.sh`
4. Update `.env` file

---

## Additional Resources

- **Lichess API Documentation:** https://lichess.org/api
- **OAuth Setup Guide:** `../OAUTH_SETUP.md`
- **Data File Documentation:** `../../data/README.md`
- **Project Codebook:** `../../data/codebook.md`

---

## Maintenance

### Update Schedule
- **Weekly:** Check for Lichess API changes
- **Monthly:** Rotate OAuth tokens
- **Quarterly:** Review rate limit policies
- **Annually:** Update R package dependencies

### Testing
```bash
# Test authentication
Rscript oauth_helper.R test

# Test data collection (dry run)
Rscript data_import.R --test

# Validate outputs
Rscript -e "source('data_import.R'); validate_outputs()"
```

---

## Contact

For issues or questions:
- Check `../README_OAUTH.md` for OAuth troubleshooting
- Review Lichess API docs for endpoint changes
- File issues in project repository
