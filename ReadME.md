---
title: "ReadMe"
output: html_document
---

## Introduction

This is the final course project for "Getting and Cleaning Data"


## Files

This repository should contain the following files:

**run_analysis.R** - this is the script to get, clean and write the tidy data  
**data**   -      this the folder containing the original data  
**tidydata.txt** - this is the file containing the tidy data, as demanded by this assignment  
**Code Book.md** - this is the code book for this data and assignment. It describes the newly introduced variables and the process which led from the original data to the tidy data  
**ReadME.md**   - this file giving a breaf description of what and where you can find in this                      repository

## Comments

The script is quite explicit in what it does. Still in short it is programmed to download the original data, create a full data for each test and train sets from the different files contained in the original data. Next it mergers the two data sets and extract from this full data only the values that represent means and standard deviation. Once it replaces the activity values with easily readable (for us) values, the script groups all the rows per activity and subject. Next it provides the average of each value per activity and per subject. Finaly it creates a file containing these averages.

