USE sakila;

-- 1. Actores que tienen de primer nombre ‘Scarlett’.
SELECT * from actor where (first_name) = 'Scarlett';

-- 2. Actores que tienen de apellido ‘Johansson’.
SELECT * from actor where (last_name) = 'Johansson';

-- 3. Actores que contengan una ‘O’ en su nombre.
SELECT * from actor where first_name LIKE '%O%';

-- 4. Actores que contengan una ‘O’ en su nombre y en una ‘A’ en su apellido.
SELECT * from actor where first_name LIKE '%O%' and last_name LIKE '%A%';

-- 5. Actores que contengan dos ‘O’ en su nombre y en una ‘A’ en su apellido.
SELECT * from actor where first_name LIKE '%O%O%' and last_name LIKE '%A%';

-- 6. Actores donde su tercera letra sea ‘B’.
SELECT * from actor WHERE first_name LIKE '__B%';

-- 7. Ciudades que empiezan por ‘a’.
SELECT * from city where city LIKE 'A%';

-- 8. Ciudades que acaban por ‘s’.
SELECT * from city where city LIKE '%S';

-- 9. Ciudades del country 61.
SELECT * from city where country_id = 61;

-- 10. Ciudades del country 'Spain'

SELECT * from city where country_id IN
(SELECT country_id from country where country = 'Spain');

select * from city c left join country co ON c.country_id = co.country_id where co.country = 'Spain';

-- 11. Ciudades con nombres compuestos.
SELECT * 
FROM city 
WHERE city LIKE '% %';

-- 12. Peliculas con una duracion entre 80 y 100.
SELECT * FROM film WHERE length >= 80 and length <= 100;
SELECT * from film where length between 80 and 100;

-- 13. Peliculas con un rental_rate entre 1 y 3.
select * from film where rental_rate between 1 and 3;

-- 14. Peliculas con un titulo de más de 12 letras.
select title, length(title) from film where length(title) > 12;

--  15. Peliculas con un rating de PG o G.
select * from film where rating IN('PG','G');

--  16. Peliculas que no tengan un rating de NC-17.
select * from film where rating <> 'NC-17';

-- 17. Peliculas con un rating PG y duracion de más de 120.
select * from film  where rating = 'PG' and length > 120;

-- 18. ¿Cuantos actores hay?
select count(*) as num_actor from actor;

-- 19. ¿Cuantas ciudades tiene el country ‘Spain’?
select co.country, count(*) as CantidadDeCiudades from city c inner join country co ON (co.country_id = c.country_id) WHERE country = 'Spain' group by 1;
SELECT COUNT(*) as num_cities FROM city WHERE country_id = (SELECT country_id from country where upper(country) = 'SPAIN');

-- 20. ¿Cuantos countries hay que empiezan por ‘a’ ?
select count(*) from country where country LIKE ucase('a%');

-- 21. Media de duración de peliculas con PG.
select AVG(length) from film where rating = 'PG';

-- 22. Suma de rental_rate de todas las peliculas.
SELECT sum(rental_rate) from film;

-- 23. Pelicula con mayor duración.
SELECT MAX(length) as mayor_duracion FROM film;
select * from film where length IN (SELECT MAX(length) from film);

-- 24. Pelicula con menor duración.
select * from film where length IN (SELECT MIN(length) from film);

-- 25. Mostrar las ciudades del country Spain (multitabla).
select * from city where country_id IN (SELECT country_id from country WHERE country = 'Spain');
select co.country, c.city from city c INNER JOIN country co ON (c.country_id = co.country_id) where co.country = 'Spain';
SELECT co.country, c.city FROM city c, country co WHERE (c.country_id = co.country_id) AND co.country = 'Spain';

-- 26. Mostrar el nombre de la película y el nombre de los actores.

select f.title, concat_ws(" ",a.first_name,a.last_name) as NombreActor from film_actor fa 
INNER JOIN film f ON (fa.film_id = f.film_id) 
INNER JOIN actor a ON (fa.actor_id = a.actor_id) order by f.title;


SELECT f.title, a.first_name, a.last_name FROM film f, actor a, film_actor fa
WHERE f.film_id = fa.film_id  AND a.actor_id = fa.actor_id ORDER BY f.title;

-- 27. Mostrar el nombre de la película y el de sus categorías.

select f.title, c.name from film f
INNER JOIN film_category fc ON (f.film_id = fc.film_id)
INNER JOIN category c ON (fc.category_id = c.category_id) order by title;

-- 28. Mostrar el country, la ciudad y dirección de cada miembro del staff.
select s.first_name, s.last_name, a.address, c.city, co.country from staff s 
inner join address a ON (s.address_id = a.address_id)
inner join city c ON (a.city_id = c.city_id)
inner join country co ON (co.country_id = c.country_id);

SELECT co.country, c.city, a.address, a.address2, s.first_name, s.last_name
FROM country co, city c, address a, staff s
WHERE co.country_id = c.country_id 
AND a.city_id = c.city_id 
AND s.address_id = a.address_id;

-- 29. Mostrar el country, la ciudad y dirección de cada customer.
select cu.first_name, cu.last_name, a.address, c.city, co.country from customer cu
inner join address a ON (cu.address_id = a.address_id)
inner join city c ON (a.city_id = c.city_id)
inner join country co ON (co.country_id = c.country_id);

SELECT co.country, c.city, a.address, a.address2, cu.first_name, cu.last_name
FROM country co, city c, address a, customer cu
WHERE co.country_id = c.country_id 
AND a.city_id = c.city_id 
AND cu.address_id = a.address_id;


-- 30. Numero de peliculas de cada rating
USE SAKILA;
SELECT rating, count(*) from film group by 1;

-- 31. Cuantas peliculas ha realizado el actor ED CHASE.

SELECT concat_ws(" ",first_name,last_name) as NombreActor, count(*) as CantidadPeliculas  from actor a
INNER JOIN film_actor fa ON (a.actor_id = fa.actor_id)
INNER JOIN film f ON (f.film_id = fa.film_id) group by 1 order by 2 ASC;

SELECT first_name, last_name, count(*)
FROM actor a, film f, film_actor fa
WHERE f.film_id = fa.film_id 
AND a.actor_id = fa.actor_id
GROUP BY first_name, last_name order by 3 ASC;

-- 32. Media de duracion de las peliculas cada categoria.

SELECT c.name, AVG(f.length) as Media from film f
INNER JOIN film_category fc ON (f.film_id = fc.film_id)
INNER JOIN category c ON (c.category_id = fc.category_id) group by 1;


SELECT c.name, avg(f.length) as media_duracion
FROM category c, film f, film_category fc 
WHERE c.category_id = fc.category_id 
AND f.film_id = fc.film_id group by 1;

