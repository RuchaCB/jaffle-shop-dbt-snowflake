{{

    config(mialized='table')
}}

with customers as (
    select 
        id as customer_id,
        first_name,
        last_name
    from jaffle_shop.raw.customers
),

orders as (
    select 
        id as order_id,
        user_id as customer_id,
        order_date,
        status
    from jaffle_shop.raw.orders
),

customer_orders as (
    select 
        customer_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(*) as number_of_orders
    from orders
    group by customer_id
),

final as (
    select 
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order,
        customer_orders.most_recent_order,
        customer_orders.number_of_orders
    from customers
    left join customer_orders
    on customers.customer_id = customer_orders.customer_id
)

select * from final
