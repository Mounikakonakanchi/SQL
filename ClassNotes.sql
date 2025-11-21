DROP DATABASE IF EXISTS sakila;
CREATE DATABASE sakila;
USE sakila;

USE sakila;
SHOW TABLES;
------------------------------------------------------
-- Nov 7
-- select 
-- Extracts data from a Database
select * from customer;

select title , count(rental_rate) as rate from  film
group by title;

select count(*) from film;

select count(distinct first_name) from actor;

select distinct(first_name) from actor;

select * from film
where film_id is not null;

-- count and ditinct count
-- Count returns the number of rows 
-- Distinct count returns distinct number of rows

select count(*) from actor;

select count(distinct title) from film;

select distinct(title) from film;

-- limit
-- returns only n number of values

select first_name from actor
limit 5;

select release_year from film
where release_year <='2026'
limit 3;

-- where
-- used to filter records based on a condition
select * from film
where rental_rate >=3;

select film_id , rating from film
where rating = 'G';

-- filtering / Order by
-- used to sort the result in aither asce or desc
select rental_rate from film
order by rental_rate;

select title, film_id from film
where film_id is not null
order by film_id asc;

-- AND OR
-- And is used to filter records based on more than one condition
-- OR is used to filter records based on more than one condition
select * from film
where rental_rate >= 4 and rating = 'G'
order by film_id desc;

select * from payment
where staff_id = 1 or amount >= 2
order by payment_id;

-- Not
-- is a logical operator used to reverse a condition.
select * from payment
where not amount >=2
order by payment_id;

select * from payment
where not payment_id in (2, 3, 5)
order by payment_id;

-- Like
-- The like operator is used in where for a specified pattern
select * from actor
where first_name like 'a%';

select * from actor
where last_name like 'a%n' ;

-- Null
-- used to check null values in the data
select * from actor
where first_name is not null;

select * from payment
where payment_date is null;

-- Between
-- used to filter data bewteen two dates
select * from payment
where payment_date between '2005-05-25' and '2005-06-10';


-- Group by and Having
-- group by is used to group rows with same values 
select count(*) as total from film
group by rental_rate
having count(*) > 20;


-- Nov 12
-- strings

-- left pads the string with another string
select title , lpad(title , 20 ,'*') as padded
from film;

-- right  pads the string with another string
select title , rpad(title , 20 ,'*') as padded
from film;

-- susbtring is a part of a string within the given length
select title , substring(title , 5,9 ) as short_title
from film;

-- concat is used to combine two strings using + , * ...
select first_name , last_name, concat(first_name ,'*', last_name) as c_name
from actor;

-- reverse is used to reverse the characters in the string
select first_name , reverse(first_name) as reverese_name
from actor;

-- length is used to caluclate the length of characters
select first_name , length(first_name) as_lengthof_title
 from actor;

-- A function in SQL that extracts a part of a string starting from a given position and for a given length.
select email , substring(email , locate('@' , email)+1)as located_email
from staff;

-- It splits the string using '@' and returns the part after the @.
select substring_index(email , '@' ,  +1)as located_email
from staff;

-- Converts the characters to upper case
select first_name , upper(first_name) as reverese_name
from actor;

-- Converts the characters to lower case
select first_name ,lower(first_name) as reverese_name
from actor;

-- LEFT is a string  that returns a specified number of characters from the left of a string.
select first_name , left(first_name , 5) as left_name
from actor;

-- Right is a string  that returns a specified number of characters from the Right of a string.
select first_name , right(first_name, 5) as right_name
from actor;

-- CASE is a conditional expression that allows to apply IF-ELSE logic inside a query.
select rental_rate ,
case when rental_rate >= 4 then 'high'
     when rental_rate <=3 then 'low'
     else 'other'
     end as 't.rating'
from film;

-- Replace is a function used to replace one character with other
select first_name , replace(first_name ,'A' , 'Z' ) R_NMAE
FROM actor;

-- Regexp allows  to search for text using patterns, not just exact matches.
select first_name from actor
where first_name REGEXP'[aeiouAEIOU]{2}';

