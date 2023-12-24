with stg_dim_buying_group_source as (
  select 
    buying_group_id
    , buying_group_name
  from `vit-lam-data.wide_world_importers.sales__buying_groups`

)
, stg_dim_buying_group_rename_column as (
  select
    buying_group_id as buying_group_key 
    , buying_group_name as buying_group_name
  from stg_dim_buying_group_source
)

, stg_dim_buying_group_add_undefined as(
  select *
  from stg_dim_buying_group_rename_column
  union all 
  select
    0 as buying_group_key,
    'Undefined' as buying_group_name
  union all 
  select
    -1 as buying_group_key,
    'Invalid' as buying_group_name
)

, stg_dim_buying_group_cast_type as (
  select
    cast(buying_group_key as integer) as buying_group_key
    , cast(buying_group_name as string) as buying_group_name
  from stg_dim_buying_group_add_undefined
)

select *
from stg_dim_buying_group_cast_type