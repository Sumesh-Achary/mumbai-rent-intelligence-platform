/*
===============================================================================
Script Name : 02_Create_Dim_Locality.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates the Locality Dimension table.
===============================================================================
*/

DROP TABLE IF EXISTS core.dim_locality;

CREATE TABLE core.dim_locality
(
    locality_key INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,

    locality VARCHAR(100) NOT NULL,

    sub_region VARCHAR(100),

    locality_tier VARCHAR(30),

    CONSTRAINT uq_dim_locality
        UNIQUE (locality, sub_region)
);

SELECT *
FROM core.dim_locality
ORDER BY locality;