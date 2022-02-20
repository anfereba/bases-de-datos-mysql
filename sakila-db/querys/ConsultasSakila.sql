USE SAKILA;

-- COMANDO SELECT FROM
SELECT * FROM Actor;
SELECT * FROM City;

-- COMANDO SELECT FROM Con Campos Especificos
SELECT actor_id, first_name, last_name, last_update from Actor;

-- ASIGNACION DE ALIAS (AS)
SELECT actor_id as Identidad, first_name AS PrimerNombre, last_name, last_update FROM Actor;

-- INSTRUCCION DISTINC: Para devolver valores diferentes o distintos de una columna (distinct(columna distinta))
SELECT DISTINCT (store_id) FROM customer;
SELECT DISTINCT (customer_id) FROM payment;

-- INSTRUCCION ORDER BY
SELECT * FROM country ORDER BY country DESC;
SELECT * FROM customer  ORDER BY first_name ASC;

-- EJERCICIO PRACTICO # 4
select store_id AS Tienda, first_name AS Nombre, last_name from customer;
select customer_id AS idCustomer, store_id AS idStore, first_name As Nombre, 
last_name as Apellido, email AS correo, address_id as idDireccion, 
active as activo, create_date as FechaRegistro, last_update 
AS ultimaActualizacion from customer;

select * from customer order by last_name DESC;

-- EJERCICIO 5
SELECT distinct(amount) FROM payment ORDER BY amount ASC;

-- CLAUSULA WHERE
SELECT * from actor where first_name = 'DAN';
SELECT * from city where city = 'LONDON';
SELECT * from city where country_id = 102;
SELECT * from customer where store_id = 1;
SELECT * from inventory where film_id > 50;
SELECT * from payment where amount < 3;
SELECT DISTINCT(amount) from payment where amount < 3;
SELECT * from staff where staff_id <> 2;
SELECT * from language where name <> 'German';


-- EJERCICIO PRACTICO # 9
SELECT description, release_year FROM film WHERE title = 'IMPACT ALADDIN';
SELECT * from payment where amount > 0.99;


-- CLAUSULA WHERE CON AND Y OR
SELECT * from country WHERE country = 'Algeria' and country_id = 2;
SELECT * from country WHERE country = 'Algeria' or country_id = 12;
SELECT * FROM language WHERE language_id = 1 OR name = 'German';
SELECT * FROM category where not name = 'Action';
SELECT distinct(rating) from film where not rating = 'PG';

-- EJERCICIO PRACTICA # 14
SELECT * from payment where customer_id = 36 AND amount > 0.99 AND staff_id = 1;
SELECT * FROM rental WHERE not staff_id = 1 AND customer_id > 250 AND inventory_id < 100;

-- OPERADOR IN (TRABAJA DENTRO DEL WHERE Y ES UNA ABREVIATURA DE MUCHOS OR)
select * from customer where first_name = 'MARY' or first_name = 'PATRICIA';
select * from customer where first_name in ('MARY','PATRICIA');
select * from film where special_features in ('Trailers','Trailers,Deleted Scenes') and rating in ('G','NC-17') and length > 100;
select * from category where name not in ('Action','Animation','Children');

-- EJERCICIO 19 Y 20
SELECT * from film_text WHERE title in('ZORRO','ARK','VIRGIN','DAISY','UNITED PILOT');
SELECT * FROM city WHERE city in ('Chiayi','Dongying','Fukuyama','Kilis');

-- OPERADOR BETWEEN (Seleccionar valores dentro de un rango)

SELECT * from rental where (customer_id between 300 and 350) and staff_id = 1;
SELECT * from payment where amount not between 3 and 5;

-- EJERCICIO 23 24 Y 25

SELECT * from payment where (amount between 2.99 and 4.99) and (staff_id = 2) AND customer_id IN (1,2);
SELECT * from address where city_id between 300 and 350;
SELECT * from film WHERE (rental_rate between 0.99 and 2.99) AND length <= 50 AND replacement_cost < 20;

-- OPERADOR LIKE (Para buscar un patron especifico)
SELECT * FROM actor WHERE first_name LIKE 'A%'AND last_name like 'B%';
SELECT * FROM actor WHERE first_name LIKE '%A'AND last_name like '%N';
SELECT * FROM actor WHERE first_name LIKE '%NE%' AND last_name like '%RO%';
SELECT * FROM actor WHERE first_name LIKE 'A%E';
SELECT * FROM actor WHERE first_name LIKE 'C%N' AND last_name like 'G%';

