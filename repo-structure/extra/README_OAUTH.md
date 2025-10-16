# Lichess Data Collection with OAuth Authentication

This enhanced version of the data collection script includes full OAuth authentication support for accessing the Lichess API with better rate limits and more comprehensive data access.

## 🚀 Quick Start

### Step 1: Set Up Authentication

**Option A: Use .env File (Recommended)**
```bash
# 1. Copy the example file
cp .env.example .env

# 2. Get your token from https://lichess.org/account/oauth/token
# 3. Edit .env file and replace 'lip_your_token_here' with your actual token

# 4. Use the helper script for setup
cd extra/scripts
Rscript oauth_helper.R setup
```

**Option B: Use Helper Script**
```bash
cd extra/scripts
Rscript oauth_helper.R setup
```
1. Go to https://lichess.org/account/oauth/token
2. Create a new Personal Access Token with these scopes:
   - `preference:read`
   - `challenge:read` 
   - `puzzle:read`
   - `tournament:read`
   - `study:read`
   - `follow:read`
3. Copy the generated token (starts with `lip_`)
4. Set environment variable:
   ```r
   Sys.setenv(LICHESS_ACCESS_TOKEN = "lip_your_token_here")
   ```

### Step 2: Run Data Collection
```r
source("data_import.R")
```

The script will automatically:
- ✅ Detect and test your OAuth token
- ✅ Use authenticated requests for better rate limits
- ✅ Collect more comprehensive data
- ✅ Handle authentication errors gracefully

## 📋 What's New

### OAuth Authentication Features
- **Personal Access Token support** - Easy setup for individual users
- **OAuth2 PKCE flow** - Full implementation for applications
- **Automatic token detection** - From environment variables or `.Renviron`
- **Token validation** - Tests tokens before use
- **Rate limit optimization** - Better performance with authentication
- **Graceful fallback** - Works without auth (with limitations)

### Enhanced Data Collection
- **Higher rate limits**: 30+ requests/minute vs 20 for anonymous
- **Larger data exports**: Up to 60 games per request vs 20
- **Priority access**: Authenticated requests get priority in API queues
- **Extended access**: Some user data requires authentication

### Better Error Handling
- **Connection timeouts**: Automatic retry with exponential backoff
- **Rate limiting**: Smart delays and queue management
- **Invalid tokens**: Clear error messages and recovery steps
- **Network issues**: Robust error handling and user feedback

## 📁 File Structure

```
extra/
├── .env.example             # Environment variable template
├── .env                     # Your actual tokens (git-ignored)
├── .gitignore               # Excludes .env from version control
├── OAUTH_SETUP.md           # Detailed OAuth setup guide
├── README_OAUTH.md          # This comprehensive documentation
├── .Renviron.template       # Alternative R environment setup
├── scripts/
│   ├── data_import.R        # Main data collection script (with OAuth)
│   ├── oauth_helper.R       # Token management utility
│   └── oauth_examples.R     # Usage examples
└── output/
    └── player_summary.csv   # Generated analysis results
```

## 🔐 Authentication Methods

### 1. Personal Access Token (Recommended)
**Best for**: Individual researchers, one-time data collection

**Pros**:
- ✅ Simple setup (5 minutes)
- ✅ No application registration needed
- ✅ Full API access with your account permissions
- ✅ Easy to revoke/rotate
- ✅ Secure storage in .env file

**Cons**:
- ❌ Tied to your personal account
- ❌ Manual setup for each user

```bash
# Quick setup with .env file
cp .env.example .env
# Edit .env file with your token
echo "LICHESS_ACCESS_TOKEN=lip_your_actual_token" > .env
```

### 2. OAuth2 Application Flow
**Best for**: Multi-user applications, production systems

**Pros**:
- ✅ Users authenticate with their own accounts
- ✅ Fine-grained permission control
- ✅ Scalable for multiple users
- ✅ Industry standard security

