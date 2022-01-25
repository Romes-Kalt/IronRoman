USE sakila;

-- 1. Write a query to display for each store its store ID, city, and country.
select st.store_id, city, country from store as st
	inner join address as ad on st.address_id = ad.address_id
		inner join city as ci on ad.city_id = ci.city_id
			inner join country as co on ci.country_id = co.country_id;

-- 2. Write a query to display how much business, in dollars, each store brought in.
select st.store_id, sum(pa.amount) from store as st
	inner join inventory as inv using(store_id)
		inner join rental as re using(inventory_id)
			inner join payment as pa using(rental_id)
	group by st.store_id;

-- 3. What is the average running time(length) of films by category?
select ca.name, avg(length) from film as fi
	inner join film_category as fi_cat using (film_id) 
		inner join category as ca using (category_id)
	group by ca.name
	order by ca.name;

-- 4. Which film categories are longest(length)? (Hint: You can rely on question 3 output.)
select ca.name, avg(length) from film as fi
	inner join film_category as fi_cat using (film_id) 
		inner join category as ca using (category_id)
	group by ca.name
	order by avg(length) desc limit 1;

-- 5. Display the most frequently(number of times) rented movies in descending order.
select fi.title, count(fi.title) from film AS fi
	inner join inventory as inv using (film_id)
		inner join rental as re using (inventory_id)
	group by fi.title
	order by count(re.rental_id) desc   
	limit 5;

-- 6. List the top five genres in gross revenue in descending order.
select name, sum(amount) as "total_revenue" from category as ca
	inner join film_category as fi_ca using(category_id)
		-- inner join film as fi using(film_id)     -- can jump directly
			inner join inventory as inv using(film_id)
				inner join rental as re using(inventory_id)
					inner join payment as pa using(rental_id)
	group by name
	order by sum(amount) desc limit 5;

-- 7. Is "Academy Dinosaur" available for rent from Store 1?
select title  from film as fi
	inner join inventory as inv using(film_id)
		inner join rental as re using(inventory_id)
where inv.store_id = 1 AND fi.title = "Academy Dinosaur" and re.return_date < current_timestamp() limit 1;

