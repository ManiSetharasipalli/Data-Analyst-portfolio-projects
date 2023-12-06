-- Data cleaning using MySQL

-- The table looks like this before cleaning
SELECT * FROM audible_books;

-- We clean the columns one by one
SELECT author, narrator FROM audible_books;

-- In these two columns, we have the same problem; we remove 'Written by' and 'Narrated by'

-- (SET AUTOCOMMIT=0) is used when we make mistakes in the manipulation process; then we simply use (ROLLBACK)

-- Update the author column, removing anything before the last colon
UPDATE audible_books 
SET author = SUBSTRING_INDEX(author, ':', -1);

-- We have two author names; we'll keep just one
UPDATE audible_books 
SET author = SUBSTRING_INDEX(author, ',', 1);

-- Apply the same process to the narrator column
UPDATE audible_books 
SET narrator = SUBSTRING_INDEX(narrator, ':', -1);

UPDATE audible_books 
SET narrator = SUBSTRING_INDEX(narrator, ',', 1);

-- The 'Name' column does not look good, so we remove '#' and ':'
UPDATE audible_books 
SET name = SUBSTRING_INDEX(name, '#', 1);

UPDATE audible_books 
SET name = SUBSTRING_INDEX(name, ':', 1); 

-- We want to change the 'time' column to minutes

-- We add new columns for this manipulation
ALTER TABLE audible_uncleaned
ADD COLUMN (hours INT, minutes INT);

-- We assign the values to 'hours' and 'minutes' into two columns and add them to the 'time' column

-- 'Hours' column
UPDATE audible_books 
SET hours = SUBSTRING_INDEX(time, ' ', 1);

UPDATE audible_books 
SET hours = hours * 60;

-- 'Minutes' column
UPDATE audible_books 
SET minutes = SUBSTRING_INDEX(SUBSTRING_INDEX(time, ' ', -2), ' ', 1);

-- Add these two columns to the 'time' column 
UPDATE audible_books 
SET time = hours + minutes;

-- Now we drop those columns
ALTER TABLE audible_books
DROP COLUMN hours,
DROP COLUMN minutes;

-- We rename the column as 'runtime_in_mins' instead of using 'time'
ALTER TABLE audible_books
RENAME COLUMN time TO runtime_in_mins;

-- Now we change the 'releasedate' column into this format 'yyyy-mm-dd'
UPDATE audible_books 
SET releasedate = DATE_FORMAT(releasedate, '20%d-%m-%y');

-- Now we take only stars from the 'stars' column
UPDATE audible_books 
SET stars = SUBSTRING_INDEX(stars, ' out', 1);

-- Now we remove 'Not rated' rows or replace them with null
UPDATE audible_books 
SET stars = NULLIF(stars, 'Not rated yet');

-- Now we remove commas in the 'price' column
UPDATE audible_books 
SET Price = REPLACE(price, ',', '');

-- Display the structure of the table
DESC audible_books;

-- Now we change the data types also
ALTER TABLE audible_books
MODIFY name VARCHAR(100),
MODIFY author VARCHAR(50),
MODIFY narrator VARCHAR(50),
MODIFY runtime_in_mins INT,
MODIFY releasedate DATE,
MODIFY language VARCHAR(30),
MODIFY stars FLOAT,
MODIFY price BIGINT;

-- We can change column names also
ALTER TABLE audible_books
RENAME COLUMN name TO Book_name,
RENAME COLUMN releasedate TO Release_date;

-- Now the table looks like this after cleaning
SELECT * FROM audible_books;

-- SET AUTOCOMMIT=1
