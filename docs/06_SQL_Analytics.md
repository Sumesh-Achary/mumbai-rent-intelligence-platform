# Sprint 3 - SQL Analytics

## Module 1 - Executive KPI Overview

### Objectives

Generate high-level business metrics from the rental warehouse.

### KPIs

- Total Listings
- Total Localities
- Total Property Types
- Total Data Sources
- Average Monthly Rent
- Minimum Rent
- Maximum Rent
- Average Rent Per Sq Ft
- Average Annual Rent
- Total Monthly Market Value
- Total Annual Market Value

These KPIs form the basis of the Executive Dashboard in Power BI.

# Module 2 – Locality Analysis

## Objective

Analyze rental prices across Mumbai localities to identify premium, affordable and high-demand rental markets.

## Business Questions

- Which localities are the most expensive?
- Which localities are the most affordable?
- Which localities have the highest rental inventory?
- Which sub-regions have the highest average rents?
- Which locality tier offers the best value?

## Business Value

This analysis helps prospective tenants compare rental markets across Mumbai and identify areas that align with their budget and space requirements.

## SQL Concepts Used

- INNER JOIN
- GROUP BY
- HAVING
- ORDER BY
- Aggregate Functions
- LIMIT

## Interview Talking Points

This module demonstrates the ability to aggregate transactional data into locality-level business insights suitable for executive reporting and dashboard visualizations.

# Module 3 – Affordability Analysis

## Objective

Help renters identify localities that provide the best value within different budget ranges.

## Business Questions

- Which localities are most affordable?
- Which areas provide the best rent per square foot?
- Which areas offer the largest carpet area for the rent paid?
- Which budget segments have the highest number of listings?

## SQL Concepts Used

- CASE
- GROUP BY
- AVG
- MIN
- ORDER BY
- HAVING
- Aggregate Functions

## Business Recommendation

## Key Findings

- Top affordable locality:
- Best rent per sq ft:
- Highest MRIP Value Index:
- Best locality for families:
- Budget category with the most listings:

## Business Recommendation

The analysis suggests that renters should compare localities using both rent and carpet area rather than monthly rent alone. The MRIP Value Index highlights areas where tenants receive significantly more living space for the same budget, helping users make informed rental decisions.

# Module 4 – Market Trends

## Objective

Analyze rental market trends using time, property characteristics and listing sources.

## Business Questions

- How many listings are posted each month?
- How has average rent changed over time?
- Do newer properties command higher rents?
- How does furnishing impact rental prices?
- Which tenant category pays the highest rent?
- Which property type is most expensive?
- Which platform has higher average rents?
- How does rent vary by BHK?

## SQL Concepts Used

- INNER JOIN
- GROUP BY
- Aggregate Functions
- ORDER BY
- ROUND
- CONCAT

### Note

Property Type analysis was intentionally excluded because the current dataset contains only one property type (Apartment).

Including this analysis would not provide any meaningful business insight.

This query can be reintroduced in future versions of the project when additional property types (Independent House, Villa, Studio, Penthouse, etc.) are available.

# Module 5 – Business Insights

## Objective

Generate actionable recommendations that help renters identify affordable, premium and high-value localities.

## Business Questions

- Which localities are hidden gems?
- Which areas appear overpriced?
- Which premium localities justify their pricing?
- Which insights have high confidence?
- Which localities have the most consistent rental prices?

## SQL Concepts Used

- Common Table Expressions (CTEs)
- Aggregate Functions
- CASE
- GROUP BY
- HAVING
- Subqueries
- Business Logic

### Excluded Analysis: Rental Demand

Rental Demand analysis was intentionally excluded because the dataset was manually sampled with approximately 15 listings per locality.

As a result, listing counts reflect the data collection methodology rather than actual market demand.

This analysis would become meaningful only if the dataset were collected through automated scraping over a defined time period without imposing equal sample sizes per locality.

## Business Recommendation

(To be completed after reviewing query results.)



