/* Project: Automotive Efficiency Analytics
   Author: Basilia del Pozo
   Description: SQL Logic to calculate OEE metrics from raw production data.
*/

WITH ProductionData AS (
    SELECT 
        Line_ID,
        Shift_Date,
        Planned_Time_Min,        -- Total shift duration
        Downtime_Min,            -- Total downtime (e.g., 70 min Mechanical Failure)
        Total_Units,             -- Total items produced
        Good_Units,              -- Items meeting quality standards
        Ideal_Cycle_Time_Sec     -- Standard production rate
    FROM Stamping_Line_Audit
),
KPI_Calculations AS (
    SELECT 
        *,
        -- Availability = (Operating Time / Planned Time)
        ROUND(CAST((Planned_Time_Min - Downtime_Min) AS FLOAT) / Planned_Time_Min, 4) AS Availability,
        
        -- Performance = (Ideal Time * Total Units) / Operating Time
        ROUND(CAST((Ideal_Cycle_Time_Sec * Total_Units) / 60.0 AS FLOAT) / (Planned_Time_Min - Downtime_Min), 4) AS Performance,
        
        -- Quality = (Good Units / Total Units)
        ROUND(CAST(Good_Units AS FLOAT) / NULLIF(Total_Units, 0), 4) AS Quality
    FROM ProductionData
)
SELECT 
    Line_ID,
    Shift_Date,
    Availability,
    Performance,
    Quality,
    -- Final OEE = A * P * Q
    ROUND(Availability * Performance * Quality, 4) AS Overall_OEE
FROM KPI_Calculations;