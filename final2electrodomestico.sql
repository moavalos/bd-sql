create Table Electrodomestico(
    id_electrodomestico int primary key,
    nombre varchar(40) not null,
    precio double not null
);

create Table Pais(
    id_pais int primary key,
    nombre varchar(40) not null
);

create Table Provincia(
    id_provincia int primary key,
    nombre varchar(40) not null,
    impuesto double not null
);

create Table Proveedor(
    id_proveedor int primary key,
    razon_social varchar(20) not null,
    cuit int not null,
    fecha_inicio date not null,
    id_pais int not null,
    id_provincia int not null,
    foreign key (id_pais) references Pais(id_pais),
    foreign key (id_provincia) references Provincia(id_provincia)
);

create Table Pieza(
    id_pieza int primary key,
    color varchar(20) not null,
    descripcion varchar(20) not null,
    id_pais int not null,
    id_proveedor int not null,
    foreign key (id_pais) references Pais(id_pais),
    foreign key (id_proveedor) references Proveedor(id_proveedor)
);

create Table Compuesto_por(
    id_electrodomestico int not null,
    id_pieza int not null,
    id_compuesto_por int not null ,
    cantidad_unidades int not null,
    primary key (id_electrodomestico, id_pieza, id_compuesto_por),
    foreign key (id_electrodomestico) references Electrodomestico(id_electrodomestico),
    foreign key (id_pieza) references Pieza(id_pieza)
);

insert into Electrodomestico(id_electrodomestico, nombre, precio) values
(1, 'Home Theater 2.1', 1200.00),
(2, 'Home Theater 5.1', 1000000.00),
(18, 'Home Theater 5.5', 1000000.00);

insert into Pais(id_pais, nombre) values
(10, 'Argentina'),
(11, 'Estados Unidos'),
(12, 'China'),
(13, 'Polonia');

insert into Provincia(id_provincia, nombre, impuesto) values 
(1, 'Buenos Aires', 1000000.00),
(2, 'California', 100.00),
(3, 'Zhejiang', 50000.00),
(4, 'Voivodato de Mazovia', 15000.00);

insert into Proveedor(id_proveedor, razon_social, cuit, fecha_inicio, id_pais, id_provincia) values 
(555, 'no se jaja', 45623456, '2022-12-8', 10, 1),
(556, 'aaaaa', 12345678, '2013-03-22', 11, 2),
(557, 'bbbbb', 98612398, '2020-01-29', 12, 3),
(558, 'ccccc', 98651234, '2002-11-11', 13, 4);

insert into Pieza(id_pieza, color, descripcion, id_pais, id_proveedor) values
(31, 'Negro', 'Amplificador', 10, 555),
(32, 'Blanco', 'Parlante', 11, 556),
(33, 'Azul', 'Subwoofer', 12, 557);

insert into Compuesto_por(id_electrodomestico, id_pieza, id_compuesto_por, cantidad_unidades) values 
(1, 31, 000, 1),
(1, 31, 001, 2),
(1, 31, 002, 1),
(2, 31, 003, 1),
(2, 31, 004, 5),
(2, 31, 005, 1),
(2, 31, 006, 7),
(2, 31, 007, 8),
(18, 31, 008, 3);

/*Mostrar el nombre de electrodomésticos y cantidad total de unidades que lo conforman, para
aquellos compuestos por un total de más de 5 unidades.*/

select e.nombre, sum(cp.cantidad_unidades)
from Electrodomestico e join Compuesto_por cp on e.id_electrodomestico = cp.id_electrodomestico
group by e.nombre, cp.cantidad_unidades
having cp.cantidad_unidades > 5;

/*Por un error de carga, todos los electrodomésticos con precio en el rango de 1000 a 2000
pesos inclusive, deben ser incrementados un 20%*/

update Electrodomestico 
set precio = precio * 1.2
where precio > 1000.00 and precio <= 2000.00;

/*Indicar la descripción de las piezas que se utilizan en todos los electrodomésticos*/

select p.descripcion
from Pieza p
where not exists (select 1
                    from Electrodomestico e
                    where not exists (select 1
                                    from Compuesto_por cp
                                    where cp.id_pieza = p.id_pieza
                                    and cp.id_electrodomestico = e.id_electrodomestico));

/*Indicar el nombre y precio de electrodomésticos compuestos por alguna pieza provista por un
proveedor de provincias con impuesto superior a 1,85*/

select e.nombre, e.precio
from Electrodomestico e join Compuesto_por cp on e.id_electrodomestico = cp.id_electrodomestico
                        join Pieza p on p.id_pieza = cp.id_pieza
                        join Proveedor pdor on pdor.id_proveedor = p.id_proveedor
                        join Provincia pcia on pcia.id_provincia = pdor.id_provincia
where pcia.impuesto > 1.85;

/*Listar la composición de piezas del electrodoméstico de código 18 indicando: cantidad de
unidades, descripción de la pieza, color y nombre de país de origen.*/

select cp.cantidad_unidades, p.descripcion, p.color, pa.nombre
from Compuesto_por cp join Pieza p on cp.id_pieza = p.id_pieza
                        join Pais pa on p.id_pais = pa.id_pais
where cp.id_electrodomestico = 18;