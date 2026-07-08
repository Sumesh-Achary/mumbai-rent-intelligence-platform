# Fact Table ETL

## Purpose

Loads rental listings into the warehouse fact table.

## Process

The ETL joins staging data with all dimension tables to retrieve surrogate keys.

### Dimension Lookups

- dim_source
- dim_locality
- dim_property
- dim_date

## Output

core.fact_rent

## Grain

One row = One rental listing.