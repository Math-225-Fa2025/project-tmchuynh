#!/usr/bin/env Rscript

############################################################
# Lichess OAuth Token Manager
# A helper script for managing Lichess API authentication
############################################################

library(httr)
library(jsonlite)

# Load .env file if it exists
load_dotenv <- function() {
  # Check multiple locations for .env file
  possible_paths <- c(".env", "../.env", "../../.env")

  for (env_file in possible_paths) {
    if (file.exists(env_file)) {
      lines <- readLines(env_file, warn = FALSE)
      lines <- lines[nzchar(lines) & !startsWith(lines, "#")]

      for (line in lines) {
        if (grepl("=", line)) {
          parts <- strsplit(line, "=", fixed = TRUE)[[1]]
          if (length(parts) >= 2) {
            key <- trimws(parts[1])
            value <- trimws(paste(parts[-1], collapse = "="))
            # Remove quotes if present
            value <- gsub('^"(.*)"$', '\\1', value)
            value <- gsub("^'(.*)'$", '\\1', value)
            # Set environment variable
            do.call(Sys.setenv, setNames(list(value), key))
          }
        }
      }
      cat("✅ Loaded .env from:", env_file, "\n")
      return(TRUE)
    }
  }
  return(FALSE)
}

# Lichess API endpoints
LICHESS_API_BASE <- "https://lichess.org/api"
LICHESS_TOKEN_URL <- "https://lichess.org/account/oauth/token"

# Test if a token is valid
test_token <- function(token) {
  if (is.null(token) || nchar(token) == 0) {
    cat("❌ No token provided\n")
    return(FALSE)
  }

  cat("🔍 Testing token:", substr(token, 1, 20), "...\n")

  tryCatch(
    {
      response <- GET(
        paste0(LICHESS_API_BASE, "/account"),
        add_headers(Authorization = paste("Bearer", token)),
        timeout(10)
      )

      if (status_code(response) == 200) {
        user_data <- content(response, as = "parsed")
        cat("✅ Token valid!\n")
        cat("   User:", user_data$username, "\n")
        cat("   ID:", user_data$id, "\n")
        if (!is.null(user_data$patron)) {
          cat("   Patron:", user_data$patron, "\n")
        }
        return(TRUE)
      } else {
        cat("❌ Token invalid or expired (HTTP", status_code(response), ")\n")
        return(FALSE)
      }
    },
    error = function(e) {
      cat("❌ Error testing token:", e$message, "\n")
      return(FALSE)
    }
  )
}

# Get token from .env, environment, or .Renviron
get_token <- function() {
  # Try .env file first
  if (load_dotenv()) {
    token <- Sys.getenv("LICHESS_ACCESS_TOKEN")
    if (nchar(token) > 0) {
      cat("🔑 Found token in .env file\n")
      return(token)
    }
  }

  # Try environment variable
  token <- Sys.getenv("LICHESS_ACCESS_TOKEN")
  if (nchar(token) > 0) {
    cat("🔑 Found token in environment\n")
    return(token)
  }

  # Try .Renviron file
  if (file.exists(".Renviron")) {
    lines <- readLines(".Renviron")
    token_line <- grep("LICHESS_ACCESS_TOKEN=", lines, value = TRUE)
    if (length(token_line) > 0) {
      token <- gsub("LICHESS_ACCESS_TOKEN=", "", token_line[1])
      if (nchar(token) > 0) {
        cat("🔑 Found token in .Renviron\n")
        return(token)
      }
    }
  }

  cat("🔍 No token found. You need to create one.\n")
  return(NULL)
}

# Interactive token setup
setup_token <- function() {
  cat("\n🚀 LICHESS OAUTH TOKEN SETUP\n")
  cat("=====================================\n\n")

  cat("1. Go to: https://lichess.org/account/oauth/token\n")
  cat("2. Click 'New personal access token'\n")
  cat("3. Add description: 'Data Science Research'\n")
  cat("4. Select these scopes:\n")
  cat("   ☐ preference:read\n")
  cat("   ☐ challenge:read\n")
  cat("   ☐ puzzle:read\n")
  cat("   ☐ tournament:read\n")
  cat("   ☐ study:read\n")
  cat("   ☐ follow:read\n")
  cat("5. Click 'Create'\n")
  cat("6. Copy the generated token (starts with 'lip_')\n\n")

  token <- readline("Paste your token here: ")

  if (nchar(token) == 0) {
    cat("❌ No token entered\n")
    return(invisible(NULL))
  }

  if (!startsWith(token, "lip_")) {
    cat(
      "⚠️  Warning: Token doesn't start with 'lip_' - are you sure it's correct?\n"
    )
  }

  # Test the token
  if (test_token(token)) {
    # Save to environment
    Sys.setenv(LICHESS_ACCESS_TOKEN = token)

    # Ask to save to .env file
    save_choice <- readline("Save to .env file for future use? (y/n): ")

    if (tolower(save_choice) %in% c("y", "yes")) {
      env_content <- paste0("LICHESS_ACCESS_TOKEN=", token, "\n")

      if (file.exists(".env")) {
        # Read existing .env and update token line
        existing_lines <- readLines(".env", warn = FALSE)
        existing_lines <- existing_lines[
          !grepl("^LICHESS_ACCESS_TOKEN=", existing_lines)
        ]
        if (length(existing_lines) > 0) {
          env_content <- paste(
            c(existing_lines, paste0("LICHESS_ACCESS_TOKEN=", token)),
            collapse = "\n"
          )
        }
      }

      writeLines(env_content, ".env")
      cat("✅ Token saved to .env file\n")
    }

    cat("\n🎉 Setup complete! You can now run your data collection script.\n")
    return(token)
  } else {
    cat("❌ Token setup failed. Please check your token and try again.\n")
    return(invisible(NULL))
  }
}

# Main function
main <- function() {
  args <- commandArgs(trailingOnly = TRUE)

  if (length(args) > 0 && args[1] == "setup") {
    setup_token()
  } else if (length(args) > 0 && args[1] == "test") {
    token <- get_token()
    if (!is.null(token)) {
      test_token(token)
    } else {
      cat("Run with 'setup' argument to configure a token\n")
    }
  } else {
    cat("Lichess OAuth Token Manager\n")
    cat("Usage:\n")
    cat("  Rscript oauth_helper.R setup  # Set up new token\n")
    cat("  Rscript oauth_helper.R test   # Test existing token\n")

    # Auto-detect what to do
    token <- get_token()
    if (!is.null(token)) {
      test_token(token)
    } else {
      cat("\nNo token found. Run setup to create one.\n")
    }
  }
}

# Run if called as script
if (!interactive()) {
  main()
}
