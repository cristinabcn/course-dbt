{{
  config(
    materialized='table'
  )
}}

with orders_with_items as (
select 
o.order_id
, promo_id
, user_id
, address_id
, created_at AS order_created_at
, order_cost
, shipping_cost
, order_total
, tracking_id
, estimated_delivery_at 
, status as order_status
, i.product_id
, i.quantity
, p.name
, p.price
, p.inventory
from {{ ref('stg_postgres_orders')}} o
left join {{ref ('stg_postgres_order_items')}} i on o.order_id = i.order_id
left join {{ref ('stg_postgres_products')}} p on i.product_id = p.product_id

)

select*
from orders_with_items
