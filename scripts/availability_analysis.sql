-- Project: Automotive Efficiency Analytics
-- File: availability_analysis.sql
-- Purpose: Analyze downtime impact on Availability
-- Business Context: Identify main causes of lost production time in stamping line

SELECT
    downtime_type,
    SUM(downtime_minutes) AS total_downtime_minutes
FROM data
GROUP BY downtime_type
ORDER BY total_downtime_minutes DESC;