--* This file contains queries for dataset 2024's data cleaning of a bike-sharing analysis for Google Data Analytics Project Capstones
--* To run this file you have to have the stations_information table in your database.
--* You can run this query just in a single time
--* SQL SERVER query


--* Remove the quotation marks (*) and asterisk (*).
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

UPDATE cyclistic_2024 
SET 
    ride_id = TRIM('*' FROM ride_id),
    rideable_type = TRIM('*' FROM rideable_type),
    started_at = TRIM('*' FROM started_at),
    ended_at = TRIM('*' FROM ended_at),
    start_station_name = TRIM('*' FROM start_station_name),
    start_station_id = TRIM('*' FROM start_station_id),
    end_station_name = TRIM('*' FROM end_station_name),
    end_station_id = TRIM('*' FROM end_station_id),
    start_lat = TRIM('*' FROM start_lat),
    start_lng = TRIM('*' FROM start_lng),
    end_lat = TRIM('*' FROM end_lat),
    end_lng = TRIM('*' FROM end_lng),
    member_casual = TRIM('*' FROM member_casual);

--* Delete remained csv header when it was merged
DELETE FROM cyclistic_2024 
WHERE rideable_type = 'rideable_type';

--* Delete rideable_type, started_at, ended_at, and member_casual missing value
DELETE FROM cyclistic_2024
WHERE (rideable_type IS NULL OR rideable_type = '')
 OR (started_at IS NULL OR started_at = '')
 OR (ended_at IS NULL OR ended_at = '')
 OR (member_casual IS NULL OR member_casual = '');

--* Delete missing end station and position
DELETE
FROM cyclistic_2024
WHERE (end_station_name = '' AND end_station_id = '')
 AND (end_lat = '' AND end_lng = '');

-* Handle missing IDs from station information by matching it with cyclistic 2024 stations
UPDATE s  
SET s.id = c.start_station_id
FROM stations_information s
JOIN (
    SELECT DISTINCT start_station_name, start_station_id
    FROM cyclistic_2024
) AS c
ON s.station_name = c.start_station_name
WHERE s.id = '';


--* To configure station info in cylistic from the station information table
UPDATE c
SET c.start_station_name = si.station_name
FROM cyclistic_2024 c
JOIN stations_information si
ON c.start_station_id = si.id
WHERE (c.start_station_name <> '' AND c.start_station_id <> '') AND
 c.start_station_name NOT IN (
    SELECT station_name
    FROM stations_information
);

UPDATE c
SET c.start_station_id = si.id
FROM cyclistic_2024 c
JOIN stations_information si
ON c.start_station_name = si.station_name
WHERE (c.start_station_name <> '' AND c.start_station_id <> '') AND
 c.start_station_id NOT IN (
    SELECT id
    FROM stations_information
);

UPDATE c
SET c.end_station_name = si.station_name
FROM cyclistic_2024 c
JOIN stations_information si
ON c.end_station_id = si.id
WHERE (c.end_station_name <> '' AND c.end_station_id <> '') AND
 c.end_station_name NOT IN (
    SELECT station_name
    FROM stations_information
);

UPDATE c
SET c.end_station_id = si.id
FROM cyclistic_2024 c
JOIN stations_information si
ON c.end_station_name = si.station_name
WHERE (c.end_station_name <> '' AND c.end_station_id <> '') AND
 c.end_station_id NOT IN (
    SELECT id
    FROM stations_information
);

--* To fix inconsistent station names
UPDATE c
SET 
    c.start_station_name = CASE
        WHEN c.start_station_name LIKE 'La Villita Park%' THEN 'La Villita Park'
        WHEN c.start_station_name LIKE 'Kildare Ave & 85th St%' THEN 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO'
        ELSE c.start_station_name
    END,
    c.end_station_name = CASE
        WHEN c.end_station_name LIKE 'La Villita Park%' THEN 'La Villita Park'
        WHEN c.end_station_name LIKE 'Kildare Ave & 85th St%' THEN 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO'
        ELSE c.end_station_name
    END
FROM cyclistic_2024 c
WHERE c.start_station_name LIKE 'La Villita Park%' OR c.start_station_name LIKE 'Kildare Ave & 85th St%'
   OR c.end_station_name LIKE 'La Villita Park%' OR c.end_station_name LIKE 'Kildare Ave & 85th St%';

