-- ============================================
-- Data Profiling Queries
-- Mumbai Rent Intelligence Platform
-- ============================================

--Total Rows
SELECT COUNT(*) AS total_rows
FROM staging.rent_raw;


--Preview Data
select * from staging.rent_raw
limit 10;


--Missing Rent
SELECT COUNT(*) AS missing_rent
FROM staging.rent_raw
WHERE rent IS NULL;


--Missing Locality
SELECT COUNT(*) AS missing_locality
FROM staging.rent_raw
WHERE locality IS NULL;


--Duplicate Listing IDs
SELECT listing_id,
       COUNT(*) AS duplicate_count
FROM staging.rent_raw
GROUP BY listing_id
HAVING COUNT(*) > 1;


--Rent Statistics
SELECT
    MIN(rent) AS minimum_rent,
    MAX(rent) AS maximum_rent,
    ROUND(AVG(rent),2) AS average_rent
FROM staging.rent_raw;



## Data Quality Audit

Performed SQL-based validation on the staging dataset.

Checks included:

- Missing values
- Duplicate Listing IDs
- Invalid Rent values
- Invalid Carpet Area
- Invalid BHK
- Future Posted Dates

Result:
(To be updated after audit execution.)