{{
  config(
    materialized='table'
  )
}}


with base as (
SELECT 
  count(distinct session_id) AS unique_sessions
, count(distinct (case when order_id is not null then session_id end)) AS sessions_with_order 
FROM {{ ref('stg_postgres_events') }}
)


select 
SUM(sessions_with_order) / SUM(unique_sessions) as conversion_rate
from base


