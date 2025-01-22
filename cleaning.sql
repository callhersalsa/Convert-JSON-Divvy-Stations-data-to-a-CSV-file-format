--* First row contains column names
--* Trips that did not include a start or end date are excluded
select *
from cyclistic_2019
where from_station_id is null or to_station_id is null;

select *
from cyclistic_2020
where start_station_id is null or end_station_id is null;

--* Trips less than 1 minute in duration are excluded
--* Trips greater than 24 hours in duration are excluded
--* Gender and birthday are only available for Subscribers
--* Divvy_Trips_2017_Q1 has 431,691 rows
--* Divvy_Trips_2017_Q2 has 1,119,814 rows

-- 2016

-- 2018
UPDATE cyclistic_2018
SET birthyear = LEFT(birthyear, CHARINDEX(';', birthyear) - 1)
where birthyear like '%;%';

-- 2019
UPDATE cyclistic_2019
SET tripduration = TRIM('"' FROM tripduration),
	from_station_id = TRIM('"' FROM from_station_id),
	from_station_name = TRIM('"' FROM from_station_name);

UPDATE cyclistic_2019
SET tripduration = from_station_id,
	from_station_id = from_station_name,
	from_station_name = to_station_id,
	to_station_id = to_station_name,
	to_station_name = usertype,
	usertype = gender,
	gender = LEFT(birthyear, CHARINDEX(',', birthyear) - 1),
	birthyear = RIGHT(birthyear, LEN(birthyear) - CHARINDEX(',', birthyear))
where from_station_id like '%[0-9].0';

UPDATE cyclistic_2019
SET tripduration = from_station_name,
	from_station_id = to_station_id,
	from_station_name = to_station_name,
	to_station_id = usertype,
	to_station_name = gender,
	usertype = LEFT(birthyear, CHARINDEX(',', birthyear) - 1),
	gender = SUBSTRING(birthyear, CHARINDEX(',', birthyear) + 1, CHARINDEX(',', birthyear, CHARINDEX(',', birthyear) + 1) - CHARINDEX(',', birthyear) - 1),
	birthyear = RIGHT(birthyear, LEN(birthyear) - CHARINDEX(',', birthyear, CHARINDEX(',', birthyear) + 1))
where from_station_name like '%[0-9].0';

DELETE
FROM cyclistic_2019
WHERE trip_id like 'trip_id';

DELETE
FROM cyclistic_2020
WHERE ride_id like 'ride_id';

DELETE
FROM cyclistic_2021
WHERE ride_id like 'ride_id';

DELETE
FROM cyclistic_2022
WHERE ride_id like 'ride_id';

DELETE
FROM cyclistic_2023
WHERE ride_id like 'ride_id';

DELETE
FROM cyclistic_2024
WHERE rideable_type like 'rideable_type';

-- 2022

UPDATE cyclistic_2022
SET 
    ride_id = TRIM('"' FROM ride_id),
    rideable_type = TRIM('"' FROM rideable_type),
    started_at = TRIM('"' FROM started_at),
    ended_at = TRIM('"' FROM ended_at),
    start_station_name = TRIM('"' FROM start_station_name),
    start_station_id = TRIM('"' FROM start_station_id),
    end_station_name = TRIM('"' FROM end_station_name),
    end_station_id = TRIM('"' FROM end_station_id),
    start_lat = TRIM('"' FROM start_lat),
    start_lng = TRIM('"' FROM start_lng),
    end_lat = TRIM('"' FROM end_lat),
    end_lng = TRIM('"' FROM end_lng),
    member_casual = TRIM('"' FROM member_casual);

