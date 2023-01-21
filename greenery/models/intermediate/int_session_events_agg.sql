{{
  config(
    materialized='table'
  )
}}

with events as (
    select 
        *
    from {{ ref('stg_postgres_events')}}
),
final as (
    select 
          user_id
        , session_id
        , sum(case when event_type = 'add_to_cars' then 1 else 0 end) as add_to_carts
        , sum(case when event_type = 'checkout' then 1 else 0 end) as checkout
        , sum(case when event_type = 'package_shipped' then 1 else 0 end) as package_shipped
        , sum(case when event_type = 'page_view' then 1 else 0 end) as page_view
        , min(created_at) AS first_session_event_at_utc
        , max(created_at) AS last_session_event_at_utc
    from events
    group by 1,2 
)
select * from final
