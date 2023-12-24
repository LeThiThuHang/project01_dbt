with dim_person__source as (
  select 
    person_id 
    , full_name 
    , preferred_name
    , search_name 
    , is_employee 
    , is_salesperson
  from `vit-lam-data.wide_world_importers.application__people`
)
, dim_person__rename_column as (
  select 
    person_id as person_key 
    , full_name 
    , preferred_name
    , search_name 
    , is_employee 
    , is_salesperson
  from dim_person__source
)
, dim_person__cast_type as (
  select
    cast (person_key as integer) as person_key 
    , cast ( full_name as string) as full_name 
    , cast ( preferred_name as string) as preferred_name 
    , cast ( search_name as string) as search_name 
    , cast ( is_employee as boolean) is_employee
    , cast ( is_salesperson as boolean) as is_salesperson
  from dim_person__rename_column
)
, dim_person__boolean as ( 
  select 
    person_key
    , full_name
    , preferred_name 
    , search_name 
    , case 
      when is_employee is true then "Employee"
      when is_employee is false then "Is not employee"
      else "Undefined" end 
      as is_employee
    , case 
      when is_salesperson is true then "Salesperson"
      when is_salesperson is false then "Is not salesperson"
      else "Undefined" end 
      as is_salesperson
  from dim_person__cast_type
)
select 
  person_key
  , full_name 
  , preferred_name 
  , search_name 
  , is_employee 
  , is_salesperson
from dim_person__boolean
