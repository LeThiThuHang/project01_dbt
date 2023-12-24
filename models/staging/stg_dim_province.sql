with dim_state_province__source as (
  select 
    state_province_id 
    , state_province_name
  from `vit-lam-data.wide_world_importers.application__state_provinces`
)
, dim_state_province__rename_column as (
  select 
    state_province_id as state_province_key 
    , state_province_name as state_province_name 
  from dim_state_province__source
)
, dim_state_province__cast_type as (
  select 
    cast (state_province_key as integer) as state_province_key 
    , cast (state_province_name as string) as state_province_name
  from dim_state_province__rename_column
)
select 
  state_province_key 
  , state_province_name 
from dim_state_province__cast_type