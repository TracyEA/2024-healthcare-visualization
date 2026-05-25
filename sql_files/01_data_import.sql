CREATE TABLE health_indicators_raw(
	ref_date INTEGER,
	geo TEXT, 
	dguid VARCHAR(11), 
	gender VARCHAR(20), 
	age_group TEXT,
	indicators TEXT, 
	characteristics TEXT, 
	uom VARCHAR(15), 
	uom_id INTEGER, 
	scalar_factor VARCHAR(6), 
	scalar_id INTEGER, 
	vector TEXT, 
	coordinate TEXT, 
	value TEXT, 
	status VARCHAR(4), 
	symbol VARCHAR, 
	terminated VARCHAR, 
	decimals INTEGER	
);

COPY health_indicators_raw
FROM 'your\absolute\path\data\raw_data\health_indicators_13100962.csv'
WITH (FORMAT CSV, HEADER);

CREATE TABLE wait_times_raw(
	ref_date INTEGER,
	geo TEXT, 
	dguid VARCHAR(11), 
	gender VARCHAR(20), 
	age_group TEXT,
	indicators TEXT, 
	characteristics TEXT, 
	uom VARCHAR(15), 
	uom_id INTEGER, 
	scalar_factor VARCHAR(6), 
	scalar_id INTEGER, 
	vector TEXT, 
	coordinate TEXT, 
	value TEXT, 
	status VARCHAR(4), 
	symbol VARCHAR, 
	terminated VARCHAR, 
	decimals INTEGER
);

COPY wait_times_raw
FROM 'your\absolute\path\data\raw_data\wait_times_13100961.csv'
WITH (FORMAT CSV, HEADER);