SELECT distinct(actor_id) from actor order by 1 desc LIMIT 1;

-- EJERCICIO 30
SELECT * FROM film WHERE release_year = 2006 and title LIKE 'ALI%';

-- INNER JOIN

select f.title, f.description, f.release_year, f.language_id, l.name from film f inner join language l on (f.language_id = l.language_id);
select a.address_id, address as Direccion, district, a.city_id, c.city as Ciudad from address a
inner join city c on (a.city_id = c.city_id);

-- RIGHT JOIN (Dejamos toda la info de actor y pegamos la info de customer donde el apellido coincida, si no hay apellido pues pone null)

SELECT 
c.customer_id, c.first_name, c.last_name, a.actor_id, a.first_name, a.last_name 
from customer c RIGHT JOIN actor a ON (c.last_name = a.last_name);

-- LEFT JOIN (Mantiene info izquierda y no hay vacios, va unir por last name, donde encuentra, va  a pegar la informacion de la derecha)

SELECT 
c.customer_id, c.first_name, c.last_name, a.actor_id, a.first_name, a.last_name 
from customer c LEFT JOIN actor a ON (c.last_name = a.last_name);

-- EJERCICIO 36
SELECT a.address, c.city, co.country from address a INNER JOIN city c ON (a.city_id = c.city_id) INNER JOIN country co ON (c.country_id = co.country_id);

-- EJERCICIO 37
SELECT c.first_name, a.address, s.store_id from customer c LEFT JOIN store s ON (c.store_id = s.store_id) LEFT JOIN address a ON (c.address_id = a.address_id);

-- EJERCICIO 38
SELECT r.rental_id, s.first_name from rental r INNER JOIN staff s ON r.staff_id = s.staff_id;

-- FUNCION SUM
SELECT * FROM payment;
SELECT sum(amount) from payment;

-- PARA SUMAR COLUMNAS
SELECT inventory_id, film_id, store_id, inventory_id + film_id + store_id from inventory;

-- COUNT
SELECT count(*) from actor; -- ARROJA EL TOTAL DE REGISTROS DE LA TABLA
SELECT count(first_name) from actor; -- ARROJA EL TOTAL DE REGISTROS DE LA COLUMNA

-- AVG (Promedio)
SELECT avg(amount) from payment; -- PROMEDIO DE UNA COLUMNA
SELECT avg(rental_duration) from film;

-- MAX Y MIN

SELECT max(length) from film;
SELECT min(replacement_cost) from film;

-- EJERCICIO 44
SELECT count(rental_id) FROM rental;

-- EJERCICIO 45
SELECT MAX(amount) FROM payment;

-- GROUP BY (Por ejemplo que me cuente la cantidad de registros que aparecen con el mismo apellido) (Agrupar la informacion)

select last_name from actor;
select last_name from actor group by last_name;
select last_name, count(*) from actor group by last_name;

-- GROUP BY (Suma todos los amount que ha pagado cada uno)

SELECT c.customer_id, c.first_name, c.last_name, p.amount from payment p
inner join customer c ON (c.customer_id = p.customer_id);


SELECT c.customer_id, c.first_name, c.last_name, sum(p.amount) from payment p
inner join customer c ON (c.customer_id = p.customer_id) group by 1,2,3;

-- EJERCICIO 48 

select * from rental;
select customer_id, (rental_date) from rental;
select customer_id, MAX(rental_date) from rental group by 1;

-- CLAUSULA HAVING (CON CLAUSULA WHERE NO PODIAMOS USAR FUNCIONES DE AGREGACION)

select last_name, count(*) from actor group by 1; -- CUANTAS VECES ESTA EL APELLIDO EN ESTA TABLA
SELECT last_name, count(*) from actor group by 1 having count(*) > 3; -- MUESTRA LAS APARICIONES DE APELLIDOS MAYOR A 3

SELECT c.customer_id, c.last_name, c.first_name, sum(p.amount) 
FROM payment p INNER JOIN customer c ON (p.customer_id = c.customer_id)
GROUP BY 1,2,3 HAVING sum(p.amount) < 60 order by sum(p.amount) desc;

-- EJERCICIO 51

select last_name, count(*) from actor group by 1 having count(*) > 2;

