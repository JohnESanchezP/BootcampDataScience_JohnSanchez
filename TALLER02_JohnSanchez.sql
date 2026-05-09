## Taller N2 MySQL John Sanchez ##

Use sakila;	

## Parte 1 – SELECT y WHERE ##

# 1. Mostrar el nombre y apellido de todos los clientes#

SELECT 
	name AS Nombre_Apellido
FROM customer_list;

# 2. Mostrar las películas con duración mayor a 120 minutos # 

SELECT 
	title as Titulo, 
	length as Duracion
FROM film 
WHERE length >= 120;

## Parte 2  – ORDER BY ##

# 1. Orden alfabetico de clientes por apellidos 

SELECT name FROM customer_list
ORDER BY  TRIM(SUBSTRING_INDEX(name, ' ', -1)) COLLATE utf8mb4_spanish_ci,  name COLLATE utf8mb4_spanish_ci;

# 2. Top 5 de peliculas más largas #

SELECT	
	title as Titulo,
    length as Duracion
FROM film
order by length desc limit 5;

## Parte 3 – INNER JOIN ##

# 1. Mostrar la cantidad pagada, fecha del pago con nombre y apellido del cliente #

SELECT 
    c.first_name AS Nombre, 
    c.last_name AS Apellido, 
    p.amount AS 'Cantidad Pagada', 
    p.payment_date AS 'Fecha de Pago'
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
ORDER BY p.payment_date DESC;

# 2. Mostrar las películas alquiladas #
 
 SELECT 
    c.first_name AS Nombre, 
    c.last_name AS Apellido, 
    f.title AS 'Título de la Película', 
    r.rental_date AS 'Fecha de Alquiler'
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
INNER JOIN inventory i ON r.inventory_id = i.inventory_id
INNER JOIN film f ON i.film_id = f.film_id
ORDER BY r.rental_date DESC;
 
 
## Parte 4 – LEFT JOIN ##
 
 
# 1. Colsultar si hay clientes sin pagos con sus respectivos nombres y apellidos #

SELECT 
    c.first_name AS Nombre, 
    c.last_name AS Apellido
FROM customer c
LEFT JOIN payment p ON c.customer_id = p.customer_id
WHERE p.payment_id IS NULL;

## No hay clientes sin pagos ## 

# 2 Listar las peliculas y su duracion de aquellos titulos que no tienen actores #

SELECT 
    f.title AS 'Título de la Película', 
    f.length AS 'Duración (min)'
FROM film f
LEFT JOIN film_actor fa ON f.film_id = fa.film_id
WHERE fa.actor_id IS NULL;


## Parte 5 – INSERT, UPDATE, DELETE (Data Definition Language ) ##

# 1. Insertar un actor temporal (Nicolas Mora) #

INSERT INTO actor (first_name, last_name)
VALUES ("Nicolas", "Mora");

Select * from actor;

# 2. Atualiza el actor recien ingresado #

UPDATE actor 
SET first_name = "PEDRO", 
    last_name = "ESCAMOSO"
WHERE actor_id = 201;

Select * from actor;

# 3. Elimina de la base de dato el actor creado #

DELETE FROM actor 
WHERE actor_id = 201;

Select * from actor;

## Parte 6 - Consultas Avanzadas ##

# 1. Consulta el top 5 clientes con mayor cantidad de dinero pagado al servicio de rentas #

SELECT 
    c.first_name AS Nombre, 
    c.last_name AS Apellido, 
    SUM(p.amount) AS Total_Pagado
FROM customer c
INNER JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY Total_Pagado DESC
LIMIT 5;


# 2. Consulta el top 5 Películas más alquiladas (JOIN entre Rental - Inventory - Film) --> Agrupar los datos con conteo y tomar las mejores 5

SELECT 
    f.title AS 'Título de la Película', 
    COUNT(r.rental_id) AS 'Total de Alquileres'
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY COUNT(r.rental_id) DESC
LIMIT 5;

## FIN ##