**Cons**:
- ❌ More complex setup
- ❌ Requires application registration
- ❌ Need to handle redirect flows

```r
# Generate authorization URL
auth_url <- generate_auth_url(
  client_id = "your_app_id",
  redirect_uri = "http://localhost:8080/callback"
)

# Exchange code for token
token <- exchange_code_for_token(
  client_id = "your_app_id",
  redirect_uri = "http://localhost:8080/callback", 
  auth_code = "code_from_callback"
)
```

### 3. Anonymous (No Authentication)
**Best for**: Testing, small-scale experiments

**Limitations**:
- ❌ Low rate limits (20 requests/minute)
- ❌ Limited data access
- ❌ No user-specific data
- ❌ Lower priority in API queues

## 📊 Performance Comparison

| Method         | Rate Limit | Games/Request | Data Access | Setup Time |
| -------------- | ---------- | ------------- | ----------- | ---------- |
| Anonymous      | 20/min     | 20            | Public only | 0 min      |
| Personal Token | 30/min     | 60            | User data   | 5 min      |
| OAuth2 App     | 30/min     | 60            | User data   | 30 min     |

## 🛠️ Advanced Usage

### Custom Rate Limiting
```r
# Set custom delays between requests
Sys.setenv(LICHESS_RATE_LIMIT = "20")  # 20 requests per minute
```

### Bulk Data Collection
```r
# Collect data from specific user lists
user_list <- c("user1", "user2", "user3")
data <- map(user_list, ~get_lichess_data(.x, access_token = token))
```

### Error Recovery
```r
# The script automatically handles:
# - Token expiration (prompts for new token)
# - Rate limiting (adds delays)
# - Network timeouts (retries with backoff)
# - Invalid responses (skips and continues)
```

## 🔧 Troubleshooting

### Common Issues

**"Invalid token" error:**
```bash
# Test your token
Rscript oauth_helper.R test

# If invalid, set up a new one
Rscript oauth_helper.R setup
```

**Rate limiting issues:**
```r
# Reduce batch size
target_users <- 100  # Instead of 500-900

# Add longer delays
Sys.sleep(2)  # Wait 2 seconds between requests
```

**Network timeouts:**
```r
# Check connection
curl -I https://lichess.org/api

# Try with smaller requests
get_lichess_data(username, max_games = 10)  # Instead of 20
```

### Getting Help

- **Test authentication**: `Rscript oauth_helper.R test`
- **Reset tokens**: Remove from `.Renviron` and run setup again
- **API documentation**: https://lichess.org/api
- **Discord support**: https://discord.gg/lichess

## 📈 Data Collection Results

With OAuth authentication, you can expect:

- **2-3x faster collection** due to higher rate limits
- **More complete datasets** with user-specific information
- **Better reliability** with priority API access
- **Reduced errors** from rate limiting

### Sample Output
```
✅ OAuth token obtained successfully!
✅ Token valid for user: your_username
📊 LICHESS DATA: 847 users, 12,450 games collected
🏆 FIDE DATA: 1,123 players across 5 rating groups
⏱️  COLLECTION TIME: 23.4 minutes
📁 OUTPUT LOCATION: /project/data/
```

## 🔒 Security Notes

### .env File Security
- **✅ Use .env files** for local development and personal use
- **✅ .env is git-ignored** automatically to prevent token exposure
- **✅ Copy .env.example** as a template for new setups
- **❌ Never commit .env** files to version control
- **❌ Never share .env** files in chat/email

### Token Management
- **Never commit tokens to version control**
- **Use .env files for secure local storage**
- **Rotate tokens periodically**
- **Limit scopes to minimum required**
- **Monitor token usage in Lichess account settings**

## 📝 License & Usage

This implementation follows Lichess API terms of service:
- Respect rate limits
- Don't abuse the API
- Use data responsibly for research
- Consider giving back to the Lichess community

---

**Ready to collect some chess data? Start with the setup guide above! 🎯**