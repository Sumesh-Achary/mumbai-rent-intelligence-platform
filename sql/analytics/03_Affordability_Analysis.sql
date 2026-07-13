/*
===============================================================================
Business Question:
Which localities have the lowest average monthly rent?

Business Value:
Helps renters identify the most affordable areas in Mumbai.

Expected Insight:
Localities with consistently lower rents can be recommended to
budget-conscious tenants.
===============================================================================
*/

SELECT
    dl.locality,
    ROUND(AVG(fr.rent), 2) AS average_monthly_rent,
    COUNT(*) AS total_listings
FROM core.fact_rent fr
JOIN core.dim_locality dl
    ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
HAVING COUNT(*) >= 2
ORDER BY average_monthly_rent ASC
LIMIT 10;

/*
===============================================================================
Business Question:
Which localities offer the lowest average rent per square foot?

Business Value:
Rent per square foot is a fair comparison across properties of
different sizes.
===============================================================================
*/

SELECT
    dl.locality,
    ROUND(AVG(fr.rent_per_sqft),2) AS avg_rent_per_sqft,
    COUNT(*) AS total_listings
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
HAVING COUNT(*) >= 2
ORDER BY avg_rent_per_sqft ASC
LIMIT 10;

/*
===============================================================================
Business Question:
Which localities provide the largest average carpet area?

Business Value:
Helps renters maximize living space within their budget.
===============================================================================
*/

SELECT
    dl.locality,
    ROUND(AVG(fr.carpet_area_sqft),2) AS avg_carpet_area_sqft,
    ROUND(AVG(fr.rent),2) AS avg_rent
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
HAVING COUNT(*) >= 2
ORDER BY avg_carpet_area_sqft DESC
LIMIT 10;

/*
===============================================================================
Business Question:
How are listings distributed across budget ranges?

Business Value:
Helps users quickly filter homes based on affordability.
===============================================================================
*/

SELECT
CASE
WHEN rent < 25000 THEN 'Budget'
WHEN rent BETWEEN 25000 AND 49999 THEN 'Affordable'
WHEN rent BETWEEN 50000 AND 74999 THEN 'Mid Premium'
WHEN rent BETWEEN 75000 AND 99999 THEN 'Premium'
ELSE 'Luxury'
END AS budget_category,
COUNT(*) AS total_listings,
ROUND(AVG(rent),2) AS average_rent
FROM core.fact_rent
GROUP BY budget_category
ORDER BY average_rent;

/*
===============================================================================
Business Question:
Which localities provide affordable 2 & 3 BHK homes?

Business Value:
Useful for families searching for larger homes within a reasonable budget.
===============================================================================
*/

SELECT
    dl.locality,
    CONCAT(dp.bhk, ' BHK') AS bhk_type,
    ROUND(AVG(fr.rent),2) AS average_rent,
    ROUND(AVG(fr.carpet_area_sqft),2) AS average_area
FROM core.fact_rent fr
JOIN core.dim_locality dl
    ON fr.locality_key = dl.locality_key
JOIN core.dim_property dp
    ON fr.property_key = dp.property_key
WHERE dp.bhk IN (2, 3)
GROUP BY
    dl.locality,
    dp.bhk
HAVING COUNT(*) >= 2
ORDER BY average_rent ASC;


/*
===============================================================================
Business Question:
Which localities provide the best value for money?

Business Value:
Higher value index means tenants get more carpet area for the rent paid.
===============================================================================
*/

SELECT
    dl.locality,
    ROUND(AVG(fr.carpet_area_sqft),2) AS avg_area,
    ROUND(AVG(fr.rent),2) AS avg_rent,
    ROUND(
        (AVG(fr.carpet_area_sqft) / NULLIF(AVG(fr.rent),0)) * 1000,
        2
    ) AS mrip_value_index
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
HAVING COUNT(*) >= 2
ORDER BY mrip_value_index DESC
LIMIT 10;

