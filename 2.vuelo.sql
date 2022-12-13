create table Avion(
    nro_avion int primary key not null,
    tipo_avion varchar(40) not null,
    modelo varchar(40) not null
);

create table Vuelo(
    nro_vuelo int primary key not null,
    desde varchar(40) not null,
    hasta varchar(40) not null,
    fecha date not null,
    nro_avion int not null,
    foreign key (nro_avion) references Avion(nro_avion)
);

create table Pasajero(
    nro_vuelo int not null,
    documento int not null,
    nombre varchar(50) not null,
    primary key(nro_vuelo, documento),
    foreign key (nro_vuelo) references Vuelo(nro_vuelo)
);

insert into Vuelo(nro_vuelo, desde, hasta, fecha, nro_avion) values (15, 'A', 'F', '2021-03-15', 22);
insert into Vuelo(nro_vuelo, desde, hasta, fecha, nro_avion) values (03, 'A', 'F', '2021-11-21', 99);
insert into Vuelo(nro_vuelo, desde, hasta, fecha, nro_avion) values (95, 'A', 'D', '2022-01-31', 65);
insert into Vuelo(nro_vuelo, desde, hasta, fecha, nro_avion) values (21, 'A', 'D', '2022-05-01', 5);
insert into Vuelo(nro_vuelo, desde, hasta, fecha, nro_avion) values (50, 'C', 'B', '2021-12-25', 10);
insert into Vuelo(nro_vuelo, desde, hasta, fecha, nro_avion) values (20, 'C', 'H', '2021-11-18', 10);

insert into Avion(nro_avion, tipo_avion, modelo) values (5, 'avion de guerra', 'no se');
insert into Avion(nro_avion, tipo_avion, modelo) values (10, 'avion normal', 'jgkfdlsñ');
insert into Avion(nro_avion, tipo_avion, modelo) values (99, 'avion boludo', 'B-777');
insert into Avion(nro_avion, tipo_avion, modelo) values (22, 'avion de papel', 'B-777');

insert into Pasajero(nro_vuelo, documento, nombre) values (15, 44318877, 'Mora Melina Avalos');
insert into Pasajero(nro_vuelo, documento, nombre) values (15, 99418855, 'Susana Gimenez');
insert into Pasajero(nro_vuelo, documento, nombre) values (15, 89312689, 'Pedro Alfonso');
insert into Pasajero(nro_vuelo, documento, nombre) values (20, 93151789, 'Pepito tonto');

/*1.Hallar los números de vuelo desde el origen A hasta el destino F*/
select nro_vuelo
from Vuelo v
where desde = 'A'
and hasta = 'F'

/*2. Hallar los nombres de pasajeros y números de vuelo para aquellos pasajeros que
viajan desde A a D.*/
select p.nombre, v.nro_vuelo
from Vuelo v join Pasajero p on v.nro_vuelo = p.nro_vuelo
where v.desde = 'A'
and v.hasta = 'D';

/*3. Hallar los tipos de avión para vuelos que parten desde C*/
select a.tipo_avion
from Avion a left join Vuelo v on a.nro_avion = v.nro_avion
where v.desde = 'C';

/*4. Listar los distintos tipo y nro. de avión que tienen a H como destino.*/
select a.tipo_avion, a.nro_avion
from Avion a left join Vuelo v on a.nro_avion = v.nro_avion
where v.hasta = 'H';

/*5. Mostrar por cada Avión (número y modelo) la cantidad de vuelos en que se
encuentra registrado.*/
select count(v.nro_avion), a.nro_avion, a.modelo
from Vuelo v join Avion a on v.nro_avion = a.nro_avion
group by a.nro_avion, a.modelo

/*6. Cuántos pasajeros diferentes han volado en un avión de modelo ‘B-777’*/
select distinct count(p.documento)
from Pasajero p join Vuelo v on p.nro_vuelo = v.nro_vuelo
                join Avion a on a.nro_avion = v.nro_avion
where a.modelo = 'B-777'
group by p.nombre, v.nro_vuelo /*NO ENTIENDO PORQUE TRAE 1 SI SON 3*/

/*7. Listar la cantidad promedio de pasajeros transportados por los aviones de la
compañía, por tipo de avión.*/
select count(avg(p.documento))
from Pasajero p join Vuelo v on p.nro_vuelo = v.nro_vuelo
                join Avion a on a.nro_avion = v.nro_avion
group by a.tipo_avion, v.nro_avion

/*8. Hallar los tipos de avión que no son utilizados en algún vuelo que pase por B.*/
select a.tipo_avion
from Avion a
where not exists (select 1
                    from Vuelo v
                    where v.nro_avion = a.nro_avion
                    and v.hasta = 'B');