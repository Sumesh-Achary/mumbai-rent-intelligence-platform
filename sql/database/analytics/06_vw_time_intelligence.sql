/*
===============================================================================
Script Name : 06_vw_Time_Intelligence.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates a reusable business view containing time-based rental intelligence
for reporting and Power BI.
===============================================================================
*/

DROP VIEW IF EXISTS analytics.vw_time_intelligence;


CREATE VIEW analytics.vw_time_intelligence AS
SELECT
    dd.year_number,
    dd.quarter_number,
    dd.month_number,
    dd.month_name,
    COUNT(*) AS total_listings,
    ROUND(AVG(fr.rent),2) AS average_rent,
    MIN(fr.rent) AS minimum_rent,
    MAX(fr.rent) AS maximum_rent,
    ROUND(AVG(fr.rent_per_sqft),2) AS average_rent_per_sqft,
    ROUND(AVG(fr.carpet_area_sqft),2) AS average_carpet_area
FROM core.fact_rent fr
JOIN core.dim_date dd
ON fr.date_key = dd.date_key
GROUP BY
    dd.year_number,
    dd.quarter_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;


SELECT *
FROM analytics.vw_time_intelligence;

