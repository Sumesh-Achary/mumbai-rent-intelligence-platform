# Star Schema

## Fact Table

fact_rent

## Dimensions

- dim_source
- dim_locality
- dim_property
- dim_date

## Grain

One record = One rental listing at the time of posting.

## Purpose

The star schema separates descriptive attributes from measurable values.

Benefits:

- Faster Power BI performance
- Simpler DAX calculations
- Reduced data redundancy
- Easier maintenance