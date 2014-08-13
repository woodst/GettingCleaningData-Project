## ====================================
## run_analysis.R
## Johns Hopkins Data Science
## Getting and Cleaning Data
## Course Project
## August 2014 - Tom Woods
## ====================================

run_analysis <- function( dataFiles ) {

## ------------------------------------
## Prerequisites
##
## Package dependencies:
## utils
##
## Constants:
## EWD - Existing working directory - to be restored at the end of the analysis
## WD  - Working directory for the analysis.  
## DL  - Datafile location
  EWD <- getwd()
  WD <- "/Users/woodst/Dropbox/Coursera/DataScience/GetCleanData/project2"                        
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  

## ------------------------------------
## Setup, retrieve data
##
## Make and set the working directory and retrieve the data file
## unless either already exists.
  file <- unlist( strsplit(URL, "[/]") )
  file <- paste( WD, "/", file[ length(file) ] , sep="" )


  print("Checking for existing data...")
  
  if ( !file.exists( WD ) ) {
    dir.create( WD )
  }
  else  {
    print("Directory found, searching for archive...")
  }
  

  setwd( WD )

  if ( !file.exists( file )) {
    print("Downloading data archive...")
    download.file(URL, file, "curl")
  }
  else {
    print("Archive found.")
  }


## ------------------------------------
## Expand the zip archive
  print("Expanding data archive...")
  unzip( file, exdir = WD )


## ------------------------------------
## Assignment part 1: Merge training and test data sets
  print("(Assignment 1: Merging test and training data...")
  
  



## ------------------------------------
## Restore the user's previous working directory
##
setwd( EWD )

}


  