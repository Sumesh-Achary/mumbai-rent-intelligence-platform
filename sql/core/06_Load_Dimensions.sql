/*
===============================================================================
Script Name : 06_Load_Dimensions.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Loads dimension tables from staging.
===============================================================================
*/

-- =====================================================
-- Load Source Dimension
-- =====================================================

INSERT INTO core.dim_source (source_name)

SELECT DISTINCT
       source
FROM staging.rent_raw
WHERE source IS NOT NULL

ORDER BY source;

SELECT *
FROM core.dim_source
ORDER BY source_key;


-- =====================================================
-- Load Locality Dimension
-- =====================================================

INSERT INTO core.dim_locality
(
    locality,
    sub_region,
    locality_tier
)

SELECT DISTINCT

       locality,
       sub_region,
       locality_tier

FROM staging.rent_raw

WHERE locality IS NOT NULL

ORDER BY locality;


-- =====================================================
-- Load Property Dimension
-- =====================================================

INSERT INTO core.dim_property
(
    bhk,
    bathroom,
    furnishing,
    property_type,
    property_age_category
)

SELECT DISTINCT

       bhk,
       bathroom,
       furnishing,
       property_type,
       property_age_category

FROM staging.rent_raw

WHERE bhk IS NOT NULL

ORDER BY bhk,
         bathroom;


-- =====================================================
-- Load Date Dimension
-- =====================================================

INSERT INTO core.dim_date
(
    date_key,
    full_date,
    day_number,
    month_number,
    month_name,
    quarter_number,
    year_number,
    weekday_name
)

SELECT DISTINCT

       TO_CHAR(posted_date,'YYYYMMDD')::INTEGER,

       posted_date,

       EXTRACT(DAY FROM posted_date),

       EXTRACT(MONTH FROM posted_date),

       TO_CHAR(posted_date,'Month'),

       EXTRACT(QUARTER FROM posted_date),

       EXTRACT(YEAR FROM posted_date),

       TO_CHAR(posted_date,'Day')

FROM staging.rent_raw

WHERE posted_date IS NOT NULL

ORDER BY posted_date;