UPDATE cyclistic_2022
SET 
    ride_id = CASE 
                WHEN ride_id LIKE '%*' THEN LEFT(ride_id, LEN(ride_id) - 1) 
                ELSE ride_id 
              END,
    rideable_type = CASE 
                      WHEN rideable_type LIKE '%*' THEN LEFT(rideable_type, LEN(rideable_type) - 1) 
                      ELSE rideable_type 
                    END,
    started_at = CASE 
                   WHEN started_at LIKE '%*' THEN LEFT(started_at, LEN(started_at) - 1) 
                   ELSE started_at 
                 END,
    ended_at = CASE 
                 WHEN ended_at LIKE '%*' THEN LEFT(ended_at, LEN(ended_at) - 1) 
                 ELSE ended_at 
               END,
    start_station_name = CASE 
                           WHEN start_station_name LIKE '%*' THEN LEFT(start_station_name, LEN(start_station_name) - 1) 
                           ELSE start_station_name 
                         END,
    start_station_id = CASE 
                         WHEN start_station_id LIKE '%*' THEN LEFT(start_station_id, LEN(start_station_id) - 1) 
                         ELSE start_station_id 
                       END,
    end_station_name = CASE 
                         WHEN end_station_name LIKE '%*' THEN LEFT(end_station_name, LEN(end_station_name) - 1) 
                         ELSE end_station_name 
                       END,
    end_station_id = CASE 
                       WHEN end_station_id LIKE '%*' THEN LEFT(end_station_id, LEN(end_station_id) - 1) 
                       ELSE end_station_id 
                     END,
    start_lat = CASE 
                  WHEN start_lat LIKE '%*' THEN LEFT(start_lat, LEN(start_lat) - 1) 
                  ELSE start_lat 
                END,
    start_lng = CASE 
                  WHEN start_lng LIKE '%*' THEN LEFT(start_lng, LEN(start_lng) - 1) 
                  ELSE start_lng 
                END,
    end_lat = CASE 
                WHEN end_lat LIKE '%*' THEN LEFT(end_lat, LEN(end_lat) - 1) 
                ELSE end_lat 
              END,
    end_lng = CASE 
                WHEN end_lng LIKE '%*' THEN LEFT(end_lng, LEN(end_lng) - 1) 
                ELSE end_lng 
              END,
    member_casual = CASE 
                      WHEN member_casual LIKE '%*' THEN LEFT(member_casual, LEN(member_casual) - 1) 
                      ELSE member_casual 
                    END;

SELECT *
FROM cyclistic_2022
WHERE 
    ride_id LIKE '%*' OR
    rideable_type LIKE '%*' OR
    started_at LIKE '%*' OR
    ended_at LIKE '%*' OR
    start_station_name LIKE '%*' OR
    start_station_id LIKE '%*' OR
    end_station_name LIKE '%*' OR
    end_station_id LIKE '%*' OR
    start_lat LIKE '%*' OR
    start_lng LIKE '%*' OR
    end_lat LIKE '%*' OR
    end_lng LIKE '%*' OR
    member_casual LIKE '%*';

SELECT *
FROM cyclistic_2022
WHERE 
    ride_id LIKE '*%' OR
    rideable_type LIKE '*%' OR
    started_at LIKE '*%' OR
    ended_at LIKE '*%' OR
    start_station_name LIKE '*%' OR
    start_station_id LIKE '*%' OR
    end_station_name LIKE '*%' OR
    end_station_id LIKE '*%' OR
    start_lat LIKE '*%' OR
    start_lng LIKE '*%' OR
    end_lat LIKE '*%' OR
    end_lng LIKE '*%' OR
    member_casual LIKE '*%';

-- 2024
UPDATE cyclistic_2024
SET 
    ride_id = TRIM('"' FROM ride_id),
    rideable_type = TRIM('"' FROM rideable_type),
    started_at = TRIM('"' FROM started_at),
    ended_at = TRIM('"' FROM ended_at),
    start_station_name = TRIM('"' FROM start_station_name),
    start_station_id = TRIM('"' FROM start_station_id),
    end_station_name = TRIM('"' FROM end_station_name),
    end_station_id = TRIM('"' FROM end_station_id),
    start_lat = TRIM('"' FROM start_lat),
    start_lng = TRIM('"' FROM start_lng),
    end_lat = TRIM('"' FROM end_lat),
    end_lng = TRIM('"' FROM end_lng),
    member_casual = TRIM('"' FROM member_casual);

WITH dup AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY trip_id, starttime, stoptime, bikeid, tripduration,
	from_station_id, from_station_name, to_station_id, to_station_name,
	usertype, gender, birthyear ORDER BY trip_id) AS RowNum
    FROM cyclistic_2016
)
SELECT * FROM dup WHERE RowNum > 1;

WITH dup AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY trip_id, start_time, end_time, bikeid, tripduration,
	from_station_id, from_station_name, to_station_id, to_station_name,
	usertype, gender, birthyear ORDER BY trip_id) AS RowNum
    FROM cyclistic_2017
)
SELECT * FROM dup WHERE RowNum > 1;

