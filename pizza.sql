SELECT * FROM Pizza_Master.pizza_sales;

-- total revenue 
 select sum(total_price) as total_revenue from Pizza_Master.pizza_sales;

-- average order values
 select sum(total_price)/count(distinct order_id) as average_order_values from Pizza_Master.pizza_sales;

-- total pizza sold
 select sum(quantity) as total_pizza_sold from Pizza_Master.pizza_sales;
 
 -- total orders placed 
 select count(distinct order_id) as tital_orders_placed from Pizza_Master.pizza_sales;

-- average pizza per order
select cast(sum(quantity)/count(distinct order_id)as decimal(10,2)) as average_pizza_per_order from Pizza_Master.pizza_sales;

-- charts for sql
-- daily trends for total orders
select dayname(STR_TO_DATE(order_date, '%d-%m-%Y')) as order_day, count(distinct order_id) as total_orders
from Pizza_Master.pizza_sales
group by dayname(STR_TO_DATE(order_date, '%d-%m-%Y'));

-- hourly trend
select HOUR(order_time) as order_hour, count(distinct order_id)
from Pizza_Master.pizza_sales
group by HOUR(order_time)
order by count(distinct order_id);

-- % of sales
select  pizza_category, cast(sum(total_price) * 100/ (select sum(total_price) from Pizza_Master.pizza_sales) as decimal(10,0)) as percentage
from Pizza_Master.pizza_sales
group by  pizza_category;

-- % of sales by month (jan)
select  pizza_category, cast(sum(total_price) * 100/ (select sum(total_price) from Pizza_Master.pizza_sales where month(str_to_date(order_date,'%d-%m-%Y' )) = 1 ) as decimal(10,0)) as percentage
from Pizza_Master.pizza_sales
where month(str_to_date(order_date,'%d-%m-%Y' )) = 1 
group by  pizza_category;

-- % of pizza size orders
select  pizza_size, cast(sum(total_price) * 100/ (select sum(total_price) from Pizza_Master.pizza_sales where month(str_to_date(order_date,'%d-%m-%Y' )) = 1 ) as decimal(10,0)) as percentage
from Pizza_Master.pizza_sales
where month(str_to_date(order_date,'%d-%m-%Y' )) = 1 
group by  pizza_size;

-- total pizza sold categorized by pizza
select pizza_category, sum(quantity) as total_sold
from Pizza_Master.pizza_sales
group by pizza_category;

-- top 5 best pizza by demand
select pizza_name, sum(quantity) as total_sold
from Pizza_Master.pizza_sales
group by pizza_name
order by sum(quantity) desc
limit 5;



