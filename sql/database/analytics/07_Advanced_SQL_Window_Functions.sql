/*
===============================================================================
Sprint 4 - Module 1
Window Functions
Query 1
===============================================================================
*/

SELECT
    fr.listing_id,
    dl.locality,
    fr.rent,
    ROUND(
        AVG(fr.rent) OVER
        (
            PARTITION BY dl.locality
        ),
        2
    ) AS locality_average_rent
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
ORDER BY
    dl.locality,
    fr.rent;


SELECT
    fr.listing_id,
    dl.locality,
    fr.rent,
    ROUND(
        AVG(fr.rent) OVER
        (
            PARTITION BY dl.locality
        ),
        2
    ) AS locality_average,
    CASE
        WHEN fr.rent >
             AVG(fr.rent) OVER
             (
                PARTITION BY dl.locality
             )
        THEN 'Above Average'
        WHEN fr.rent <
             AVG(fr.rent) OVER
             (
                PARTITION BY dl.locality
             )
        THEN 'Below Average'
        ELSE 'Average'
    END AS rent_position
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
ORDER BY locality, rent;



SELECT
    dl.locality_name,
    fr.rent,
    ROW_NUMBER() OVER (
        PARTITION BY dl.locality_name
        ORDER BY fr.rent DESC
    ) AS rent_rank
FROM core.fact_rent fr
JOIN core.dim_locality dl
    ON fr.locality_key = dl.locality_key
ORDER BY
    dl.locality_name,
    rent_rank;


/*
===============================================================================
ROW_NUMBER()
===============================================================================
*/

SELECT
    fr.listing_id,
    dl.locality,
    fr.rent,
    ROW_NUMBER() OVER
    (
        PARTITION BY dl.locality
        ORDER BY fr.rent
    ) AS rent_rank
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
ORDER BY
    dl.locality,
    rent_rank;


WITH ranked_properties AS
(
SELECT
    fr.listing_id,
    dl.locality,
    fr.rent,
    ROW_NUMBER() OVER
    (
        PARTITION BY dl.locality
        ORDER BY fr.rent
    ) AS rent_rank
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
)
SELECT *
FROM ranked_properties
WHERE rent_rank = 1
ORDER BY locality;


/*
===============================================================================
RANK()
===============================================================================
*/

WITH locality_rent AS
(
SELECT
    dl.locality,
    ROUND(AVG(fr.rent),2) AS average_rent
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
)
SELECT
    locality,
    average_rent,
    RANK() OVER
    (
        ORDER BY average_rent DESC
    ) AS rent_rank
FROM locality_rent
ORDER BY rent_rank;


/*
===============================================================================
DENSE RANK()
===============================================================================
*/


WITH locality_rent AS
(
SELECT
    dl.locality,
    ROUND(AVG(fr.rent),2) AS average_rent
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
)
SELECT
    locality,
    average_rent,
	DENSE_RANK() OVER
(
    ORDER BY average_rent DESC
)
AS dense_rank
FROM locality_rent
ORDER BY dense_rank;


/*
===============================================================================
NTILE()
===============================================================================
*/

WITH locality_rent AS
(
SELECT
    dl.locality,
    ROUND(AVG(fr.rent),2) AS average_rent
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
)
SELECT
    locality,
    average_rent,
    NTILE(4) OVER
    (
        ORDER BY average_rent DESC
    ) AS market_quartile
FROM locality_rent
ORDER BY average_rent DESC;



WITH locality_rent AS
(
SELECT
    dl.locality,
    ROUND(AVG(fr.rent),2) AS average_rent
FROM core.fact_rent fr
JOIN core.dim_locality dl
ON fr.locality_key = dl.locality_key
GROUP BY dl.locality
),
quartiles AS
(
SELECT
    locality,
    average_rent,
    NTILE(4) OVER
    (
        ORDER BY average_rent DESC
    ) AS market_quartile
FROM locality_rent
)
SELECT
    locality,
    average_rent,
    CASE
        WHEN market_quartile = 1 THEN 'Premium Market'
        WHEN market_quartile = 2 THEN 'Upper Mid Market'
        WHEN market_quartile = 3 THEN 'Lower Mid Market'
        ELSE 'Budget Market'
    END AS market_segment
FROM quartiles
ORDER BY average_rent DESC;


/*
===============================================================================
LAG()
===============================================================================
*/

WITH monthly_rent AS
(
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
)
SELECT
    year_number,
    month_number,
    month_name,
    average_rent,
    LAG(average_rent) OVER
    (
        ORDER BY year_number, month_number
    ) AS previous_month_rent
FROM monthly_rent
ORDER BY
    year_number,
    month_number;


WITH monthly_rent AS
(
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
)
SELECT
    year_number,
    month_number,
    month_name,
    average_rent,
    LAG(average_rent) OVER
    (
        ORDER BY year_number, month_number
    ) AS previous_month,
    ROUND
    (
        average_rent -
        LAG(average_rent) OVER
        (
            ORDER BY year_number, month_number
        ),
        2
    ) AS monthly_change
FROM monthly_rent
ORDER BY
    year_number,
    month_number;


/*
===============================================================================
LEAD()
===============================================================================
*/

WITH monthly_rent AS
(
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
)
SELECT
    year_number,
    month_number,
    month_name,
    average_rent,
    LEAD(average_rent) OVER
    (
        ORDER BY year_number, month_number
    ) AS previous_month_rent
FROM monthly_rent
ORDER BY
    year_number,
    month_number;


WITH monthly_rent AS
(
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
)
SELECT
    year_number,
    month_number,
    month_name,
    average_rent,
    LEAD(average_rent) OVER
    (
        ORDER BY year_number, month_number
    ) AS previous_month,
    ROUND
    (
        average_rent -
        LAG(average_rent) OVER
        (
            ORDER BY year_number, month_number
        ),
        2
    ) AS monthly_change
FROM monthly_rent
ORDER BY
    year_number,
    month_number;


