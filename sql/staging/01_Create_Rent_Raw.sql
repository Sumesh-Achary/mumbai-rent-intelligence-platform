/*
===============================================================================
Script Name : 01_Create_Rent_Raw.sql
Project     : Mumbai Rent Intelligence Platform
Author      : Sumesh Achary

Purpose:
Creates the staging table to store raw rental listing data.

===============================================================================
*/

CREATE TABLE IF NOT EXISTS staging.rent_raw
(
    listing_id              VARCHAR(20),
    source                  VARCHAR(50),
    locality                VARCHAR(100),
    sub_region              VARCHAR(100),
    locality_tier           VARCHAR(30),
    society_name            VARCHAR(150),

    rent                    INTEGER,
    bhk                     SMALLINT,
    bathroom                SMALLINT,

    floor                   SMALLINT,
    total_floors            SMALLINT,

    carpet_area_sqft        INTEGER,

    furnishing              VARCHAR(50),
    tenant_type             VARCHAR(50),
    property_type           VARCHAR(50),

    property_age_category   VARCHAR(50),
    property_age_years      NUMERIC(5,2),

    posted_date             DATE,

    rent_per_sqft           NUMERIC(10,2),
    rent_annual             INTEGER,

    rent_band               VARCHAR(30),
    area_band               VARCHAR(30),

    rate_quality_flag       VARCHAR(30),
    absolute_price_flag     VARCHAR(30),
    rate_ceiling_flag       VARCHAR(30),

    data_quality_flag       VARCHAR(30)
);

DROP TABLE staging.rent_raw;


CREATE TABLE IF NOT EXISTS staging.rent_raw
(
    listing_id              VARCHAR(20),
    source                  VARCHAR(50),
    locality                VARCHAR(100),
    sub_region              VARCHAR(100),
    locality_tier           VARCHAR(30),
    society_name            VARCHAR(150),

    rent                    NUMERIC(12,2),

    bhk                     SMALLINT,
    bathroom                SMALLINT,

    floor                   SMALLINT,
    total_floors            SMALLINT,

    carpet_area_sqft        NUMERIC(10,2),

    furnishing              VARCHAR(50),
    tenant_type             VARCHAR(50),
    property_type           VARCHAR(50),

    property_age_category   VARCHAR(50),
    property_age_years      NUMERIC(5,2),

    posted_date             DATE,

    rent_per_sqft           NUMERIC(10,2),
    rent_annual             NUMERIC(12,2),

    rent_band               VARCHAR(30),
    area_band               VARCHAR(30),

    rate_quality_flag       VARCHAR(30),
    absolute_price_flag     VARCHAR(30),
    rate_ceiling_flag       VARCHAR(30),

    data_quality_flag       VARCHAR(30)
);

select * from staging.rent_raw;

--Total Rows
SELECT COUNT(*) AS total_rows
FROM staging.rent_raw;


--Preview Data
select * from staging.rent_raw
limit 10;


--Missing Rent
SELECT COUNT(*) AS missing_rent
FROM staging.rent_raw
WHERE rent IS NULL;


--Missing Locality
SELECT COUNT(*) AS missing_locality
FROM staging.rent_raw
WHERE locality IS NULL;


--Duplicate Listing IDs
SELECT listing_id,
       COUNT(*) AS duplicate_count
FROM staging.rent_raw
GROUP BY listing_id
HAVING COUNT(*) > 1;


--Rent Statistics
SELECT
    MIN(rent) AS minimum_rent,
    MAX(rent) AS maximum_rent,
    ROUND(AVG(rent),2) AS average_rent
FROM staging.rent_raw;