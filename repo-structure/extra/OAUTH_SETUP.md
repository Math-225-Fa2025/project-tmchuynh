# Lichess OAuth Authentication Setup

This guide explains how to set up OAuth authentication for the Lichess data collection script.

## Quick Start (Personal Access Token - Recommended)

### 1. Create a Personal Access Token

1. **Go to Lichess token page**: https://lichess.org/account/oauth/token
2. **Click "New personal access token"**
3. **Enter a description**: e.g., "Data Science Research Project"
4. **Select the following scopes**:
   - `preference:read` - Read preferences
   - `challenge:read` - Read incoming challenges
   - `puzzle:read` - Read puzzle activity
   - `tournament:read` - Read tournament participation
   - `study:read` - Read studies
   - `follow:read` - Read followed players

5. **Click "Create"**
6. **Copy the generated token** (starts with `lip_`)

### 2. Set Up the Token in R

**Option A: Environment Variable (Recommended)**
```r
# Set for current session
Sys.setenv(LICHESS_ACCESS_TOKEN = "lip_your_token_here")

# Or add to your .Renviron file for permanent setup
# Edit ~/.Renviron and add:
# LICHESS_ACCESS_TOKEN=lip_your_token_here
```

**Option B: Direct Input**
```r
# The script will prompt you to enter the token interactively
# when it runs and no token is found
```

### 3. Run the Data Collection Script

```r
source("data_import.R")
```

The script will automatically:
- Detect your access token
- Test its validity
- Use authenticated requests for better rate limits
- Collect data with enhanced access

## Advanced Setup (OAuth2 Flow)

For applications that need to authenticate multiple users:

### 1. Register Your Application

1. Contact Lichess support or use their OAuth documentation
2. Get a `client_id` for your application
3. Set up a redirect URI

### 2. Use OAuth2 Flow in R

```r
# Set your client configuration
client_id <- "your_app_client_id"
redirect_uri <- "http://localhost:8080/callback"  # Your callback URL

# Generate authorization URL
auth_url <- generate_auth_url(
  client_id = client_id,
  redirect_uri = redirect_uri,
  scopes = c("preference:read", "challenge:read", "puzzle:read")
)

# Send user to this URL
cat("Go to this URL to authorize:\n", auth_url, "\n")

# After user authorizes, they'll be redirected with a code
# Extract the code from the redirect URL and exchange it:
access_token <- exchange_code_for_token(
  client_id = client_id,
  redirect_uri = redirect_uri,
  auth_code = "code_from_redirect"
)
```

## Benefits of OAuth Authentication

### Without Authentication (Anonymous)
- ✅ Basic API access
- ❌ Rate limited to 20 requests/minute
- ❌ Limited game export (max 20 games per request)
- ❌ No access to user preferences or private data

### With Personal Access Token
- ✅ Higher rate limits (30+ requests/minute)
- ✅ Larger game exports (up to 60 games per request for own games)
- ✅ Access to user-specific data
- ✅ More reliable data collection
- ✅ Priority in API queues

## Security Best Practices

### Personal Access Tokens
- **Never commit tokens to version control**
- **Use environment variables or secure storage**
- **Rotate tokens periodically**
- **Limit scopes to minimum required**
- **Revoke unused tokens**

### OAuth2 Applications
- **Store client secrets securely**
- **Use HTTPS for redirect URIs**
- **Validate state parameters**
- **Implement proper error handling**

## Troubleshooting

### Token Issues

**Invalid Token Error:**
```r
# Test your token
test_access_token("lip_your_token_here")

# If invalid, create a new one at:
# https://lichess.org/account/oauth/token
```

**Rate Limiting:**
```r
# Even with auth, respect rate limits
# The script includes automatic delays
# For heavy usage, consider:
# - Smaller batch sizes
# - Longer delays between requests
# - Caching results
```

**Scope Errors:**
```r
# Ensure your token has required scopes:
# - preference:read
# - challenge:read  
# - puzzle:read
# - tournament:read
# - study:read
# - follow:read
```

### Network Issues

**Timeout Errors:**
- Check internet connection
- Lichess API may be experiencing high load
- Try again later or reduce batch size

**SSL/HTTPS Issues:**
- Update R and httr packages
- Check firewall settings

## API Endpoints Used

The script accesses these Lichess API endpoints with authentication:

1. **User Data**: `/api/games/user/{username}` 
   - Enhanced rate limits with auth
   - More games per request

2. **User Profile**: `/api/user/{username}`
   - Public data access
   - Some fields require auth

3. **Leaderboards**: `/api/player/top/{nb}/{perfType}`
   - Public access
   - Auth provides priority

4. **Account Info**: `/api/account` (with token)
   - Validates token
   - Gets authenticated user info

## Sample Environment Setup

Create a `.Renviron` file in your project directory:

```bash
# Lichess API Configuration
LICHESS_ACCESS_TOKEN=lip_your_actual_token_here
LICHESS_CLIENT_ID=your_app_client_id
```

Then restart R and your tokens will be automatically loaded.

## Rate Limits Summary

| Authentication  | Rate Limit | Games/Request  | Priority |
| --------------- | ---------- | -------------- | -------- |
| None            | 20/min     | 20             | Low      |
| Personal Token  | 30/min     | 60 (own games) | Normal   |
| OAuth2 App      | 30/min     | 60             | Normal   |
| Lichess Partner | Higher     | Higher         | High     |

## Getting Help

- **Lichess API Documentation**: https://lichess.org/api
- **OAuth Examples**: https://github.com/lichess-org/api/tree/master/example
- **Discord Support**: https://discord.gg/lichess
- **Email**: contact@lichess.org

---

**Note**: This authentication setup significantly improves the reliability and speed of data collection for your chess research project!