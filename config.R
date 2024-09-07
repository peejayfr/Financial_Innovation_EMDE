# config.R

# Define project-wide variables
PROJECT_DIR <- getwd()
DATA_DIR <- file.path(PROJECT_DIR, "data")
OUTPUT_DIR <- file.path(PROJECT_DIR, "output")
R_DIR<-here("R")

# Create directories if they don't exist
dir.create(DATA_DIR, showWarnings = FALSE)
dir.create(OUTPUT_DIR, showWarnings = FALSE)
dir.create(R_DIR, showWarnings = FALSE)
dir.create("R/data/raw", showWarnings = FALSE)
dir.create("R/data/processed",showWarnings = FALSE)
dir.create("R/output/figures",showWarnings = FALSE)
dir.create("R/output/tables",showWarnings=FALSE)

# Define color palette for plots
COUNTRY_COLORS <- c("High income" = "#1f77b4", 
                    "Upper middle income" = "#ff7f0e",
                    "Lower middle income" = "#2ca02c", 
                    "Low income" = "#d62728")

# Define common data processing functions
clean_country_names <- function(x) {
  gsub("\\s+", " ", trimws(x))  # Remove extra spaces and trim whitespace
}

# Set default theme for ggplot
theme_set(theme_minimal())

# Print confirmation message
cat("Config file loaded. Project directories set up. Packages and global settings initialized.\n")
