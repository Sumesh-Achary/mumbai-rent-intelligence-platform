/*
===============================================================================
Script Name : 05_Create_Fact_Rent.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates the Fact Rent table.
===============================================================================
*/

DROP TABLE IF EXISTS core.fact_rent;

CREATE TABLE core.fact_rent
(
    listing_id VARCHAR(20) PRIMARY KEY,

    source_key INTEGER NOT NULL,

    locality_key INTEGER NOT NULL,

    property_key INTEGER NOT NULL,

    date_key INTEGER NOT NULL,

    rent NUMERIC(12,2),

    carpet_area_sqft NUMERIC(10,2),

    rent_per_sqft NUMERIC(10,2),

    rent_annual NUMERIC(12,2),

    property_age_years NUMERIC(5,2),

    CONSTRAINT fk_fact_source
        FOREIGN KEY (source_key)
        REFERENCES core.dim_source(source_key),

    CONSTRAINT fk_fact_locality
        FOREIGN KEY (locality_key)
        REFERENCES core.dim_locality(locality_key),

    CONSTRAINT fk_fact_property
        FOREIGN KEY (property_key)
        REFERENCES core.dim_property(property_key),

    CONSTRAINT fk_fact_date
        FOREIGN KEY (date_key)
        REFERENCES core.dim_date(date_key)
);