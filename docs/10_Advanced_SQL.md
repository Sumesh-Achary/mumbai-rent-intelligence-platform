# Sprint 4 – Advanced SQL

## Module 1 – Window Functions

### Concept

Window functions perform calculations across a group of rows without collapsing the result set.

### Business Use Case

Compare each rental listing against the average rent of its locality while preserving individual property records.

### Function Used

AVG() OVER (PARTITION BY locality)

## Module 2 – ROW_NUMBER()

### Concept

Assigns a unique sequential number to every row within a partition.

### Business Use Case

Identify the cheapest rental listing in every locality.

### Function Used

ROW_NUMBER() OVER
(
PARTITION BY locality
ORDER BY rent
)

## Module 3 – Ranking Functions

### RANK()

Assigns rankings with gaps after ties.

Business Use Case

Competition-style ranking of localities by average rent.

---

### DENSE_RANK()

Assigns rankings without gaps after ties.

Business Use Case

Business dashboards where consecutive rankings are preferred.

## Module 4 – NTILE()

### Concept

Divides ordered rows into equal-sized groups (tiles).

### Business Use Case

Segment Mumbai localities into Premium, Upper Mid, Lower Mid, and Budget markets based on average rent.

### Function Used

NTILE(4) OVER (ORDER BY average_rent DESC)

## Module 5 – LAG() and LEAD()

### LAG()

Returns a value from a previous row.

Business Use Case

Compare current month's average rent with the previous month.

### LEAD()

Returns a value from the next row.

Business Use Case

Prepare future-period comparisons and forecasting analyses.

