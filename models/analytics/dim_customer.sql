with dim_customer__source as (
    select 
        customer_id
        , customer_name 
        , is_statement_sent
        , is_on_credit_hold
        , credit_limit
        , standard_discount_percentage
        , payment_days
        , account_opened_date
        , customer_category_id
        , buying_group_id
        , delivery_method_id
        , delivery_city_id
        , postal_city_id
        , primary_contact_person_id
        , alternate_contact_person_id 
        , bill_to_customer_id 
    from `vit-lam-data.wide_world_importers.sales__customers`
)
, dim_customer__rename_columns as (
    select 
      customer_id as customer_key
      , customer_name as customer_name
      , is_statement_sent as is_statement_sent
      , is_on_credit_hold as is_on_credit_hold
      , credit_limit as credit_limit
      , standard_discount_percentage as standard_discount_percentage
      , payment_days as payment_days
      , account_opened_date as account_opened_date
      , customer_category_id as customer_category_key
      , buying_group_id as buying_group_key
      , delivery_method_id as delivery_method_key
      , delivery_city_id as delivery_city_key
      , postal_city_id as postal_city_key
      , primary_contact_person_id as primary_contact_person_key
      , alternate_contact_person_id as alternate_contact_person_key 
      , bill_to_customer_id as bill_to_customer_key 
    from dim_customer__source
)
, dim_customer__cast_type as (
    select
      cast(customer_key as integer) as customer_key
      , cast(customer_name as string) as customer_name
      --dung ten cho cot boolean khác với các cột kia
      , cast(is_statement_sent as boolean) as is_statement_sent_boolean
      , cast(is_on_credit_hold as boolean) as is_on_credit_hold_boolean
      , cast(credit_limit as integer) as credit_limit
      , cast(standard_discount_percentage as integer) as standard_discount_percentage
      , cast(payment_days as integer) as payment_days
      , cast(account_opened_date as date) as account_opened_date
      , cast(customer_category_key as integer) as customer_category_key
      , cast(buying_group_key as integer) as buying_group_key
      , cast(delivery_method_key as integer) as delivery_method_key
      , cast(delivery_city_key as integer) as delivery_city_key
      , cast(postal_city_key as integer) as postal_city_key
      , cast(primary_contact_person_key as integer) as primary_contact_person_key
      , cast(alternate_contact_person_key as integer) as alternate_contact_person_key 
      , cast(bill_to_customer_key as integer) as bill_to_customer_key
    from dim_customer__rename_columns
)
, dim_customer_convert_boolean as (
  select
    customer_key
    , customer_name
    , case 
    when is_statement_sent_boolean is true then "Statement Sent"
    when is_statement_sent_boolean is false then "Statement Not Send"
    else "Undefined" end 
    as is_statement_sent
    , case
    when is_on_credit_hold_boolean is true then "On Credit Hold"
    when is_on_credit_hold_boolean is false then "Not on Credit Hold"
    else "Undefined" end
    as is_on_credit_hold
    , credit_limit
    , standard_discount_percentage
    , payment_days
    , account_opened_date
    , customer_category_key
    , buying_group_key
    , delivery_method_key
    , delivery_city_key
    , postal_city_key
    , primary_contact_person_key
    , alternate_contact_person_key 
    , bill_to_customer_key 
  from dim_customer__cast_type
)
, dim_customer__null as (
  select 
    customer_key
    , customer_name
    , is_statement_sent
    , is_on_credit_hold
    , credit_limit
    , standard_discount_percentage
    , payment_days
    , account_opened_date
    , customer_category_key
    , coalesce(buying_group_key, 0) as buying_group_key
    , delivery_method_key
    , delivery_city_key
    , postal_city_key
    , primary_contact_person_key
    , coalesce(alternate_contact_person_key, 0) as alternate_contact_person_key 
    , bill_to_customer_key 
  from dim_customer_convert_boolean
)

select
     customer.customer_key
    , customer.customer_name
    , customer.is_statement_sent
    , customer.is_on_credit_hold
    , customer.credit_limit
    , customer.standard_discount_percentage
    , customer.payment_days
    , customer.account_opened_date
    , customer.customer_category_key
    , customer_category.customer_category_name
    , coalesce(customer.buying_group_key,-1) as buying_group_key
    , buying_group.buying_group_name
    , customer.delivery_method_key
    , delivery_method.delivery_method_name
    , customer.delivery_city_key
    , delivery_city.city_name as delivery_city_name
    , delivery_city.state_province_name as delivery_state_province_name
    , customer.postal_city_key
    , postal_city.city_name as postal_city_name 
    , postal_city.state_province_name as postal_state_province_name
    , customer.primary_contact_person_key
    , primary_contact_person.full_name as primary_contact_person_full_name
    , customer.alternate_contact_person_key 
    , alternate_contact_person.full_name as alternate_contact_person_full_name
    , customer.bill_to_customer_key 
    , bill_to_customer.customer_name as bill_to_customer_name 
from dim_customer__null as customer 
left join {{ref("stg_dim_customer_category")}} as customer_category
  on customer.customer_category_key = customer_category.customer_category_key
left join {{ref("stg_dim_buying_group")}} as buying_group
  on customer.buying_group_key = buying_group.buying_group_key
left join {{ref("stg_dim_delivery_methods")}} as delivery_method
  on customer.delivery_method_key = delivery_method.delivery_method_key
left join {{ref("stg_dim_cities")}} as delivery_city 
  on customer.delivery_city_key = delivery_city.city_key
left join {{ref("stg_dim_cities")}} as postal_city 
  on customer.delivery_city_key = postal_city.city_key
left join {{ref("dim_person")}} as primary_contact_person 
 on customer.primary_contact_person_key = primary_contact_person.person_key
left join {{ref("dim_person")}} as alternate_contact_person 
  on customer.alternate_contact_person_key = alternate_contact_person.person_key
left join dim_customer__null as bill_to_customer 
  on customer.bill_to_customer_key = bill_to_customer.customer_key


