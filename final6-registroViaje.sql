create table Marca(
    id_marca int primary key not null,
    descripcion varchar(40) not null
);

create table Tipo(
    id_tipo int primary key not null,
    descripcion varchar(40) not null
);

create table Vehiculo(
    id_vehiculo int primary key not null,
    patente varchar(15) unique,
    capacidad int not null,
    id_marca int not null,
    id_tipo int not null,
    foreign key (id_marca) references Marca(id_marca),
    foreign key (id_tipo) references Tipo(id_tipo)
);

create table Chofer(
    id_chofer int primary key,
    documento long not null,
    nombre varchar(40) not null,
    sueldo double not null
);

create table Cliente(
    id_cliente int primary key,
    nombre varchar(40) not null
);

create table Registro(
    id_registro int primary key,
    importe decimal not null,
    kilometros double not null,
    fecha date not null,
    origen varchar(30) not null,
    destino varchar(30) not null,
    id_vehiculo int not null,
    id_chofer int not null,
    id_cliente int not null,
    foreign key (id_vehiculo) references Vehiculo(id_vehiculo),
    foreign key (id_chofer) references Chofer(id_chofer),
    foreign key (id_cliente) references Cliente(id_cliente)
);

create table Particular(
    id_cliente int primary key not null,
    mail varchar(40) not null,
    f_nacimiento date not null,
    foreign key (id_cliente) references Cliente(id_cliente)
);

create table Empresa(
    id_cliente int primary key not null,
    cuit long not null,
    foreign key (id_cliente) references Cliente(id_cliente)
);

create table Telefono (
    id_telefono int primary key not null,
    numero varchar(30) not null,
    id_cliente int not null,
    foreign key (id_cliente) references Cliente(id_cliente)
);


insert into Marca(id_marca, descripcion) values 
(555, 'Ford'),
(556, 'Fiat'),
(557, 'Chevrolet');

insert into Tipo(id_tipo, descripcion) values 
(100, 'Sedan'),
(101, 'Camioneta'),
(102, 'Limousine');

insert into Vehiculo(id_vehiculo, patente, capacidad, id_marca, id_tipo) values
(50, 'HSS 911', 5, 556, 100),
(51, 'JOB 890', 7, 555, 101),
(52, 'FDE 561', 4, 557, 102);

insert into Chofer(id_chofer, documento, nombre, sueldo) values
(90, 44318877, 'Mora', 10000.00),
(91, 85403885, 'Horacio', 50000.00),
(92, 43204839, 'Manuel', 21000.00);

insert into Cliente(id_cliente, nombre) values
(20, 'Graciela'),
(21, 'Lara'),
(22, 'Franco');

insert into Registro(id_registro, importe, kilometros, fecha, origen, destino, id_vehiculo, id_chofer, id_cliente) values
-- (1, 500.00, 200.00, '2022-12-14', 'Merlo', 'Ituzaigo', 50, 90, 20),
(2, 5804.00, 49304.00, '2016-10-12', 'jdla', 'jdla', 51, 91, 21),
(3, 4639.00, 47329.00, '2021-09-21', 'djkw', 'djewl', 50, 92, 22),
(4, 4639.00, 47329.00, '2021-09-21', 'djkw', 'djewl', 51, 92, 22),
(5, 4639.00, 47329.00, '2021-09-21', 'djkw', 'djewl', 52, 92, 22),
(6, 4639.00, 47329.00, '2021-09-21', 'djkw', 'djewl', 52, 92, 22),
(7, 4639.00, 47329.00, '2016-09-21', 'djkw', 'djewl', 52, 92, 22);

/*Mostrar el nombre y sueldo de aquellos choferes que no hayan realizado viaje alguno
durante el año 2016*/

select ch.id_chofer,ch.nombre, ch.sueldo
        from Chofer ch 
        where ch.id_chofer not in 
                                    (
                                        select id_chofer from Registro where Year(fecha)=2016
                                    )


/*Listar el total recorrido por cada vehículo, mostrando por cada uno de ellos la patente, marca
y total de kilómetros de todos los viajes. Sólo mostrar aquellos vehículos que han recorrido
un total superior a los 25.000 km.*/

select r.id_vehiculo,v.patente,m.descripcion marca, sum(r.kilometros)	 totalKM 
from Registro r join Vehiculo v  on r.id_vehiculo=v.id_vehiculo
join Marca m on v.id_marca =m.id_marca
group by   r.id_vehiculo,v.patente,m.descripcion
having sum(r.kilometros) >= 25000


/*
 Indicar el nombre de los choferes que manejaron todos los vehículos de la flota
 */

/*TRES FORMAS DISTINTAS DE HACER LO MISMO (hay una 4ta pero es una verga)*/
 
 select *
 from ( 
        select c.id_chofer, (select count( distinct id_vehiculo) 
                            from Registro 
                            where id_chofer=c.id_chofer
                            ) CantidadDeVehiculos
        from Chofer c
        group by c.id_chofer 
        )a  
 where a.CantidadDeVehiculos = (select count(id_vehiculo) from Vehiculo)
 

 select c.id_chofer
 from Chofer c
 where  (select count( distinct id_vehiculo) 
        from Registro 
        where id_chofer=c.id_chofer) = (select count(id_vehiculo) 
                                        from Vehiculo)
 group by c.id_chofer 
 

 select c.id_chofer
 from Chofer c
 join  Registro r where r.id_chofer=c.id_chofer
 group by c.id_chofer 
 having count( distinct id_vehiculo) = (select count(id_vehiculo) from Vehiculo)
 
 /*Por un error de carga, todos los viajes realizados el día 21/01/2016 por el chofer “Alvaro
Gomez” con el vehículo de patente AAA333, deben ser movidos al día 22/01/2016*/

update Registro re join Chofer ch on ch.id_chofer = re.id_chofer
                join Vehiculo v on v.id_vehiculo = re.id_vehiculo
set re.fecha = '2016-01-22'
where re.fecha = '2016-01-22'
and ch.nombre = 'Alvaro Gomez'
and v.patente = 'AAA333'

/*Realizar una lista de todos los viajes realizados el mes de octubre de 2016, donde el
pasajero haya viajado a la misma localidad de donde partió. Por cada viaje indicar: fecha,
importe, kilometros, nombre del chofer, patente, tipo y marca del vehículo, nombre y teléfono
del cliente.*/

select re.fecha, re.importe, re.kilometros, ch.nombre, v.patente, v.id_tipo, v.id_marca, cl.nombre, cl.teléfono
from Registro re join Chofer ch on re.id_chofer = ch.id_chofer
                join Vehiculo v on re.id_vehiculo = v.id_vehiculo
                join Cliente cl on re.id_cliente = cl.id_cliente
where Month(re.fecha) = 10
and Year(re.fecha) = 2016
and re.origen = re.destino