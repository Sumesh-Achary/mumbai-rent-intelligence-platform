# 🏙️ Mumbai Rent Intelligence Platform (MRIP)

## 📌 Project Overview

The Mumbai Rent Intelligence Platform (MRIP) is an end-to-end data analytics project that transforms raw rental listings into actionable business insights using PostgreSQL and Power BI.

The objective is to help renters make informed housing decisions by identifying fair rental prices, comparing localities, and analyzing market trends.

---

## 🎯 Business Problem

Many people searching for rental homes in Mumbai have limited access to reliable market insights. As a result, they often overpay or depend heavily on brokers.

This platform addresses that problem by:

- Identifying fair rental prices
- Comparing localities based on rent per sq. ft.
- Highlighting premium and affordable markets
- Providing data-driven rental insights

---

## 🛠 Tech Stack

- PostgreSQL 18
- SQL
- Power BI
- Git & GitHub

---

## 📂 Project Structure

```text
sql/
docs/
data/
powerbi/
images/
```

---

## 🏗 Data Warehouse Architecture

The project follows a Star Schema.

- Staging Layer
- Dimension Tables
- Fact Table

Dimensions

- dim_source
- dim_locality
- dim_property
- dim_date

Fact

- fact_rent

---

## 🔄 ETL Workflow

Raw Dataset

↓

staging.rent_raw

↓

Dimension Tables

↓

fact_rent

↓

Analytics

↓

Power BI Dashboard

---

## 📊 Planned Dashboard Features

- Executive KPI Dashboard
- Rental Price Intelligence
- Locality Comparison
- Rent per Sq. Ft. Analysis
- Time Trend Analysis
- Property Insights

---

## 📌 Current Status

- ✅ Data Warehouse Completed
- 🔄 SQL Analytics In Progress
- ⏳ Power BI Dashboard
- ⏳ Documentation & Case Study

---

## 👨‍💻 Author

**Sumesh Achary**

Aspiring Data Analyst | SQL | PostgreSQL | Power BI