WITH dup AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY trip_id, start_time, end_time, bikeid, tripduration,
	from_station_id, from_station_name, to_station_id, to_station_name,
	usertype, gender, birthyear ORDER BY trip_id) AS RowNum
    FROM cyclistic_2018
)

DELETE FROM dup WHERE RowNum > 1;

WITH dup AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY trip_id, start_time, end_time, bikeid, tripduration,
	from_station_id, from_station_name, to_station_id, to_station_name,
	usertype, gender, birthyear ORDER BY trip_id) AS RowNum
    FROM cyclistic_2019
)

DELETE cyclistic_2019
where gender = 'Member Gender';

DELETE FROM dup WHERE RowNum > 1;

-- 2020
WITH dup AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY ride_id, rideable_type, started_at, ended_at,
	start_station_id, start_station_name, end_station_id, end_station_name,
	start_lat, start_lng, end_lat, end_lng,
	member_casual ORDER BY ride_id) AS RowNum
    FROM cyclistic_2020
)

SELECT * FROM dup WHERE RowNum > 1;

SELECT *
FROM cyclistic_2020
WHERE started_at > ended_at;

DELETE FROM cyclistic_2020
WHERE (ride_id IN (
    SELECT ride_id
    FROM cyclistic_2020
    GROUP BY ride_id
    HAVING COUNT(*) > 1
)) AND started_at > ended_at;

UPDATE cyclistic_2020
SET
	started_at = ended_at,
	ended_at = started_at
WHERE started_at > ended_at;

-- 2022
DELETE FROM cyclistic_2022 WHERE ride_id = '"ride_id"';

WITH dup AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY ride_id, rideable_type, started_at, ended_at,
	start_station_id, start_station_name, end_station_id, end_station_name,
	start_lat, start_lng, end_lat, end_lng,
	member_casual ORDER BY ride_id) AS RowNum
    FROM cyclistic_2022
)

SELECT * FROM dup WHERE RowNum > 1;

WITH dup AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY ride_id, rideable_type, started_at, ended_at,
	start_station_id, start_station_name, end_station_id, end_station_name,
	start_lat, start_lng, end_lat, end_lng,
	member_casual ORDER BY ride_id) AS RowNum
    FROM cyclistic_2023
)

SELECT * FROM dup WHERE RowNum > 1;

DELETE FROM cyclistic_2023 WHERE ride_id = 'ride_id' or ride_id = 'rideable_type';

WITH dup AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY ride_id, rideable_type, started_at, ended_at,
	start_station_id, start_station_name, end_station_id, end_station_name,
	start_lat, start_lng, end_lat, end_lng,
	member_casual ORDER BY ride_id) AS RowNum
    FROM cyclistic_2024
)

SELECT * FROM dup WHERE RowNum > 1;

ALTER TABLE Divvy_Stations
ALTER COLUMN id INT NOT NULL;

ALTER TABLE Divvy_Stations
ALTER COLUMN name VARCHAR(50) NOT NULL;

ALTER TABLE Divvy_Stations
ALTER COLUMN city VARCHAR(50) NOT NULL;

ALTER TABLE Divvy_Stations
ALTER COLUMN latitude FLOAT NOT NULL;

ALTER TABLE Divvy_Stations
ALTER COLUMN longitude FLOAT NOT NULL;

ALTER TABLE Divvy_Stations
ALTER COLUMN dpcapacity INT NOT NULL;

ALTER TABLE Divvy_Stations
ALTER COLUMN online_date DATETIME NOT NULL;

ALTER TABLE Divvy_Stations
ADD CONSTRAINT PK_Divvy_Stations PRIMARY KEY (id);

