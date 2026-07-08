# Data Model

## Fact Table Grain

Each record in fact_rent represents one rental property listing captured on its posted date.

The fact table stores measurable business values such as:

- Monthly Rent
- Carpet Area
- Rent per SqFt
- Annual Rent

Dimensions provide descriptive attributes for analysis.

## Dimension Tables

### dim_source

Purpose:

Stores unique property listing platforms.

Primary Key:

- source_key (Surrogate Key)

Business Key:

- source_name

### ETL

Source data is loaded into dim_source using DISTINCT values from staging.rent_raw.

Business Rule:

- Ignore NULL values.
- Keep one record per unique source platform.

### dim_locality

Purpose:

Stores unique Mumbai localities and their geographical classification.

Primary Key

- locality_key

Business Key

- locality + sub_region

Attributes

- locality
- sub_region
- locality_tier

### dim_property

Purpose

Stores descriptive property characteristics.

Primary Key

- property_key

Business Key

- BHK
- Bathroom
- Furnishing
- Property Type
- Property Age Category

Attributes

- bhk
- bathroom
- furnishing
- property_type
- property_age_category

### dim_date

Purpose

Stores calendar attributes used for time-based analysis.

Primary Key

- date_key

Business Key

- full_date

Attributes

- day_number
- month_number
- month_name
- quarter_number
- year_number
- weekday_name

### fact_rent

Purpose

Stores one record per rental listing.

Grain

One row = One rental listing at the time it was posted.

Measures

- rent
- carpet_area_sqft
- rent_per_sqft
- rent_annual
- property_age_years
- affordability_ratio

Foreign Keys

- source_key
- locality_key
- property_key
- date_key

Business Key

- listing_id