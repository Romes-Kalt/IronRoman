USE sakila;

-- 1. Which actor has appeared in the most films?
select first_name, last_name, count(lft.actor_id) as 'how_many_films' from film_actor as lft
	inner join actor as rgt using(actor_id)
    group by lft.actor_id
	order by count(lft.actor_id) desc limit 1;

-- 2. Most active customer (the customer that has rented the most number of films).
select first_name, last_name, count(rgt.customer_id) as how_many_rentals from customer as lft
	inner join rental as rgt on lft.customer_id = rgt.customer_id
    group by rgt.customer_id
    order by how_many_rentals desc limit 1; 

-- 3. List number of films per category.
select rgt.name, count(lft.film_id) as number_of_titles from film_category as lft
	inner join category as rgt on lft.category_id = rgt.category_id
    group by rgt.name;

-- 4. Display the first and last names, as well as the address, of each staff member.
select first_name, last_name, address from staff as lft
	inner join address as rgt on lft.address_id = rgt.address_id;
    
-- 5. Display the total amount rung up by each staff member in August of 2005.
select first_name, last_name, sum(rgt.amount) from staff as lft
	inner join payment as rgt on lft.staff_id = rgt.staff_id
    group by lft.staff_id;

-- 6. List each film and the number of actors who are listed for that film.
select title, COUNT(actor_id) as how_many_actors from film as lft
	inner join film_actor as rgt on lft.film_id = rgt.film_id
	group by title;

-- 7. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name.
select last_name, first_name, SUM(amount) from payment as lft
	inner join customer as rgt on lft.customer_id = rgt.customer_id
	group by lft.customer_id
	order by last_name asc;

-- Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.
select more_left.title, count(more_left.title) from film as more_left
	inner join inventory as lft using (film_id)
		inner join rental as rgt using (inventory_id)
	group by more_left.title
	order by count(rgt.rental_id) desc   
	limit 1;