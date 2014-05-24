# CleaningData

## Background

This README refers principally to the file `run_analysis.R` that processes Samsung Galaxy S data and produces a tidy summary.

`run_analysis.R` assumes that the UCI Har Dataset (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)
has been unpacked into the working directory before execution. 

## Processing

The following steps are performed:

* The test and training datasets are read from their respective sub-directories
* The features are read from features.txt and stripped of invalid R characters
* The test and training dataset features are then named
* The datasets are filtered to include only selected features relating to means and standard deviations:
Note1. It seemed unsafe to calculate the means of angles that were themselves derived from mean value data therefore angle related features were manually removed.
Note2. For a list of the features selected for summarisation, please refer to the file `codebook.md`
* The test and train activity data is appended to the relevant datasets using descriptive activity names.
* The test and train subject identifiers are appended to the relevant datasets.
* The datasets are then merged and aggregated by activity and subject
* The resultant dataset is written to the workign directory in the file `tidy_phone.csv`

## Other files

Please see the file `tidy_phone.csv` for example output.
Please see the file `codebook.md` for descriptions of the features included in the output.
