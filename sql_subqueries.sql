#How many copies of the film Hunchback Impossible exist in the inventory system?
#List all films whose length is longer than the average of all the films.
#Use subqueries to display all actors who appear in the film Alone Trip.
#Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.
#Get name and email from customers from Canada using subqueries. Do the same with joins. Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, that will help you get the relevant information.
#Which are films starred by the most prolific actor? Most prolific actor is defined as txhe actor that has acted in the most number of films. First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.
#Films rented by most profitable customer. You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments
#Get the client_id and the total_amount_spent of those clients who spent more than the average of the total_amount spent by each client.

use sakila;

select film_inventory.title as f_title, count(*) as f_copies from (select f.film_id, f.title, i.inventory_id from film f
join inventory i on f.film_id = i.film_id) as film_inventory
where film_inventory.title = 'HUNCHBACK IMPOSSIBLE';
#Answer: 6 copies.

select * from film where length > (select avg(length) from film);

select * from actor;
select actor_id, first_name 
from film_actor fa join actor a using (actor_id) where film_id = (select film_id from film where title = 'Alone Trip');
#5 actors

select title from film_category fc 
join film f using(film_id) where category_id = (select category_id from category where name = 'Family');

select first_name, last_name, email from customer where address_id in (select address_id from address where city_id in (select city_id from city where country_id in
(select country_id from country where country = 'Canada')));

select first_name, last_name, email from customer cust
join address a using(address_id) join city ci using(city_id) join country co using(country_id) where country = 'Canada';

select * from actor;
select actor_id, count(actor_id) as appearences from film_actor group by actor_id order by  appearences desc limit 1;
select * from actor where actor_id = (select actor_id from film_actor
 group by actor_id order by count(actor_id) desc limit 1);
 select title from film_actor fa join film f using(film_id) 
 where actor_id = (select actor_id from film_actor 
 group by actor_id order by count(actor_id) desc limit 1);
 
 select customer_id from payment group by customer_id order by sum(amount) desc limit 1;
 
 select customer_id from payment group by customer_id order by sum(amount) desc limit 1;
 select * from payment;
 select inventory_id from rental where customer_id = (select customer_id from payment group by customer_id order by sum(amount) desc limit 1);
select title from inventory i join film using(film_id) where inventory_id in (select inventory_id from rental where customer_id = (select customer_id from payment
group by customer_id order by sum(amount) desc limit 1));

select * from customer;
select * from payment;
select customer_id, sum(amount) as total from payment group by customer_id;
select avg(summed) from (select sum(amount) as summed from payment group by customer_id) result1;



