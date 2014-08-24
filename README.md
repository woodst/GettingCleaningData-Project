README.md

# Overview and Usage
---

## run_analysis.R ##
This is the main script, capable of downloading and decompressing the assignment data file if it isn't already available, then stepping through the assignment requirements one by one to produce the required output.

The WD variable is set to the working directory. The script will run if the dataset zip file exists in the working directory.  If the file is not in the working directory, the script will download it.  The MD variable holds the name of the directory that will hold merged data.

## Dependencies ##
> Packages
>> utils, dplyr

## Usage ##
after varifying package dependencies and sourcing run_analysis(), simply run 
  
    run_analysis.R() 

in the R console.  The first time you run the script it will create the MD directory and download and expand the dataset.
The script will unzip the data file into the "UCI Har Dataset" directory and then proceed to merge the test and training data into a single data set that resides in the directory specified by MD. If you need to run the script again, it can detect the data file and will skip downloading it

The script then generates the two tidy data sets, per the assignment instructions.

Run time on my Macbook Pro ( 2.4Ghz core 2 duo with 4GB of RAM ) is about three minutes.  The script will display it's progress as it executes.

# Assumptions #
---
The following assumptions were made about the assignment.  On a personal note, many years of IT experience have taught me that requirements are always vaugue, and that some judgement is necessary to complete work on schedule. You can't always go back to the client to ask what they meant.  Often they can't tell you.  It is in that spirit that I submit these assumptions, because within the "science" part of Data Science is the ability to discuss what is vague, what I know and don't know, and what I did about it.



## Assumption #1: All data should be combined ##
  1. The combined test and training datasets include ALL of the data in a new directory using the same structure as the existing test and train directories, with everything moved up one level (since 'train' and 'test' directories are no longer needed).  Even though we never use the data in the Inertial Signals directories, this is merged as well into the final data set stored in the UCIMerged directory.

## Assumption #2: What's in, not in the tidy data sets ##
For Tidy Data Set #1, the subject ID, a descriptive version of the activities, and 66 columns of data that represent mean and standard deviation are included.

For Tidy Data Set #2, ALL of the variables are used, with the mean of each grouped by subject and within subject by activity.  30 subjects X 6 activities = 180 Rows.  There are 563 columns total in this data set.

## Assumption #3: Generation of modified variable names ##
The default column names have punctuation in the form of commas and parentheses that can confuse some of the functions.  These are stripped using regex "[\\(\\),]+", which results in slightly different column names over the original data set.  These are documented in the code book.
