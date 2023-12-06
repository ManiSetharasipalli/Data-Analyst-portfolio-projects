## Audible Books Data Cleaning Project

# Overview:

This project focuses on cleaning and enhancing the Audible Books dataset using MySQL to improve data quality, consistency, and overall usability.

# Key Features:

1.**Author and Narrator Cleanup:** 
    1.Extracted and standardized author and narrator names.
    2.Standardized the 'Name' column by eliminating '#' and ':'.

2.**Time and Runtime Enhancement:**
    1.Converted 'time' to minutes, introducing a new 'runtime_in_mins' column for precise duration representation.

3.**Date Standardization:**
    1.Transformed 'releasedate' to 'yyyy-mm-dd' format for consistency in date representation.

4.**Stars and Rating Refinement:**
    1.Cleaned the 'stars' column, removing 'Not rated yet' entries to enhance data accuracy.

5.**Price Column Optimization:**
    1.Removed commas in the 'price' column for improved numerical handling.

State Before and After Cleaning:

Before Cleaning:
![Before Cleaning]("C:\Users\manis\Pictures\Screenshots\Screenshot (117).png")


After Cleaning:
![After Cleaning]("C:\Users\manis\Pictures\Screenshots\Screenshot (118).png")

Outcome:

    Achieved elevated data quality and consistency.
    Enhanced the overall readability and usability of the Audible Books dataset.

Getting Started:

Prerequisites:

    MySQL installed.
    Access to the Audible Books dataset.
