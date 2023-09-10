-- Data cleaning using MySQL

-- The table looks like this before cleaning

SELECT * FROM audible_books;

-- We  clean the columns one by one
SELECT author,narrator FROM audible_books;

-- In this two cloumns has same problem, we remove Writtenby,Narratedby
 
-- (SET AUTOCOMMIT=0) this is use when we did mistakes in manipulation process then we  simply use (ROLLBACK)

UPDATE audible_books 
SET author=SUBSTRING_INDEX(author,':',-1);

-- we have two author names we just take one or leave it  same
-- i am going take just one author name
UPDATE audible_books 
SET author=SUBSTRING_INDEX(author,',',1);

-- this process will aplly to narrator column also

UPDATE audible_books 
SET narrator=SUBSTRING_INDEX(narrator,':',-1);

UPDATE audible_books 
SET narrator=SUBSTRING_INDEX(author,',',1);

-- Name column is look good  we just remove '#' and ':' 

UPDATE audible_books 
SET name=SUBSTRING_INDEX(name,'#',1);

UPDATE audible_books 
SET name=SUBSTRING_INDEX(name,':',1); 

-- we want to change the time column in minutes

-- By splitting the string and calculating the total duration in minutes

-- we add new column for this manipulation

ALTER  TABLE audible_uncleaned
ADD COLUMN (hours int,minutes int);

-- we assign the values to hours and minutes into two columns and add to time column

-- hours column

UPDATE audible_books 
SET hours=SUBSTRING_INDEX(time,' ',1);

UPDATE audible_books 
SET hours=hours*60;

-- minutes column
UPDATE audible_books 
SET minutes=SUBSTRING_INDEX(SUBSTRING_INDEX(time,' ',-2),' ',1);
-- add this two columns to time column 

UPDATE audible_books 
SET time=hours+minutes;
-- Now we drop that columns

ALTER TABLE audible_books
DROP COLUMN hours,
DROP COLUMN minutes;

-- we rename the column as runtime_in_mins instead using time

ALTER TABLE audible_books
RENAME COLUMN time TO runtime_in_mins;

-- now we change releasedate column into  in this format 'yyyy-mm-dd'
UPDATE audible_books SET releasedate=DATE_FORMAT(releasedate,'20%d-%m-%y');

-- now we take in the stars column only stars

UPDATE audible_books 
SET stars=SUBSTRING_INDEX(stars,' out',1);

-- Now we remove not rated rows or replace with null
UPDATE audible_books 
SET stars=NULLIF(stars,'Not rated yet');
-- now we remove comma in the price column
UPDATE audible_books 
SET Price=REPLACE(price,',','');

DESC audible_books;

-- now we change the data types also

ALTER TABLE audible_books
MODIFY name VARCHAR(100),
MODIFY author VARCHAR(50),
MODIFY narrator VARCHAR(50),
MODIFY runtime_in_mins INT,
MODIFY releasedate DATE,
MODIFY language VARCHAR(30),
MODIFY stars FLOAT,
MODIFY price BIGINT;
-- we can also change column name

ALTER TABLE audible_books
RENAME COLUMN name TO Book_name,
RENAME COLUMN releasedate TO Release_date;

-- Now the table looks like this after cleaning

SELECT * FROM audible_books;
-- SET AUTOCOMMIT=1













