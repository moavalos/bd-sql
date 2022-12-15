create table Marca(
    id_marca int primary key not null,
    descripcion varchar(40) not null
);

create table Tipo(
    id_tipo int primary key not null,
    descripcion varchar(40) not null
);

create table Estado(
    id_estado int primary key not null,
    descripcion varchar(40) not null
);

create table Vehiculo(
    id_vehiculo int primary key not null,
    patente varchar(20) not null,
    año_patentamiento int not null,
    cant_plazas int not null,
    id_marca int not null,
    id_tipo int not null,
    id_estado int not null,
    foreign key (id_marca) references Marca(id_marca),
    foreign key (id_tipo) references Tipo(id_tipo),
    foreign key (id_estado) references Estado(id_estado)
);

create table Cliente(
    id_cliente int primary key not null,
    nombre varchar(40) not null,
    mail varchar(40) not null,
    domicilio varchar(40) not null,
    provincia varchar(40) not null,
    pais varchar(40) not null
);

create table Telefono(
    id_telefono int primary key not null,
    id_cliente int not null,
    telefono varchar(30) not null,
    foreign key (id_cliente) references Cliente(id_cliente)
);

create table Particular(
    id_cliente int primary key not null,
    fecha_nacimiento date not null,
    foreign key (id_cliente) references Cliente(id_cliente)
);

create table Empresa(
    id_cliente int primary key not null,
    cuit decimal not null,
    rubro varchar(30) not null,
    foreign key (id_cliente) references Cliente(id_cliente)
);

create table Alquiler(
    id_alquiler int primary key not null,
    fecha date not null,
    dias_de_alquiler int not null,
    importe decimal not null,
    seguro varchar(20) not null,
    id_cliente int not null,
    id_vehiculo int not null,
    foreign key (id_cliente) references Cliente(id_cliente),
    foreign key (id_vehiculo) references Vehiculo(id_vehiculo)
);

insert into Marca(id_marca, descripcion) values (00, 'Fiat');

insert into Tipo(id_tipo, descripcion) values (000, 'Sedan');

insert into Estado(id_estado, descripcion) values (01, 'Bueno');

insert into Vehiculo(id_vehiculo, patente, año_patentamiento, cant_plazas, id_marca, id_tipo, id_estado) values (999, 'HSS 912', 2017, 5, 00, 000, 01);

insert into Cliente(id_cliente, nombre, mail, domicilio, provincia, pais) values (40, 'Juan', 'juan123@hotmail.com', 'Pedraza 544', 'Buenos Aires', 'Argentina');

insert into Telefono(id_telefono, id_cliente, telefono) values (500, 40, '+5491122528877');

insert into Particular(id_cliente, fecha_nacimiento) values(40, '2002-10-26');

insert into Empresa(id_cliente, cuit, rubro) values(89, 24663215, 'no se');

insert into Alquiler(id_alquiler, fecha, dias_de_alquiler, importe, seguro, id_cliente, id_vehiculo) values (111, '2014-11-22', 10, 500000.00, 'jelw', 40, 9999);

/*Liste nombre de clientes que no realizaron alquiler alguno durante el año 2014*/
select c.nombre
from Cliente c 
where not exists (select 1
                from Alquiler a
                where a.id_alquiler = c.id_cliente
                and Year(a.fecha) = 2014);

/* Liste los nombres de clientes del país “Brasil”, junto al importe total de todos los
alquileres efectuados al mismo*/
select c.nombre, sum(a.importe)
from Cliente c join Alquiler a on c.id_cliente = a.id_cliente
where c.pais = 'Brasil'
group by c.nombre;

/*Crear un listado de los alquileres realizados durante el año 2015. Por cada alquiler,
detallar: fecha de alquiler, nombre, provincia y país del cliente, patente del vehículo, marca,
tipo y estado de conservación*/
select a.fecha, c.nombre, c.provincia, c.pais, v.patente, v.id_marca, v.id_tipo, v.id_estado
from Alquiler a join Cliente c on a.id_cliente = c.id_cliente
                join Vehiculo v on v.id_vehiculo = a.id_vehiculo
where Year(a.fecha) = 2015
group by a.fecha, c.nombre, c.provincia, c.pais, v.patente, v.id_marca, v.id_tipo, v.id_estado;

/*Liste patente y año de los vehículos alquilados por todos los clientes*/
select v.patente, v.año_patentamiento
from Vehiculo v 
where not exists (select 1
                from Cliente c
                where not exists (select 1
                                    from Alquiler a
                                    where a.id_vehiculo = v.id_vehiculo
                                    and a.id_cliente = c.id_cliente));
/*otra forma*/
select v.patente, v.año_patentamiento
from Vehiculo v join Alquiler a on a.id_vehiculo = v.id_vehiculo
                join Cliente cl on cl.id_cliente = a.id_cliente
group by v.id_vehiculo
having count(distinct a.id_cliente) = count(cl.id_cliente);

/*Elimine todos los alquileres realizados a clientes cuyo nombre comienza con la letra A,
donde la fecha de alquiler sea 21/05/2013, el vehículo tenga 5 plazas y no se haya
contratado seguro.*/

delete a.* from Alquiler a
    join Cliente c on a.id_cliente = c.id_cliente
    join Vehiculo v on a.id_vehiculo = v.id_vehiculo
where c.nombre like 'A%'
and a.fecha = '2013-05-21'
and v.cant_plazas = 5
and seguro is null