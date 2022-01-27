USE sakila;
-- 1. In the table actor, what last names are not repeated?
select last_name from actor group by last_name having count(*) = 1;


-- 2. Which last names appear more than once?
select last_name from actor group by last_name having count(*) > 1;

-- 3. Using the rental table, find out how many rentals were processed by each employee.
select staff_id as staff_member, count(rental_id) as num_of_rentals from rental group by staff_id;

-- 4. Using the film table, find out how many films were released.
select count(*) as num_of_films from film;

-- 5. Using the film table, find out how many films there are of each rating.
select rating, count(rating) as num_in_inventory from film group by rating;

-- 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
select rating, round(avg(length),2) as average_length from film group by rating;

-- 7. Which kind of movies (rating) have a mean duration of more than two hours?
select rating, round(avg(length),2) as average_length from film group by rating having average_length > 120;

