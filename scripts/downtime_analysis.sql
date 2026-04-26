-- Project: Automotive Efficiency Analytics
-- File: downtime_analysis.sql
-- Purpose: Identify main downtime root causes
-- Business Context: Detect recurring mechanical failures and operational stops

SELECT
    downtime_reason,
    COUNT(*) AS occurrences,
    SUM(downtime_minutes) AS total_downtime_minutes
FROM data
GROUP BY downtime_reason
ORDER BY total_downtime_minutes DESC, occurrences DESC;