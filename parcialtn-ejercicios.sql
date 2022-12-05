
CREATE TABLE Localidad(
	cod_localidad CHAR(5) PRIMARY KEY NOT NULL,
    descripcion VARCHAR(40) NOT NULL
);
CREATE TABLE Cliente(
	id_cliente CHAR(5) PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL, 
    fecha_nac DATE NOT NULL,
    cod_localidad CHAR(5) NOT NULL,
    FOREIGN KEY (cod_localidad) REFERENCES Localidad(cod_localidad)
);
CREATE TABLE Empleado(
	nro_empleado int primary key,
	cuil INT not NULL,
    nombre VARCHAR(40) NOT NULL,
    sueldo DECIMAL NOT NULL,
    cod_localidad CHAR(5) NOT NULL,
    FOREIGN KEY (cod_localidad) REFERENCES Localidad(cod_localidad)
);
CREATE TABLE Reparacion(
	nro_reparacion INT PRIMARY KEY NOT NULL,
    fecha DATE NOT NULL,
    importe DECIMAL NOT NULL,
    id_cliente CHAR(5) NOT NULL,
    nro_empleado INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (nro_empleado) REFERENCES Empleado(nro_empleado)
);
CREATE TABLE Proveedor(
    nro_proveedor int primary key not null,
	cuit INT NOT NULL,
    razon_social VARCHAR(40) NOT NULL,
    telefono INT NOT NULL
);
CREATE TABLE Insumo(
	nro_insumo INT PRIMARY KEY NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    costo DECIMAL NOT NULL,
    nro_proveedor INT NOT NULL,
    FOREIGN KEY (nro_proveedor) REFERENCES Proveedor(nro_proveedor)
);
CREATE TABLE Reparacion_Insumo(
	nro_reparacion INT NOT NULL,
    nro_insumo INT NOT NULL,
    CONSTRAINT pk_rep_ins PRIMARY KEY (nro_reparacion, nro_insumo),
    FOREIGN KEY (nro_reparacion) REFERENCES Reparacion(nro_reparacion),
    FOREIGN KEY (nro_insumo) REFERENCES Insumo(nro_insumo)
);

insert into Localidad(cod_localidad, descripcion) values 
(01, 'Merlo'),
(02, 'Libertad'),
(03, 'La Plata');

insert into Cliente(id_cliente, nombre, fecha_nac, cod_localidad) values
(50, 'Juan Perez', '2022-10-26', 01),
(51, 'Marta Garcia', '1988-04-21', 02),
(52, 'Marcelo Polino', '1981-03-15', 03);

insert into Empleado(nro_empleado, cuil, nombre, sueldo, cod_localidad) values
(60, 27916389, 'Pepe', 140000, 01),
(61, 25753578, 'Juan', 90000, 02),
(62, 56017597, 'Monica', 100000, 03);

insert into Reparacion(nro_reparacion, fecha, importe, id_cliente, nro_empleado) values
(30, '2022-11-23', 900.00, 50, 60),
(31, '2014-05-15', 1500.00, 51, 61),
(32, '2022-12-01', 2000.00, 52, 62);

insert into Proveedor(nro_proveedor, cuit, razon_social, telefono) values
(20, 23547891, 'no se', 1122528877),
(21, 87120976, 'no se 2', 1187628762),
(22, 08657576, 'no se 3', 1173616280);

insert into Insumo(nro_insumo, descripcion, costo, nro_proveedor) values
(90, 'jdskal', 500.00, 20),
(91, 'jdsalk', 1000.00, 21),
(92, 'hfnbkdsa', 50000.00, 22);

insert into Reparacion_Insumo(nro_reparacion, nro_insumo) values
(30, 90),
(31, 91),
(32, 92);


/*1. Agregar un nuevo cliente de nombre “Juan Perez”, id 15,
fecha de nacimiento 21 de mayo de 1956 y código de
localidad 34*/

insert into Cliente (id_cliente, nombre, fecha_nac, cod_localidad) values (15, 'Juan Perez', '1956-03-21', 34);

/*2. Indicar el nombre y sueldo de aquellos empleados que NO hayan realizado reparación alguna en todo el año
2014.*/
/*select e.nombre, e.sueldo
from Empleado e
where not exists (select 1
                    from Reparacion re
                    where re.nro_empleado = e.nro_empleado
                    and Year(re.fecha) = 2014);*/


/*3. Listar el nombre de aquellos clientes que hayan
efectuado más de 5 reparaciones superiores a $1000.*/
/*select c.nombre
from Cliente c
where exists (select 1
            from Reparacion re
            where c.id_cliente = re.id_cliente
            and re.importe = 1000
            group by re.nro_reparacion, c.nombre
            having count(*) > 5)*/


/*4. Listar las reparaciones realizadas en el año 2012. Por
cada una de ellas mostrar: fecha, importe, nombre de
cliente y descripción de su localidad y finalmente el
nombre del empleado que realizó la reparación. Ordenar
los resultados por fecha (las más recientes primero).*/

/*select re.fecha, re.importe, c.nombre, l.descripcion, e.nombre
from Reparacion re
join Cliente c on re.id_cliente = c.id_cliente
join Localidad l on c.cod_localidad = l.cod_localidad
join Empleado e on l.cod_localidad = e.cod_localidad
where Year(re.fecha) = 2012
order by re.fecha desc*/


/*5. Modificar los empleados que comienzan con la letra “A”
de manera que tengan el mismo sueldo del empleado
de CUIL 123456789*/

/*UPDATE Empleado e
SET e.sueldo = ( SELECT emp.sueldo
				FROM Empleado emp
                WHERE emp.cuil = '123456789')
WHERE e.nombre LIKE '%A';*/


/*6. Listar la descripción de aquellos insumos que se han
utilizado en todas las reparaciones.*/

/*select i.descripcion
from Insumo i
where not exists (select 1
                from Reparacion re
                where not exists (select 1
                                    from Reparacion_Insumo reIn
                                    where reIn.nro_insumo = i.nro_insumo
                                    and reIn.nro_reparacion = re.nro_reparacion))*/


/*7. Indicar el sueldo máximo de los empleados por cada
localidad (descripción).*/

/*select max(e.sueldo)
from Empleado e join Localidad l on e.cod_localidad = l.cod_localidad
group by l.descripcion*/

    
/*8. Eliminar a todas las reparaciones que se hayan efectuado
con un empleado que viva en “San Justo”*/

/*DELETE FROM Reparacion rep
    WHERE NOT EXISTS (
						SELECT 1
                        FROM Localidad loc
                        WHERE NOT EXISTS(
											SELECT 1 
                                            FROM Empleado emp
                                            WHERE loc.descripcion = 'San Justo'
                                            AND emp.nro_empleado = rep.nro_empleado
                                            AND emp.cod_localidad = loc.cod_localidad));*/
	

/*9. Agregar un campo nuevo a la tabla Proveedor, que
indique la localidad donde el mismo vive, utilizando el
tipo de dato y las restricciones de integridad que
correspondan.*/

ALTER TABLE Proveedor
    ADD COLUMN cod_localidad SMALLINT UNSIGNED;
    ALTER TABLE Proveedor
    ADD FOREIGN KEY(cod_localidad) REFERENCES Localidad(cod_localidad);
                                            


    

	


	