UPDATE c
SET 
    c.start_station_id = CASE
        WHEN c.start_station_name = 'La Villita Park' THEN '21336'
        WHEN c.start_station_name = 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO' THEN '23114'
        ELSE c.start_station_id
    END,
    c.end_station_id = CASE
        WHEN c.end_station_name = 'La Villita Park' THEN '21336'
        WHEN c.end_station_name = 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO' THEN '23114'
        ELSE c.end_station_id
    END
FROM cyclistic_2024 c
WHERE c.start_station_name = 'La Villita Park' OR c.start_station_name = 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO'
   OR c.end_station_name = 'La Villita Park' OR c.end_station_name = 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO';

UPDATE c
SET 
    c.start_station_name = CASE
        WHEN c.start_station_name LIKE 'La Villita Park%' THEN 'La Villita Park'
        WHEN c.start_station_name LIKE 'Kildare Ave & 85th St%' THEN 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO'
        ELSE c.start_station_name
    END,
    c.end_station_name = CASE
        WHEN c.end_station_name LIKE 'La Villita Park%' THEN 'La Villita Park'
        WHEN c.end_station_name LIKE 'Kildare Ave & 85th St%' THEN 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO'
        ELSE c.end_station_name
    END
FROM cyclistic_2024 c
WHERE c.start_station_name LIKE 'La Villita Park%' OR c.start_station_name LIKE 'Kildare Ave & 85th St%'
   OR c.end_station_name LIKE 'La Villita Park%' OR c.end_station_name LIKE 'Kildare Ave & 85th St%';

UPDATE c
SET 
    c.start_station_id = CASE
        WHEN c.start_station_name = 'La Villita Park' THEN '21336'
        WHEN c.start_station_name = 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO' THEN '23114'
        ELSE c.start_station_id
    END,
    c.end_station_id = CASE
        WHEN c.end_station_name = 'La Villita Park' THEN '21336'
        WHEN c.end_station_name = 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO' THEN '23114'
        ELSE c.end_station_id
    END
FROM cyclistic_2024 c
WHERE c.start_station_name = 'La Villita Park' OR c.start_station_name = 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO'
   OR c.end_station_name = 'La Villita Park' OR c.end_station_name = 'Kildare Ave & 85th St (Kostner Ave & 87th St TEMPO';

UPDATE cyclistic_2024 --DON'T FORGET TO CHANGE FOR START_STATION_NAME AND ID
SET end_station_name = CASE
    WHEN end_station_name = 'Bloomingdale Ave & Harlem Ave' THEN 'Harlem Ave & Bloomingdale Ave'
    WHEN end_station_name = 'Cicero Ave & Grace St' THEN 'Grace St & Cicero Ave'
    WHEN end_station_name = 'Harlem & Irving Park' THEN 'Harlem Ave & Irving Park Rd'
    WHEN end_station_name = 'Kilbourn & Belden' THEN 'Kilbourn Ave & Belden Ave'
    WHEN end_station_name = 'Mayfield & Roosevelt Rd' THEN 'Mayfield Ave & Roosevelt Rd'
    WHEN end_station_name = 'Mulligan Ave & Wellington Ave' THEN 'Wellington Ave & Mulligan Ave'
    WHEN end_station_name = 'N Sheffield Ave & W Wellington Ave' THEN 'Sheffield Ave & Wellington Ave'
    WHEN end_station_name = 'Narragansett & McLean' THEN 'Narragansett Ave & McLean Ave'
    WHEN end_station_name = 'Narragansett & Wrightwood' THEN 'Narragansett Ave & Wrightwood Ave'
    WHEN end_station_name = 'Nordica & Medill' THEN 'Nordica Ave & Medill Ave'
    WHEN end_station_name = 'Orange & Addison' THEN 'Orange Ave & Addison St'
    WHEN end_station_name = 'Public Rack - Baltimore Ave & 133rd St' THEN 'Baltimore Ave & 133rd St'
    WHEN end_station_name = 'Public Rack - California Ave & Touhy Ave - midblock' THEN 'Public Rack - California Ave & Touhy Ave - midbloc'
    WHEN end_station_name = 'Public Rack - Lake Park Ave & 47th St' THEN 'Lake Park Ave & 47th St'
    WHEN end_station_name = 'Public Rack - McCormick Blvd & Devon Ave' THEN 'McCormick Blvd & Devon Ave'
    WHEN end_station_name = 'Public Rack - Penn Elementary School / KIPP Ascend Middle School' THEN 'Public Rack - Penn Elementary School / KIPP Ascend'
    WHEN end_station_name = 'Pulaski & Ann Lurie Pl' THEN 'Pulaski Rd & Ann Lurie Pl'
    WHEN end_station_name = 'Sacramento Ave & Pershing Rd' THEN 'Pershing Rd & Sacramento Ave'
    WHEN end_station_name = 'Sayre & Diversey' THEN 'Sayre Ave & Diversey Ave'
    WHEN end_station_name = 'Sheffield Ave & Fullerton Ave' THEN '(Archive) Sheffield Ave & Fullerton Ave'
    WHEN end_station_name = 'Spaulding Ave & 63rd St' THEN 'Spaulding Ave & 63rd'
    WHEN end_station_name = 'St Louis Ave & Norman Bobbins Ave' THEN 'St Louis Ave & Norman Bobbins Pl'
    ELSE end_station_name 
