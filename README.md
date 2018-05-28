This README file explains the script used in the run_analysis.R file that extracts data from the UCI HAR Dataset

The steps for the analysis are as follows:

1. Check if the data already exists locally, and if not, download and unzip it. 
2. Read the data into the working memory
3. Create variables to store activity and feature labels, extracting the features that have mean and SD measurements
4. Clean up the format of the feature labels
5. Get the desired training data from the files, extracting only the desired ones using the features described in step 3
6. Merge the data into one training dataset
7. Get the desired test data from the files using the same procedure as in step 5. 
8. Merge the test data into one test dataset
9. Merge the two datasets into a master dataset and change its names as appropriate using feature labels
10. Create a tidy dataset that groups by subject and activity and extracts desired means. 
11. Write this dataset into a new txt file. 

