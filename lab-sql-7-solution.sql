use sakila;

## 1. In the table actor, which are the actors whose last names are not repeated? 
select * from actor;
select distinct last_name as different_last_names, count(*) as times_repeated
from actor
group by different_last_names
having times_repeated = 1;

## 2.  Which last names appear more than once? We would use the same logic as in the previous question but this time we want to include 
## the last names of the actors where the last name was present more than once.

## solution 1:
select * from actor;
select distinct last_name as different_last_names, count(*) as times_repeated
from actor
group by different_last_names
having times_repeated != 1;

## solution 2:
with cte_rep_last_names as (select distinct last_name as different_last_names, count(*) as times_repeated
							from actor
							group by different_last_names
							having times_repeated != 1)
select * from cte_rep_last_names;

## 3. Using the rental table, find out how many rentals were processed by each employee.
## solution 1:
select * from rental;
select staff_id, count(*) as total_rentals_processed
from rental
group by staff_id;

## solution 2:
select staff_id, total_rentals_processed,
rank() over (order by total_rentals_processed desc) as employee_rank
from (
    select staff_id, count(*) as total_rentals_processed
	from rental
	group by staff_id
) as rental_summary;


## 4. Using the film table, find out how many films were released each year.
select * from film;
select release_year, count(film_id)
from film
group by release_year;

## 5. Using the film table, find out for each rating how many films were there.
select distinct rating, count(film_id) as number_of_films
from film
group by rating;

## 6. What is the mean length of the film for each rating type. Round off the average lengths to two decimal places
select distinct rating, round(avg(length(length)), 2) as mean_length
from film
group by rating;

## 7. Which kind of movies (rating) have a mean duration of more than two hours?
select rating, round(avg(length)) as avg_duration
from film
group by rating
having avg(length) > 120;