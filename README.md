---
title: "Getting and Cleaning Data Course Project"
author: "CM Chow (Cherry)"
date: "2025-12-7"
output: github_document
---

# Getting-and-Cleaning-Data-Course-Project

Getting and Cleaning Data Course Project: to prepare tidy data that can be used for later analysis

## Project Overview

This project processes the Human Activity Recognition Using Smartphones Dataset. It merges training and test sets, extracts mean and standard deviation measurements, applies descriptive activity names, and produces a tidy dataset with averages for each subject and activity.

GitHub repository: [cmchow1030/Getting-and-Cleaning-Data-Course-Project](https://github.com/cmchow1030/Getting-and-Cleaning-Data-Course-Project.git)

------------------------------------------------------------------------

## ️ Requirements

-   R (≥ 4.0)
-   tidyverse
-   tibble

Install packages:

``` r
install.packages("tidyverse")
install.packages("tibble")
```

## How to Run

1.  Clone the repository: git clone <https://github.com/cmchow1030/Getting-and-Cleaning-Data-Course-Project.git>
2.  Open R or RStudio.
3.  Run the script:

``` r
source("run_analysis.R")
```

## Outputs

clean_data.csv: tidy dataset with averages col_name_list2.csv: variable names for codebook

## Files Used:

-  test/subject_test.txt: Subject IDs for test set
-  test/y_test.txt: Activity codes for test set
-  test/X_test.txt: Feature measurements for test set
-  train/subject_train.txt: Subject IDs for training set
-  train/y_train.txt: Activity codes for training set
-  train/X_train.txt: Feature measurements for training set
-  features.txt: List of feature names
-  activity_labels.txt: Mapping of activity codes to descriptive names


## Files in This Repo run_analysis.R → Main R script for data cleaning

CodeBook.md → Explains variables, transformations, and final dataset structure

clean_data.csv → Output tidy dataset (generated after running the script)

## Scripts Steps:

(1) Merge datasets: Combine training and test sets.
(2) Extract variables: Keep only measurements with mean or std.
(3) Label activities: Replace numeric codes with descriptive names.
(4) Rename variables: -Remove parentheses () -Replace mean → MeanValue -Replace std → StdDev -Replace - → \_ Append \_axis to variables ending in X/Y/Z -Create tidy dataset: Average each variable by subject and activity
