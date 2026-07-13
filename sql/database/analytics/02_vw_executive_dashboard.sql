DROP VIEW IF EXISTS analytics.vw_executive_dashboard;



CREATE VIEW analytics.vw_executive_dashboard AS
SELECT
COUNT(*) AS total_listings,
ROUND(AVG(rent),2) AS average_rent,
MIN(rent) AS minimum_rent,
MAX(rent) AS maximum_rent,
ROUND(AVG(rent_per_sqft),2) AS average_rent_per_sqft,
ROUND(AVG(carpet_area_sqft),2) AS average_carpet_area
FROM core.fact_rent;

SELECT *
FROM analytics.vw_executive_dashboard;

