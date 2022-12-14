
# Keep only the necessary variables for RAP -------------------------------

library(magrittr)
# library(tidyverse)

# After the variables have been properly selected in the `data-raw/project-variables.csv`
# file, run this function so that only the selected variables are kept in the
# `data-raw/rap-variables.csv` file. This file has the exact variable names used
# by RAP that we need in order to create the project-specific dataset. After
# running this function, review the changes in Git and add and commit the changed
# files into the history.

# These are variables from my original UKB project.
original_variables <- readr::read_csv(here::here("data-raw/original-variables.csv")) %>%
    dplyr::mutate(id = old_variable_name %>%
               stringr::str_extract("_f[:digit:]+_") %>%
               stringr::str_remove_all("_") %>%
               stringr::str_replace("^f", "p"))

# Update if necessary.
ukbAid::rap_variables %>%
    readr::write_csv(here::here("data-raw/rap-variables.csv"))

ukbAid::project_variables %>%
    dplyr::semi_join(original_variables) %>%
    readr::write_csv(here::here("data-raw/project-variables.csv"))

ukbAid::subset_rap_variables(instances = 0)

# Create the project dataset and save inside RAP --------------------------

# Uncomment and run the below lines **ONLY AFTER** running the above function.
# After running this code and creating the csv file in the main RAP project
# folder, comment it out again so you don't accidentally run it anymore (unless
# you need to re-create the dataset).

# readr::read_csv(here::here("data-raw/rap-variables.csv")) %>%
#     dplyr::pull(rap_variable_name) %>%
#     ukbAid::create_csv_from_database()
