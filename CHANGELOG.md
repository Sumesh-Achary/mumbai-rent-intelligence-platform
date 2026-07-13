# Changelog

## Version 0.1.0
- Initial project setup
- PostgreSQL database created
- Folder structure established

## Version 0.2.0
- Star schema implemented
- Fact and dimension tables created
- ETL completed

## Version 0.3.0
- SQL analytics completed
- Business Insights module added
- Invalid analyses removed

## Version 0.4.0
- Semantic Analytics Layer introduced
- Executive Dashboard view created
- Locality Intelligence view created
- Property Intelligence view created

# Version 0.5.0 – Semantic Analytics Layer

## Added
- Created vw_executive_dashboard
- Created vw_locality_intelligence
- Created vw_property_intelligence
- Created vw_pricing_intelligence
- Created vw_time_intelligence

## Improved
- Standardized analytics layer naming conventions.
- Separated business domains into reusable semantic views.
- Enhanced documentation for analytics layer.

## Fixed
- Updated time intelligence view to use year_number, quarter_number and month_number from dim_date.
- Removed unsupported analyses based on equal sampling methodology.

