WITH paypal_sales AS (
  SELECT 'Akash' AS name, 50 AS deals_closed UNION ALL
  SELECT 'Brittany', 50 UNION ALL
  SELECT 'Carlos', 40 UNION ALL
  SELECT 'Dave', 30 UNION ALL
  SELECT 'Eve', 30 UNION ALL
  SELECT 'Farhad', 10
)
SELECT name, deals_closed,
  RANK() OVER (ORDER BY deals_closed DESC) as rank,
  DENSE_RANK() OVER (ORDER BY deals_closed DESC) as dense_rank
FROM paypal_sales;