END,
 end_station_id = CASE
    WHEN end_station_name = 'Bloomingdale Ave & Harlem Ave' THEN '21377'
    WHEN end_station_name = 'Cicero Ave & Grace St' THEN '21322'
    WHEN end_station_name = 'Harlem & Irving Park' THEN '21326'
    WHEN end_station_name = 'Kilbourn & Belden' THEN '21359'
    WHEN end_station_name = 'Mayfield & Roosevelt Rd' THEN '21367'
    WHEN end_station_name = 'Mulligan Ave & Wellington Ave' THEN '21351'
    WHEN end_station_name = 'N Sheffield Ave & W Wellington Ave' THEN 'TA1307000052'
    WHEN end_station_name = 'Narragansett & McLean' THEN '21309'
    WHEN end_station_name = 'Narragansett & Wrightwood' THEN '21314'
    WHEN end_station_name = 'Nordica & Medill' THEN '21378'
    WHEN end_station_name = 'Orange & Addison' THEN '21320'
    WHEN end_station_name = 'Public Rack - Baltimore Ave & 133rd St' THEN '24407'
    WHEN end_station_name = 'Public Rack - California Ave & Touhy Ave - midblock' THEN '477'
    WHEN end_station_name = 'Public Rack - Lake Park Ave & 47th St' THEN 'TA1308000035'
    WHEN end_station_name = 'Public Rack - McCormick Blvd & Devon Ave' THEN '23101'
    WHEN end_station_name = 'Public Rack - Penn Elementary School / KIPP Ascend Middle School' THEN '531'
    WHEN end_station_name = 'Pulaski & Ann Lurie Pl' THEN '21340'
    WHEN end_station_name = 'Sacramento Ave & Pershing Rd' THEN '21339'
    WHEN end_station_name = 'Sayre & Diversey' THEN '21352'
    WHEN end_station_name = 'Sheffield Ave & Fullerton Ave' THEN '13060'
    WHEN end_station_name = 'Spaulding Ave & 63rd St' THEN '21349'
    WHEN end_station_name = 'St Louis Ave & Norman Bobbins Ave' THEN '21385'
    ELSE end_station_id -- Keep the current ID
END
WHERE end_station_name IN (
    'Bloomingdale Ave & Harlem Ave', 
    'Cicero Ave & Grace St',
    'Harlem & Irving Park',
    'Kilbourn & Belden',
    'Mayfield & Roosevelt Rd',
    'Mulligan Ave & Wellington Ave',
    'N Sheffield Ave & W Wellington Ave',
    'Narragansett & McLean',
    'Narragansett & Wrightwood',
    'Nordica & Medill',
    'Orange & Addison',
    'Public Rack - Baltimore Ave & 133rd St',
    'Public Rack - California Ave & Touhy Ave - midblock',
    'Public Rack - Lake Park Ave & 47th St',
    'Public Rack - McCormick Blvd & Devon Ave',
    'Public Rack - Penn Elementary School / KIPP Ascend Middle School',
    'Pulaski & Ann Lurie Pl',
    'Sacramento Ave & Pershing Rd',
    'Sayre & Diversey',
    'Sheffield Ave & Fullerton Ave',
    'Spaulding Ave & 63rd St',
    'St Louis Ave & Norman Bobbins Ave'
);