-- FUNCION CHAR_LENGHT (Mide la longitud de una cadena de texto)

select name, char_length(name) as LongitudCadena from category;
select city, char_length(city) as LongitudCiudad from city;

-- FUNCION CONCAT y CONCAT_WS
select *, concat(first_name," ", last_name) as NombreCompleto from customer;
select concat_ws("-",title,description,release_year) from film;

-- FUNCION ROUND
select *, ROUND(amount,0) FROM payment;

-- FUNCION UPPERCASE Y LOWERCASE
select *,lcase(concat(first_name," ",last_name)) as "Nombre Completo" from actor;

-- EJERCICIO 57
select *, char_length(email) from customer;

-- EJERCICIO 58
select*, concat(first_name," ",last_name," ",email) from customer;

-- EJERCICIO 59
select * from film;
select concat_ws
("-",film_id,title,description,release_year,language_id,original_language_id,rental_duration,rental_rate,length,replacement_cost,rating,special_features,last_update) 
from film;

-- EJERCICIO 60
SELECT customer_id, ROUND(AVG(amount),0) FROM PAYMENT group by 1;

-- EJERCICIO 61
SELECT *,UCASE(city) from city;

-- FUNCION CASE
SELECT address, address2,
CASE 
	WHEN address2 IS NULL THEN "Sin direccion 2"
    ELSE "Con Direccion"
    END AS Comentario
    FROM address;
    
SELECT * FROM payment;
SELECT payment_id, amount,
CASE 
	WHEN amount <1 THEN "Precio Minimo"
    WHEN amount BETWEEN 1 AND 3 THEN "Precio Intermedio"
    ELSE "Precio Maximo"
    END AS Comentario
FROM payment;

-- EJERCICIO 63

SELECT rental_rate,
CASE
	WHEN rental_rate < 1 THEN "Pelicula Mala"
    WHEN rental_rate BETWEEN 1 AND 3 THEN "Pelicula Buena"
    ELSE "Pelicula Excelente"
    END AS Calificacion
from film;    

-- SUBCONSULTAS (Selects anidados)
USE sakila;


-- UN SELECT DONDE SU IDIOMA SEA INGLES Y ADEMAS QUE EMPIECE POR K O POR Q

SELECT title FROM FILM WHERE title LIKE 'K%' OR title LIKE 'Q%'
AND title IN
(   -- DONDE LA CONDICION VA A HACER LANGUAGE_ID
	SELECT title FROM film WHERE language_id IN
    (	-- DONDE LANGUAGE_iD SEA INGLES
		SELECT language_id FROM language where name = 'English'
    )
);


SELECT first_name, last_name FROM actor WHERE actor_id IN(
	SELECT actor_id from film_actor WHERE film_id IN
    (
		SELECT film_id from film WHERE title = 'Alone Trip'
    )
);



select * from film WHERE film_id IN(
	SELECT film_id FROM film_category WHERE category_id IN -- 8
    (
		SELECT category_id FROM category WHERE name = 'Family' -- 8
    )
);

SELECT first_name, last_name, email from customer WHERE customer_id IN(
	SELECT customer_id FROM rental WHERE inventory_id IN(
		SELECT inventory_id from inventory where film_id IN
        (
		SELECT film_id FROM film_category where category_id IN 
			(
			SELECT category_id from category where name = 'Action'
			)
		)
    )
);

    
select c.customer_id, c.first_name, c.last_name, count(*) from payment p 
inner join customer c ON p.customer_id = c.customer_id WHERE amount > (
	SELECT AVG(amount) as amount from payment
) group by 1;

select customer_id, AVG(amount) from payment group by 1;

select customer_id, count(amount) from payment where amount > (
	select AVG(amount) from payment WHERE customer_id IN (
		select customer_id from payment
    ) 
) group by customer_id;

select customer_id, amount from payment order by 1,2;

-- VISTAS

CREATE VIEW ingresos_por_genero as
select name, SUM(amount) FROM category
INNER JOIN film_category
ON category.category_id = film_category.category_id
INNER join inventory
ON film_category.film_id = inventory.film_id
INNER join rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN payment
ON rental.rental_id = payment.rental_id
GROUP BY name
ORDER BY sum(amount) DESC LIMIT 5;

SELECT * from ingresos_por_genero;
DROP view ingresos_por_genero;









