# main.R

# Always run these
source("config.R")
source("R/helper_functions.R")
source("R/visualization.R")
source("R/data_preparation.R")


# Exploratory Analysis - comment out if you don't need to rerun
source("R/exploratory_analysis.R")

# Leapfrogging Analysis - uncomment when you're ready to run this part
# source("R/leapfrogging_analysis.R")

# Visualization - uncomment when you're ready to create plots
# source("R/visualization.R")

# Save workspace - uncomment if you want to save at the end
# save.image(file = "data/processed/financial_innovation_workspace.RData")

print("Analysis complete!")
