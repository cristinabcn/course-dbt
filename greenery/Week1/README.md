


Question 1 : How many users do we have?
130 Distinct Users

SELECT COUNT (DISTINCT user_id) 
FROM stg_postgres_users



Question 2 : On average, how many orders do we receive per hour?
7,52 orders per hour on average


SELECT 
count (DISTINCT order_id) as "total orders",
count (distinct order_id) / DATEDIFF (hour, min (date(created_at)), max(((created_at))))
FROM stg_postgres_orders


Question 3: On average, how long does an order take from being placed to being delivered?
It takes 3,89 days on average to deliver an order since it's placed

with not_null_delivery as
(select * from stg_postgres_orders
where delivered_at is not null)
select
count(*) as total_orders,
sum(datediff(day, created_at, delivered_at)) as total_days,
sum(datediff(day, created_at, delivered_at)) / count(*) as average_days_to_deliver
from not_null_delivery


Question 4 : How many users have only made one purchase? Two purchases? Three+ purchases?
1 Purchase: 25, 2 Purchases: 28, more than 3 Purchases: 71


WITH purchases_by_user AS (
SELECT COUNT (DISTINCT order_id) AS "Purchases by User", 
       user_id
FROM STG_POSTGRES_ORDERS
GROUP BY 2)

SELECT count(DISTINCT user_id), 
CASE WHEN "Purchases by User" = 1 then '1 Purchase'
     WHEN "Purchases by User" = 2 then '2 Purchases'
     WHEN "Purchases by User" > 2 then '+3 Purchases'
     END                  AS  "Purchases by User"
FROM purchases_by_user
GROUP BY 2


Question 5: On average, how many unique sessions do we have per hour?
39,34 unique sessions per hour

WITH cte_hours AS (
select HOUR(CREATED_AT) as hour, count(distinct session_id) as sessions
from stg_postgres_events
GROUP BY 1
ORDER BY 1 ASC)
Select sum(sessions)/ count(hour) as average_sessions from cte_hours
