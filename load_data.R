library(openxlsx)
library(dplyr)


# Function takes a folder path and string filter as arguments -> returns a data frame
# Has default arguments for folder path and string filter which can be overridden when called
load_data_from_folder <- function(folderpath = "data/", string_filter = "EGOV_DATA"){
  
  # Getting list of files from folder path argument so as to create a list of files
  data_files_list <- list.files(path = folderpath)
  
  # Initializing an empty data frame so that can append data to it as we iterate over files
  output_df <- data.frame()
  
  # Setting up loop so can check each file and extract data if string filter condition is met
  for (filename in data_files_list) {
    
    # Check if file name contains string filter argument so can extract or skip
    if (grepl(string_filter, filename, fixed = TRUE)){
      
      # Extract and append data table to the output data frame
      output_df <- paste(folderpath, filename, sep="") %>%
        read.csv(header = TRUE) %>%
        rbind(output_df, .)
    }
  }
  
  # Return the data tables as a single combined data frame  
  return(output_df)
}

df_combined_raw_data <- load_data_from_folder(folderpath = "data/", string_filter = "EGOV_DATA")

df_egov_2022_with_regions <- read.csv("data/EGOV_WITH_REGIONS_DATA_2022.csv")

df_egov_all_years <- full_join(df_combined_raw_data, df_egov_2022_with_regions, by = "Country.Name")
