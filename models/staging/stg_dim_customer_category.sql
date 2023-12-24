with stg_dim_customer_category_source as (
  select 
    customer_category_id
    , customer_category_name 
  from `vit-lam-data.wide_world_importers.sales__customer_categories`
)
,  stg_dim_customer_category_rename as (
  select 
    customer_category_id as customer_category_key 
    , customer_category_name as customer_category_name
  from stg_dim_customer_category_source
)
,  stg_dim_customer_category_cast_type as (
  select 
    cast(customer_category_key as integer) as customer_category_key
    , cast(customer_category_name as string) as customer_category_name
  from stg_dim_customer_category_rename
)

select 
*
from  stg_dim_customer_category_cast_type