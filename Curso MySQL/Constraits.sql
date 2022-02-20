-- CONSTRAINTS 

-- CREATE TABLE <nombre_tabla> (
-- <columna_1> <tipo_dato_1>,
-- ...,
-- <columna_n> <tipo_dato_n>,
-- CONSTRAINT CHECK (<condicion>)
-- );

-- CREATE TABLE <nombre_tabla> (
-- <columna_1> <tipo_dato_1>,
-- ...,
-- <columna_n> <tipo_dato_n> DEFAULT <valor_predeterminado>
-- )

USE BODEGA;

CREATE TABLE EMPLEADOS (
	ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    APELLIDO VARCHAR(28),
    NOMBRE VARCHAR(28),
    EDAD INT NOT NULL,
    LOCAL_NOMBRE VARCHAR(28) DEFAULT 'Los Proceres',
    CONSTRAINT CK_EDAD CHECK (EDAD >=18)
);

DESC Empleados;

INSERT INTO EMPLEADOS (APELLIDO, NOMBRE, EDAD)
values
	("Tantamo","Ernesto",23),
    ("Pozo","Alejandra",20)
;

SELECT * FROM EMPLEADOS;

ALTER TABLE EMPLEADOS
ALTER EDAD SET DEFAULT 19;

INSERT INTO EMPLEADOS (APELLIDO, NOMBRE)
values
	("Borgia","Ernesto")
;