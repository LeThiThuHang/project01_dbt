with fact_sale_order_line__source as (
    select
        order_line_id
        , order_id
        , stock_item_id
        , package_type_id
        , quantity
        , unit_price
        , tax_rate
        , picked_quantity
    from `vit-lam-data.wide_world_importers.sales__order_lines`
)
, fact_sale_order__rename_column as (
    select
        order_line_id as sale_order_line_key
        , order_id as sale_order_key
        , stock_item_id as stock_item_key
        , package_type_id as package_type_key
        , quantity as quantity
        , unit_price as unit_price
        , tax_rate as tax_rate
        , picked_quantity as picked_quantity
    from fact_sale_order_line__source
)
, fact_sale_order__cast_type as (
    select
        cast(sale_order_line_key as integer) as sale_order_line_key
        , cast(sale_order_key as integer) as sale_order_key
        , cast(stock_item_key as integer) as stock_item_key
        , cast(package_type_key as integer) as package_type_key
        , cast(quantity as integer) as quantity
        , cast(unit_price as integer) as unit_price
        , cast(tax_rate as integer) as tax_rate
        , cast(picked_quantity as integer) as picked_quantity
    from `fact_sale_order__rename_column`
)
, fact_sale_order__calculate_measure as (
    select 
        *
        , quantity * unit_price as gross_amount
    from fact_sale_order__cast_type as fact_sale_order
)

select
    fact_line.sale_order_line_key
    , fact_line.sale_order_key
    , fact_line.stock_item_key
    , fact_line.package_type_key
    , fact_line.quantity
    , fact_line.unit_price
    , fact_line.tax_rate
    , fact_line.picked_quantity

    , fact_order.customer_key
    , fact_order.salesperson_person_key
    , fact_order.picked_by_person_key
    , fact_order.contact_person_key
    , fact_order.backorder_order_key
    , fact_order.order_date
    , fact_order.expected_delivery_date
from fact_sale_order__calculate_measure as fact_line 
left join {{ref("stg_fact_sale_order")}} as fact_order 
    on fact_line.sale_order_key = fact_order.order_key