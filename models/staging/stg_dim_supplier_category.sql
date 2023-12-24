with dim_supplier_category__source as (
  select 
    supplier_category_id 
    , supplier_category_name
  from `vit-lam-data.wide_world_importers.purchasing__supplier_categories`
)
, dim_supplier_category__rename_column as (
  select 
    supplier_category_id as supplier_category_key 
    , supplier_category_name as supplier_category_name
  from dim_supplier_category__source
)
, dim_supplier_category__cast_type as (
  select
    cast(supplier_category_key as integer) as supplier_category_key 
    , cast(supplier_category_name as string) as supplier_category_name
  from dim_supplier_category__rename_colum
)
select 
  supplier_category_key
  , supplier_category_name
from dim_supplier_category__cast_type