-- CAST is a function used to convert one data type into another data type.
select first_name , cast(first_name as decimal) as c_name
from actor;

-- Generates a random number between 0 & 1
SELECT title FROM film
ORDER BY RAND()
LIMIT 5;

-- rounds a number up to the nearest integer like smallest integere
SELECT title, rental_rate, ceiling(rental_rate) AS rounded_length
FROM film;

-- rounds a number up to the specified number of decimal places
SELECT title, rental_rate, round(rental_rate) AS rounded_length
FROM film;

-- Removes unwanted spaces either leading or trailing
select email , trim(' ' from email) as trimmed_mail from staff;

-- Repeat is a function used to repeat the charcters with the given integer
select email ,repeat(email,2) as trimmed_mail from staff;

-- Returns the numeric ASCII value of the first character of a string.
select first_name ,ascii(first_name) from actor;
---------------------------------------
-- Nov 14
-- subqueries
-- Query inside a query(Nested)

-- It returns the lastest date
select max(payment_date) from  payment;

-- it returns all the payment dates from yesterday
select customer_id , payment_date , amount from payment
where payment_date >= now() - interval 1 day;


select customer_id , payment_date , amount from payment
where payment_date >= (
select max(payment_date)  - interval 10 day from  payment
);

-- It returns the current date And time
select now() - interval 1 day as yesterday;

select concat('today is :', curdate()) as message;
select concat('today is :', now()) as message;

-- Curdate() is used to get current date
select curdate() , now() , current_time();

select first_name , last_name from customer
where address_id in ( select address_id from customer 
where address_id = 5);

--- subquery in select
select first_name , last_name , actor_id,
( select count(*) from film_actor
WHERE film_actor.actor_id = actor.actor_id )as film_count
from actor;

--- derived tables
select a.actor_id , a.first_name , a.last_name , fa.film_count
from actor a join(
select actor_id , count(film_id) as film_count  from film_actor
group by actor_id , last_update
having count(film_id) >10
) fa on a.actor_id = fa.actor_id;

select * from (
select last_name ,
case 
  when left(last_name , 1) between 'A' AND 'M' then 'group a- m'
  when left(last_name , 1) between 'N' and  'z' then 'group n- z'
  else 'other'
  end as grouped_list
  from customer ) as grouped_customers
 where grouped_list = 'group a- m' ;
 
 -- select in where
 select customer_id , amount from payment
 where amount > (select avg(amount) from payment);
  
  select first_name ,
  (select address_id from address where district = 'california'  limit 1) as cali_address
  from customer;
  
select title , 
(select count(*) from film_actor fa 
where fa.film_id = f.film_id) as actor_count
from film f;

-- corelated Subquerey
-- The inner and outer qurey related to each other , and uses one column from either queries
select payment_id , customer_id , amount , payment_date from payment p
where amount>( select avg(amount) from payment p1
where p.customer_id = p1.customer_id);

-- Non Corelated subquerey
-- Independent of the outer query and runs once and returns a value or set of values.
SELECT first_name
FROM customer
WHERE store_id = (SELECT MIN(store_id) FROM store);

-- Advantages of Subqueries
-- Can break complex queries into smaller, readable parts.
-- Avoids using multiple separate queries in your application.
-- Can be used where JOINs might be diificult.
-- Flexible: Can return a single value, a list, or a table.

-- Disadvantages of Subqueries
-- Performance issues for correlated subqueries, which run for each outer row.
-- Sometimes JOINs are faster for large datasets.
-- Can become hard to read if nested deeply.
-- Some databases limit subquery capabilities in certain clauses.
---------------------------------------------
-- Nov 17
-- Joins , Relation ships

-- 1-1
-- 1 row in a table maps one row in other table
-- Get the manager of each store
-- Each store has one manager
SELECT s.store_id, s.manager_staff_id, st.first_name, st.last_name
FROM store s
JOIN staff st ON s.manager_staff_id = st.staff_id;

-- 1 - Many
-- 1 row in a table maps multiple rows in other table
-- One customer can have many payments.
SELECT c.customer_id, c.first_name, c.last_name, p.payment_id, p.amount
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id;

