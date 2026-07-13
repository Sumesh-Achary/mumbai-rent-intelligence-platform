/*
===============================================================================
Which localities have the highest average monthly rent?
===============================================================================
*/

SELECT
    dl.locality,
    ROUND(AVG(fr.rent),2) AS average_monthly_rent,
    COUNT(*) AS total_listings
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
ORDER BY average_monthly_rent DESC
LIMIT 10;

/*
===============================================================================
Which localities offer the lowest average monthly rent?
===============================================================================
*/

SELECT
    dl.locality,
    ROUND(AVG(fr.rent),2) AS average_monthly_rent,
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
Which localities have the highest rental inventory?
===============================================================================
*/

SELECT
    dl.locality,
    COUNT(*) AS total_listings
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
ORDER BY total_listings DESC;

