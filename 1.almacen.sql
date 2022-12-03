create table Almacen(
    nro int primary key not null,
    nombre varchar(40) not null,
    responsable varchar(40) not null
);

create table Articulo(
    cod_art int primary key not null,
    descripcion varchar(40) not null,
    precio double not null
);

create table Material(
    cod_mat int primary key not null,
    descripcion varchar(40) not null
);

create table Ciudad(
    cod_ciu int primary key not null,
    nombre varchar(40) not null
);

create table Proveedor(
    cod_prov int primary key,
    nombre varchar(40) not null,
    domicilio varchar(100) not null,
    cod_ciu int not null,
    fecha_alta date not null,
    foreign key (cod_ciu) references Ciudad(cod_ciu)
);

create table Contiene(
    nro int not null,
    cod_art int not null,
    primary key (nro, cod_art),
    foreign key (nro) references Almacen(nro),
    foreign key (cod_art) references Articulo(cod_art)
);

create table Compuesto_por(
    cod_art int not null,
    cod_mat int not null,
    primary key (cod_art, cod_mat),
    foreign key (cod_art) references Articulo(cod_art),
    foreign key (cod_mat) references Material(cod_mat)
); 

create table Provisto_por(
    cod_mat int not null,
    cod_prov int not null,
    primary key(cod_mat, cod_prov),
    foreign key (cod_mat) references Material(cod_mat),
    foreign key (cod_prov) references Proveedor(cod_prov)
);

 INSERT INTO Almacen (nro, responsable, nombre) VALUES (34,'Martín Gómez', 'Superchino');
 INSERT INTO Almacen (nro, responsable, nombre) VALUES (2,'Pedrita Garcia', 'Aromos');
 INSERT INTO Almacen (nro, responsable, nombre) VALUES (1,'Martin Sanchez', 'Tostaditas');

INSERT INTO Articulo (cod_art, descripcion, precio) VALUES (5, 'Limpieza', 400);
INSERT INTO Articulo (cod_art, descripcion, precio) VALUES (1, 'Cocina', 100);
INSERT INTO Articulo (cod_art, descripcion, precio) VALUES (6, 'Coche', 250);
INSERT INTO Articulo (cod_art, descripcion, precio) VALUES (3, 'Arroz', 550);
INSERT INTO Articulo (cod_art, descripcion, precio) VALUES (9, 'A', 2550);

INSERT INTO Material (cod_mat, descripcion) VALUES (3, 'no se');
INSERT INTO Material (cod_mat, descripcion) VALUES (7, 'no se 1');
INSERT INTO Material (cod_mat, descripcion) VALUES (9, 'no se 2');

INSERT INTO Ciudad (cod_ciu, nombre) VALUES (45, 'La Plata');
INSERT INTO Ciudad (cod_ciu, nombre) VALUES (41, 'Rosario');
INSERT INTO Ciudad (cod_ciu, nombre) VALUES (15, 'Santa fe');
INSERT INTO Ciudad (cod_ciu, nombre) VALUES (99, 'Zárate');
INSERT INTO Ciudad (cod_ciu, nombre) VALUES (32, 'Capital federal');

INSERT INTO Proveedor (cod_prov, nombre, domicilio, cod_ciu, fecha_alta) VALUES (5, 'Juan Pablo', 'Pedraza 544', 45, '2001-10-26');
INSERT INTO Proveedor (cod_prov, nombre, domicilio, cod_ciu, fecha_alta) VALUES (12, 'Agustin Riquelme', 'Acacias 1065', 99, '2010-2-10');
INSERT INTO Proveedor (cod_prov, nombre, domicilio, cod_ciu, fecha_alta) VALUES (21, 'Victoria Piola', 'Iturri 912', 15, '1999-5-31');
INSERT INTO Proveedor (cod_prov, nombre, domicilio, cod_ciu, fecha_alta) VALUES (41, 'Facundo Avalos', 'Noguera 942', 32, '2001-9-11');

INSERT INTO Contiene(nro, cod_art) VALUES (34,5);
INSERT INTO Contiene(nro, cod_art) VALUES (2,1);
INSERT INTO Contiene(nro, cod_art) VALUES (1,9);

