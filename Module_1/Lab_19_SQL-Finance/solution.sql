-- 1. From the order_items table, find the price of the highest priced order and lowest price order.
-- the highlest price: 6735
-- the lowest price: 0,85
use olist;
use order_items;
select price from order_items
group by price
order by price DESC
limit 1;

select price from order_items
group by price
order by price ASC
limit 1;

-- 2. From the order_items table, what is range of the shipping_limit_date of the orders?
-- the range of the shipping_limit_date of the orders is: 2016-09-19 02:15:34 - 2020-04-10 00:35:08
select shipping_limit_date from order_items
group by shipping_limit_date
order by shipping_limit_date ASC
limit 1;

select shipping_limit_date from order_items
group by shipping_limit_date
order by shipping_limit_date DESC
limit 1;

-- 3. From the customers table, find the states with the greatest number of customers.
-- SP	41746

select distinct customer_state, count(customer_state) from customers
group by customer_state
order by count(customer_state) DESC
limit 1;

-- 4. From the customers table, within the state with the greatest number of customers, find the cities with the greatest number of customers.
-- vargem grande

select customer_city from customers
Where customer_state <> "SP"
group by customer_city
order by count(customer_id)
limit 1;

-- 5. From the closed_deals table, how many distinct business segments are there (not including null)?
-- 841

select distinct count(business_segment) from closed_deals
where business_segment is not null;

-- 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
/*
50695006	construction_tools_house_garden
8000000	phone_mobile
710000	home_decor
*/

select sum(declared_monthly_revenue), business_segment from closed_deals
group by business_segment
order by sum(declared_monthly_revenue) DESC
limit 3;

-- 7. From the order_reviews table, find the total number of distinct review score values.
-- 5

select count(distinct review_score) from order_reviews;

-- 8. In the order_reviews table, create a new column with a description that corresponds to each number category for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.
/*
5	57420
4	19200
1	11858
3	8287
2	3235

-- the review score and category occurring most frequently in the table is 5
*/

select review_score, count(review_score) from order_reviews
group by review_score
order by count(review_score) DESC;

-- 9. From the order_reviews table, find the review value occurring most frequently and how many times it occurs.
-- the review value occurring most frequently: 5 with 57420 times

select review_score, count(review_score) from order_reviews
group by review_score
order by count(review_score) DESC
limit 1;