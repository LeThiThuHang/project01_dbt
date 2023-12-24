with dim_package_type__source as (
  select 
    package_type_id , 
    package_type_name
  from `vit-lam-data.wide_world_importers.warehouse__package_types`
)
, dim_package_type__rename_column as (
  select 
    package_type_id as package_type_key 
    , package_type_name as package_type_name 
  from dim_package_type__source
)
, dim_package_type_cast_type as (
  select 
    cast(package_type_key as integer) as package_type_key 
    , cast(package_type_name as string) as package_type_name
  from dim_package_type__rename_column
)
select 
  package_type_key 
  , package_type_name
from dim_package_type_cast_type