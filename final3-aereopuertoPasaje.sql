create table Pais(
    id_pais int primary key,
    nombre varchar(20) not null
);

create table Provincia(
    id_provincia int primary key,
    nombre varchar(20) not null
);

create table Aereopuerto(
    id_aereopuerto int primary key,
    nombre varchar(40) not null, 
    id_pais int not null, 
    id_provincia int not null,
    foreign key (id_pais) references Pais(id_pais),
    foreign key (id_provincia) references Provincia(id_provincia)
);

create table Vuelo(
    id_vuelo int primary key,
    fecha_hora datetime not null, 
    id_aereopuerto_origen int not null,
    id_aereopuerto_destino int not null,
    foreign key (id_aereopuerto_destino) references Aereopuerto(id_aereopuerto),
    foreign key (id_aereopuerto_origen) references Aereopuerto(id_aereopuerto)
);

create table Pasajero(
    id_pasajero int primary key,
    pasaporte int not null,
    nombre varchar(40) not null,
    fecha_nacimiento date not null,
    domicilio varchar(50) not null,
    id_pais int not null,
    id_provincia int not null,
    foreign key (id_pais) references Pais(id_pais),
    foreign key (id_provincia) references Provincia(id_provincia)
);

create table Pasaje(
    id_pasaje int primary key,
    ticket int not null,
    fecha_venta date not null,
    importe double not null,
    id_vuelo int not null,
    id_pasajero int not null,
    foreign key (id_vuelo) references Vuelo(id_vuelo),
    foreign key (id_pasajero) references Pasajero(id_pasajero)
);

insert into Pais(id_pais, nombre) values 
(001, 'Argentina'),
(002, 'Brasil');

insert into Provincia (id_provincia, nombre) values
(100, 'Buenos Aires'),
(101, 'Guarulhos');

insert into Aereopuerto(id_aereopuerto, nombre, id_pais, id_provincia) values
(500, 'Ezeiza', 001, 100),
(600, 'São Paulo-Guarulhos', 002, 101),
(700, 'Salvador de Bahìa', 002, 101);

insert into Vuelo(id_vuelo, fecha_hora, id_aereopuerto_origen, id_aereopuerto_destino) values
(333, '2012-12-12 11:46:10', 500, 600),
(334, '2021-07-18 09:12:00', 600, 700),
(335, '2020-12-25 07:21:05', 600, 700);

insert into Pasajero(id_pasajero, pasaporte, nombre, fecha_nacimiento, domicilio, id_pais, id_provincia) values
(202, 12345678, 'Manuel Caamano', '1999-02-06', 'Pedraza 544 S. A. Padua', 001, 100),
(203, 09376177, 'Graciela Caamano', '1953-10-07', 'Iturri 912', 001, 100);

insert into Pasaje(id_pasaje, ticket, fecha_venta, importe, id_vuelo, id_pasajero) values
(1, 4221, '2021-03-21', 10000.00, 335, 202),
(2, 7439, '2022-06-23', 47329.00, 334, 203);

/* Liste nombre y fecha de nacimiento de pasajeros que no volaron durante el año 2012.*/
select p.nombre, p.fecha_nacimiento
from Pasajero p join Pasaje pje on p.id_pasajero = pje.id_pasajero
where exists (select 1
                    from Vuelo v
                    where Year(v.fecha_hora) != 2012
                    and v.id_vuelo = pje.id_vuelo);

/* Liste nombre de los pasajeros que han comprado pasajes para todos los vuelos posibles*/
select p.nombre
from Pasajero p
where not exists (select 1
                from Vuelo v
                where not exists (select 1
                                from Pasaje pje
                                where pje.id_pasajero = p.id_pasajero
                                and pje.id_vuelo = v.id_vuelo));

/*otra forma*/
select p.nombre
from Pasajero p join Pasaje pje on pje.id_pasajero = p.id_pasajero
                join Vuelo v on pje.id_vuelo = v.id_vuelo
group by p.id_pasajero
having count(distinct pje.id_vuelo) = count(v.id_vuelo)
                                    /*(select count(*)
                                    from Vuelo v);*/

/* A todos los clientes que viajen desde el aeropuerto de nombre “Ezeiza” el día 18/07/2021,
se le deberá hacer una bonificación del 10% en el importe de todos los pasajes adquiridos.
Realice la modificación de datos correspondiente.*/
update Pasaje p
join Vuelo v on p.id_vuelo = v.id_vuelo
join Aereopuerto a on v.id_aereopuerto_origen = a.id_aereopuerto
set p.importe = p.importe * 0.1
where a.nombre = 'Ezeiza'
and v.fecha_hora = '2021-07-18';

/*Liste los nombres de pasajeros, junto a la suma total de los importes de los pasajes
comprados cuyo vuelo tiene como destino un aeropuerto de nombre “Salvador de bahía”*/
select p.nombre, sum(pje.importe)
from Pasajero p join Pasaje pje on p.id_pasajero = pje.id_pasajero
                join Vuelo v on pje.id_vuelo = v.id_vuelo
                join Aereopuerto a on v.id_aereopuerto_destino = a.id_aereopuerto
where a.nombre = 'Salvador de Bahìa'
group by p.nombre;

/*Cuántos pasajes se vendieron para vuelos dentro del mismo país?*/
/*NO CONFIO MUCHO EN ESTO*/
select count(psje.id_pasaje)
from Pasaje psje join Vuelo v on psje.id_vuelo = v.id_vuelo
            join Aereopuerto a on v.id_aereopuerto_origen = a.id_aereopuerto 
            join Pais p on p.id_pais = a.id_pais
where a.id_pais = p.id_pais
group by psje.id_pasaje;