-- Many - 1
-- Many rows in a table maps one row in other table
-- Many films belong to one category.
SELECT f.film_id, f.title, c.category_id, c.name AS category_name
FROM film f
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id;

-- Many - Many
--  Many rows in a table maps many rows in other table
SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
JOIN actor a ON fa.actor_id = a.actor_id;

-- Left join
-- Returns all rows from the left table and matching rows from the right table
-- Get all customers and their payments
SELECT c.customer_id, c.first_name, c.last_name, p.payment_id, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id;

-- Right join
-- Returns all rows from the right table and matching rows from the left table
-- Get all payments and customer info if available
SELECT c.customer_id, c.first_name, c.last_name, p.payment_id, p.amount
FROM customer c
RIGHT JOIN payment p ON c.customer_id = p.customer_id;


-- Inner join
-- Returns only rows that have matching values in both tables
-- Get payments and customer info for matching records
SELECT p.payment_id, p.amount, p.payment_date, c.first_name, c.last_name
FROM payment p
INNER JOIN customer c ON p.customer_id = c.customer_id;

-- Full Outer Join
-- Returns all rows from both tables, with NULL where there’s no match.
-- Sql dosen't support full outer so we use Union
SELECT c.customer_id, c.first_name, p.payment_id, p.amount
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
UNION
SELECT c.customer_id, c.first_name, p.payment_id, p.amount
FROM customer c
RIGHT JOIN payment p ON c.customer_id = p.customer_id;


-- cross join
-- Returns all possible combinations of rows from both tables
-- Combine all stores with all staff
SELECT s.store_id, t.staff_id, t.first_name, t.last_name
FROM store s
CROSS JOIN staff t;

-- self join
-- A table is joined to itself
-- Find payments by customers who share the same last name
SELECT c1.customer_id AS customer1, c2.customer_id AS customer2, c1.last_name
FROM customer c1
JOIN customer c2 ON c1.last_name = c2.last_name AND c1.customer_id <> c2.customer_id;

-----------------------------------
-- assignemnt 1
/*Get all customers whose first name starts with 'J' and who are active */
select * from actor
where first_name like 'j%'  and active =1;

/*Find all films where the title contains the word 'ACTION' or the description contains 'WAR'*/
select * from film #2
where title LIKE '%ACTION%' or description LIKE '%War%';

/*List all customers whose last name is not 'SMITH' and whose first name ends with 'a'*/
select * from customer  #3
where last_name not like '%smith%' and first_name like 'a%';

/*Get all films where the rental rate is greater than 3.0 and the replacement cost is not null*/
select film_id , rental_rate , replacement_cost from film #4
where rental_rate > 3.0 and replacement_cost is not null;

/*Count how many customers exist in each store who have active status = 1*/
SELECT store_id, COUNT(*) AS active_customers #5
FROM customer
WHERE active = 1
group by store_id;

/*Show distinct film ratings available in the film table*/
select count(rating) from film; #6
select count(distinct rating) from film;

/*Find the number of films for each rental duration where the average length is more than 100 minutes*/
select rental_duration , count(*) as no_films from film #7
group by rental_duration 
having avg(length) > 100; 

/*List payment dates and total amount paid per date, but only include days where more than 100 payments were made*/
SELECT payment_date, SUM(amount) AS total_amount, COUNT(*) AS payment_count  #8
FROM payment
GROUP BY payment_date
HAVING COUNT(*) > 100
ORDER BY payment_date;

/*Find customers whose email address is null or ends with '.org'*/
select customer_id ,email from customer  #9
where email is null or email like '%org';

/*List all films with rating 'PG' or 'G', and order them by rental rate in descending order*/
select film_id , rating, rental_rate from film #10
where rating = 'PG' OR rating = 'G'
order by rental_rate desc;

/*Count how many films exist for each length where the film title starts with 'T' and the count is more than 5*/
SELECT length, title ,COUNT(*) AS film_count #11
FROM film
WHERE title LIKE 'T%'
GROUP BY length
Having film_count > 5 ;

