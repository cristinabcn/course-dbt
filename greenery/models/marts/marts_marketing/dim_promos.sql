{{
  config(
    materialized='table'
  )
}}


    select 
        *
    from {{ ref('int_promos_agg')}}
