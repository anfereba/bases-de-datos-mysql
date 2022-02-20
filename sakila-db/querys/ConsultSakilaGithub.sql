# Consultas a la base de datos Sakila
USE SAKILA;

#### 1a. Mostrar los nombres y apellidos de todos los actores de la tabla `actor`.

SELECT first_name, last_name FROM Actor;

#### 1b. Mostrar el nombre y el apellido de cada actor en una sola columna en mayúsculas. Nombra la columna `Nombre del actor`.

SELECT lcase(concat_ws(' ',first_name, last_name)) as NombreDelActor FROM Actor;

#### 2a. Necesitas encontrar el número de identificación, el nombre y el apellido de un actor del que sólo conoces el nombre, "Joe". ¿
### Qué consulta utilizarías para obtener esta información?

SELECT * From Actor;

SELECT * FROM Actor where first_name = 'Joe';


#### 2b. Encuentra todos los actores cuyo apellido contenga las letras `GEN`:

SELECT * from ACTOR WHERE last_name LIKE '%GEN%';


#### 2c. Encuentre todos los actores cuyos apellidos contengan las letras `LI`.
### Esta vez, ordena las filas por apellido y nombre, en ese orden:


SELECT * from ACTOR WHERE last_name LIKE '%LI%' order by last_name, first_name;

#### 2d. Utilizando `IN`, muestra las columnas `country_id` y `country` de los siguientes países:
### Afganistán, Bangladesh y China:

SELECT country_id, country from country WHERE country IN ('Afghanistan','Bangladesh','China');


#### 3a. Quieres guardar una descripción de cada actor. No crees que vayas a realizar consultas sobre una descripción, 
### así que crea una columna en la tabla `actor` llamada `description` y utiliza el tipo de datos `BLOB` (Asegúrate de investigar el tipo `BLOB`, ya que la diferencia entre éste y `VARCHAR` son significativas).

SHOW COLUMNS IN actor;
ALTER TABLE actor ADD COLUMN description BLOB;

#### 3b. Rápidamente se da cuenta de que introducir descripciones para cada actor es demasiado esfuerzo. Elimina la columna `description`.

ALTER TABLE actor
DROP COLUMN description;

#### 4a. Enumera los apellidos de los actores, así como cuántos actores tienen ese apellido.

select last_name, count(last_name) as Cantidad from ACTOR GROUP BY last_name ORDER BY Cantidad DESC;

#### 4b. Enumerar los apellidos de los actores y el número de actores que tienen ese apellido, pero sólo para los nombres que son compartidos por al menos dos actores

select last_name, count(last_name) as Cantidad from ACTOR GROUP BY last_name HAVING Cantidad >=2 ORDER BY Cantidad DESC;

#### 4c. El actor `HARPO WILLIAMS` fue introducido accidentalmente en la tabla `actor` como `GROUCHO WILLIAMS`. Escribe una consulta para corregir el registro.

UPDATE Actor SET first_name = 'HARPO' WHERE actor_id IN (SELECT actor_id from Actor WHERE first_name = 'GROUCHO' and last_name = 'WILLIAMS');

#### 4d. Quizás nos hemos precipitado al cambiar "Groucho" por "Harpo". Resulta que, después de todo, ¡GROUCHO era el nombre correcto! En una única consulta, si el nombre del actor es actualmente `HARPO`, cámbialo por `GROUCHO`.

UPDATE Actor SET first_name = 'GROUCHO' WHERE actor_id IN (SELECT actor_id from Actor WHERE first_name = 'HARPO' and last_name = 'WILLIAMS');

#### 5a. No puedes localizar el esquema de la tabla `address`. ¿Qué consulta utilizarías para recrearla?

SHOW CREATE TABLE address;

#### 6a. Utiliza `JOIN` para mostrar el nombre y los apellidos, así como la dirección, de cada miembro del personal. Utiliza las tablas `staff` y `address`:

SELECT s.first_name, s.last_name, a.address, a.district, a.postal_code, a.city_id from staff s
LEFT JOIN address a ON a.address_id = s.address_id;


#### 6b. Utilice `JOIN` para mostrar el importe total recaudado por cada miembro del personal en agosto de 2005. Utilice las tablas `staff` y `payment`.

SELECT s.first_name, s.last_name, sum(amount) from staff s 
INNER JOIN payment p ON p.staff_id = s.staff_id 
WHERE month(p.payment_date) = 8 and year(p.payment_date) = 2005 GROUP BY 1;

#### 6c. Enumere cada película y el número de actores que figuran en ella. Utilice las tablas `film_actor` y `film`. Utilice la unión interna.

SELECT f.title, count(fa.film_id) NumeroActores  from film f
INNER JOIN film_actor fa ON fa.film_id = f.film_id GROUP BY 1 ORDER BY NumeroActores DESC; 

#### 6d. ¿Cuántas copias de la película "Jorobado Imposible" existen en el sistema de inventario?

