# Test script to verify the fix for vctrs_error_incompatible_size
# Load the updated function
source(
  "/home/tmchuynh/Documents/Data Science/project-tmchuynh/repo-structure/extra/scripts/data_import.R"
)

# Test with the user that was causing issues
test_user <- "Letslolgamer"

# Load access token
access_token <- get_access_token()

cat("Testing data fetching for user:", test_user, "\n")
cat("Access token available:", !is.null(access_token), "\n\n")

# Test the function
result <- get_lichess_data(
  test_user,
  max_games = 5,
  access_token = access_token
)

if (!is.null(result)) {
  cat("SUCCESS: Data fetched successfully!\n")
  cat("Number of games:", nrow(result), "\n")
  cat("Columns:", paste(names(result), collapse = ", "), "\n")
  print(head(result, 2))
} else {
  cat("FAILED: Function returned NULL\n")
}
