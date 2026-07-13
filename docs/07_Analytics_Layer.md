# Analytics Layer

## Purpose

The Analytics layer provides reusable SQL views that expose business-ready data for reporting tools such as Power BI.

## Data Flow

Excel
↓
Staging
↓
Core Warehouse
↓
Analytics Views
↓
Power BI
↓
Business Decisions

## Benefits

- Centralized business logic
- Reusable SQL
- Cleaner Power BI model
- Easier maintenance
- Enterprise architecture

## Planned Views

- vw_kpi_overview
- vw_locality_analysis
- vw_affordability
- vw_market_trends
- vw_business_insights

## View: vw_kpi_overview

### Purpose

Provides executive-level KPIs for the Mumbai rental market.

### Source

core.fact_rent

### Metrics

- Total Listings
- Average Rent
- Minimum Rent
- Maximum Rent
- Average Rent per SqFt
- Average Carpet Area

### Consumers

- Executive Dashboard
- Power BI KPI Cards

## View: vw_locality_intelligence

### Purpose

Provides reusable locality-level rental intelligence for business reporting and Power BI.

### Source

- core.fact_rent
- core.dim_locality

### Metrics

- Average Rent
- Minimum Rent
- Maximum Rent
- Average Rent per SqFt
- Average Carpet Area
- Total Listings
- Confidence Level

### Consumers

- Locality Dashboard
- Executive Dashboard
- Budget Finder
- Pricing Intelligence

## View: vw_property_intelligence

### Purpose

Provides reusable property-level rental intelligence for business reporting and Power BI.

### Source

- core.fact_rent
- core.dim_property

### Metrics

- Average Rent
- Minimum Rent
- Maximum Rent
- Average Rent per SqFt
- Average Carpet Area
- Total Properties
- Confidence Level

### Consumers

- Property Dashboard
- Executive Dashboard
- Pricing Intelligence

## View: vw_pricing_intelligence

### Purpose

Provides pricing intelligence and value segmentation for Mumbai rental localities.

### Source

- core.fact_rent
- core.dim_locality

### Metrics

- Average Rent
- Average Rent per SqFt
- Average Carpet Area
- Market Position
- Value Segment

### Consumers

- Pricing Intelligence Dashboard
- Budget Finder
- Executive Dashboard