UPDATE cyclistic_2024
SET start_station_name = CASE
    WHEN start_station_name = 'Bloomingdale Ave & Harlem Ave' THEN 'Harlem Ave & Bloomingdale Ave'
    WHEN start_station_name = 'Cicero Ave & Grace St' THEN 'Grace St & Cicero Ave'
    WHEN start_station_name = 'Harlem & Irving Park' THEN 'Harlem Ave & Irving Park Rd'
    WHEN start_station_name = 'Kilbourn & Belden' THEN 'Kilbourn Ave & Belden Ave'
    WHEN start_station_name = 'Mayfield & Roosevelt Rd' THEN 'Mayfield Ave & Roosevelt Rd'
    WHEN start_station_name = 'Mulligan Ave & Wellington Ave' THEN 'Wellington Ave & Mulligan Ave'
    WHEN start_station_name = 'N Sheffield Ave & W Wellington Ave' THEN 'Sheffield Ave & Wellington Ave'
    WHEN start_station_name = 'Narragansett & McLean' THEN 'Narragansett Ave & McLean Ave'
    WHEN start_station_name = 'Narragansett & Wrightwood' THEN 'Narragansett Ave & Wrightwood Ave'
    WHEN start_station_name = 'Nordica & Medill' THEN 'Nordica Ave & Medill Ave'
    WHEN start_station_name = 'Orange & Addison' THEN 'Orange Ave & Addison St'
    WHEN start_station_name = 'Public Rack - Baltimore Ave & 133rd St' THEN 'Baltimore Ave & 133rd St'
    WHEN start_station_name = 'Public Rack - California Ave & Touhy Ave - midblock' THEN 'Public Rack - California Ave & Touhy Ave - midbloc'
    WHEN start_station_name = 'Public Rack - Lake Park Ave & 47th St' THEN 'Lake Park Ave & 47th St'
    WHEN start_station_name = 'Public Rack - McCormick Blvd & Devon Ave' THEN 'McCormick Blvd & Devon Ave'
    WHEN start_station_name = 'Public Rack - Penn Elementary School / KIPP Ascend Middle School' THEN 'Public Rack - Penn Elementary School / KIPP Ascend'
    WHEN start_station_name = 'Pulaski & Ann Lurie Pl' THEN 'Pulaski Rd & Ann Lurie Pl'
    WHEN start_station_name = 'Sacramento Ave & Pershing Rd' THEN 'Pershing Rd & Sacramento Ave'
    WHEN start_station_name = 'Sayre & Diversey' THEN 'Sayre Ave & Diversey Ave'
    WHEN start_station_name = 'Sheffield Ave & Fullerton Ave' THEN '(Archive) Sheffield Ave & Fullerton Ave'
    WHEN start_station_name = 'Spaulding Ave & 63rd St' THEN 'Spaulding Ave & 63rd'
    WHEN start_station_name = 'St Louis Ave & Norman Bobbins Ave' THEN 'St Louis Ave & Norman Bobbins Pl'
    ELSE start_station_name 
END,
 start_station_id = CASE
    WHEN start_station_name = 'Bloomingdale Ave & Harlem Ave' THEN '21377'
    WHEN start_station_name = 'Cicero Ave & Grace St' THEN '21322'
    WHEN start_station_name = 'Harlem & Irving Park' THEN '21326'
    WHEN start_station_name = 'Kilbourn & Belden' THEN '21359'
    WHEN start_station_name = 'Mayfield & Roosevelt Rd' THEN '21367'
    WHEN start_station_name = 'Mulligan Ave & Wellington Ave' THEN '21351'
    WHEN start_station_name = 'N Sheffield Ave & W Wellington Ave' THEN 'TA1307000052'
    WHEN start_station_name = 'Narragansett & McLean' THEN '21309'
    WHEN start_station_name = 'Narragansett & Wrightwood' THEN '21314'
    WHEN start_station_name = 'Nordica & Medill' THEN '21378'
    WHEN start_station_name = 'Orange & Addison' THEN '21320'
    WHEN start_station_name = 'Public Rack - Baltimore Ave & 133rd St' THEN '24407'
    WHEN start_station_name = 'Public Rack - California Ave & Touhy Ave - midblock' THEN '477'
    WHEN start_station_name = 'Public Rack - Lake Park Ave & 47th St' THEN 'TA1308000035'
    WHEN start_station_name = 'Public Rack - McCormick Blvd & Devon Ave' THEN '23101'
    WHEN start_station_name = 'Public Rack - Penn Elementary School / KIPP Ascend Middle School' THEN '531'
    WHEN start_station_name = 'Pulaski & Ann Lurie Pl' THEN '21340'
    WHEN start_station_name = 'Sacramento Ave & Pershing Rd' THEN '21339'
    WHEN start_station_name = 'Sayre & Diversey' THEN '21352'
    WHEN start_station_name = 'Sheffield Ave & Fullerton Ave' THEN '13060'
    WHEN start_station_name = 'Spaulding Ave & 63rd St' THEN '21349'
    WHEN start_station_name = 'St Louis Ave & Norman Bobbins Ave' THEN '21385'
    ELSE start_station_id -- Keep the current ID