-- CYCLISTIC_2016
ALTER TABLE Cyclistic_2016 ALTER COLUMN trip_id INT NOT NULL;
ALTER TABLE Cyclistic_2016 ALTER COLUMN starttime DATETIME;
ALTER TABLE Cyclistic_2016 ALTER COLUMN stoptime DATETIME;
ALTER TABLE Cyclistic_2016 ALTER COLUMN bikeid INT;
ALTER TABLE Cyclistic_2016 ALTER COLUMN tripduration FLOAT;
ALTER TABLE Cyclistic_2016 ALTER COLUMN from_station_id INT;
ALTER TABLE Cyclistic_2016 ALTER COLUMN from_station_name VARCHAR(50);
ALTER TABLE Cyclistic_2016 ALTER COLUMN to_station_id INT;
ALTER TABLE Cyclistic_2016 ALTER COLUMN to_station_name VARCHAR(50);
ALTER TABLE Cyclistic_2016 ALTER COLUMN usertype VARCHAR(50);
ALTER TABLE Cyclistic_2016 ALTER COLUMN gender VARCHAR(50);
ALTER TABLE Cyclistic_2016 ALTER COLUMN birthyear INT;

ALTER TABLE Cyclistic_2016
ADD CONSTRAINT PK_Cyclistic_2016 PRIMARY KEY (trip_id);

-- cyclistic_2017
ALTER TABLE Cyclistic_2017 ALTER COLUMN trip_id INT NOT NULL;
ALTER TABLE Cyclistic_2017 ALTER COLUMN start_time DATETIME;
ALTER TABLE Cyclistic_2017 ALTER COLUMN end_time DATETIME;
ALTER TABLE Cyclistic_2017 ALTER COLUMN bikeid INT;
ALTER TABLE Cyclistic_2017 ALTER COLUMN tripduration FLOAT;
ALTER TABLE Cyclistic_2017 ALTER COLUMN from_station_id INT;
ALTER TABLE Cyclistic_2017 ALTER COLUMN from_station_name VARCHAR(50);
ALTER TABLE Cyclistic_2017 ALTER COLUMN to_station_id INT;
ALTER TABLE Cyclistic_2017 ALTER COLUMN to_station_name VARCHAR(50);
ALTER TABLE Cyclistic_2017 ALTER COLUMN usertype VARCHAR(50);
ALTER TABLE Cyclistic_2017 ALTER COLUMN gender VARCHAR(50);
ALTER TABLE Cyclistic_2017 ALTER COLUMN birthyear INT;

ALTER TABLE Cyclistic_2017
ADD CONSTRAINT PK_Cyclistic_2017 PRIMARY KEY (trip_id);

-- cyclistic_2018
ALTER TABLE Cyclistic_2018 ALTER COLUMN trip_id INT NOT NULL;
ALTER TABLE Cyclistic_2018 ALTER COLUMN start_time DATETIME;
ALTER TABLE Cyclistic_2018 ALTER COLUMN end_time DATETIME;
ALTER TABLE Cyclistic_2018 ALTER COLUMN bikeid INT;
ALTER TABLE Cyclistic_2018 ALTER COLUMN tripduration FLOAT;
ALTER TABLE Cyclistic_2018 ALTER COLUMN from_station_id INT;
ALTER TABLE Cyclistic_2018 ALTER COLUMN from_station_name VARCHAR(50);
ALTER TABLE Cyclistic_2018 ALTER COLUMN to_station_id INT;
ALTER TABLE Cyclistic_2018 ALTER COLUMN to_station_name VARCHAR(50);
ALTER TABLE Cyclistic_2018 ALTER COLUMN usertype VARCHAR(50);
ALTER TABLE Cyclistic_2018 ALTER COLUMN gender VARCHAR(50);
ALTER TABLE Cyclistic_2018 ALTER COLUMN birthyear INT;

ALTER TABLE Cyclistic_2018
ADD CONSTRAINT PK_Cyclistic_2018 PRIMARY KEY (trip_id);

-- CYCLISTIC_2019
ALTER TABLE Cyclistic_2019 ALTER COLUMN trip_id INT NOT NULL;
ALTER TABLE Cyclistic_2019 ALTER COLUMN start_time DATETIME;
ALTER TABLE Cyclistic_2019 ALTER COLUMN end_time DATETIME;
ALTER TABLE Cyclistic_2019 ALTER COLUMN bikeid INT;
ALTER TABLE Cyclistic_2019 ALTER COLUMN tripduration FLOAT;
ALTER TABLE Cyclistic_2019 ALTER COLUMN from_station_id INT;
ALTER TABLE Cyclistic_2019 ALTER COLUMN from_station_name VARCHAR(50);
ALTER TABLE Cyclistic_2019 ALTER COLUMN to_station_id INT;
ALTER TABLE Cyclistic_2019 ALTER COLUMN to_station_name VARCHAR(50);
ALTER TABLE Cyclistic_2019 ALTER COLUMN usertype VARCHAR(50);
ALTER TABLE Cyclistic_2019 ALTER COLUMN gender VARCHAR(50);
ALTER TABLE Cyclistic_2019 ALTER COLUMN birthyear INT;

