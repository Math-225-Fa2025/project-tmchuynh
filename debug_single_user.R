# Debug script to test a single user
# This script will help diagnose the issues with user data fetching

# Load necessary libraries
library(httr)
library(jsonlite)

# Load environment variables
source("repo-structure/extra/scripts/data_import.R")

# Test with a single known user
test_username <- "hikaru" # Hikaru Nakamura - definitely exists

# Load access token
access_token <- get_access_token()
if (is.null(access_token)) {
  message("Warning: No access token found. Running without authentication.")
}

# Test the user checking function
message("Testing user existence check...")
user_exists <- check_lichess_user(test_username)
message(paste("User", test_username, "exists:", user_exists))

# Test the data fetching function
message("\nTesting data fetching...")
result <- get_lichess_data(
  test_username,
  max_games = 5,
  access_token = access_token
)

if (is.null(result)) {
  message("Result is NULL - check error messages above")
} else {
  message(paste("Successfully fetched", nrow(result), "games"))
  message("Columns:", paste(names(result), collapse = ", "))
  print(head(result, 2))
}