END
WHERE start_station_name IN (
    'Bloomingdale Ave & Harlem Ave', 
    'Cicero Ave & Grace St',
    'Harlem & Irving Park',
    'Kilbourn & Belden',
    'Mayfield & Roosevelt Rd',
    'Mulligan Ave & Wellington Ave',
    'N Sheffield Ave & W Wellington Ave',
    'Narragansett & McLean',
    'Narragansett & Wrightwood',
    'Nordica & Medill',
    'Orange & Addison',
    'Public Rack - Baltimore Ave & 133rd St',
    'Public Rack - California Ave & Touhy Ave - midblock',
    'Public Rack - Lake Park Ave & 47th St',
    'Public Rack - McCormick Blvd & Devon Ave',
    'Public Rack - Penn Elementary School / KIPP Ascend Middle School',
    'Pulaski & Ann Lurie Pl',
    'Sacramento Ave & Pershing Rd',
    'Sayre & Diversey',
    'Sheffield Ave & Fullerton Ave',
    'Spaulding Ave & 63rd St',
    'St Louis Ave & Norman Bobbins Ave'
);

--* Drop stations in the cyclistic table that are not in the stations' information table.
DELETE FROM cyclistic_2024
WHERE (start_station_name <> '' AND start_station_id <> '')
    AND start_station_name NOT IN (SELECT station_name FROM stations_information);

DELETE FROM cyclistic_2024
WHERE (end_station_name <> '' AND end_station_id <> '')
   AND end_station_name NOT IN (SELECT station_name FROM stations_information);

--* Update stations' latitude and longitude in the cyclistic table as per the stations' information table.
UPDATE c
SET c.start_lat = si.latitude,
    c.start_lng = si.longitude
FROM cyclistic_2024 c
JOIN stations_information si
    ON c.start_station_name = si.station_name;

UPDATE c
SET c.end_lat = si.latitude,
    c.end_lng = si.longitude
FROM cyclistic_2024 c
JOIN stations_information si
    ON c.end_station_name = si.station_name;

--* Handle missing values
-- For start station
WITH station_list AS (
    SELECT DISTINCT 
        station_name AS station_name_sl,
        id AS id_sl,
        LEFT(latitude, CHARINDEX('.', latitude) + 2) AS station_lat,
        LEFT(longitude, CHARINDEX('.', longitude) + 2) AS station_long
    FROM stations_information
    WHERE 
        (station_name IS NOT NULL AND station_name <> '')
        AND (id IS NOT NULL AND id <> '')
        AND (latitude IS NOT NULL AND latitude <> '')
        AND (longitude IS NOT NULL AND longitude <> '')
),
uniq_station AS (
    SELECT station_lat AS us_lat, station_long AS us_long, COUNT(*) AS C
    FROM station_list
    GROUP BY station_lat, station_long
    HAVING COUNT(*) = 1
)

UPDATE c
SET c.start_station_name = s.station_name_sl,
    c.start_station_id = s.id_sl
FROM cyclistic_2024 c
JOIN uniq_station u
    ON c.start_lat = u.us_lat AND c.start_lng = u.us_long
JOIN station_list s
    ON u.us_lat = s.station_lat AND u.us_long = s.station_long;

