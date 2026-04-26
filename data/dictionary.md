# Data Dictionary — Automotive Efficiency Analytics

This dataset represents an OEE audit for a stamping production line.  
It includes production time, downtime events, and output metrics used to evaluate Availability, Performance, and Quality.

## Columns

- `planned_time`: Total scheduled production time for the shift.
- `operating_time`: Time the production line was actively running.
- `downtime_minutes`: Total minutes lost due to downtime events.
- `downtime_type`: Category of downtime (e.g., mechanical, setup, adjustment).
- `downtime_reason`: Specific cause of the downtime event.
- `total_units`: Total number of units produced.
- `good_units`: Units that passed quality inspection.
- `scrap_units`: Units rejected due to defects.
- `shift`: Production shift identifier.
- `date`: Date of the production audit.

## Notes

- Availability is calculated as operating_time / planned_time.
- Performance and Quality are derived from production output and scrap rates.
- This dataset is used to identify efficiency losses and improvement opportunities in the production line.