ALTER TABLE Cyclistic_2019
ADD CONSTRAINT PK_Cyclistic_2019 PRIMARY KEY (trip_id);

-- cyclistic_2020
ALTER TABLE cyclistic_2020 ALTER COLUMN ride_id VARCHAR(50) NOT NULL;
ALTER TABLE cyclistic_2020 ALTER COLUMN rideable_type VARCHAR(50);
ALTER TABLE cyclistic_2020 ALTER COLUMN started_at DATETIME;
ALTER TABLE cyclistic_2020 ALTER COLUMN ended_at DATETIME;
ALTER TABLE cyclistic_2020 ALTER COLUMN start_station_id VARCHAR(50);
ALTER TABLE cyclistic_2020 ALTER COLUMN start_station_name VARCHAR(50);
ALTER TABLE cyclistic_2020 ALTER COLUMN end_station_id VARCHAR(50);
ALTER TABLE cyclistic_2020 ALTER COLUMN end_station_name VARCHAR(50);
ALTER TABLE cyclistic_2020 ALTER COLUMN start_lat FLOAT;
ALTER TABLE cyclistic_2020 ALTER COLUMN start_lng FLOAT;
ALTER TABLE cyclistic_2020 ALTER COLUMN end_lat FLOAT;
ALTER TABLE cyclistic_2020 ALTER COLUMN end_lng FLOAT;
ALTER TABLE cyclistic_2020 ALTER COLUMN member_casual VARCHAR(50);

ALTER TABLE Cyclistic_2020
ADD CONSTRAINT PK_Cyclistic_2020 PRIMARY KEY (ride_id);

-- cyclistic_2021
ALTER TABLE cyclistic_2021 ALTER COLUMN ride_id VARCHAR(50) NOT NULL;
ALTER TABLE cyclistic_2021 ALTER COLUMN rideable_type VARCHAR(50);
ALTER TABLE cyclistic_2021 ALTER COLUMN started_at DATETIME;
ALTER TABLE cyclistic_2021 ALTER COLUMN ended_at DATETIME;
ALTER TABLE cyclistic_2021 ALTER COLUMN start_station_id VARCHAR(50);
ALTER TABLE cyclistic_2021 ALTER COLUMN start_station_name VARCHAR(50);
ALTER TABLE cyclistic_2021 ALTER COLUMN end_station_id VARCHAR(50);
ALTER TABLE cyclistic_2021 ALTER COLUMN end_station_name VARCHAR(50);
ALTER TABLE cyclistic_2021 ALTER COLUMN start_lat FLOAT;
ALTER TABLE cyclistic_2021 ALTER COLUMN start_lng FLOAT;
ALTER TABLE cyclistic_2021 ALTER COLUMN end_lat FLOAT;
ALTER TABLE cyclistic_2021 ALTER COLUMN end_lng FLOAT;
ALTER TABLE cyclistic_2021 ALTER COLUMN member_casual VARCHAR(50);

ALTER TABLE Cyclistic_2021
ADD CONSTRAINT PK_Cyclistic_2021 PRIMARY KEY (ride_id);

-- cyclistic_2022
ALTER TABLE cyclistic_2022 ALTER COLUMN ride_id VARCHAR(50) NOT NULL;
ALTER TABLE cyclistic_2022 ALTER COLUMN rideable_type VARCHAR(50);
ALTER TABLE cyclistic_2022 ALTER COLUMN started_at DATETIME;
ALTER TABLE cyclistic_2022 ALTER COLUMN ended_at DATETIME;
ALTER TABLE cyclistic_2022 ALTER COLUMN start_station_id VARCHAR(50);
ALTER TABLE cyclistic_2022 ALTER COLUMN start_station_name VARCHAR(50);
ALTER TABLE cyclistic_2022 ALTER COLUMN end_station_id VARCHAR(50);
ALTER TABLE cyclistic_2022 ALTER COLUMN end_station_name VARCHAR(50);
ALTER TABLE cyclistic_2022 ALTER COLUMN start_lat FLOAT;
ALTER TABLE cyclistic_2022 ALTER COLUMN start_lng FLOAT;
ALTER TABLE cyclistic_2022 ALTER COLUMN end_lat FLOAT;
ALTER TABLE cyclistic_2022 ALTER COLUMN end_lng FLOAT;
ALTER TABLE cyclistic_2022 ALTER COLUMN member_casual VARCHAR(50);

