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