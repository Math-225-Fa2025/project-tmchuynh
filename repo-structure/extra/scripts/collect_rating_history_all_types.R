############################################################
# Script: collect_rating_history_all_types.R
# Author: Tina Huynh
# Date: 2025-10-16
# Purpose: Collect rating history for ALL Lichess game types
#          including time controls and variants
############################################################

library(tidyverse)
library(httr)
library(jsonlite)
library(lubridate)

# Load environment variables
source("../../extra/scripts/data_import.R") # For get_access_token()

setwd(
  "/home/tmchuynh/Documents/Data Science/project-tmchuynh/repo-structure/extra/scripts"
)
data_dir <- "../../data/"

message("=== COLLECTING COMPREHENSIVE RATING HISTORY ===")
message("Including all time controls and chess variants")

# Get access token
access_token <- get_access_token(interactive = FALSE)

# Function to get rating history for a user (all game types)
get_rating_history <- function(username, access_token = NULL) {
  url <- paste0("https://lichess.org/api/user/", username, "/rating-history")

  # Prepare headers
  headers <- list()
  if (!is.null(access_token) && nchar(access_token) > 0) {
    headers <- add_headers(Authorization = paste("Bearer", access_token))
  }

  tryCatch(
    {
      Sys.sleep(runif(1, 0.3, 0.8)) # Rate limiting

      response <- if (length(headers) > 0) {
        GET(url, headers, timeout(15))
      } else {
        GET(url, timeout(15))
      }

      if (status_code(response) != 200) {
        message(paste(
          "Failed for",
          username,
          "- status:",
          status_code(response)
        ))
        return(NULL)
      }

      history <- content(response, as = "parsed")

      if (length(history) == 0) {
        return(NULL)
      }

      # Process each game type's rating history
      result <- map_dfr(history, function(perf_history) {
        if (length(perf_history$points) == 0) {
          return(NULL)
        }

        # Extract category name
        category <- perf_history$name

        # Convert points to data frame
        points_df <- map_dfr(perf_history$points, function(point) {
          tibble(
            year = point[[1]],
            month = point[[2]],
            day = point[[3]],
            rating = point[[4]]
          )
        })

        if (nrow(points_df) == 0) {
          return(NULL)
        }

        points_df %>%
          mutate(
            user = username,
            category = category,
            date = make_date(year, month + 1, day), # API uses 0-indexed months
            date_index = row_number()
          ) %>%
          select(user, category, date_index, rating, date)
      })

      return(result)
    },
    error = function(e) {
      message(paste("Error for", username, ":", e$message))
      return(NULL)
    }
  )
}

# Load existing user list
if (file.exists(paste0(data_dir, "lichess_clean.csv"))) {
  message("Loading users from lichess_clean.csv...")
  users_df <- read_csv(
    paste0(data_dir, "lichess_clean.csv"),
    show_col_types = FALSE
  )
  target_users <- users_df$user
  message(paste("Found", length(target_users), "users"))
} else {
  message("No existing user data found. Using sample users...")
  target_users <- c(
    "Magnus_Carlsen",
    "Hikaru",
    "GothamChess",
    "penguingim",
    "chessnetwork",
    "agadmator",
    "chessbrah",
    "gmhikaru",
    "chess24",
    "speedchess"
  )
}

# Collect rating history for all users
message(paste(
  "\nCollecting rating history for",
  length(target_users),
  "users..."
))
message("This includes ALL game types: time controls + variants")

all_history <- list()
success_count <- 0
fail_count <- 0

for (i in seq_along(target_users)) {
  username <- target_users[i]

  if (i %% 20 == 0) {
    message(sprintf(
      "Progress: %d/%d users (%.1f%%)",
      i,
      length(target_users),
      (i / length(target_users)) * 100
    ))
  }

  user_history <- get_rating_history(username, access_token)

  if (!is.null(user_history) && nrow(user_history) > 0) {
    all_history[[username]] <- user_history
    success_count <- success_count + 1
  } else {
    fail_count <- fail_count + 1
  }

  # Rate limiting pause
  if (i %% 50 == 0) {
    message("  → Rate limiting pause...")
    Sys.sleep(30)
  }
}

# Combine all data
if (length(all_history) > 0) {
  rating_history_all <- bind_rows(all_history)

  message(sprintf("\n✓ Collection complete!"))
  message(sprintf("  - Users processed: %d", success_count))
  message(sprintf("  - Total data points: %d", nrow(rating_history_all)))
  message(sprintf(
    "  - Game types found: %d",
    n_distinct(rating_history_all$category)
  ))

  # Show distribution by category
  category_dist <- rating_history_all %>%
    count(category, sort = TRUE)

  message("\nGame type distribution:")
  for (i in seq_len(min(15, nrow(category_dist)))) {
    message(sprintf(
      "  %s: %d points",
      category_dist$category[i],
      category_dist$n[i]
    ))
  }

  # Save to CSV
  output_file <- paste0(data_dir, "lichess_rating_history.csv")
  write_csv(rating_history_all, output_file)
  message(sprintf("\n✓ Data saved to: %s", output_file))

  # Create summary statistics
  summary_stats <- rating_history_all %>%
    group_by(category) %>%
    summarise(
      users = n_distinct(user),
      total_points = n(),
      avg_rating = round(mean(rating, na.rm = TRUE), 1),
      min_rating = min(rating, na.rm = TRUE),
      max_rating = max(rating, na.rm = TRUE),
      date_range_days = as.numeric(difftime(
        max(date),
        min(date),
        units = "days"
      )),
      .groups = "drop"
    ) %>%
    arrange(desc(total_points))

  message("\nSummary by game type:")
  print(summary_stats, n = Inf)

  write_csv(summary_stats, paste0(data_dir, "rating_history_summary.csv"))
} else {
  message("\n⚠ No rating history data collected")
}

message("\n=== COLLECTION COMPLETE ===")