ALTER TABLE cyclistic_2022
ADD CONSTRAINT PK_Cyclistic_2022 PRIMARY KEY (ride_id);

-- cyclistic_2023
ALTER TABLE cyclistic_2023 ALTER COLUMN ride_id VARCHAR(50) NOT NULL;
ALTER TABLE cyclistic_2023 ALTER COLUMN rideable_type VARCHAR(50);
ALTER TABLE cyclistic_2023 ALTER COLUMN started_at DATETIME;
ALTER TABLE cyclistic_2023 ALTER COLUMN ended_at DATETIME;
ALTER TABLE cyclistic_2023 ALTER COLUMN start_station_id VARCHAR(50);
ALTER TABLE cyclistic_2023 ALTER COLUMN start_station_name VARCHAR(50);
ALTER TABLE cyclistic_2023 ALTER COLUMN end_station_id VARCHAR(50);
ALTER TABLE cyclistic_2023 ALTER COLUMN end_station_name VARCHAR(50);
ALTER TABLE cyclistic_2023 ALTER COLUMN start_lat FLOAT;
ALTER TABLE cyclistic_2023 ALTER COLUMN start_lng FLOAT;
ALTER TABLE cyclistic_2023 ALTER COLUMN end_lat FLOAT;
ALTER TABLE cyclistic_2023 ALTER COLUMN end_lng FLOAT;
ALTER TABLE cyclistic_2023 ALTER COLUMN member_casual VARCHAR(50);

ALTER TABLE cyclistic_2023
ADD CONSTRAINT PK_cyclistic_2023 PRIMARY KEY (ride_id);

-- cyclistic_2024
ALTER TABLE cyclistic_2024 ALTER COLUMN ride_id VARCHAR(50) NOT NULL;
ALTER TABLE cyclistic_2024 ALTER COLUMN rideable_type VARCHAR(50);
ALTER TABLE cyclistic_2024 ALTER COLUMN started_at DATETIME;
ALTER TABLE cyclistic_2024 ALTER COLUMN ended_at DATETIME;
ALTER TABLE cyclistic_2024 ALTER COLUMN start_station_id VARCHAR(50);
ALTER TABLE cyclistic_2024 ALTER COLUMN start_station_name VARCHAR(50);
ALTER TABLE cyclistic_2024 ALTER COLUMN end_station_id VARCHAR(50);
ALTER TABLE cyclistic_2024 ALTER COLUMN end_station_name VARCHAR(50);
ALTER TABLE cyclistic_2024 ALTER COLUMN start_lat FLOAT;
ALTER TABLE cyclistic_2024 ALTER COLUMN start_lng FLOAT;
ALTER TABLE cyclistic_2024 ALTER COLUMN end_lat FLOAT;
ALTER TABLE cyclistic_2024 ALTER COLUMN end_lng FLOAT;
ALTER TABLE cyclistic_2024 ALTER COLUMN member_casual VARCHAR(50);

ALTER TABLE cyclistic_2024
ADD CONSTRAINT PK_cyclistic_2024 PRIMARY KEY (ride_id);


INSERT INTO Divvy_Stations (id, name, city, latitude, longitude, dpcapacity, online_date) 
VALUES (372, 'N Hamlin Ave & W Grand Ave', 'Chicago', 41.9039946, -87.7215561, NULL, NULL);

ALTER TABLE cyclistic_2016
ADD CONSTRAINT FK_2016_FromStation
FOREIGN KEY (from_station_id) REFERENCES Divvy_Stations(id);

ALTER TABLE cyclistic_2016
ADD CONSTRAINT FK__2016ToStation
FOREIGN KEY (to_station_id) REFERENCES Divvy_Stations(id);

