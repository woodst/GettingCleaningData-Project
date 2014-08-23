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
## EWD      - Existing working directory - to be restored at the end of the analysis
## WD       - Working directory for the analysis.  
## URL      - Datafile location
## MD       - Directory to hold the merged dataset
## VARINDEX - Columns that contain mean and standard deviation, used in TidyDataset1
  EWD <- getwd()
  WD <- "/Users/woodst/Desktop/GCDProject"                        
  URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  MD <- "/UCIMerged"
  VARINDEX <- c( 1:6, 41:46, 81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429, 503:504, 516:517, 529:530, 542:543 ) 
  

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
## Assignment Part 1: Merge training and test data sets, as is, into one structure
## NOTE: the choice to brute-force this, one set of files at a time, is deliberate.
## I realize a sub-function or loop is more elegant.  What is here is more readable 
## and faster to develop, and has the added benefit of quickly tailoring any future
## analysis to a single part of the dataset, something I find myself doing a lot of
## in the real world.
  print("Merging test and training data...")

  # New Merge Directories
  if ( !file.exists( paste(WD, MD, sep="") ) ) {
    print("Creating merge directory...")
    dir.create( paste(WD, MD, sep="") )
    dir.create( paste(WD, MD,"/Inertial Signals", sep="") )    
  }


  # Filenames
    testSubjectFile <- paste( WD,"/UCI HAR Dataset/test/subject_test.txt", sep="" )
    trainSubjectFile <- paste( WD,"/UCI HAR Dataset/train/subject_train.txt", sep="" )
    testActFile <- paste( WD,"/UCI HAR Dataset/test/y_test.txt", sep="" )
    trainActFile <- paste( WD,"/UCI HAR Dataset/train/y_train.txt", sep="" )
    testVarFile <- paste( WD, "/UCI HAR Dataset/test/X_test.txt", sep="")
    trainVarFile <- paste( WD, "/UCI HAR Dataset/train/X_train.txt", sep="")
    testbax <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt", sep="")
    testbay <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt", sep="")
    testbaz <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt", sep="")
    testbgx <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt", sep="")
    testbgy <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt", sep="")
    testbgz <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt", sep="")
    testtax <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt", sep="")
    testtay <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt", sep="")
    testtaz <- paste( WD, "/UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt", sep="")
    trainbax <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt", sep="")
    trainbay <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt", sep="")
    trainbaz <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt", sep="")
    trainbgx <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt", sep="")
    trainbgy <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt", sep="")
    trainbgz <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt", sep="")
    traintax <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt", sep="")
    traintay <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt", sep="")
    traintaz <- paste( WD, "/UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt", sep="")

  # Non-merged files
    print("...copying non-merging files")
    file.copy( paste( WD, "/UCI HAR Dataset/activity_labels.txt", sep=""), paste(WD, MD,  sep=""), overwrite = TRUE ) 
    file.copy( paste( WD, "/UCI HAR Dataset/features_info.txt", sep=""), paste(WD, MD,  sep=""), overwrite = TRUE ) 
    file.copy( paste( WD, "/UCI HAR Dataset/features.txt", sep=""), paste(WD, MD,  sep=""), overwrite = TRUE ) 
    file.copy( paste( WD, "/UCI HAR Dataset/README.txt", sep=""), paste(WD, MD,  sep=""), overwrite = TRUE ) 
  
  # Master subject list
    print("...subjects")
    allSubjects <- read.table( testSubjectFile )
    trainSubjects <- read.table( trainSubjectFile )
    allSubjects <- append( allSubjects[,1], trainSubjects[,1], after=length(allSubjects) )
    write.table( allSubjects, paste( WD, MD,"/subject.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    
    
  # Activities (includes substitution of friendly activity names per Assignment Part 4)
    print("...activities")
    actIndex <- read.table( "UCI HAR Dataset/activity_labels.txt")
    allActs <- read.table( testActFile )
    trainActs <- read.table( trainActFile )
    allActs <- append( allActs[,1], trainActs[,1], after=length(allActs))
    #write.table( actIndex[,2][allActs], "allActivities.txt", row.names = FALSE, col.names = FALSE)
    write.table( allActs, paste( WD, MD, "/y.txt", sep="" ), row.names = FALSE, col.names = FALSE)

  
  # Required Measurement Variables per Assignment Part 2
    print("...measurements")
    allVars <- read.table( testVarFile )
    trainVars <- read.table( trainVarFile )
    #allVars <- rbind( allVars[, VARINDEX ], trainVars[, VARINDEX ] )
    allVars <- rbind( allVars, trainVars)
    write.table( allVars, paste( WD, MD, "/X.txt", sep="" ), row.names = FALSE, col.names = FALSE)


  # Inertial Data
    print("...Inertial Data")

    allBax <- read.table( testbax )
    trainBax <- read.table( trainbax )
    allBax<- append( allBax[,1], trainBax[,1], after=length(allBax) )
    write.table( allBax, paste( WD, MD,"/Inertial Signals/body_acc_x.txt", sep="" ), row.names = FALSE, col.names = FALSE)

    allBay <- read.table( testbay )
    trainBay <- read.table( trainbay )
    allBay<- append( allBay[,1], trainBay[,1], after=length(allBay) )
    write.table( allBay, paste( WD, MD,"/Inertial Signals/body_acc_y.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    
    allBaz <- read.table( testbaz )
    trainBaz <- read.table( trainbaz )
    allBaz<- append( allBaz[,1], trainBaz[,1], after=length(allBaz) )
    write.table( allBaz, paste( WD, MD,"/Inertial Signals/body_acc_z.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    
    allBgx <- read.table( testbgx )
    trainBgx <- read.table( trainbgx )
    allBgx<- append( allBgx[,1], trainBgx[,1], after=length(allBgx) )
    write.table( allBgx, paste( WD, MD,"/Inertial Signals/body_gyro_x.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    
    allBgy <- read.table( testbgy )
    trainBgy <- read.table( trainbgy )
    allBgy<- append( allBgy[,1], trainBgy[,1], after=length(allBgy) )
    write.table( allBgy, paste( WD, MD,"/Inertial Signals/body_gyro_y.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    
    allBgz <- read.table( testbgz )
    trainBgz <- read.table( trainbgz )
    allBgz<- append( allBgz[,1], trainBgz[,1], after=length(allBgz ) )
    write.table( allBgz, paste( WD, MD,"/Inertial Signals/body_gyro_z.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    
    allTax <- read.table( testtax )
    trainTax <- read.table( traintax )
    allTax<- append( allTax[,1], trainTax[,1], after=length(allTax) )
    write.table( allTax, paste( WD, MD,"/Inertial Signals/total_acc_x.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    
    allTay <- read.table( testtay )
    trainTay <- read.table( traintay )
    allTay<- append( allTay[,1], trainTay[,1], after=length(allTay) )
    write.table( allTay, paste( WD, MD,"/Inertial Signals/total_acc_y.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    
    allTaz <- read.table( testtaz )
    trainTaz <- read.table( traintaz )
    allTaz<- append( allTaz[,1], trainTaz[,1], after=length(allTaz) )
    write.table( allTaz, paste( WD, MD,"/Inertial Signals/total_acc_z.txt", sep="" ), row.names = FALSE, col.names = FALSE)
    

## Assignment Parts 2-4: Create the first tidy data set
## Format: [Subject], [Activitiy], [66 mean and std variable colums]
## Acti=vity codes converted to names
## Descriptive variable names
  print("Creating tidy data set 1...")
  tidyDS1 <- NULL
  cn <- read.table( paste( WD, MD, "/features.txt", sep="") )
  
  tidyDS1$subject <- allSubjects
  tidyDS1$activity <- actIndex[,2][allActs]
  tidyDS1 <- cbind(tidyDS1, allVars[,VARINDEX] )
  colnames(tidyDS1) <- c("subject", "activity", as.character( cn[ VARINDEX, 2 ]) ) 
  
  write.table( tidyDS1, paste(WD, "/tidyData1.csv", sep=""), quote=FALSE, sep=",", row.names = FALSE)
## ------------------------------------
## Data Labels
  

## ------------------------------------
## Restore the user's previous working directory
## perform other cleanup
rm(allSubjects, trainSubjects,  allActs, trainActs,  allVars, trainVars )
setwd( EWD )

}


  