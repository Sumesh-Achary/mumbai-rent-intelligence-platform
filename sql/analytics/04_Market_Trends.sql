/*
===============================================================================
Business Question:
How many rental listings were posted each month?

Business Value:
Shows rental market activity over time.

Expected Insight:
Identify months with higher rental activity.
===============================================================================
*/

SELECT
    dd.year_number,
    dd.month_number,
    dd.month_name,
    COUNT(*) AS total_listings
FROM core.fact_rent fr
JOIN core.dim_date dd
    ON fr.date_key = dd.date_key
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;

/*
===============================================================================
Business Question:
How has the average monthly rent changed over time?
===============================================================================
*/

SELECT
    dd.year_number,
    dd.month_number,
    dd.month_name,
    ROUND(AVG(fr.rent),2) AS average_rent
FROM core.fact_rent fr
JOIN core.dim_date dd
    ON fr.date_key = dd.date_key
GROUP BY
    dd.year_number,
    dd.month_number,
    dd.month_name
ORDER BY
    dd.year_number,
    dd.month_number;


/*
===============================================================================
Business Question:
Do newer properties command higher rents?
===============================================================================
*/

SELECT
    dp.property_age_category,
    ROUND(AVG(fr.rent),2) AS average_rent,
    COUNT(*) AS listings
FROM core.fact_rent fr
JOIN core.dim_property dp
    ON fr.property_key = dp.property_key
GROUP BY
    dp.property_age_category
ORDER BY
    average_rent DESC;


/*
===============================================================================
Business Question:
How does furnishing impact rental prices?
===============================================================================
*/

SELECT
    dp.furnishing,
    ROUND(AVG(fr.rent),2) AS average_rent,
    COUNT(*) AS listings
FROM core.fact_rent fr
JOIN core.dim_property dp
    ON fr.property_key = dp.property_key
GROUP BY
    dp.furnishing
ORDER BY
    average_rent DESC;


/*
===============================================================================
Business Question:
Which tenant category pays the highest average rent?

Business Value:
Understand how rental pricing varies by preferred tenant type.
===============================================================================
*/

SELECT
    tenant_type,
    ROUND(AVG(rent),2) AS average_rent,
    COUNT(*) AS total_listings
FROM staging.rent_raw
GROUP BY tenant_type
ORDER BY average_rent DESC;


/*
===============================================================================
Business Question:
Which property type commands the highest rents?
===============================================================================
*/

SELECT
    dp.property_type,
    ROUND(AVG(fr.rent),2) AS average_rent,
    COUNT(*) AS listings
FROM core.fact_rent fr
JOIN core.dim_property dp
    ON fr.property_key = dp.property_key
GROUP BY
    dp.property_type
ORDER BY
    average_rent DESC;


/*
===============================================================================
Business Question:
Do listing prices differ between data sources?
===============================================================================
*/

SELECT
    ds.source_name,
    ROUND(AVG(fr.rent),2) AS average_rent,
    COUNT(*) AS total_listings
FROM core.fact_rent fr
JOIN core.dim_source ds
    ON fr.source_key = ds.source_key
GROUP BY
    ds.source_name
ORDER BY
    average_rent DESC;


/*
===============================================================================
Business Question:
How does rent vary by BHK configuration?
===============================================================================
*/

SELECT
    CONCAT(dp.bhk,' BHK') AS bhk_type,
    ROUND(AVG(fr.rent),2) AS average_rent,
    COUNT(*) AS listings
FROM core.fact_rent fr
JOIN core.dim_property dp
    ON fr.property_key = dp.property_key
GROUP BY
    dp.bhk
ORDER BY
    dp.bhk;