SELECT count(*) from inventory where film_id IN (SELECT film_id from film WHERE title = 'Hunchback Impossible');
SELECT f.title, count(*) Stock FROM inventory i INNER JOIN film f ON f.film_id = i.film_id WHERE title = 'Hunchback Impossible' group by 1;

#### 6e. Utilizando las tablas `pago` y `cliente` y el comando `JOIN`, enumera el total pagado por cada cliente. Enumera los clientes alfabéticamente por su apellido:

SELECT c.first_name, c.last_name, sum(p.amount) TotalPagado from payment p
inner join customer c ON c.customer_id = p.customer_id group by 1,2 order by 2;

#### 7a. La música de Queen y Kris Kristofferson ha experimentado un improbable resurgimiento. Como consecuencia involuntaria, 
## las películas que comienzan con las letras "K" y "Q" también han aumentado su popularidad. 
# Utiliza las subconsultas para mostrar los títulos de las películas que empiezan por las letras "K" y "Q" cuyo idioma es el inglés.

SELECT title from film WHERE (title LIKE 'K%' OR title LIKE 'Q%') AND language_id IN (SELECT language_id from language WHERE name = 'English') order by title;


#### 7b. Utiliza subconsultas para mostrar todos los actores que aparecen en la película `Alone Trip`.

select * from actor WHERE actor_id IN
(select actor_id from film_actor where film_id IN (SELECT film_id FROM film where title = lower('Alone Trip')));


#### 7c. Desea realizar una campaña de marketing por correo electrónico en Canadá, 
### para lo cual necesitará los nombres y las direcciones de correo electrónico de todos los clientes canadienses. Utiliza los joins para recuperar esta información.

select c.first_name, c.last_name, c.email from customer c
left join address a ON a.address_id = c.address_id
left join city ci ON ci.city_id = a.city_id
left join country co ON co.country_id = ci.country_id WHERE co.country = 'Canada';

SELECT first_name, last_name, email from customer WHERE address_id IN(
	select address_id from address WHERE city_id IN(
		select city_id from city WHERE country_id IN(
			select country_id from country WHERE country = 'Canada'
        )
    )
)



#### 7d. Las ventas han disminuido entre las familias jóvenes, y usted desea dirigir una promoción a todas las películas familiares. Identifique todas las películas categorizadas como películas _familiares_.


select film_id, title, description from film WHERE film_id IN (
	select film_id from film_category WHERE category_id IN (
		select category_id from category WHERE name = 'Family'
	)
)

#### 7e. Muestre las películas más alquiladas en orden descendente.


select f.film_id, f.title, count(*) as CantidadAlquiladas from film f
LEFT JOIN inventory i ON i.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id GROUP BY 1 order by CantidadAlquiladas DESC;



#### 7f. Escriba una consulta para mostrar el volumen de negocio, en dólares, de cada tienda.

select s.store_id, sum(p.amount) as Ventas from store s
INNER JOIN customer c ON c.store_id = s.store_id
INNER JOIN payment p ON p.customer_id = c.customer_id GROUP BY s.store_id;

#### 7g. Escribe una consulta para mostrar para cada tienda su ID de tienda, ciudad y país y ventas totales.

SELECT s.store_id, c.city, co.country, sum(p.amount) Ventas from store s
INNER JOIN address a ON a.address_id = s.address_id
INNER JOIN city c ON c.city_id = a.city_id
INNER JOIN country co on co.country_id = c.country_id
INNER JOIN customer cu ON cu.store_id = s.store_id
INNER JOIN payment p ON p.customer_id = cu.customer_id GROUP BY s.store_id;

select * from country;

#### 7h. Enumera los cinco géneros más importantes en ingresos brutos en orden descendente. (**Pista**: es posible que tenga que utilizar las siguientes tablas: categoría, film_category, inventario, pago y alquiler).

select ca.name, sum(p.amount) from category ca
LEFT JOIN film_category fc ON fc.category_id = ca.category_id
LEFT JOIN film fi ON fi.film_id = fc.film_id
LEFT JOIN inventory i ON i.film_id = fi.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
LEFT JOIN payment p ON p.rental_id = r.rental_id group by 1 order by 2 DESC LIMIT 5;

#### 8a. En su nuevo papel como ejecutivo, le gustaría tener una manera fácil de ver los cinco géneros principales por ingresos brutos. Utilice la solución del problema anterior para crear una vista. Si no ha resuelto el problema 7h, puede sustituirlo por otra consulta para crear una vista.

CREATE VIEW TopCincoGeneros AS
select ca.name, sum(p.amount) from category ca
LEFT JOIN film_category fc ON fc.category_id = ca.category_id
LEFT JOIN film fi ON fi.film_id = fc.film_id
LEFT JOIN inventory i ON i.film_id = fi.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
LEFT JOIN payment p ON p.rental_id = r.rental_id group by 1 order by 2 DESC LIMIT 5;

#### 8b. ¿Cómo mostrarías la vista que creaste en 8a?

SELECT * from TopCincoGeneros;

#### 8c. Descubres que ya no necesitas la vista `top_five_genres`. Escribe una consulta para eliminarla.

DROP VIEW TopCincoGeneros;

