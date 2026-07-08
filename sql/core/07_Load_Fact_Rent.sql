/*
===============================================================================
Script Name : 07_Load_Fact_Rent.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Loads the Fact Rent table from staging by joining all dimensions.
===============================================================================
*/

INSERT INTO core.fact_rent
(
    listing_id,
    source_key,
    locality_key,
    property_key,
    date_key,
    rent,
    carpet_area_sqft,
    rent_per_sqft,
    rent_annual,
    property_age_years
)

SELECT

    s.listing_id,

    ds.source_key,

    dl.locality_key,

    dp.property_key,

    dd.date_key,

    s.rent,

    s.carpet_area_sqft,

    s.rent_per_sqft,

    s.rent_annual,

    s.property_age_years

FROM staging.rent_raw s

INNER JOIN core.dim_source ds
    ON s.source = ds.source_name

INNER JOIN core.dim_locality dl
    ON s.locality = dl.locality
   AND s.sub_region = dl.sub_region

INNER JOIN core.dim_property dp
    ON s.bhk = dp.bhk
   AND s.bathroom = dp.bathroom
   AND s.furnishing = dp.furnishing
   AND s.property_type = dp.property_type
   AND s.property_age_category = dp.property_age_category

INNER JOIN core.dim_date dd
    ON s.posted_date = dd.full_date;

