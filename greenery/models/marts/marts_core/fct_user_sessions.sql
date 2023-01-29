{{
  config(
    materialized='table'
  )
}}


    select  *
    from {{ ref('int_session_events_macro_agg')}}
