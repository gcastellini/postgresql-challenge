--Evolution Women in Government during time

--Check which series I need
SELECT * FROM mydatabase.series WHERE 
supersector_code ='90' AND series_title LIKE '%Women%';

--Create table with time series for women
CREATE TABLE mydatabase.womengovernment AS
SELECT * FROM mydatabase.dataset WHERE 
series_id ='CES9000000010' ; 

--Add date column
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

--Drop unnecesary columns
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

--Final table for evolution of women in goverment during time
CREATE TABLE mydatabase.women_in_government
AS SELECT date,value FROM mydatabase.womengov;

ALTER TABLE mydatabase.women_in_government
RENAME value to valueInThousands;

DROP TABLE mydatabase.womengovernment;
DROP TABLE mydatabase.womengov;

-- Evolution of the ratio "production employees / supervisory employees" during time

--Check employees table for the private sector
SELECT * FROM mydatabase.series WHERE supersector_code ='05';

--Create Tables with all employees and production employees
CREATE TABLE mydatabase.allemp AS
SELECT * FROM mydatabase.dataset
WHERE series_id = 'CES0500000001';


CREATE TABLE mydatabase.prodemp AS
SELECT * FROM mydatabase.dataset
WHERE series_id = 'CES0500000006';


ALTER TABLE mydatabase.allemp RENAME value to valueall;
ALTER TABLE mydatabase.prodemp RENAME value to valueprod;

ALTER TABLE mydatabase.prodemp DROP COLUMN series_id;
ALTER TABLE mydatabase.prodemp DROP COLUMN footnote_code;

--Inner Join between all employees and production employees table
CREATE TABLE  mydatabase.merged AS
SELECT mydatabase.allemp.year,mydatabase.allemp.period,valueall,valueprod  FROM mydatabase.prodemp INNER JOIN mydatabase.allemp
ON ((mydatabase.prodemp.year = mydatabase.allemp.year) AND (mydatabase.prodemp.period = mydatabase.allemp.period));

--Add column to calculate ratio
ALTER TABLE mydatabase.merged
ADD COLUMN valuesup int;
UPDATE mydatabase.merged SET valuesup = valueall-valueprod;
--Add date column
ALTER TABLE mydatabase.merged
ADD COLUMN month VARCHAR; 
UPDATE mydatabase.merged SET month = 'January' WHERE period = 'M01'; 
UPDATE mydatabase.merged SET month = 'February' WHERE period = 'M02';
UPDATE mydatabase.merged SET month = 'March' WHERE period = 'M03';
UPDATE mydatabase.merged SET month = 'April' WHERE period = 'M04';
UPDATE mydatabase.merged SET month = 'May' WHERE period = 'M05';
UPDATE mydatabase.merged SET month = 'June' WHERE period = 'M06';
UPDATE mydatabase.merged SET month = 'July' WHERE period = 'M07';
UPDATE mydatabase.merged SET month = 'August' WHERE period = 'M08';
UPDATE mydatabase.merged SET month = 'September' WHERE period = 'M09';
UPDATE mydatabase.merged SET month = 'October' WHERE period = 'M10';
UPDATE mydatabase.merged SET month = 'November' WHERE period = 'M11';
UPDATE mydatabase.merged SET month = 'December' WHERE period = 'M12';
ALTER TABLE mydatabase.merged
ADD COLUMN date VARCHAR; 
UPDATE mydatabase.merged set date = CONCAT(month,' ',year);
--Add ratio column
ALTER TABLE mydatabase.merged
ADD COLUMN ratio float;
UPDATE mydatabase.merged set ratio = valueprod/NULLIF(valuesup,0);

--Final table for production employees / supervisory employees ratio

CREATE TABLE mydatabase.ratio_prod_supervisory AS
SELECT date,valueall,valueprod,valuesup,ratio,year,period FROM mydatabase.merged
ORDER BY year asc, period asc;

ALTER TABLE mydatabase.ratio_prod_supervisory DROP COLUMN year;
ALTER TABLE mydatabase.ratio_prod_supervisory DROP COLUMN period;
ALTER TABLE mydatabase.ratio_prod_supervisory RENAME valueall to allEmployeesThousands;
ALTER TABLE mydatabase.ratio_prod_supervisory RENAME valueprod to prodEmployeesThousands;
ALTER TABLE mydatabase.ratio_prod_supervisory RENAME valuesup to supEmployeesThousands;

DROP TABLE mydatabase.allemp;
DROP TABLE mydatabase.prodemp;
DROP TABLE mydatabase.merged;


--Role creation to access the API

create role web_anon nologin;
grant usage on schema mydatabase to web_anon; 
grant select on ALL TABLES IN SCHEMA mydatabase to web_anon;

create role authenticator noinherit login password 'mysecretpassword';
grant web_anon to authenticator; 




