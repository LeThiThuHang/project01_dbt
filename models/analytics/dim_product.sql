with dim_product__source as (
  select
    stock_item_id 
    , stock_item_name 
    , unit_package_id 
    , outer_package_id 
    , supplier_id 
  from `vit-lam-data.wide_world_importers.warehouse__stock_items`
)
, dim_product__rename_column as ( 
  select
    stock_item_id as stock_item_key 
    , stock_item_name 
    , unit_package_id as unit_package_key 
    , outer_package_id as outer_package_key 
    , supplier_id as supplier_key 
  from dim_product__source 
)
, dim_product__cast_type as (
  select 
    cast(stock_item_key as integer) as stock_item_key 
    , cast(stock_item_name as string) as stock_item_name 
    , cast (unit_package_key as integer) as unit_package_key 
    , cast(outer_package_key as integer) as outer_package_key 
    , cast (supplier_key as integer) as supplier_key
  from dim_product__rename_column
)
select 
  product.stock_item_key 
  , product.stock_item_name 
  , product.unit_package_key 
  , unit_package.package_type_name as unit_package_type_name
  , product.outer_package_key 
  , outer_package.package_type_name as outer_package_type_name 
  , product.supplier_key 
  , supplier.supplier_name 
  , supplier.supplier_category_name 
from dim_product__cast_type as product 
left join {{ref("dim_package_type")}} as unit_package 
  on product.unit_package_key = unit_package.package_type_key 
left join {{ref("dim_package_type")}} as outer_package 
  on product.unit_package_key = outer_package.package_type_key 
left join {{ref("stg_dim_supplier")}} as supplier 
  on product.supplier_key = supplier.supplier_key
