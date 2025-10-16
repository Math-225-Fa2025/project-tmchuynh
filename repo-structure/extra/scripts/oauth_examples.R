#!/usr/bin/env Rscript

############################################################
# Example: OAuth Setup and Data Collection
# Demonstrates how to use the enhanced authentication
############################################################

# Load required libraries
library(tidyverse)
library(httr)
library(jsonlite)

# Source the main script (this loads all OAuth functions)
source("data_import.R")

############################################################
# EXAMPLE 1: PERSONAL ACCESS TOKEN SETUP
############################################################

example_personal_token <- function() {
  cat("=== PERSONAL ACCESS TOKEN EXAMPLE ===\n")

  # Method 1: Set token directly
  # Get your token from: https://lichess.org/account/oauth/token
  token <- "lip_your_token_here" # Replace with your actual token
  Sys.setenv(LICHESS_ACCESS_TOKEN = token)

  # Method 2: Use the helper script
  # system("Rscript oauth_helper.R setup")

  # Test the token
  if (test_access_token(token)) {
    cat("✅ Token is valid! Ready for data collection.\n")

    # Collect sample data
    sample_user <- "magnus" # Example user
    user_data <- get_lichess_data(
      sample_user,
      max_games = 10,
      access_token = token
    )

    if (!is.null(user_data) && nrow(user_data) > 0) {
      cat("📊 Collected", nrow(user_data), "games for user:", sample_user, "\n")
      print(head(user_data))
    }
  } else {
    cat("❌ Token is invalid. Please check your token.\n")
  }
}

############################################################
# EXAMPLE 2: OAUTH2 APPLICATION FLOW
############################################################

example_oauth2_flow <- function() {
  cat("\n=== OAUTH2 APPLICATION FLOW EXAMPLE ===\n")

  # Your OAuth2 application settings
  client_id <- "your_app_client_id" # Get from Lichess
  redirect_uri <- "http://localhost:8080/callback"

  # Step 1: Generate authorization URL
  auth_url <- generate_auth_url(
    client_id = client_id,
    redirect_uri = redirect_uri,
    scopes = c("preference:read", "puzzle:read", "tournament:read")
  )

  cat("🔗 Authorization URL:\n")
  cat(auth_url, "\n\n")
  cat("👤 Send users to this URL to authorize your application.\n")
  cat("🔄 After authorization, they'll be redirected to your callback URL.\n")

  # Step 2: Extract code from callback (example)
  # In a real application, you'd extract this from the redirect URL
  example_code <- "authorization_code_from_callback"

  # Step 3: Exchange code for token
  tryCatch(
    {
      access_token <- exchange_code_for_token(
        client_id = client_id,
        redirect_uri = redirect_uri,
        auth_code = example_code
      )

      cat("✅ Access token obtained:", substr(access_token, 1, 20), "...\n")
    },
    error = function(e) {
      cat("❌ Token exchange failed:", e$message, "\n")
      cat("ℹ️  This is expected in the example since the code is fake.\n")
    }
  )
}

############################################################
# EXAMPLE 3: ENHANCED DATA COLLECTION
############################################################

example_enhanced_collection <- function() {
  cat("\n=== ENHANCED DATA COLLECTION EXAMPLE ===\n")

  # Get access token (from environment or setup)
  access_token <- get_access_token(interactive = FALSE)

  if (!is.null(access_token)) {
    cat("🔑 Using authenticated requests\n")

    # Collect data with better rate limits
    sample_users <- c("magnuscarlsen", "hikaru", "gothamchess")

    all_data <- list()

    for (user in sample_users) {
      cat("📊 Collecting data for:", user, "\n")

      # Enhanced data collection with OAuth
      user_data <- get_lichess_data(
        username = user,
        max_games = 30, # More games with auth
        access_token = access_token
      )

      if (!is.null(user_data) && nrow(user_data) > 0) {
        all_data[[user]] <- user_data
        cat("   ✅ Collected", nrow(user_data), "games\n")
      } else {
        cat("   ❌ No data collected\n")
      }

      # Shorter delay with authentication
      Sys.sleep(0.5)
    }

    # Combine and analyze
    if (length(all_data) > 0) {
      combined_data <- bind_rows(all_data, .id = "user")
      cat("\n📈 TOTAL GAMES COLLECTED:", nrow(combined_data), "\n")

      # Quick analysis
      summary_stats <- combined_data %>%
        group_by(user) %>%
        summarise(
          games = n(),
          avg_rating = round(mean(rating_pre, na.rm = TRUE), 0),
          win_rate = round(mean(result, na.rm = TRUE), 3),
          .groups = "drop"
        )

      print(summary_stats)
    }
  } else {
    cat("❌ No access token available. Using anonymous requests.\n")
    cat("ℹ️  Run oauth_helper.R setup to configure authentication.\n")
  }
}

############################################################
# EXAMPLE 4: ERROR HANDLING AND RECOVERY
############################################################

example_error_handling <- function() {
  cat("\n=== ERROR HANDLING EXAMPLE ===\n")

  # Demonstrate various error scenarios

  # 1. Invalid token
  cat("🧪 Testing invalid token...\n")
  invalid_result <- test_access_token("lip_invalid_token")
  cat("Result:", invalid_result, "\n")

  # 2. Network timeout simulation
  cat("\n🧪 Testing network timeout handling...\n")
  tryCatch(
    {
      # This would timeout in real usage
      response <- GET("https://httpbin.org/delay/10", timeout(2))
    },
    error = function(e) {
      cat("✅ Timeout handled gracefully:", e$message, "\n")
    }
  )

  # 3. Rate limit simulation
  cat("\n🧪 Testing rate limit handling...\n")
  cat("ℹ️  The script includes automatic delays and backoff strategies.\n")

  # 4. Recovery strategies
  cat("\n🔧 Recovery strategies:\n")
  cat("   - Invalid token → Prompt for new token\n")
  cat("   - Rate limited → Exponential backoff\n")
  cat("   - Network error → Retry with delay\n")
  cat("   - Invalid response → Skip and continue\n")
}

############################################################
# MAIN FUNCTION
############################################################

main <- function() {
  cat("🎯 LICHESS OAUTH EXAMPLES\n")
  cat("=========================\n")

  args <- commandArgs(trailingOnly = TRUE)

  if (length(args) > 0) {
    example_type <- args[1]

    switch(
      example_type,
      "personal" = example_personal_token(),
      "oauth2" = example_oauth2_flow(),
      "collect" = example_enhanced_collection(),
      "errors" = example_error_handling(),
      {
        cat("Unknown example type. Available options:\n")
        cat("  personal - Personal access token setup\n")
        cat("  oauth2   - OAuth2 application flow\n")
        cat("  collect  - Enhanced data collection\n")
        cat("  errors   - Error handling demonstration\n")
      }
    )
  } else {
    # Run all examples
    example_personal_token()
    example_oauth2_flow()
    example_enhanced_collection()
    example_error_handling()
  }

  cat("\n🎉 Examples complete!\n")
  cat("💡 To run a specific example: Rscript oauth_examples.R <type>\n")
}

# Run examples if called as script
if (!interactive()) {
  main()
}
