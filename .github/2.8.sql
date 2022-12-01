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

#6 is Academy Dinausaur  available for rent from store 1

select 
from 

 