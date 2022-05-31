USE parcialtn;
/*1. Agregar un nuevo cliente de nombre “Juan Perez”, id 15,
fecha de nacimiento 21 de mayo de 1956 y código de
localidad 34

	INSERT INTO Cliente(id, nombre, fecha_nac, cod_loc) VALUES(15, 'Juan Perez', '1956-05-21', 34);*/

/*2. Indicar el nombre y sueldo de aquellos empleados que NO hayan realizado reparación alguna en todo el año
2014.*/

	SELECT e.nombre, e.sueldo
	FROM Empleado e 
    WHERE NOT EXISTS (
						SELECT 1
                        FROM reparacion r 
                        WHERE fecha BETWEEN '2014-01-01' AND '2015-01-01'
                        AND r.cuil_empleado = e.cuil);
                        
/*3. Listar el nombre de aquellos clientes que hayan
efectuado más de 5 reparaciones superiores a $1000.*/
	SELECT clie.nombre
    FROM cliente clie
    WHERE clie.id IN (
						SELECT rep.id_cliente
                        FROM reparacion rep
                        WHERE rep.importe > 1000
                        GROUP BY rep.id_cliente, rep.importe
                        HAVING COUNT(*) > 5);
                        
/*4. Listar las reparaciones realizadas en el año 2012. Por
cada una de ellas mostrar: fecha, importe, nombre de
cliente y descripción de su localidad y finalmente el
nombre del empleado que realizó la reparación. Ordenar
los resultados por fecha (las más recientes primero).*/

	SELECT rep.fecha, rep.importe, clie.nombre, loc.descripcion, emp.nombre
    FROM Reparacion rep JOIN Cliente clie ON rep.id_cliente = clie.id
						JOIN Empleado emp ON emp.cuil = rep.cuil_empleado
                        JOIN Localidad loc ON emp.cod_loc = loc.cod
	WHERE rep.fecha BETWEEN '2012-01-01' AND '2013-01-01'
    ORDER BY rep.fecha DESC;

/*5. Modificar los empleados que comienzan con la letra “A”
de manera que tengan el mismo sueldo del empleado
de CUIL 123456789
	
    UPDATE Empleado e
    SET e.sueldo = (
					SELECT emp.sueldo
					FROM Empleado emp
                    WHERE emp.cuil = '123456789')
	WHERE e.nombre LIKE '%A';*/

/*Listar la descripción de aquellos insumos que se han
utilizado en todas las reparaciones.*/

	SELECT ins.descripcion
    FROM Insumo ins
    WHERE NOT EXISTS ( 
					SELECT 1
                    FROM Reparacion rep
                    WHERE NOT EXISTS(
									SELECT 1
                                    FROM Reparacion_Insumo ri
                                    WHERE ri.nro_reparacion = rep.nro
                                    AND ri.nro_reparacion = ins.nro));
                                    
/*7. Indicar el sueldo máximo de los empleados por cada
localidad (descripción).*/

	SELECT MAX(emp.sueldo), loc.descripcion
    FROM empleado emp JOIN localidad loc ON emp.cod_loc = loc.cod
    GROUP BY loc.cod, loc.descripcion;
    
/*Eliminar a todas las reparaciones que se hayan efectuado
con un empleado que viva en “San Justo”
	
    DELETE FROM Reparacion rep
    WHERE NOT EXISTS (
						SELECT 1
                        FROM Localidad loc
                        WHERE NOT EXISTS(
											SELECT 1 
                                            FROM Empleado emp
                                            WHERE loc.descripcion = 'San Justo'
                                            AND emp.cuil = rep.cuil_empleado
                                            AND emp.cod_loc = loc.cod));*/
									
/*Agregar un campo nuevo a la tabla Proveedor, que
indique la localidad donde el mismo vive, utilizando el
tipo de dato y las restricciones de integridad que
correspondan.*/

	ALTER TABLE Proveedor
    ADD COLUMN cod_loc SMALLINT UNSIGNED;
    ALTER TABLE Proveedor
    ADD FOREIGN KEY(cod_loc) REFERENCES Localidad(cod);
                                            


    

	


	