WITH DuplicateRideIds AS (
    SELECT ride_id
    FROM cyclistic_2024
    GROUP BY ride_id
    HAVING COUNT(*) > 1
)
DELETE FROM cyclistic_2024
WHERE ride_id IN (SELECT ride_id FROM DuplicateRideIds)
  AND FORMAT(started_at, 'fff') = '000'
  AND FORMAT(ended_at, 'fff') = '000';

 UPDATE cyclistic_2020
SET 
    cyclistic_2020.start_station_id = divvy_stations.id,
    cyclistic_2020.start_lat = divvy_stations.latitude,
    cyclistic_2020.start_lng = divvy_stations.longitude
FROM cyclistic_2020
INNER JOIN divvy_stations
    ON cyclistic_2020.start_station_name = divvy_stations.name;

UPDATE cyclistic_2024
SET 
    cyclistic_2024.end_station_id = divvy_stations.id,
    cyclistic_2024.end_lat = divvy_stations.latitude,
    cyclistic_2024.end_lng = divvy_stations.longitude
FROM cyclistic_2024
INNER JOIN divvy_stations
    ON cyclistic_2024.end_station_name = divvy_stations.name;

SELECT *
FROM cyclistic_2024
WHERE end_station_name = 'Stetson Ave & South Water St';

SELECT *
FROM cyclistic_2023
WHERE ((start_station_name IS NULL OR start_station_name = '')
	OR (start_station_id IS NULL OR start_station_id = '')
	OR (end_station_name IS NULL OR end_station_name = '')
	OR (end_station_id IS NULL OR end_station_name = '')) AND (start_lat = '41.65' AND start_lng = '-87.62')
ORDER BY start_lat, start_lng;

-- check length_time for started_at > ended_at
SELECT 
    *, 
    DATEDIFF(second, ended_at, started_at) AS length_time_seconds 
FROM 
    cyclistic_2023
WHERE 
    started_at > ended_at -- Corrected condition
ORDER BY 
    start_lat, start_lng;

-- count missing value in each bike type in each year


-- list of station
WITH stations_2023 AS (
    SELECT DISTINCT 
        start_station_name AS station_name_2023,
        start_station_id AS station_id_2023,
        LEFT(start_lat, CHARINDEX('.', start_lat) + 2) AS lat,
        LEFT(start_lng, CHARINDEX('.', start_lng) + 2) AS long
    FROM 
        cyclistic_2023
    WHERE 
        (start_station_name IS NOT NULL AND start_station_name <> '')
        AND (start_station_id IS NOT NULL AND start_station_id <> '')
        AND (start_lat IS NOT NULL AND start_lat <> '')
        AND (start_lng IS NOT NULL AND start_lng <> '')
),
unique_positions AS (
    SELECT 
        lat, long, 
        COUNT(*) AS stations_same
    FROM 
        stations_2023
    GROUP BY 
        lat, long
    HAVING 
        COUNT(*) = 1
)

SELECT *
FROM stations_2023; -- change the table name accordingly

--- check the lat and long of missing values in start station
SELECT distinct start_lat, start_lng
FROM cyclistic_2023
WHERE ((start_station_name IS NULL OR start_station_name = '')
	AND (start_station_id IS NULL OR start_station_id = '')) 
ORDER BY start_lat, start_lng;

-- find missing id station with len lat and long < 6
select *
from cyclistic_2023
where ((start_station_name is not null 
  and start_station_name <> '')
  and (start_station_id = '' or start_station_id is null))
  OR ((end_station_name is not null 
  and end_station_name <> '')
  and (end_station_id = '' or end_station_id is null)) 
  AND len(start_lat) < 5 and len(start_lng) < 6;

