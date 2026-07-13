/*
===============================================================================
Script Name : 03_vw_Locality_Intelligence.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates a reusable business view containing locality-level rental intelligence
for Power BI dashboards and business reporting.
===============================================================================
*/

DROP VIEW IF EXISTS analytics.vw_locality_intelligence;

CREATE VIEW analytics.vw_locality_intelligence AS
SELECT
    dl.locality,
    dl.sub_region,
    dl.locality_tier,
    COUNT(*) AS total_listings,
    ROUND(AVG(fr.rent),2) AS average_rent,
    MIN(fr.rent) AS minimum_rent,
    MAX(fr.rent) AS maximum_rent,
    ROUND(AVG(fr.rent_per_sqft),2) AS average_rent_per_sqft,
    ROUND(AVG(fr.carpet_area_sqft),2) AS average_carpet_area,
    CASE
        WHEN COUNT(*) < 5 THEN 'Low'
        WHEN COUNT(*) BETWEEN 5 AND 15 THEN 'Medium'
        ELSE 'High'
    END AS confidence_level
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY
    dl.locality,
    dl.sub_region,
    dl.locality_tier;

SELECT *
FROM analytics.vw_locality_intelligence;