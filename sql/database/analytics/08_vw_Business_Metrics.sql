/*
===============================================================================
Script Name : 08_vw_Business_Metrics.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates the Business Metrics View used by Power BI.

Version : 2.1 (Production)

Business Metrics Included
1. MRVI - Mumbai Rental Value Index
2. MPS  - Market Position Score
===============================================================================
*/

DROP VIEW IF EXISTS analytics.vw_business_metrics;

CREATE VIEW analytics.vw_business_metrics AS

/*=============================================================================
STEP 1 : BASE METRICS
=============================================================================*/

WITH base_metrics AS
(
    SELECT

        dl.locality,

        ROUND(AVG(fr.rent),2)             AS average_rent,

        ROUND(AVG(fr.rent_per_sqft),2)    AS average_rent_per_sqft,

        ROUND(AVG(fr.carpet_area_sqft),2) AS average_carpet_area

    FROM core.fact_rent fr

    INNER JOIN core.dim_locality dl
        ON fr.locality_key = dl.locality_key

    GROUP BY
        dl.locality
),

/*=============================================================================
STEP 2 : MUMBAI BENCHMARK
=============================================================================*/

city_benchmark AS
(
    SELECT

        ROUND(AVG(average_rent),2)          AS mumbai_average_rent,

        ROUND(AVG(average_rent_per_sqft),2) AS mumbai_average_rent_per_sqft

    FROM base_metrics
),

/*=============================================================================
STEP 3 : LOCALITY BENCHMARK
=============================================================================*/

benchmark_metrics AS
(
    SELECT

        bm.locality,

        bm.average_rent,

        bm.average_rent_per_sqft,

        bm.average_carpet_area,

        cb.mumbai_average_rent,

        cb.mumbai_average_rent_per_sqft,

        ROUND
        (
            (
                (
                    bm.average_rent_per_sqft
                    -
                    cb.mumbai_average_rent_per_sqft
                )
                /
                NULLIF(cb.mumbai_average_rent_per_sqft,0)
            ) * 100,
            2
        ) AS pricing_difference_pct

    FROM base_metrics bm

    CROSS JOIN city_benchmark cb
),

/*=============================================================================
STEP 4 : MRVI SCORE

Higher Score = Better Rental Value
Lower Rent/SqFt = Higher Score
=============================================================================*/

mrvi_metrics AS
(
    SELECT

        locality,

        average_rent,

        average_rent_per_sqft,

        average_carpet_area,

        mumbai_average_rent,

        mumbai_average_rent_per_sqft,

        pricing_difference_pct,

        ROUND
        (
            (
                100
                -
                (
                    PERCENT_RANK() OVER
                    (
                        ORDER BY average_rent_per_sqft ASC
                    ) * 100
                )
            )::NUMERIC,
            2
        ) AS mrvi_score

    FROM benchmark_metrics
),

/*=============================================================================
STEP 5 : MARKET POSITION SCORE (MPS)

Weighting:
70% = Average Rent
30% = Average Rent/SqFt

Higher Score = Better Overall Market Position
=============================================================================*/

mps_metrics AS
(
    SELECT

        locality,

        average_rent,

        average_rent_per_sqft,

        average_carpet_area,

        mumbai_average_rent,

        mumbai_average_rent_per_sqft,

        pricing_difference_pct,

        mrvi_score,

        ROUND
        (
            (
                (
                    100
                    -
                    (
                        PERCENT_RANK() OVER
                        (
                            ORDER BY average_rent ASC
                        ) * 100
                    )
                ) * 0.70
                +
                (
                    100
                    -
                    (
                        PERCENT_RANK() OVER
                        (
                            ORDER BY average_rent_per_sqft ASC
                        ) * 100
                    )
                ) * 0.30
            )::NUMERIC,
            2
        ) AS mps_score

    FROM mrvi_metrics
)

/*=============================================================================
FINAL OUTPUT
=============================================================================*/

SELECT

    locality,

    average_rent,

    average_rent_per_sqft,

    average_carpet_area,

    mumbai_average_rent,

    mumbai_average_rent_per_sqft,

    pricing_difference_pct,

    mrvi_score,

    CASE

        WHEN mrvi_score >= 85 THEN 'Excellent Rental Value'

        WHEN mrvi_score >= 70 THEN 'High Rental Value'

        WHEN mrvi_score >= 55 THEN 'Moderate Rental Value'

        WHEN mrvi_score >= 40 THEN 'Limited Rental Value'

        ELSE 'Premium Cost Market'

    END AS mrvi_category,

    mps_score,

    CASE

        WHEN mps_score >= 85 THEN 'Excellent'

        WHEN mps_score >= 70 THEN 'High'

        WHEN mps_score >= 55 THEN 'Moderate'

        WHEN mps_score >= 40 THEN 'Limited'

        ELSE 'Premium'

    END AS mps_category

FROM mps_metrics;


/*=============================================================================
VALIDATION QUERY
=============================================================================*/

SELECT

    locality,

    average_rent,

    average_rent_per_sqft,

    average_carpet_area,

    mumbai_average_rent,

    mumbai_average_rent_per_sqft,

    pricing_difference_pct,

    mrvi_score,

    mrvi_category,

    mps_score,

    mps_category

FROM analytics.vw_business_metrics

ORDER BY

    mrvi_score DESC,

    mps_score DESC,

    locality;


