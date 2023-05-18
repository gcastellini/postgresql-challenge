/*
 CREATE SCHEMA mydatabase; 
 CREATE TABLE mydatabase.dataset (series_id VARCHAR,year INT,period VARCHAR,value float,footnote_code VARCHAR); 
\copy mydatabase.dataset FROM 'C:/Users/Giuliana Castellini/Documents/Giuliana 2/Nimble/ce.data.0.AllCESSeries.txt' DELIMITER '|' CSV HEADER;
 CREATE TABLE mydatabase.sectors (supersector_code VARCHAR,supersector_name VARCHAR);
\copy mydatabase.sectors FROM 'C:/Users/Giuliana Castellini/Documents/Giuliana 2/Nimble/sector_codes.txt' DELIMITER '|' CSV HEADER;
 CREATE TABLE mydatabase.series (series_id VARCHAR,supersector_code VARCHAR,industry_code VARCHAR,data_type_code VARCHAR,seasonal VARCHAR,series_title VARCHAR, 
 footnote_codes VARCHAR, begin_year INT, begin_period VARCHAR,end_year INT, end_period VARCHAR);
 \copy mydatabase.series FROM 'C:/Users/Giuliana Castellini/Documents/Giuliana 2/Nimble/ce.series.txt' DELIMITER '|' CSV HEADER; 
*/
/*
CREATE TABLE mydatabase.women AS
SELECT * FROM mydatabase.series WHERE 
supersector_code ='90' AND series_title LIKE '%Women%';
*/

/*CREATE TABLE mydatabase.womengovernment AS
SELECT * FROM mydatabase.dataset WHERE 
series_id ='CES9000000010' ; 
ALTER TABLE mydatabase.womengovernment 
ADD COLUMN month VARCHAR; 
UPDATE mydatabase.womengovernment SET month = 'January' WHERE period = 'M01'; 
UPDATE mydatabase.womengovernment SET month = 'February' WHERE period = 'M02';
UPDATE mydatabase.womengovernment SET month = 'March' WHERE period = 'M03';
UPDATE mydatabase.womengovernment SET month = 'April' WHERE period = 'M04';
UPDATE mydatabase.womengovernment SET month = 'May' WHERE period = 'M05';
UPDATE mydatabase.womengovernment SET month = 'June' WHERE period = 'M06';
UPDATE mydatabase.womengovernment SET month = 'July' WHERE period = 'M07';
UPDATE mydatabase.womengovernment SET month = 'August' WHERE period = 'M08';
UPDATE mydatabase.womengovernment SET month = 'September' WHERE period = 'M09';
UPDATE mydatabase.womengovernment SET month = 'October' WHERE period = 'M10';
UPDATE mydatabase.womengovernment SET month = 'November' WHERE period = 'M11';
UPDATE mydatabase.womengovernment SET month = 'December' WHERE period = 'M12';

ALTER TABLE mydatabase.womengovernment
ADD COLUMN date VARCHAR; 
UPDATE mydatabase.womengovernment SET date = CONCAT(month,' ',year);

CREATE TABLE mydatabase.womengov AS
SELECT * FROM mydatabase.womengovernment ORDER BY year asc, period asc;

ALTER TABLE mydatabase.womengov
DROP COLUMN series_id;
ALTER TABLE mydatabase.womengov
DROP COLUMN year;
ALTER TABLE mydatabase.womengov
DROP COLUMN period;
ALTER TABLE mydatabase.womengov
DROP COLUMN footnote_code;
ALTER TABLE mydatabase.womengov
DROP COLUMN MONTH;

CREATE TABLE mydatabase.women_in_government
AS SELECT date,value FROM mydatabase.temp;

ALTER TABLE mydatabase.women_in_government
RENAME value to valueInThousands;
*/

/*
create role web_anon nologin;
grant usage on schema mydatabase to web_anon; 
grant select on ALL TABLES IN SCHEMA mydatabase to web_anon;

create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator; 
*/


