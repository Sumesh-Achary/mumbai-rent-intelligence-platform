/*
===============================================================================
Script Name : 05_vw_Pricing_Intelligence.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates a reusable pricing intelligence view for business reporting,
Power BI dashboards, and pricing analysis.
===============================================================================
*/

DROP VIEW IF EXISTS analytics.vw_pricing_intelligence;


CREATE VIEW analytics.vw_pricing_intelligence AS
WITH locality_summary AS
(
SELECT
    dl.locality,
    dl.sub_region,
    ROUND(AVG(fr.rent),2) AS average_rent,
    ROUND(AVG(fr.rent_per_sqft),2) AS average_rent_per_sqft,
    ROUND(AVG(fr.carpet_area_sqft),2) AS average_carpet_area
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY
    dl.locality,
    dl.sub_region
)
SELECT
*,
CASE
WHEN average_rent >
(
SELECT AVG(rent)
FROM core.fact_rent
)
THEN 'Premium'
WHEN average_rent <
(
SELECT AVG(rent)
FROM core.fact_rent
)
THEN 'Budget'
ELSE 'Mid Market'
END AS market_position,
CASE
WHEN average_rent <
(
SELECT AVG(rent)
FROM core.fact_rent
)
AND average_carpet_area >
(
SELECT AVG(carpet_area_sqft)
FROM core.fact_rent
)
THEN 'Hidden Gem'
WHEN average_rent >
(
SELECT AVG(rent)
FROM core.fact_rent
)
AND average_carpet_area <
(
SELECT AVG(carpet_area_sqft)
FROM core.fact_rent
)
THEN 'Potentially Overpriced'
ELSE 'Fair Value'
END AS value_segment
FROM locality_summary;


SELECT *
FROM analytics.vw_pricing_intelligence
ORDER BY average_rent DESC;