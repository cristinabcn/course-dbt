{{
  config(
    materialized='table'
  )
}}

with orders_with_items as (
    select * from {{ ref('int_orders_with_items')}}
)
SELECT
        product_id
      , name as product_name
      , inventory as product_inventory
      , price as product_price
      , sum(quantity) as product_sales
    from orders_with_items
    group by 1,2,3,4
    

