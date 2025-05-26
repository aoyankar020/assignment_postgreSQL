-- =============== Creating Rengers Table ======================
CREATE TABLE rangers (
    ranger_id SERIAL PRIMARY KEY,
    name CHAR(50) NOT NULL,
    region VARCHAR(255) NOT NULL
);
-- Inserting Data Into Rangers Table
INSERT INTO
    rangers (name, region)
VALUES (
        'Alice Green',
        'Northern Hills'
    ),
    ('Bob White', 'River Delta '),
    (
        'Carol King',
        'Mountain Range'
    );

-- ================ Creating Species Table =====================
CREATE TABLE iF NOT EXISTS species (
    species_id SERIAL PRIMARY KEY,
    common_name VARCHAR(255) NOT NULL,
    scientific_name VARCHAR(255) NOT NULL,
    discovery_date DATE NOT NULL,
    conservation_status VARCHAR(255) NOT NULL
);
-- Inserting Data Into Species
INSERT INTO
    species (
        common_name,
        scientific_name,
        discovery_date,
        conservation_status
    )
VALUES (
        'Snow Leopard',
        'Panthera uncia',
        ' 1775-01-01',
        'Endangered '
    ),
    (
        'Bengal Tiger ',
        'Panthera tigris tigris ',
        '1758-01-01',
        'Endangered'
    ),
    (
        'Red Panda ',
        'Ailurus fulgens ',
        '1825-01-01 ',
        ' Vulnerable'
    ),
    (
        'Asiatic Elephant',
        'Elephas maximus indicus',
        '1758-01-01',
        'Endangered'
    );

-- ================= Creating Sightings Table =================
CREATE TABLE IF NOT EXISTS sightings (
    sighting_id SERIAL PRIMARY KEY,
    ranger_id INTEGER NOT NULL,
    species_id INTEGER NOT NULL,
    location VARCHAR(255) NOT NULL,
    sighting_time TIMESTAMP NOT NULL,
    notes VARCHAR(255) DEFAULT 'Not Specific',
    FOREIGN KEY (ranger_id) REFERENCES rangers (ranger_id),
    FOREIGN KEY (species_id) REFERENCES species (species_id)
);
-- Inserting Data Into Sightings
INSERT INTO
    sightings (
        ranger_id,
        species_id,
        location,
        sighting_time,
        notes
    )
VALUES (
        1,
        1,
        'Peak Ridge ',
        '2024-05-10 07:45:00',
        'Camera trap image captured'
    ),
    (
        2,
        2,
        'Bankwood Area',
        '2024-05-12 16:20:00',
        'Juvenile seen '
    ),
    (
        3,
        3,
        'Bamboo Grove East',
        '2024-05-15 09:10:00',
        'Feeding observed'
    ),
    (
        1,
        2,
        'Snowfall Pass ',
        '2024-05-18 18:30:00',
        NULL
    );

-- ********************** Problems & Solutions ****************************
-- Problem ONE
INSERT INTO
    rangers (name, region)
VALUES ('Derek Fox', 'Coastal Plains');

-- Problem TWO
select count(DISTINCT species_id) AS "unique_species_count"
from sightings;

-- Problem THREE
SELECT * FROM sightings WHERE location ILIKE ('%Pass%');

-- Problem FOUR
SELECT name, COUNT(species_id) as "total_sightings"
FROM rangers
    JOIN sightings USING (ranger_id)
GROUP BY
    name;

-- Problem FIVE
SELECT common_name
FROM species AS s
    LEFT JOIN sightings AS si ON s.species_id = si.species_id
WHERE
    si.species_id IS NULL;

-- Problem SIX
SELECT name, common_name, sighting_time
FROM sightings
    JOIN rangers USING (ranger_id)
    JOIN species USING (species_id)
ORDER BY sighting_time DESC
LIMIT 2;
;

-- Problem SEVEN
UPDATE species
SET
    conservation_status = 'Historic'
WHERE
    extract(
        YEAR
        FROM discovery_date
    ) < 1800;

-- Problem EIGHT

SELECT
    sighting_id,
    CASE
        WHEN EXTRACT(
            Hour
            FROM sighting_time
        ) BETWEEN 1 AND 11  THEN 'Morning'
        WHEN EXTRACT(
            Hour
            FROM sighting_time
        ) BETWEEN 12 AND 17  THEN 'Afternoon'
        WHEN EXTRACT(
            Hour
            FROM sighting_time
        ) BETWEEN 18 AND 23  THEN 'Evening'
    END AS time_of_day
FROM sightings;

-- Problem NINE
DELETE FROM rangers
WHERE
    ranger_id IN (
        select R.ranger_id
        from rangers AS R
            LEFT JOIN sightings AS S ON R.ranger_id = S.ranger_id
        WHERE
            S.ranger_id IS Null
    );

-- ======================= Select ===============
-- select * from rangers;

-- select * from species;

-- select * from sightings;

-- ======================== DROP =================

-- DROP TABLE rangers;

-- DROP TABLE species;

-- DROP TABLE sightings;