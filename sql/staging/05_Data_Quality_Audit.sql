-- Missing Values by Important Columns

SELECT
    COUNT(*) AS total_rows,
	COUNT(*) FILTER (WHERE listing_id IS NULL) AS missing_listing_id,
    COUNT(*) FILTER (WHERE locality IS NULL) AS missing_locality,
    COUNT(*) FILTER (WHERE rent IS NULL) AS missing_rent,
    COUNT(*) FILTER (WHERE carpet_area_sqft IS NULL) AS missing_area,
    COUNT(*) FILTER (WHERE posted_date IS NULL) AS missing_posted_date
FROM staging.rent_raw;

-- Duplicate Listing IDs
SELECT
    listing_id,
    COUNT(*) AS duplicates
FROM staging.rent_raw
GROUP BY listing_id
HAVING COUNT(*) > 1;

--Invalid Rent Values

SELECT *
FROM staging.rent_raw
WHERE rent <= 0;

-- Invalid Carpet Area
SELECT *
FROM staging.rent_raw
WHERE carpet_area_sqft <= 0;

-- Invalid BHK
SELECT *
FROM staging.rent_raw
WHERE bhk < 1
   OR bhk > 10;

-- Future Posted Dates
SELECT *
FROM staging.rent_raw
WHERE posted_date > CURRENT_DATE;


-- Data Quality Summary
SELECT
    COUNT(*) AS total_records,
    COUNT(*) FILTER (WHERE data_quality_flag = 'Pass') AS good_records,
    COUNT(*) FILTER (WHERE data_quality_flag <> 'Pass') AS flagged_records
FROM staging.rent_raw;
