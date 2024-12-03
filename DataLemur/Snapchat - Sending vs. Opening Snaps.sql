-- Write a query to obtain a breakdown of the time spent sending vs. opening snaps as a percentage of total time spent on these activities grouped by age group.
-- Round the percentage to 2 decimal places in the output

WITH table_times AS (
  SELECT
    age_bucket,
    SUM(CASE WHEN activity_type = 'send' THEN time_spent ELSE 0 END) AS send_time,
    SUM(CASE WHEN activity_type = 'open' THEN time_spent ELSE 0 END) AS open_time,
    SUM(CASE WHEN activity_type IN ('open', 'send') THEN time_spent ELSE 0 END) AS total_time
    FROM
      activities
    INNER JOIN
      age_breakdown ON
        activities.user_id = age_breakdown.user_id
    GROUP BY
      age_bucket
)

SELECT
  age_bucket,
  ROUND(100 * send_time/total_time, 2) AS send_perc,
  ROUND(100 * open_time/total_time, 2) AS open_perc
  FROM
    table_times;