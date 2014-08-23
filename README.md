README.md

# Overview and Usage
---

## run_analysis.R ##
This is the main script, capable of downloading and decompressing the assignment data file if it isn't already available, then stepping through the assignment requirements one by one to produce the required output.

> * YOU MUST DEFINE THE WD CONSTANT BEFORE RUNNING THIS SCRIPT! *

WD sets the working directory, and the script will fail if your system doesn't have the directory listed.  Also, don't end your WD with a forward slash.  The convention in this script is to put the forward slashes on each individual file name instead.

## Other Constants ##
* URL is the location of the data file for this assignment.  You probably don't need to change it.
* EWD isn't really a constant, but is set by the script to be whatever working directory is yours prior to changing to WD.  The script retores you to your previous working directory before exiting.
* VARINDEX is a vector containing the column numbers of all the variables required for the assignment

## Package Dependencies ##
utils

## Usage ##
after varifying package dependencies and sourcing run_analysis(), simply run 
  
    run_analysis.R() 

in the R console.  The first time you run the script it will create the WD directory and download and expand the dataset.

# Assumptions #
---
The following assumptions were made about the assignment.  On a personal note, many years of IT experience have taught me that requirements are always vaugue, and that some judgement is necessary to complete work on schedule. You can't always go back to the client to ask what they meant.  Often they can't tell you.  It is in that spirit that I submit these assumptions, because within the "science" part of Data Science is the ability to discuss what is vague, what I know and don't know, and what I did about it.

## Initial Assignment, consolidated for reference ##

 * GOAL: prepare tidy data that can be used for later analysis
 * DELIVERABLES: 
  * a tidy data set
  * an R scripot called run_analysis() that:
     * Merges the training and the test sets to create one data set.
     * Extracts only the measurements on the mean and standard deviation for each measurement. 
     * Uses descriptive activity names to name the activities in the data set
     * Appropriately labels the data set with descriptive variable names. 
     * Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  * a CodeBook.md
  * a README.md (which you are reading right now)
  * a GitHub repository 

## detailed assumptions ##
  1. The combined test and training datasets include ALL of the data in a new directory using the same structure as the existing test and train directories, with everything moved up one level (since 'train' and 'test' directories are no longer needed).  Even though we never use the data in the Inertial Signals directories, this is merged as well into the final data set stored in the UCIMerged directory.

https://class.coursera.org/getdata-006/forum/thread?thread_id=196
