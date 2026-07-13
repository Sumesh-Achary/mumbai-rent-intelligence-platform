# SQL Best Practices

## Naming

fr = fact_rent

dl = dim_locality

dp = dim_property

ds = dim_source

dd = dim_date

-----------------------------------

Always

ROUND()

NULLIF()

COUNT(*)

COUNT(DISTINCT)

Meaningful aliases

Comment every business question

-----------------------------------

Avoid

SELECT *

Hardcoded values

Nested subqueries when JOIN is clearer

Duplicate logic