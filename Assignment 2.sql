-- assignment 2
 
 -- Identify if there are duplicates in Customer table. Don't use customer id to check the duplicates
 select first_name , last_name ,email, count(*) as dup_count from customer
 group by first_name, last_name , email
 having count(*) >1 ;
 
 -- Number of times letter 'a' is repeated in film descriptions
 SELECT film_id ,title,description,
    LENGTH(description) - LENGTH(REPLACE(description, 'a', '')) AS a_count
FROM film; 

-- Number of times each vowel is repeated in film descriptions 
SELECT film_id ,title,description,
    LENGTH(description) - LENGTH(REPLACE(description, 'a', '')) AS a_count,
    LENGTH(description) - LENGTH(REPLACE(description, 'e', '')) AS e_count,
    LENGTH(description) - LENGTH(REPLACE(description, 'i', '')) AS i_count,
    LENGTH(description) - LENGTH(REPLACE(description, 'o', '')) AS o_count,
    LENGTH(description) - LENGTH(REPLACE(description, 'u', '')) AS u_count
FROM film;

-- Display the payments made by each customer
--         1. Month wise
SELECT customer_id,
    DATE_FORMAT(payment_date, '%Y-%m') AS payment_month,
    SUM(amount) AS total_payment FROM payment
GROUP BY customer_id, payment_month
ORDER BY customer_id, payment_month;

-- 2.year wise
 SELECT customer_id,
    Year(payment_date) AS payment_year,
    SUM(amount) AS total_payment FROM payment
GROUP BY customer_id, payment_year
ORDER BY customer_id, payment_year;
 
--  3.week wise

 SELECT customer_id,
    week(payment_date, 1) AS payment_week,
    SUM(amount) AS total_payment FROM payment
GROUP BY customer_id, payment_week
ORDER BY customer_id, payment_week;
 
 
-- Check if any given year is a leap year or not. You need not consider any table from sakila database. Write within the select query with hardcoded date
 SELECT YEAR('2025-11-19') AS year,
    CASE 
        WHEN (YEAR('2025-11-19') % 4 = 0 
        AND (YEAR('2025-11-19') % 100 != 0 OR YEAR('2025-11-19') % 400 = 0))
        THEN 'Leap Year'
        ELSE 'Not a Leap Year'
    END AS leap_year_status;

SELECT 
    IF(2024 % 4 = 0 AND 2024 % 100 != 0 OR 2024 % 400 = 0,
       'Leap Year', 'Not a Leap Year') AS result;

SELECT 
    IF(DAY(LAST_DAY('2024-02-01')) = 29, 'Leap Year', 'Not a Leap Year') AS result;

 
 -- Display number of days remaining in the current year from today.
 
SELECT DATEDIFF(LAST_DAY(CONCAT(YEAR(CURDATE()), '-12-01')), CURDATE()) AS days_remaining;


-- display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
SELECT payment_id, payment_date,
    CONCAT('Q', QUARTER(payment_date)) AS payment_quarter
FROM payment
ORDER BY payment_date;