show tables;

/*List all actors who have appeared in more than 10 films*/
SELECT a.actor_id, a.first_name, a.last_name, COUNT(fa.film_id) AS film_count   #12
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
GROUP BY a.actor_id, a.first_name, a.last_name
HAVING COUNT(fa.film_id) > 10
ORDER BY film_count DESC;
 
/*Find the top 5 films with the highest rental rates and longest lengths combined, ordering by rental rate first and length second*/
select rental_rate , title, length from film   #13
order by rental_rate desc , length desc
limit 5;

/*Show all customers along with the total number of rentals they have made, ordered from most to least rentals*/
SELECT c.customer_id, c.first_name, c.last_name, #14
       COUNT(r.rental_id) AS total_rentals
FROM customer c
LEFT JOIN rental r
       ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_rentals DESC;

/*List the film titles that have never been rented*/
SELECT f.title FROM film f         #15
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IS NULL;

/*Find all staff members along with the total payments they have processed, ordered by total payment amount in descending order*/
SELECT s.staff_id, s.first_name, s.last_name,  #16
       SUM(p.amount) AS total_payment FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
GROUP BY s.staff_id
ORDER BY total_payment DESC;

/*Show the category name along with the total number of films in each category*/
select c.category_id , c.name , count(f.film_id) as total_films from category c #17
left join film_category f on c.category_id = f.category_id
group by c.name;


/*List the top 3 customers who have spent the most money in total*/
SELECT c.customer_id, c.first_name, c.last_name , sum(m.amount)as most_spent from customer c #18
left join payment m on c.customer_id = m.customer_id
group by c.first_name
order by most_spent desc
limit 3;


select rental_duration , title from film #7
group by rental_duration 
having avg(length) = 112.9113; 




SELECT title, length, rental_duration,
    (SELECT AVG(length) 
     FROM film 
     WHERE rental_duration = 3) AS avg_length
FROM film
WHERE rental_duration = 3;


SELECT 
    title,
    release_year,
    CAST(release_year AS CHAR) AS release_year_text
FROM film
LIMIT 5;

 -----------------------------------
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
    LENGTH(description) - LENGTH(REPLACE(description, 'aeiou', '')) AS a_count
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

---------------------------------------------------------
--  assignment 3 (subquery):

-- display all customer details who have made more than 5 payments.
SELECT * FROM customer
WHERE customer_id IN (
    SELECT customer_id  FROM payment
    GROUP BY customer_id
    HAVING COUNT(payment_id) > 5);

 -- Find the names of actors who have acted in more than 10 films.
 SELECT first_name, last_name FROM actor
WHERE actor_id IN (
    SELECT actor_id FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(film_id) > 10 );
    
-- Find the names of customers who never made a payment.
SELECT first_name, last_name FROM customer
WHERE customer_id NOT IN (
    SELECT customer_id FROM payment);

-- List all films whose rental rate is higher than the average rental rate of all films.
select title , rental_rate from film
where rental_rate>(select avg(rental_rate )from film);

-- List the titles of films that were never rented.
SELECT title FROM film
WHERE film_id NOT IN (
    SELECT inventory.film_id FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id);


 -- Display the customers who rented films in the same month as customer with ID 5.
SELECT DISTINCT customer_id  FROM rental
WHERE MONTH(rental_date) = (
    SELECT MONTH(rental_date) FROM rental
    WHERE customer_id = 5
    LIMIT 1);
    
    
-- Find all staff members who handled a payment greater than the average payment amount
select distinct staff_id , amount from payment
where amount>(select avg(amount) from payment);


-- show the title and rental duration of films whose rental duration is greater than the average.
select title , rental_duration from film
where rental_duration>(select avg(rental_duration) from film);


-- Find all customers who have the same address as customer with ID 1.
select * from customer;
SELECT customer_id, first_name, last_name, address_id FROM customer
WHERE address_id = (
    SELECT address_id FROM customer
    WHERE customer_id = 1);
    
-- List all payments that are greater than the average of all payments.
select * from payment
where amount>(select avg(amount) from payment)
order by amount;


