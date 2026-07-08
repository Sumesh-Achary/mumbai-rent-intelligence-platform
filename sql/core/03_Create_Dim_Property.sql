/*
===============================================================================
Script Name : 03_Create_Dim_Property.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates the Property Dimension table.
===============================================================================
*/

DROP TABLE IF EXISTS core.dim_property;

CREATE TABLE core.dim_property
(
    property_key INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,

    bhk SMALLINT NOT NULL,

    bathroom SMALLINT NOT NULL,

    furnishing VARCHAR(50),

    property_type VARCHAR(50),

    property_age_category VARCHAR(50),

    CONSTRAINT uq_dim_property
        UNIQUE
        (
            bhk,
            bathroom,
            furnishing,
            property_type,
            property_age_category
        )
);

SELECT *
FROM core.dim_property
ORDER BY property_key;