INSERT INTO Compuesto_por(cod_art, cod_mat) VALUES (5,3);
INSERT INTO Compuesto_por(cod_art, cod_mat) VALUES (1,7);
INSERT INTO Compuesto_por(cod_art, cod_mat) VALUES (6,9);

INSERT INTO Provisto_por(cod_mat, cod_prov) VALUES (3,12);
INSERT INTO Provisto_por(cod_mat, cod_prov) VALUES (7,5);
INSERT INTO Provisto_por(cod_mat, cod_prov) VALUES (9,41);

/*1. Listar los números de artículos cuyo precio se encuentre entre $100 y $1000 y su
descripción comience con la letra A.*/
/*select cod_art
from Articulo 
where precio between 100 and 1000
and descripcion like 'A%';*/

/*2. Listar todos los datos de todos los proveedores.*/
/*select *
from Proveedor;*/

/*3. Listar la descripción de los materiales de código 1, 3, 6, 9 y 18.*/
/*select descripcion
from Material
where cod_mat IN (1,3,6,9,18);*/

/*4. Listar código y nombre de proveedores de la calle Suipacha, que hayan sido dados
de alta en el año 2001*/
/*select cod_prov, nombre
from Proveedor
where domicilio like '%Suipacha%'
and fecha_alta >= '2001-01-01' and '2002-01-01'*/

/*5. Listar nombre de todos los proveedores y de su ciudad.*/
/*select p.nombre as proveedor", c.nombre as "ciudad"
from Proveedor p left join Ciudad c on p.cod_ciu = c.cod_ciu*/

/*6. Listar los nombres de los proveedores de la ciudad de La Plata.*/
/*select p.nombre
from Proveedor p left join Ciudad c on p.cod_ciu = c.cod_ciu
where c.nombre = 'La Plata'*/

/*7. Listar los números de almacenes que almacenan el artículo de descripción A.*/
/*select distinct c.nro
from Contiene c join Articulo art on c.cod_art = art.cod_art
where art.descripcion = 'A';*/

/*8.Listar los materiales (código y descripción) provistos por proveedores de la ciudad
de Rosario*/
/*select distinct mat.cod_mat, mat.descripcion
from Material mat join Provisto_por pp on mat.cod_mat = pp.cod_mat 
                join Proveedor p on p.cod_prov = pp.cod_prov
                join Ciudad c on c.cod_ciu = p.cod_ciu
where c.nombre = "Rosario"*/

/*9. Listar los nombres de los proveedores que proveen materiales para artículos
ubicados en almacenes que Martín Gómez tiene a su cargo.*/
/*select p.nombre
from Proveedor p join Provisto_por pp on p.cod_prov = pp.cod_prov
                join Compuesto_por cp on cp.cod_mat = pp.cod_mat
                join Contiene c on c.cod_art = cp.cod_art
                join Almacen a on a.nro = c.nro
where a.responsable = "Martín Gómez"*/

/*12. Indicar la cantidad de proveedores que comienzan con la letra F*/
/*select count(cod_prov)
from Proveedor
where nombre like 'F%'*/

/*13. Listar el promedio de precios de los artículos por cada almacén (nombre)*/
/*select avg(art.precio) as "promedio de precios", a.nombre
from Articulo art join Contiene c on art.cod_art = c.cod_art
                join Almacen a on a.nro = c.nro
group by a.nombre*/

/*14. Listar la descripción de artículos compuestos por al menos 2 materiales*/
 /*select art.descripcion
 from Articulo art join Compuesto_por cp on art.cod_art = cp.cod_art
 group by art.descripcion, art.cod_art
 having count(*) >= 2*/
 
/*15. Listar cantidad de materiales que provee cada proveedor (código, nombre y
domicilio)*/
/*select count(pp.cod_mat) as "cantidad de materiales", p.cod_prov, p.nombre, p.domicilio
from Provisto_por pp join Proveedor p on p.cod_prov = pp.cod_prov
group by p.cod_prov, p.nombre, p.domicilio*/

/*16. Cuál es el precio máximo de los artículos que proveen los proveedores de la ciudad
de Zárate.*/
/*select max(art.precio) as "Precio maximo"
from Articulo art join Compuesto_por cp on art.cod_art = cp.cod_art
                join Provisto_por pp on pp.cod_mat = cp.cod_mat
                join Proveedor p on p.cod_prov = pp.cod_prov
                join Ciudad c on c.cod_ciu = p.cod_ciu
where c.nombre = "Zárate"*/

