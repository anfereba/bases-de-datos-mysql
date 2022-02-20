-- ELIMINAR DATOS DE UNA TABLA

USE BODEGA;

CREATE TABLE PERSONAS(
	ID INT AUTO_INCREMENT PRIMARY KEY,
    NOMBRE VARCHAR(20),
    EDAD INT,
    PAIS VARCHAR(20)
);

INSERT INTO PERSONAS (NOMBRE, EDAD, PAIS) VALUES
	("Sergio",20,"Cuba"),
    ("Jenny",24,"Argentina"),
    ("Rafael",22,"Mexico"),
    ("Furiyel",23,"Venezuela"),
    ("Berengenio",19,"Colombia"),
    ("Joana",22,"Mexico");
    
SELECT * FROM PERSONAS;

-- ELIMINAR UNA FILA

DELETE FROM personas
WHERE NOMBRE = "FURIYEL";

-- ELIMINAR VARIAS FILAS

DELETE FROM personas
WHERE PAIS = "Colombia";


DELETE FROM personas;

use sakila;
INSERT INTO SAKILA.ACTOR (first_name, last_name)
VALUES 
("Fiorella", "Guelini"), 
("Liv", "Tyler"),
("Helen", "Grady"), 
("Hector", "Troya"), 
("Hugo", "Balbuena"), 
("Robert", "Pattinson"),
("Fred", "Thompson"), 
("Nuvo", "Milano");

select * from actor;
    
    