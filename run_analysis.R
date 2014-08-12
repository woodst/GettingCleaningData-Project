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
## WD - Working directory for the analysis.  
## DL - Datafile location
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

  if ( !file.exists( WD ) ) {
    dir.create( WD )
  }
  
  setwd( WD )

  if ( !file.exists( file )) {
    download.file(URL, file, "curl")
  }

## ------------------------------------



## ------------------------------------
## Restore the user's previous working directory
##
setwd( EWD )

}


  