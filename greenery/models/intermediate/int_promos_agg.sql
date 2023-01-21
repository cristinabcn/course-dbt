{{
  config(
    materialized='table'
  )
}}

with promos as (
    select 
        *
    from {{ ref('stg_postgres_promos')}}
),
final as (
    select 
          promo_id
        , discount
        , sum(case when status = 'active' then 1 else 0 end) as active_promos
        , sum(case when status = 'inactive' then 1 else 0 end) as inactive_promos
        , sum(case when discount >=  '11' then 1 else 0 end) as high_discounted_promos
        , sum(case when discount <  '11' then 1 else 0 end) as low_discounted_promos    
        from promos
    group by 1,2
)
select * from final
