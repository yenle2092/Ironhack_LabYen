USE sakila;

## 1. In the table actor, what last names are not repeated? 66 names

SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) = 1
ORDER BY last_name;

## 2. Which last names appear more than once? 55 names

SELECT last_name FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1
ORDER BY last_name;

## 3. Using the rental table, find out how many rentals were processed by each employee.
SELECT staff_id,
	   count(rental_id) 
FROM rental
GROUP BY staff_id;


## 4. Using the film table, find out how many films there are of each rating

SELECT rating,
	   count(film_id)
FROM film
GROUP BY rating;

## 5. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
SELECT rating,
	   ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating;

## 6. Which kind of movies (rating) have a mean duration of more than two hours?

SELECT rating,
	   ROUND(AVG(length), 2) AS avg_length
FROM film
GROUP BY rating
ORDER BY ROUND(AVG(length), 2) DESC
LIMIT 1;






