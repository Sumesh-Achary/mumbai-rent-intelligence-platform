-- Row Count Check

SELECT COUNT(*) AS source_count
FROM core.dim_source;

SELECT COUNT(*) AS locality_count
FROM core.dim_locality;

SELECT COUNT(*) AS property_count
FROM core.dim_property;

SELECT COUNT(*) AS date_count
FROM core.dim_date;


-- Duplicate Check

--Source
SELECT source_name, COUNT(*)
FROM core.dim_source
GROUP BY source_name
HAVING COUNT(*) > 1;

--Locality
SELECT locality,
       sub_region,
       COUNT(*)
FROM core.dim_locality
GROUP BY locality,
         sub_region
HAVING COUNT(*) > 1;

--Property
SELECT
    bhk,
    bathroom,
    furnishing,
    property_type,
    property_age_category,
    COUNT(*)
FROM core.dim_property
GROUP BY
    bhk,
    bathroom,
    furnishing,
    property_type,
    property_age_category
HAVING COUNT(*) > 1;

--Date
SELECT full_date,
       COUNT(*)
FROM core.dim_date
GROUP BY full_date
HAVING COUNT(*) > 1;


-- Preview Data

SELECT * FROM core.dim_source;
SELECT * FROM core.dim_locality LIMIT 10;
SELECT * FROM core.dim_property LIMIT 10;
SELECT * FROM core.dim_date LIMIT 10;
