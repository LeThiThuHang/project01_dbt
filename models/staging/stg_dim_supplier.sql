with dim_supplier__source as (
  select
    supplier_id
    , supplier_name 
    , supplier_category_id
  from `vit-lam-data.wide_world_importers.purchasing__suppliers`
)
, dim_supplier__rename_columns as (
  select 
    supplier_id as supplier_key 
    , supplier_name as supplier_name 
    , supplier_category_id as supplier_category_key 
  from dim_supplier__source
)
, dim_supplier__cast_type as (
  select 
    cast(supplier_key as integer) as supplier_key 
    , cast(supplier_name as string) as supplier_name 
    , cast (supplier_category_key as integer) as supplier_category_key
  from dim_supplier__rename_columns
)
select 
  supplier.supplier_key
  , supplier.supplier_name
  , supplier.supplier_category_key 
  , supplier_category.supplier_category_name 
from dim_supplier__cast_type as supplier 
left join {{ref("stg_dim_supplier_category")}} as supplier_category 
  on supplier.supplier_category_key = supplier_category.supplier_category_key