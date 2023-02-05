{{
  config(
    materialized='table'
  )
}}


 with base as (select 
SUM(ADD_TO_CART) as add_to_cart
    , SUM(CHECKOUT) as checkout
    , SUM(PAGE_VIEW) as page_view    
    , SUM(PAGE_VIEW + ADD_TO_CART + CHECKOUT) as total_sessions
    from {{ ref('int_session_events_macro_agg')}}
 )

select
  add_to_Cart / page_view as CR1_cart_from_views
, checkout / add_to_cart as CR2_checkout_from_cart
, page_view / total_sessions as page_view_rate
, add_to_Cart / total_sessions as add_to_cart_rate
, checkout / total_sessions as checkout_rate
from base