{{
  config(
    materialized='table'
  )
}}


with user as (
    SELECT
      u.first_name
    , u.last_name
    , u.email
    , u.phone_number
    , u.created_at
    , u.updated_at
    , a.zipcode
    , a.state
    , a.country
from {{ ref('stg_postgres_users') }} u
left join {{ ref('stg_postgres_addresses') }} a
on u.address_id = a.address_id
)

select * from user