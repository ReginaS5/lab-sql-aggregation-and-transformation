USE sakila;

-- 1.1 Determine the shortest and longest movie durations 
-- and name the values as max_duration and min_duration.
SELECT MIN(length) AS min_duration
FROM film;
SELECT MAX(length) AS max_duration
FROM film;

-- 1.2. Express the average movie duration in hours and minutes.
-- Don't use decimals.
-- Hint: Look for floor and round functions.
SELECT AVG(length)
FROM film; 
SELECT ROUND(115.2720) AS RoundValue
FROM film;

-- 2 You need to gain insights related to rental dates:
SELECT *
FROM rental;
-- 2.1.Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to
-- film_text-- subtract the earliest date in the rental_date column from the 
-- latest date.
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS operating_days
FROM rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental.
-- Return 20 rows of results.
SELECT*, MONTH(rental_date) AS rental_month,
DAYNAME(rental_date) AS rental_weekday
FROM rental
LIMIT 20;

-- 2.3 Bonus: Retrieve rental information and add an additional column called DAY_TYPE with values
--  'weekend' or 'workday', depending on the day of the week.
-- Hint: use a conditional expression.
SELECT *,
    CASE 
        WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
        ELSE 'workday'
    END AS DAY_TYPE
FROM rental;

-- 3 You need to ensure that customers can easily access information about the movie collection.
-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, 
-- replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
SELECT title,
IFNULL(rental_duration, 'NA') AS rental_duration
FROM sakila.film
ORDER BY title ASC;

-- CHALLENGE 2
-- Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
-- 1.1. The total number of films that have been released.
SELECT COUNT(*) AS total_released FROM film;

-- 1.2. The number of films for each rating
-- 1.3.The number of films for each rating, sorting the results in descending order of the number of films.
 -- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions
 -- accordingly.
SELECT rating, COUNT(*) AS number_of_films_for_each_rating
	FROM film
	GROUP BY rating;
    
    -- 2.1. Identify popular movie lengths for each category
    SELECT rating, ROUND(AVG(length),2) AS 'film duration'
    FROM film GROUP BY rating
    ORDER BY rating ASC;
    
    -- 2.2. Customers who prefer longer movies
    SELECT rating, AVG(length) AS average_duration
FROM film
GROUP BY rating
HAVING AVG(length) > 120;
