create table Auto(
    nro_auto int primary key not null,
    patente varchar(20) not null,
    modelo varchar(40) not null,
    año int not null
);

create table Chofer(
    nro_chofer int primary key not null,
    nombre varchar(40) not null,
    fecha_ingreso date not null,
    telefono int not null
);

create table Cliente(
    nro_cliente int primary key not null,
    nombre varchar(40) not null,
    domicilio varchar(50) not null,
    localidad varchar(20) not null
);

create table Viaje(
    nro_chofer int not null,
    nro_cliente int not null,
    nro_auto int not null,
    fecha date not null,
    km_totales double not null,
    tiempo_espera time not null,
    primary key (nro_chofer, nro_cliente, nro_auto),
    foreign key (nro_chofer) references Chofer(nro_chofer),
    foreign key (nro_cliente) references Cliente(nro_cliente),
    foreign key (nro_auto) references Auto(nro_auto)
);

insert into Auto(nro_auto, patente, modelo, año) values 
(1, 'HSS 911', 'Palio', 2008), 
(2, 'JOB 820', 'Kangoo', 2010), 
(3, 'FDE 111', 'no se', 2012);

insert into Chofer(nro_chofer, nombre, fecha_ingreso, telefono) values
(10, 'Maria Candela', '2021-12-21', 1135791243),
(11, 'Horio Garcia', '2020-8-12', 1163821575),
(12, 'Lucas Manuel', '2014-3-23', 1157842578);

insert into Viaje(nro_chofer, nro_cliente, nro_auto, fecha, km_totales, tiempo_espera) values
(10, 90, 1, '2005-12-2', 900000.00, '12:46:11'),
(11, 91, 2, '2005-9-31', 1000000.00, '23:11:00'),
(12, 92, 3, '2005-1-15', 80000.00, '08:21:21');

insert into Cliente(nro_cliente, nombre, domicilio, localidad) values
(90, 'Mora Avalos', 'Iturri 912', 'Libertad'),
(91, 'Lara Caamano', 'Noguera 544', 'San Antonio De Padua'),
(92, 'Olivia Garcia', 'no se', 'Merlo');

/*1. Cuál es el tiempo de espera promedio de los viajes del año 2005?*/
select avg(v.tiempo_espera)
from Viaje v
where Year(v.fecha) = 2005;

/*2. Listar el nombre de los clientes que hayan viajado en todos los autos.*/
select c.nombre
from Cliente c
where not exists (select 1
                from Auto a
                where not exists (select 1
                                    from Viaje v
                                    where v.nro_cliente = c.nro_cliente
                                    and v.nro_auto = a.nro_auto));

/* 3.Listar nombre y teléfono de los choferes que no manejaron algún vehículo de
modelo posterior al año 2010. */
select c.nombre, c.telefono
from Chofer c join Viaje v on c.nro_chofer = v.nro_chofer
where not exists (select 1
                    from Auto a
                    where a.año > 2010
                    and a.nro_auto = v.nro_auto);

/* 4. Listar los kilómetros realizados en viajes por cada auto (patente y modelo)*/
select sum(v.km_totales)
from Viaje v join Auto a on v.nro_auto = a.nro_auto
group by a.patente, a.modelo;

/*5. Mostrar el el costo promedio de los viajes realizados por cada auto (patente), para
viajes de clientes de la localidad de Ramos Mejía*/
select avg(v.km_totales*v.tiempo_espera)
from Viaje v join Auto a on v.nro_auto = a.nro_auto
            join Cliente c on v.nro_cliente = c.nro_cliente
where c.localidad = 'Ramos Mejía'
group by a.patente

/*6.Listar el costo total de los viajes realizados por cada chofer (número y nombre)
cuyo nombre comienza con la letra A.*/
select sum(v.costo)
from Viaje v join Chofer ch on v.nro_chofer = ch.nro_chofer
where ch.nombre like 'A%'
group by ch.nro_chofer, ch.nombre

/*7. Mostrar la fecha de ingreso, el nombre del chofer y nombre de cliente, que hayan
realizado el viaje más largo de la historia.*/
select ch.fecha_ingreso, ch.nombre, cl.nombre, max(v.km_totales)
from Chofer ch join Viaje v on ch.nro_chofer = v.nro_chofer
                join Cliente cl on v.nro_cliente = cl.nro_cliente
group by ch.fecha_ingreso, ch.nombre, cl.nombre
having max(v.km_totales);
/*having max(v.km_totales) = (select max(v2.km_totales)
                                from Viaje v2)*/







