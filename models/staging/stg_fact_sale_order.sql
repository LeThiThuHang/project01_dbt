with fact_sale_order__source as (
    select
        order_id
        , customer_id
        , salesperson_person_id
        , picked_by_person_id
        , contact_person_id
        , backorder_order_id
        , order_date
        , expected_delivery_date
    from `vit-lam-data.wide_world_importers.sales__orders`
)
, fact_sale_order__rename_column as (
    select
        order_id as order_key
        , customer_id as customer_key
        , salesperson_person_id as salesperson_person_key
        , picked_by_person_id as picked_by_person_key
        , contact_person_id as contact_person_key
        , backorder_order_id as backorder_order_key
        , order_date as order_date
        , expected_delivery_date as expected_delivery_date
    from fact_sale_order__source
)
, fact_sale_order__cast_type as (
    select 
        cast(order_key as integer) as order_key
        , cast(customer_key as integer) as customer_key
        , cast(salesperson_person_key as integer) as salesperson_person_key
        , cast(picked_by_person_key as integer) as picked_by_person_key
        , cast(contact_person_key as integer) as contact_person_key
        , cast(backorder_order_key as integer) as backorder_order_key
        , cast(order_date as date) as order_date
        , cast(expected_delivery_date as date) as expected_delivery_date
    from fact_sale_order__rename_column
)

select 
    order_key
    , customer_key
    , salesperson_person_key
    , picked_by_person_key
    , contact_person_key
    , backorder_order_key
    , order_date
    , expected_delivery_date
from fact_sale_order__cast_type