-- For end station 
WITH station_list AS (
    SELECT DISTINCT 
        station_name AS station_name_sl,
        id AS id_sl,
        LEFT(latitude, CHARINDEX('.', latitude) + 2) AS station_lat,
        LEFT(longitude, CHARINDEX('.', longitude) + 2) AS station_long
    FROM stations_information
    WHERE 
        (station_name IS NOT NULL AND station_name <> '')
        AND (id IS NOT NULL AND id <> '')
        AND (latitude IS NOT NULL AND latitude <> '')
        AND (longitude IS NOT NULL AND longitude <> '')
  AND station_name NOT LIKE 'Public Rack%'
),
uniq_station AS (
    SELECT station_lat AS us_lat, station_long AS us_long, COUNT(*) AS C
    FROM station_list
    GROUP BY station_lat, station_long
    HAVING COUNT(*) = 1
)

UPDATE c
SET c.end_station_name = s.station_name_sl,
    c.end_station_id = s.id_sl
FROM cyclistic_2024 c
JOIN uniq_station u
    ON c.end_lat = u.us_lat AND c.end_lng = u.us_long
JOIN station_list s
    ON u.us_lat = s.station_lat AND u.us_long = s.station_long;

-- For end station (classic bike excluded)
WITH station_list AS (
    SELECT DISTINCT 
        station_name AS station_name_sl,
        id AS id_sl,
        LEFT(latitude, CHARINDEX('.', latitude) + 2) AS station_lat,
        LEFT(longitude, CHARINDEX('.', longitude) + 2) AS station_long
    FROM stations_information
    WHERE 
        (station_name IS NOT NULL AND station_name <> '')
        AND (id IS NOT NULL AND id <> '')
        AND (latitude IS NOT NULL AND latitude <> '')
        AND (longitude IS NOT NULL AND longitude <> '')
),
uniq_station AS (
    SELECT station_lat AS us_lat, station_long AS us_long, COUNT(*) AS C
    FROM station_list
    GROUP BY station_lat, station_long
    HAVING COUNT(*) = 1
)

UPDATE c
SET c.end_station_name = s.station_name_sl,
    c.end_station_id = s.id_sl
FROM cyclistic_2024 c
JOIN uniq_station u
    ON c.end_lat = u.us_lat AND c.end_lng = u.us_long
JOIN station_list s
    ON u.us_lat = s.station_lat AND u.us_long = s.station_long
WHERE rideable_type <> 'classic_bike';

--* Re-update coordinates
UPDATE c
SET c.start_lat = si.latitude,
    c.start_lng = si.longitude
FROM cyclistic_2024 c
JOIN stations_information si
    ON c.start_station_name = si.station_name;

UPDATE c
SET c.end_lat = si.latitude,
    c.end_lng = si.longitude
FROM cyclistic_2024 c
JOIN stations_information si
    ON c.end_station_name = si.station_name;

--* Delete a rent transaction with a length duration of more than 24 hours and less than 60 seconds or a minute
DELETE FROM cyclistic_2024
WHERE DATEDIFF(SECOND, CAST(started_at AS DATETIME), CAST(ended_at AS DATETIME)) < 60;

DELETE FROM cyclistic_2024
WHERE DATEDIFF(HOUR, CAST(started_at AS DATETIME), CAST(ended_at AS DATETIME)) > 24;

--* Delete duplicates
WITH a AS (SELECT 
    ride_id, 
    COUNT(*) AS duplicate_count
FROM cyclistic_2024
GROUP BY ride_id
HAVING COUNT(*) > 1)

DELETE
FROM cyclistic_2024
WHERE ride_id in (SELECT ride_id FROM a)
AND DATEPART(MILLISECOND, CAST(started_at AS DATETIME)) = 0;

--* Format data
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

--* New attributes 
ALTER TABLE cyclistic_2024
ADD month varchar(50);
ALTER TABLE cyclistic_2024
ADD day_of_the_week varchar(50);
ALTER TABLE cyclistic_2024
ADD is_weekend BIT;

UPDATE cyclistic_2024
SET month = DATENAME(MONTH, started_at);
UPDATE cyclistic_2024
SET day_of_the_week = DATENAME(WEEKDAY, started_at);
UPDATE cyclistic_2024
SET is_weekend = CASE
    WHEN day_of_the_week IN ('Saturday', 'Sunday') THEN 1 
    ELSE 0 
END;

ALTER TABLE cyclistic_2024
ADD ride_length float;

UPDATE cyclistic_2024
SET ride_length = DATEDIFF(SECOND, started_at, ended_at);
