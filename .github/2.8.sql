USE sakila;

#1 Write a query to display for each store its store ID, city, and country.

select store_id, city, country
from store s
join address a
using(address_id)
join city ci
using(city_id)
join country co
using(country_id);

#2 Write a query to display how much business, in dollars, each store brought in.

select store_id, sum(amount) as revenue
from payment
left join staff
using(staff_id)
group by store_id;

#3 Which film categories are longest?

select name as category, avg(length) as movie_duration
from film
join film_category
using(film_id)
join category
using(category_id)
group by category
order by avg(length) desc
limit 1;

#4 Display the most frequently rented movies in descending order.

select i.film_id, f.title, count(rental_id) as rentals
from rental r
left join inventory i
using(inventory_id)
join film f
using(film_id)
group by i.film_id, f.title
order by 3 desc;

#5 List the top five genres in gross revenue in descending order.

select name as category, sum(amount) as revenue
from payment
join rental
using(rental_id)
join inventory
using(inventory_id)
join film_category
using(film_id)
join category
using(category_id)
group by name
order by 2 desc
limit 5;

#6 is Academy Dinausaur available for rent from store 1

SELECT rental_date 
FROM rental 
JOIN inventory
USING (inventory_id)
JOIN store
USING (store_id)
JOIN film
USING (film_id)
WHERE rental_date is NULL AND store_id = '1' and title = 'Academy Dinausaur'
GROUP BY rental_date;
  -- I don't know if this one is right. It works but i am not sure. Please let me know if i missed something here.

  -- 7- Get all pairs of actors that worked together
  
SELECT *
FROM
(SELECT concat(first_name,last_name) as a1, COUNT(DISTINCT a1.film_id)
FROM actor a
JOIN film_actor f
ON a.film_id = f.film_id
GROUP BY COUNT(DISTINCT a.film_id),a1
JOIN
(SELECT concat(first_name,last_name) as a2, COUNT(DISTINCT a2.film_id)
FROM actor a
LEFT JOIN film_actor f
ON a.film_id = f.film_id
GROUP BY a2
HAVING COUNT(DISTINCT a.film_id) = COUNT(DISTINCT a1.film_id);

  -- 8- Get all pairs of customers that have rented the same film more than 3 times.
  
SELECT c.first_name,c.last_name, count(distinct r.rental_id) as number_of_rents
FROM customer c
JOIN rental r
ON c.customer_id = r.customer_id
group by c.first_name,c.last_name
having count(distinct r.rental_id) > 3
ORDER BY count(r.rental_id) DESC;
  

  -- 9 - For each film, list actor that has acted in more films.
  
  SELECT concat(first_name,' ',last_name) AS actor_name
  FROM actor
  JOIN film_actor
  USING (actor_id)
  GROUP BY actor_name
  order by count(film_id)
