-- AGREGAR O QUITAR CLAVES FORANEAS

-- ALTER TABLE <nombre_tabla_hija>
-- ADD CONSTRAIT <nombre_restriccion>
-- FOREIGN KEY (<nombre_columna>) REFERENCES <nombre_tabla_madre>;

-- ALTER TABLE <nombre_tabla_hija>
-- DROP FOREIGN KEY;

-- CREATE TABLE <nombre_tabla_hija>(
-- <nombre_columna1> <tipo_de_data_1> NOT NULL,
-- <nombre_columna2> <tipo_de_data_2> NOT NULL,
-- ...
-- PRIMARY KEY (<nombre_columna1>),
-- FOREIGN KEY (<nombre_columna2>) REFERENCES <nombre_tabla_madre> 	
-- );

USE GRUPOS;
SHOW TABLES;

DESCRIBE ZONAS;
DESCRIBE GRUPO_1;
DESCRIBE GRUPO_2;

ALTER TABLE GRUPO_1
ADD constraint FK_ZONASID
foreign key (DIR_COD) references ZONAS(ID);

CREATE TABLE GRUPO_2 (
	ID INT NOT NULL ,
    NOMBRE VARCHAR(20),
    DIR_COD INT NOT NULL,
    primary key (ID),
    FOREIGN KEY (DIR_COD) REFERENCES ZONAS(ID)
);

ALTER TABLE GRUPO_1
DROP FOREIGN KEY FK_ZONASID;