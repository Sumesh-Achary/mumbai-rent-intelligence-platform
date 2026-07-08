/*
===============================================================================
Script Name : 04_Create_Dim_Date.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates the Date Dimension table.
===============================================================================
*/

DROP TABLE IF EXISTS core.dim_date;

CREATE TABLE core.dim_date
(
    date_key INTEGER PRIMARY KEY,

    full_date DATE NOT NULL UNIQUE,

    day_number SMALLINT,

    month_number SMALLINT,

    month_name VARCHAR(20),

    quarter_number SMALLINT,

    year_number SMALLINT,

    weekday_name VARCHAR(20)
);

SELECT *
FROM core.dim_date
ORDER BY full_date;