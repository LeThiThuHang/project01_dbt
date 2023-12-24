with dim_city__source as (
  select 
    city_id 
    , city_name 
    , state_province_id 
  from `vit-lam-data.wide_world_importers.application__cities`
)
, dim_city__rename_columns as (
  select 
    city_id as city_key 
    , city_name as city_name 
    , state_province_id as state_province_key
  from dim_city__source
)
, dim_city__cast_type as (
  select 
    cast (city_key as integer) as city_key 
    , cast (city_name as string) as city_name 
    , cast (state_province_key as integer) as state_province_key
  from dim_city__rename_columns
)
select 
  city.city_key
  , city.city_name
  , city.state_province_key 
  , province.state_province_name
from dim_city__cast_type as city
left join {{ref("stg_dim_province")}} as province 
  on city.state_province_key = province.state_province_key