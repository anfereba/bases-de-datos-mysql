USE empleadoss_departamentoss;

-- 1. Obtener los datos completos de los empleados.
SELECT * from empleados;

-- 2. Obtener los datos completos de los departamentos.
SELECT * from departamentos;

-- 3. Obtener los datos de los empleados con cargo ‘Secretaria’.
SELECT * from empleados WHERE cargoE = 'Secretaria';

-- 4. Obtener el nombre y salario de los empleados.
SELECT nomEmp, salEmp from empleados;

-- 5. Obtener los datos de los empleados vendedores, ordenado por nombre.
SELECT * from empleados where cargoE = 'Vendedor' order by nomEmp;

-- 6. Listar el nombre de los departamentos.
select nombreDpto from departamentos;

-- 7. Obtener el nombre y cargo de todos los empleados, ordenado por salario.
select nomEmp, cargoE, salEmp from empleados order by salEmp;

-- 8. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado por comisión.
select salEmp, comisionE from empleados where codDepto = 2000;

-- 9. Listar todas las comisiones.
select comisionE from empleados;

-- 10. Obtener el valor total a pagar que resulta de sumar a los empleados del departamento 3000 una bonificación de 500.000, en orden alfabético del empleado
select  *, (salEmp + 500000) as pagoestimado from empleados where codDepto = 3000 order by nomEmp;

-- 11. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.
select * from empleados where comisionE > salEmp; 

-- 12. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.
select * from empleados where comisionE <= (salEmp * 0.3);

-- 13.Elabore un listado donde para cada fila, figure ‘Nombre’ y ‘Cargo’ antes del valor respectivo para cada empleado.
select nomEmp as Nombre, cargoE as Cargo from empleados, salEmp;

-- 14. Hallar el salario y la comisión de aquellos empleados cuyo número de documento de identidad es superior al ‘19.709.802’.
select ndiEmp, salEmp, comisionE from empleados where nDIEmp > '19.709.802';

-- 15. Muestra los empleados cuyo nombre empiece entre las letras J y Z (rango). Liste estos empleados y su cargo por orden alfabético.
select * from empleados where nomEmp > 'J' AND nomEmp <= 'Z' order by nomEmp;
select nomemp, cargoe from empleados where lower(nomemp) > 'j' and lower(nomemp) < 'z' order by nomemp;

-- 16. Listar el salario, la comisión, el salario total (salario + comisión), 
-- documento de identidad del empleado y nombre, de aquellos empleados que tienen comisión superior a 1.000.000, ordenar el informe por el número del documento de identidad

select * from empleados;
SELECT nDIEmp, nomEmp, salEmp, comisionE, (salEmp + comisionE) AS SalarioTotal from empleados where comisionE > 1000000 order by nDIEmp; 

-- 17. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen comisión
SELECT nDIEmp, nomEmp, salEmp, comisionE, (salEmp + comisionE) AS SalarioTotal from empleados where comisionE = 0 order by nDIEmp; 

-- 18. Hallar los empleados cuyo nombre no contiene la cadena “MA”
SELECT * from empleados where nomEmp NOT LIKE '%MA%';

-- 19. Obtener los nombres de los departamentos que no sean “Ventas” ni “Investigación” NI ‘MANTENIMIENTO’.
SELECT * from departamentos where nombreDpto NOT IN ('VENTAS','INVESTIGACIÓN','MANTENIMIENTO');

-- 20. Obtener el nombre y el departamento de los empleados con cargo ‘Secretaria’ o ‘Vendedor’, que no trabajan en el departamento de “PRODUCCION”,
-- cuyo salario es superior a $1.000.000, ordenados por fecha de incorporación.

select * from empleados e
inner join departamentos d ON (d.codDepto = e.codDepto) where e.cargoE IN ('Secretaria','Vendedor') AND d.nombreDpto <> 'PRODUCCIÓN' AND e.salEmp > 1000000
ORDER BY e.fecIncorporacion;


-- 22. Obtener información de los empleados cuyo nombre tiene al menos 11 caracteres
select *,length(nomEmp) from empleados where length(nomEmp) >= 11;

-- 23. Listar los datos de los empleados cuyo nombre inicia por la letra ‘M’, su salario es mayor a $800.000 o reciben comisión y trabajan para el departamento de ‘VENTAS’
select * from empleados e 
where (nomEmp LIKE 'M%') and (salEmp > 800000 OR comisionE > 0) and codDepto IN (SELECT codDepto FROM departamentos WHERE nombreDpto = 'VENTAS');

select *
from empleados e, departamentos d 
where e.codDepto=d.codDepto and lower(e.nomEmp) like 'm%' and (e.salEmp > 800000 or e.comisionE>0) 
and lower(d.nombreDpto) = 'ventas';

-- 24. Obtener los nombres, salarios y comisiones de los empleados que reciben un salario situado entre la mitad de la comisión y la propia comisión.
select nomEmp, salEmp, comisionE from empleados WHERE salEmp between (comisionE/2) and comisionE;




