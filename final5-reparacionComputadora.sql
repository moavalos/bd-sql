create table Marca(
    id_marca int primary key,
    descripcion varchar(40) not null
);

create table Sistema_operativo(
    id_sistema_operativo int primary key,
    descripcion varchar(40) not null
);

create table Provincia(
    id_provincia int primary key,
    nombre varchar(40) not null
);

create table Cliente(
    id_cliente int primary key,
    nombre varchar(20) not null,
    telefono varchar(20) not null,
    domicilio varchar(30) not null,
    localidad varchar(20) not null,
    id_provincia int not null,
    foreign key (id_provincia) references Provincia(id_provincia)
);

create Table Computadora(
    id_computadora int primary key,
    nro_serie int not null,
    id_marca int not null,
    id_sistema_operativo int not null,
    id_cliente int not null,
    foreign key (id_marca) references Marca(id_marca),
    foreign key (id_sistema_operativo) references Sistema_operativo(id_sistema_operativo),
    foreign key (id_cliente) references Cliente(id_cliente)
);

create table Tecnico(
    id_tecnico int primary key,
    nro_doc int not null,
    tipo_doc varchar(10) not null,
    nombre varchar(40) not null,
    sueldo double not null
);

create table Reparacion(
    id_reparacion int primary key not null,
    fecha date not null,
    costo double not null,
    id_computadora int not null,
    id_tecnico int,
    foreign key (id_computadora) references Computadora(id_computadora),
    foreign key (id_tecnico) references Tecnico(id_tecnico)
);

create table Especializacion(
    id_especializacion int primary key not null,
    descripcion varchar(40) not null
);

create table Posee(
    id_especializacion int not null,
    id_tecnico int not null,
    constraint id_tec_esp primary key (id_especializacion, id_tecnico),
    foreign key (id_especializacion) references Especializacion(id_especializacion),
    foreign key (id_tecnico) references Tecnico(id_tecnico)
);

insert into Marca(id_marca, descripcion) values 
(150, 'ASUS'),
(151, 'Lenovo'),
(152, 'Apple');

insert into Sistema_operativo(id_sistema_operativo, descripcion) values
(500, 'Windows'),
(501, 'Lnux'),
(502, 'OSX');

insert into Provincia(id_provincia, nombre) values 
(333, 'Buenos Aires'),
(334, 'Cordoba'),
(335, 'Entre Rios');

insert into Cliente(id_cliente, nombre, telefono, domicilio, localidad, id_provincia) values 
(230, 'Graciela', '+5491134510987', 'Noguera 544', 'Merlo', 333),
(231, 'Nicolas', '+5491112983476', 'Banana 123', 'Ituzaigó', 334),
(232, 'Manuela', '+5491109218765', 'no se 432', 'Pepino', 335);

insert into Computadora(id_computadora, nro_serie, id_marca, id_sistema_operativo, id_cliente) values 
(3030, 00, 150, 500, 230),
(3040, 10, 151, 501, 231),
(3050, 2, 152, 502, 232);

insert into Tecnico(id_tecnico, nro_doc, tipo_doc, nombre, sueldo) values 
(9, 44318877, 'DNI', 'Mora', 30000.00),
(10, 45871289, 'Pasaporte', 'Pepe', 1500.00),
(11, 54120987, 'DNI', 'Juana', 0.00);

insert into Reparacion(id_reparacion, fecha, costo, id_computadora, id_tecnico) values 
(0, '2013-12-24', 300.00, 3030, 09),
(1, '2014-05-16', 1500.00, 3040, 10),
(2, '2014-10-01', 2000.00, 3050, 11);

insert into Especializacion(id_especializacion, descripcion) values 
(20, 'Hardware'),
(21, 'Software'),
(22, 'Ensamblado'),
(23, 'Diagnóstico');

insert into Posee(id_especializacion, id_tecnico) values 
(20, 9),
(21, 10),
(22, 11),
(23, 9);

/*Listar el nombre y sueldo de todos los técnicos que no hayan efectuado reparación alguna*/

select t.nombre, t.sueldo
from Tecnico t join Reparacion r on r.id_tecnico = t.id_tecnico
where r.id_tecnico is null;

/*Listar el número de serie y cantidad de reparaciones efectuadas durante el año 2013*/

/*no me anda el having*/
select c.nro_serie, count(r.id_reparacion)
from Computadora c join Reparacion r on c.id_computadora = r.id_computadora
/*group by c.id_computadora
having Year(r.fecha) = 2013*/
where Year(r.fecha) = 2013
group by c.id_computadora, r.id_reparacion;

/*Mostrar el número de serie y modelo, de aquellas computadoras que fueron reparadas por
todos los técnicos.*/

select c.nro_serie, m.descripcion
from Computadora c join Reparacion r on r.id_computadora = c.id_computadora
                    join Tecnico t on r.id_tecnico = t.id_tecnico
                    join Marca m on c.id_marca = m.id_marca
group by c.nro_serie, m.descripcion
having count(distinct r.id_tecnico) = (select count(*)
                                    from Tecnico);

/*Efectuar un reporte de reparaciones del mes de enero de 2014, indicando por cada una de
ellas: fecha de reparación, número de serie, sistema operativo, nombre de cliente, nombre de
localidad donde vive, nombre del técnico y costo de reparación*/

select re.fecha, re.costo, c.nro_serie, c.id_sistema_operativo, cl.nombre as 'nombre cliente', cl.localidad as 'localidad cliente', t.nombre as 'nombre tecnico'
from Cliente cl join Computadora c on cl.id_cliente = c.id_cliente
                join Reparacion re on re.id_computadora = c.id_computadora
                join Tecnico t on t.id_tecnico = re.id_tecnico
where Year(re.fecha) = 2014
group by re.id_reparacion, re.fecha, re.costo, c.nro_serie, c.id_sistema_operativo, cl.nombre, cl.localidad, t.nombre;

/*Indicar el costo promedio de reparación por localidad de cliente (mostrar la descripción de la
localidad)*/

select avg(re.costo), cl.localidad
from Reparacion re left join Computadora c on re.id_computadora = c.id_computadora
                        join Cliente cl on c.id_cliente = cl.id_cliente
group by cl.localidad;