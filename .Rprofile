#Basic options settings

setup <-function(){
  suppressMessages({
options(stringAsFactors=FALSE, scipen=999, 
        repos=c(CRAN="https://cloud.r-project.org"))

# Load required packages
library(tidyverse)  # for data manipulation and visualization
library(conflicted)
conflict_prefer("filter", "dplyr")
conflict_prefer("lag", "dplyr")
library(readxl)     # for reading Excel files
library(scales)     # for scale functions in plots
library(knitr)      # for creating tables
library(ggrepel)    # for non-overlapping text labels in ggplot
library(janitor)    # to manage names with blanks in tibbles
library(here)       # to facilitate moving along paths
  })
}

invisible(setup()) #to run the commands above without echo on the console screen

#Print ready message
cat ("Project is loaded and ready to start. Run main.R to load objects and outputs generated so far\n")
