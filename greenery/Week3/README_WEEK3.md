# PART 1
Q1: What is our conversion Rate?
- Answer:  0,624

- Method:
```
with base as (
SELECT 
  count(distinct session_id) AS unique_sessions
, count(distinct (case when order_id is not null then session_id end)) AS sessions_with_order 
FROM stg_postgres_events
)

select 
SUM(sessions_with_order) / SUM(unique_sessions) as conversion_rate
from base
```

Q2: What is our conversion Rate by Product?

- Answer:
String of pearls	  m gre0.609375
Arrow Head	        0.555556
Pilea Peperomioides	0.474576
Jade Plant	        0.478261
Orchid	            0.453333
Cactus	            0.545455
Bird of Paradise	  0.45
Birds Nest Fern	    0.423077
Aloe Vera	          0.492308
Alocasia Polly     	0.411765
Bamboo            	0.537313
Peace Lily	        0.409091
Fiddle Leaf Fig 	  0.5
ZZ Plant	          0.539683
Money Tree	        0.464286
Pink Anthurium  	  0.418919
Ponytail Palm	      0.4
Dragon Tree	        0.467742
Pothos	            0.344262
Spider Plant	      0.474576
Majesty Palm	      0.492537
Calathea Makoyana	  0.509434
Philodendron	      0.483871
Snake Plant	        0.39726
Boston Fern	        0.412698
Devil's Ivy	        0.488889
Rubber Plant	      0.518519
Monstera	          0.510204
Angel Wings Begonia	0.393443
Ficus	              0.426471



- Method:

```
with base as(SELECT 
 count(distinct (case when event_type = 'checkout' then session_id end)) AS sessions_with_order 
,count(distinct (case when event_type = 'page_view' then session_id end)) AS sessions_with_view
,coalesce (i.name, p.name) AS product_name
FROM stg_postgres_events e
LEFT JOIN int_orders_with_items i on e.order_id = i.order_id
LEFT JOIN stg_postgres_products p on e.product_id = p.product_id
group by product_name)


SELECT
 product_name
 ,SUM(sessions_with_order) / SUM(sessions_with_view) AS conversion_rate
from base
group by product_name
```

# PART 5: Snapshot - Which orders changed from week 2 to week 3? 

- Answer: These are the orders that changed from Week 2 to Week 3:
29d20dcd-d0c4-4bca-a52d-fc9363b5d7c6, c0873253-7827-4831-aa92-19c38372e58d, e2729b7d-e313-4a6f-9444-f7f65ae8db9a


 - Method:     
 ```            
select order_id
from DEV_DB.DBT_CRISTINABLANCOAUDIBENEDE.SNAPSHOT_ORDERS
where dbt_valid_to::date = '2023-01-26'
```