--- find missing id start station
select distinct start_station_name
from cyclistic_2023
where ((start_station_name <> '')
  and (start_station_id = ''))

 ;


 WITH stations_2023 AS (
    SELECT DISTINCT 
        start_station_name AS station_name_2023,
        start_station_id AS station_id_2023,
        LEFT(start_lat, CHARINDEX('.', start_lat) + 2) AS lat,
        LEFT(start_lng, CHARINDEX('.', start_lng) + 2) AS long
    FROM 
        cyclistic_2023
    WHERE 
        (start_station_name IS NOT NULL AND start_station_name <> '')
        AND (start_station_id IS NOT NULL AND start_station_id <> '')
        AND (start_lat IS NOT NULL AND start_lat <> '')
        AND (start_lng IS NOT NULL AND start_lng <> '')
        AND start_station_name NOT LIKE 'Public Rack%'
),
unique_positions AS (
    SELECT 
        lat, long,
        COUNT(*) AS stations_same
    FROM 
        stations_2023
    GROUP BY 
        lat, long
    HAVING 
        COUNT(*) = 1
),
stations_2023_unique AS (
    SELECT s.station_name_2023, s.station_id_2023, s.lat, s.long
    FROM unique_positions AS u
    JOIN stations_2023 AS s
        ON u.lat = s.lat
        AND u.long = s.long
)

UPDATE cyclistic_2023
SET 
    start_station_name = station_name_2023,
    start_station_id = station_id_2023
FROM stations_2023_unique
WHERE ((start_station_name = '' AND start_station_id = '')
    AND (LEN(start_lat) <= 5 AND LEN(start_lng) <= 6))
    AND (start_lat = lat AND start_lng = long);


UPDATE c
SET 
 c.end_station_name = s.station_2023,
    c.end_station_id = s.id_2023 -- Assuming `station_id` is the column in stations_2023
FROM 
    cyclistic_2023 c
JOIN 
    stations_2023 s ON c.end_lat = s.lat 
                    AND c.end_lng = s.long
WHERE (
    c.end_station_name = '' 
    AND c.end_station_id = '' )
    AND (
	LEN(c.end_lat) <= 5 
    AND LEN(c.end_lng) <= 6);

UPDATE c
SET 
 c.start_station_name = s.station_2024,
    c.start_station_id = s.id_2024
FROM 
    cyclistic_2024 c
JOIN 
    stations_2024 s
	ON c.start_lat = s.lat 
    AND c.start_lng = s.long
WHERE (
    c.start_station_name = '' 
    AND c.start_station_id = '' )
    AND (
	LEN(c.start_lat) <= 5 
    AND LEN(c.start_lng) <= 6);

select *
from stations_information
join (select distinct start_station_name, start_station_id
from cyclistic_2024) as c
on station_name = c.start_station_name
where id = ''
order by station_name

ALTER TABLE cyclistic_2024_precleaned
ADD CONSTRAINT PK_cyclistic_2024 PRIMARY KEY (ride_id);

ALTER TABLE cyclistic_2024_precleaned
ADD ride_length INT,
	hour_start INT,
	hour_end INT,
	month_name NVARCHAR(20), -- Column to store the name of the month
    day_of_the_week NVARCHAR(20), -- Column to store the name of the day
    is_weekend BIT; -- Column to indicate whether it's a weekend (1 for Yes, 0 for No)

UPDATE cyclistic_2024_precleaned
SET month = DATENAME(MONTH, started_at); -- Replace `started_at` with the actual datetime column

UPDATE cyclistic_2024_precleaned
SET day_of_the_week = DATENAME(WEEKDAY, started_at);

UPDATE cyclistic_2024_precleaned
SET is_weekend = CASE 
    WHEN DATENAME(WEEKDAY, started_at) IN ('Saturday', 'Sunday') THEN 1
    ELSE 0
END;

UPDATE cyclistic_2024_precleaned
SET ride_duration = DATEDIFF(second, started_at, ended_at);

UPDATE cyclistic_2024_precleaned
SET hour_start = DATEPART(HOUR, started_at),
	hour_end = DATEPART(HOUR, ended_at);

UPDATE c
SET start_lat = si.latitude,
    start_lng = si.longitude
FROM cyclistic_2024_precleaned c
JOIN stations_information si
ON c.start_station_name = si.station_name AND c.start_station_id = si.id
WHERE LEN(c.start_station_name) <> 0 
  AND LEN(c.start_lat) <= 5 
  AND LEN(c.start_lng) <= 6;	

UPDATE c
SET end_lat = si.latitude,
    end_lng = si.longitude
FROM cyclistic_2024_precleaned c
JOIN stations_information si
ON c.end_station_name = si.station_name AND c.end_station_id = si.id
WHERE LEN(c.end_station_name) <> 0 
  AND LEN(c.end_lat) <= 5 
  AND LEN(c.end_lng) <= 6;	