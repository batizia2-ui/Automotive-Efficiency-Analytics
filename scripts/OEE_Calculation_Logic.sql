-- Project: Automotive Efficiency Analytics
-- File: OEE_Calculation_Logic.sql
-- Purpose: Calculate OEE (Availability, Performance, Quality)
-- Business Context: Identify efficiency losses in stamping line

WITH base AS (
    SELECT
        SUM(planned_time_minutes) AS planned_time,
        SUM(operating_time_minutes) AS operating_time,
        SUM(total_units) AS total_units,
        SUM(good_units) AS good_units
    FROM data
),
metrics AS (
    SELECT
        planned_time,
        operating_time,
        total_units,
        good_units,
        CASE 
            WHEN planned_time = 0 THEN 0
            ELSE ROUND((operating_time * 100.0) / planned_time, 2)
        END AS availability_pct,
        CASE 
            WHEN operating_time = 0 THEN 0
            ELSE ROUND((total_units * 100.0) / operating_time, 2)
        END AS performance_pct,
        CASE 
            WHEN total_units = 0 THEN 0
            ELSE ROUND((good_units * 100.0) / total_units, 2)
        END AS quality_pct
    FROM base
)
SELECT
    availability_pct,
    performance_pct,
    quality_pct,
    ROUND((availability_pct * performance_pct * quality_pct) / 10000.0, 2) AS oee_pct
FROM metrics; 