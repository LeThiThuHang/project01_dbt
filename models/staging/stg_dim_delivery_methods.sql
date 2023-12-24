with dim_delivery_method__source as (
  select 
  delivery_method_id
  , delivery_method_name
  from `vit-lam-data.wide_world_importers.application__delivery_methods`
)
, dim_delivery_method__rename_columns as (
  select 
  delivery_method_id as delivery_method_key
  , delivery_method_name as delivery_method_name
  from dim_delivery_method__source
)
, dim_delivery_method__cast_type as (
  select 
  cast (delivery_method_key as integer) as delivery_method_key
  , cast (delivery_method_name as string) as delivery_method_name
  from dim_delivery_method__rename_columns
)
select 
  delivery_method_key
  , delivery_method_name
from dim_delivery_method__cast_type

