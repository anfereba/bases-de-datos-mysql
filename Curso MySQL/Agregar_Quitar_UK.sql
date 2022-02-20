-- AGREGAR Y QUITAR UNIQUE CONSTRAIT
-- ALTER TABLE <nombre_tabla>
-- ADD CONSTRAINT <nombre_constraint> UNIQUE <nombre_columna>

-- ALTER TABLE <nombre_tabla>
-- DROP INDEX <nombre_columna>

DESC grupo_1;
ALTER TABLE grupo_1
ADD CONSTRAINT u_nombre UNIQUE (NOMBRE);

CREATE TABLE grupo_3 (
	id INT NOT NULL,
    dir_id int not null,
    PRIMARY KEY (ID),
    UNIQUE (dir_id)
);

DESCRIBE GRUPO_3;

ALTER TABLE GRUPO_1
DROP INDEX u_nombre;