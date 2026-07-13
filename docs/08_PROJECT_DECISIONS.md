# Project Decisions Log

---

## Decision #001

### Title
Use Star Schema

### Decision
Implemented a Star Schema with one fact table and multiple dimension tables.

### Reason
Optimized for analytical workloads, simpler joins, and Power BI reporting.

### Alternatives Considered
Snowflake Schema

### Why Rejected
Additional joins without meaningful benefit for this project.

---

## Decision #002

### Title
Create an Analytics Schema

### Decision
Implemented a dedicated analytics schema containing reusable SQL views.

### Reason
Centralizes business logic and keeps Power BI dashboards simple and maintainable.

---

## Decision #003

### Title
Exclude Property Type Analysis

### Decision
Property Type analysis was not included.

### Reason
The dataset contains only one property type (Apartment), so the analysis would not provide meaningful business insight.

---

## Decision #004

### Title
Exclude Rental Demand Analysis

### Decision
Rental Demand analysis was removed.

### Reason
Approximately 30 listings were collected for every locality, meaning listing counts reflect the sampling strategy rather than actual market demand.