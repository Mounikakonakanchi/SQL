-- assignment 3 (subquery):

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