# Getting and Cleaning Data Course Project

## Project Dependencies

Assume that the script run_analysis.R is in the working directory.  

The script downloads the data set and unzips it into a "data" folder.

This project also uses the dplyr library for it's awesome chaining functionality.  
Make sure that you have the latest version of dplyr since we are using a new function called summarize_each.

Also, a special thanks to those on the forums that posted all of the help information and the amazing R community.

## Using the script

To generate the tidy data file set your working directory, then run the run_analysis.R script and it will produce a file called "tidydata.txt" which can be used for further analysis.  

The run_analysis script merges the training and test data sets together to create one data set.  It then adds column headers to the data to make it easier to understand.
After the data sets are merged and the column names are added the script then combines all of the data into one data frame that has the subject, activity, and data.  
The next step in the script is to only select the measurements for the mean and standard deviation for each measurement.  There is also a section in the script for cleaning up the
column names to make them more descriptive. Finally, the script creates a new tidy data set that can be used for further analysis. 


