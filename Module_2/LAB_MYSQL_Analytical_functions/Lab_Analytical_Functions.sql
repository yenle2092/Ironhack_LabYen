use sakila;

-- 1. Find the running total of rental payments for each customer in the payment table, ordered by payment date

SELECT 
		customer_id, 
        payment_date, 
        amount,
        SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total
FROM payment;

-- 2. Find the rank and dense rank of each payment amount within each payment date

SELECT 
		DATE(payment_date),
        amount,
        RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS rnk,
		DENSE_RANK() OVER (PARTITION BY DATE(payment_date) ORDER BY amount DESC) AS dense_rnk
FROM payment;

SELECT payment_id, amount, date_format(payment.payment_date, '%Y-%m-%d') as Date,
RANK() OVER (PARTITION BY "Date" ORDER BY amount DESC) AS transaction_rank,
dense_rank() OVER (PARTITION BY "Date" ORDER BY amount DESC) AS transaction_DENSErank
FROM payment;

-- 3. Find the ranking of each film based on its rental rate, within its respective category

SELECT 
		name as "Category",
        f.title as film_title,
        f.rental_rate,
        RANK() OVER (PARTITION BY "Category" ORDER BY f.rental_rate DESC ) AS rnk,
		DENSE_RANK() OVER (PARTITION BY "Category" ORDER BY f.rental_rate DESC ) AS dense_rnk
FROM film f
LEFT JOIN film_category fc
ON f.film_id=fc.film_id
LEFT JOIN category c
ON fc.category_id=c.category_id
order by rental_rate DESC, name,film_title;

-- 4.(OPTIONAL) update the previous query from above to retrieve only the top 5 films within each category
SELECT * FROM
(SELECT 
		Category, 
        film_title, 
        rental_rate,
        rnk,
        dense_rnk,
		ROW_NUMBER() OVER (PARTITION BY Category ORDER BY  rental_rate DESC) AS row_num
FROM 
(
  SELECT 
		name as "Category",
        f.title as film_title,
        f.rental_rate,
        RANK() OVER (PARTITION BY "Category" ORDER BY f.rental_rate DESC ) AS rnk,
		DENSE_RANK() OVER (PARTITION BY "Category" ORDER BY f.rental_rate DESC ) AS dense_rnk
FROM film f
LEFT JOIN film_category fc
ON f.film_id=fc.film_id
LEFT JOIN category c
ON fc.category_id=c.category_id
order by rental_rate DESC, name,film_title
) as sub
) as subq
WHERE row_num  <=5;



-- 5. find the difference between the current and previous payment amount and the difference between the current and next payment amount, for each customer in the payment table

SELECT 
		payment_id, 
        customer_id, 
        amount, 
        payment_date,
        (amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date)) AS diff_from_prev,
        (LEAD(amount)  OVER (PARTITION BY customer_id ORDER BY payment_date) - amount) AS diff_from_next
FROM payment;