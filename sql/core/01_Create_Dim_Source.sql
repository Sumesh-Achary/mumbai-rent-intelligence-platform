/*
===============================================================================
Script Name : 01_Create_Dim_Source.sql
Project     : Mumbai Rent Intelligence Platform

Purpose:
Creates the Source Dimension table.
===============================================================================
*/

DROP TABLE IF EXISTS core.dim_source;

CREATE TABLE core.dim_source
(
    source_key INTEGER GENERATED ALWAYS AS IDENTITY
        PRIMARY KEY,

    source_name VARCHAR(50) NOT NULL
        UNIQUE
);

SELECT *
FROM core.dim_source;