/*17. Listar los nombres de aquellos proveedores que no proveen ningún material.*/
/*select p.nombre
from Proveedor p left join Provisto_por pp on p.cod_prov = pp.cod_prov
where pp.cod_prov is null*/

/*SELECT prov.nombre
    FROM proveedor prov 
    WHERE NOT EXISTS (SELECT 1 
						FROM provisto_por pp
                        WHERE pp.cod_prov = prov.cod_prov);*/

/*18.Listar los códigos de los materiales que provea el proveedor 10 y no los provea el
proveedor 15. */
/*select m.cod_mat
from Material m
where exists (select 1
                from Provisto_por pp
                where m.cod_mat = pp.cod_mat
                and pp.cod_prov = 10)
and not exists ( select 1
                from Provisto_por pp2
                where m.cod_mat = pp2.cod_mat
                and pp2.cod_prov = 15);*/

/*19. Listar número y nombre de almacenes que contienen los artículos de descripción A
y los de descripción B (ambos).*/
/*select a.nro, a.nombre
from Almacen a 
where exists (select 1 
             from Contiene c join Articulo art on art.cod_art = c.cod_art
             where a.nro = c.nro 
             and art.descripcion = 'A')
and exists (select 1 
             from Contiene c2 join Articulo art2 on art2.cod_art = c2.cod_art
             where a.nro = c2.nro 
             and art2.descripcion = 'A')*/

/*20. Listar la descripción de artículos compuestos por todos los materiales.*/
/*select a.descripcion
from Articulo a 
where not exists(select 1
                from Material m
                where not exists(select 1
                                from Compuesto_por cp
                                where cp.cod_art = a.cod_art
                                and cp.cod_mat = m.cod_mat))*/

/*21. Hallar los códigos y nombres de los proveedores que proveen al menos un material
que se usa en algún artículo cuyo precio es mayor a $100.*/
/*select p.cod_prov, p.nombre
from Proveedor p 
where exists( select 1
            from Provisto_por pp join Compuesto_por cp on cp.cod_mat = pp.cod_mat
                                join Articulo art on art.cod_art = cp.cod_art
            where p.cod_prov = pp.cod_prov
            and art.precio > 100)*/

/*22. Listar la descripción de los artículos de mayor precio*/
/*select a.descripcion
from Articulo a
where precio = (select max(a2.precio)
                from Articulo a2)*/

/*23. Listar los nombres de proveedores de Capital Federal que sean únicos
proveedores de algún material.*/
/*select distinct p.nombre
from Proveedor p join Ciudad c on p.cod_ciu = c.cod_ciu
                join Provisto_por pp on pp.cod_prov = p.cod_prov
where c.nombre = 'Capital federal' 
and exists ( select pp2.cod_mat
                        from Provisto_por pp2
                        group by pp2.cod_mat
                        having count(*) = 1);*/

/*24. Listar los nombres de almacenes que almacenan la mayor cantidad de artículos*/
/*select a.nombre
from Almacen a join Contiene c on c.nro = a.nro
group by a.nro, a.nombre
having count(*) = (select  max(nroAlm, cantArt)
                    from (select count(*) as cantArt
                            from Contiene c2
                            group by c2.nro as nroAlm))*/

/*25. Listar la ciudades donde existan proveedores que proveen todos los materiales.*/
/*select c.nombre, c.cod_ciu
from Proveedor p join Ciudad c on c.cod_ciu = p.cod_ciu
where not exists (select 1
                    from Material mat
                    where not exists(select 1
                                        from Provisto_por pp 
                                        where p.cod_prov = pp.cod_prov
                                        and pp.cod_mat = mat.cod_mat))*/

/*26. Listar los números de almacenes que tienen todos los artículos que incluyen el
material con código 123.*/
/*select a.nro
from Almacen a
where not exists (select 1
                from Articulo art join Compuesto_por cp on art.cod_art = cp.cod_art
                where cp.cod_mat = 123
                and not exists (select 1
                                from Contiene c 
                                where c.nro = a.nro
                                and c.cod_art = art.cod_art))*/