# Data Profiling Report

## Project

Mumbai Rent Intelligence Platform

---

## Purpose

This document profiles the source rental dataset before it is loaded into PostgreSQL.

The objective is to:

- Understand the dataset structure.
- Validate data types.
- Identify missing values.
- Detect duplicate records.
- Detect invalid values.
- Document assumptions before ETL.

---

## Source Information

| Property | Value |
|----------|-------|
| Source File | Mumbai_Rent_Raw_Data.csv |
| Original Source | 99acres & MagicBricks |
| Data Format | CSV |
| Database | mumbai_rent_intelligence |
| Schema | staging |
| Table | rent_raw |

---

## Dataset Overview

To be updated after importing the CSV.

| Metric | Value |
|---------|------|
| Total Rows | |
| Total Columns | |
| Duplicate Records | |
| Missing Values | |
| Invalid Values | |

---

## Column Validation

This section documents each column, its purpose, SQL data type, and validation status.

(To be completed during profiling.)

---

## Data Quality Checks

The following checks will be performed after import:

- Duplicate Listing IDs
- Missing Rent
- Missing Locality
- Missing Carpet Area
- Missing Posted Date
- Invalid Rent Values
- Invalid Area Values
- Invalid BHK Values

---

## Observations

(To be updated during data profiling.)

---

## Next Step

Load validated data into the Core Data Warehouse.