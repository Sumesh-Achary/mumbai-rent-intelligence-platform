/*
===============================================================================
Business Question:
Which localities provide more living space at a lower-than-average rent?

Business Value:
Helps renters identify "hidden gem" localities that offer excellent value.
===============================================================================
*/

WITH locality_summary AS
(
SELECT
    dl.locality,
    ROUND(AVG(fr.rent),2) AS avg_rent,
    ROUND(AVG(fr.carpet_area_sqft),2) AS avg_area,
    COUNT(*) AS listings
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
HAVING COUNT(*) >= 2
)
SELECT *
FROM locality_summary
WHERE avg_rent <
(
SELECT AVG(rent)
FROM core.fact_rent
)
AND avg_area >
(
SELECT AVG(carpet_area_sqft)
FROM core.fact_rent
)
ORDER BY avg_area DESC;


/*
===============================================================================
Business Question:
Which localities deserve premium pricing?
===============================================================================
*/


SELECT
dl.locality,
ROUND(AVG(fr.rent),2) AS avg_rent,
ROUND(AVG(fr.rent_per_sqft),2) AS avg_rent_sqft,
ROUND(AVG(fr.carpet_area_sqft),2) AS avg_area
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
HAVING COUNT(*) >= 2
ORDER BY avg_rent DESC
LIMIT 10;


/*
===============================================================================
Business Question:
Which localities charge higher rent while offering relatively smaller homes?
===============================================================================
*/

WITH locality_summary AS
(
SELECT
dl.locality,
ROUND(AVG(fr.rent),2) AS avg_rent,
ROUND(AVG(fr.carpet_area_sqft),2) AS avg_area
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key=dl.locality_key
GROUP BY dl.locality
HAVING COUNT(*)>=2
)
SELECT *
FROM locality_summary
WHERE avg_rent >
(
SELECT AVG(rent)
FROM core.fact_rent
)
AND avg_area <
(
SELECT AVG(carpet_area_sqft)
FROM core.fact_rent
)
ORDER BY avg_rent DESC;


/*
===============================================================================
Business Question:
Cheapest locality based on sufficient data.
===============================================================================
*/

SELECT dl.locality,
COUNT(*) listings,
ROUND(AVG(fr.rent),2) avg_rent,
CASE
WHEN COUNT(*) <5 THEN 'Low'
WHEN COUNT(*) BETWEEN 5 AND 15 THEN 'Medium'
ELSE 'High'
END AS confidence_level
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key=dl.locality_key
GROUP BY dl.locality
ORDER BY avg_rent;


/*
===============================================================================
Business Question:
Which localities have the most consistent rental prices?
===============================================================================
*/


SELECT
    dl.locality,
    ROUND(AVG(fr.rent),2) AS avg_rent,
    ROUND(STDDEV(fr.rent),2) AS rent_stddev,
    MIN(fr.rent) AS min_rent,
    MAX(fr.rent) AS max_rent
FROM core.fact_rent fr
JOIN core.dim_locality dl
    ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
HAVING COUNT(*) >= 5
ORDER BY rent_stddev;