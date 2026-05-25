--------------CLEANING THE DATA--------------
---- Both the health indicators and the wait time data go through the same cleaning steps
-- Removing unreliable data i.e. any rows with status as x, .., E and F
-- Making the vector column the primary key column 
-- Filtering out rows with null values in the value column if any are present
-- Filtering for rows where characteristics=Percentage because these have calculated percentages rather than confidence intervals
-- Changing the value column to numeric data type with 1 decimal place



---------CLEANING THE HEALTH INDICATORS DATA-------------
SELECT count(*), status 
FROM health_indicators_raw
GROUP BY status;
-- 1608 rows have unreliable data

-- Creating a copy of the health indicators table with required columns
-- filtered by status to remove unreliable data with status x, .., E and F
CREATE TABLE health_indicators 
AS SELECT 	vector, 
			geo, 
			dguid, 
			gender, 
			age_group, 
			indicators,
			characteristics,
			uom, 
			uom_id, 
			coordinate, 
			value
FROM health_indicators_raw
WHERE status NOT IN ('..', 'x', 'E', 'F');

-- Making the vector the primary key 
ALTER TABLE health_indicators
ADD CONSTRAINT hi_pkey PRIMARY KEY (vector);

-- Checking for null values
SELECT * FROM health_indicators WHERE value = '';

-- Filtering for rows where characteristics = 'Percentage'
SELECT count(*), characteristics FROM health_indicators 
GROUP BY characteristics;

-- Only values with characteristics = Percentage will be utilized for analysis
CREATE TABLE health_indicators_percent
AS SELECT 	vector, 
			geo,
			dguid, 
			gender, 
			age_group, 
			indicators, 
			coordinate, 
			value			
FROM health_indicators
WHERE characteristics = 'Percentage';

-- Changing the value column data type to decimal type
ALTER TABLE health_indicators_percent
ALTER COLUMN value TYPE NUMERIC(4,1)
USING value::numeric;

-- Exporting the data 
COPY health_indicators_percent
TO 'your\absolute\path\data\cleaned_data\health_indicators_percent.csv'
WITH (FORMAT CSV, HEADER);

--------------------CLEANING THE WAIT TIMES DATA--------------------
-- Filtering the data for the wait times based on status
SELECT * FROM wait_times_raw;

SELECT count(*), status 
FROM wait_times_raw
GROUP BY status;
-- There are 1176 rows of unreliable data

-- Making a copy of the table with only required columns and dropping the unreliable data
CREATE TABLE wait_times 
AS SELECT 	vector,
			geo, 
			dguid, 
			gender, 
			age_group, 
			indicators,
			characteristics,
			uom, 
			uom_id, 
			coordinate, 
			value
FROM wait_times_raw
WHERE status NOT IN ('..', 'x', 'E', 'F');

-- Setting vector column as the primary key
ALTER TABLE wait_times
ADD CONSTRAINT wt_pkey PRIMARY KEY (vector);

-- Checking for null text values in the value column
SELECT * FROM wait_times WHERE value = '';

-- Filtering for rows where characteristics=Percentage
SELECT count(*), characteristics FROM wait_times 
GROUP BY characteristics;

CREATE TABLE wait_times_percent
AS SELECT 	vector, 
			geo,
			dguid, 
			gender, 
			age_group, 
			indicators, 
			coordinate, 
			value
FROM wait_times
WHERE characteristics = 'Percentage';

-- Changing the value column data type to decimal type
ALTER TABLE wait_times_percent
ALTER COLUMN value TYPE NUMERIC(4,1)
USING value::numeric;

-- Exporting the data
COPY wait_times_percent
TO 'your\absolute\path\data\cleaned_data\wait_times_percent.csv'
WITH (FORMAT CSV, HEADER);
