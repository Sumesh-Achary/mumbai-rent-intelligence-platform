/*
===============================================================================
Script Name : 01_KPI_Overview.sql
Project     : Mumbai Rent Intelligence Platform (MRIP)

Purpose:
Executive KPI overview of Mumbai rental market.

Author: Sumesh Achary
===============================================================================
*/

-- ============================================================================
-- KPI 1 : Total Rental Listings
-- ============================================================================

SELECT
    COUNT(*) AS total_listings
FROM core.fact_rent;


-- ============================================================================
-- KPI 2 : Total Localities Covered
-- ============================================================================

SELECT
    COUNT(*) AS total_localities
FROM core.dim_locality;


-- ============================================================================
-- KPI 3 : Total Property Types
-- ============================================================================

SELECT
    COUNT(DISTINCT property_type) AS total_property_types
FROM core.dim_property;


-- ============================================================================
-- KPI 4 : Total Data Sources
-- ============================================================================

SELECT
    COUNT(*) AS total_sources
FROM core.dim_source;

-- ============================================================================
-- KPI 5 : Average Monthly Rent
-- ============================================================================

SELECT
    ROUND(AVG(rent),2) AS average_rent
FROM core.fact_rent;


-- ============================================================================
-- KPI 6 : Minimum Rent
-- ============================================================================

SELECT
    MIN(rent) AS minimum_rent
FROM core.fact_rent;


-- ============================================================================
-- KPI 7 : Maximum Rent
-- ============================================================================

SELECT
    MAX(rent) AS maximum_rent
FROM core.fact_rent;


-- ============================================================================
-- KPI 8 : Average Rent Per Sq Ft
-- ============================================================================

SELECT
    ROUND(AVG(rent_per_sqft),2) AS average_rent_per_sqft
FROM core.fact_rent;


-- ============================================================================
-- KPI 9 : Average Annual Rent
-- ============================================================================

SELECT
    ROUND(AVG(rent_annual),2) AS average_annual_rent
FROM core.fact_rent;

-- ============================================================================
-- KPI 10 : Total Rental Market Value
-- ============================================================================

SELECT
    SUM(rent) AS total_monthly_market_value,
    SUM(rent_annual) AS total_annual_market_value
FROM core.fact_rent;