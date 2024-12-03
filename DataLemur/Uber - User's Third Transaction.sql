-- Write a query to obtain the third transaction of every user.
-- Output the user id, spend and transaction date

WITH ranked AS (
    SELECT
        *, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY transaction_date) as row_num
    FROM transactions
)
SELECT user_id, spend, transaction_date
FROM ranked
WHERE row_num = 3;