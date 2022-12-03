create table Proveedor(
    id_proveedor int primary key not null,
    nombre varchar(40) not null,
    cuit int not null
);

create table Producto(
    id_producto int primary key not null,
    descripcion varchar(50) not null,
    estado varchar(20) not null,
    id_proveedor int not null,
    foreign key (id_proveedor) references Proveedor(id_proveedor)
);

create table Cliente(
    id_cliente int primary key not null,
    nombre varchar(40) not null
);

create table Vendedor(
    id_vendedor int primary key not null,
    nombre varchar(20) not null,
    apellido varchar(20) not null,
    dni int not null
);

create table Venta(
    nro_factura int primary key not null,
    id_cliente int not null,
    fecha date not null,
    id_vendedor int not null,
    foreign key (id_cliente) references Cliente(id_cliente),
    foreign key (id_vendedor) references Vendedor(id_vendedor)
);

create table Detalle_Venta(
    nro_factura int not null,
    nro_detalle int not null,
    id_producto int not null,
    cantidad double not null,
    precio_unitario double not null,
    primary key (nro_factura, nro_detalle),
    foreign key (nro_factura) references Venta(nro_factura),
    foreign key (id_producto) references Producto(id_producto)
);

insert into Producto(id_producto, descripcion, estado, id_proveedor) values (05, 'Galletitas Oreo', 'en stock', 100);
insert into Producto(id_producto, descripcion, estado, id_proveedor) values (06, 'Aquarius de Pera', 'sin stock', 10);
insert into Producto(id_producto, descripcion, estado, id_proveedor) values (07, 'Pepas', 'sin stock', 11);

insert into Proveedor(id_proveedor, nombre, cuit) values (100, 'Juana Sanchez', 274710476);
insert into Proveedor(id_proveedor, nombre, cuit) values (10, 'Lara Caamano', 259732167);
insert into Proveedor(id_proveedor, nombre, cuit) values (51, 'Laura pepino', 658409353);
insert into Proveedor(id_proveedor, nombre, cuit) values (11, 'fhofjdsl', 64091275);

insert into Cliente(id_cliente, nombre) values (01, 'Martin Gomez');
insert into Cliente(id_cliente, nombre) values (02, 'jfkdls');
insert into Cliente(id_cliente, nombre) values (03, 'fgjdops');
insert into Cliente(id_cliente, nombre) values (04, 'juana');

insert into Vendedor(id_vendedor, nombre, apellido, dni) values (98, 'Pedro', 'Alfonso', 44318877);
insert into Vendedor(id_vendedor, nombre, apellido, dni) values (99, 'Juana', 'Alba', 99527722);
insert into Vendedor(id_vendedor, nombre, apellido, dni) values (100, 'Juana', 'Alba', 68740324);
insert into Vendedor(id_vendedor, nombre, apellido, dni) values (101, 'fkmdslñ', 'fiksopa', 0175265);

insert into Venta(nro_factura, id_cliente, fecha, id_vendedor) values (321, 01, '2022-11-30', 98);
insert into Venta(nro_factura, id_cliente, fecha, id_vendedor) values (322, 02, '2022-03-21', 99);
insert into Venta(nro_factura, id_cliente, fecha, id_vendedor) values (323, 03, '2015-04-11', 100);
insert into Venta(nro_factura, id_cliente, fecha, id_vendedor) values (324, 04, '2015-01-22', 101);

insert into Detalle_Venta(nro_factura, nro_detalle, id_producto, cantidad, precio_unitario) values (321, 65, 05, 50.0, 350.0);
insert into Detalle_Venta(nro_factura, nro_detalle, id_producto, cantidad, precio_unitario) values (322, 66, 06, 140.0, 150.0);
insert into Detalle_Venta(nro_factura, nro_detalle, id_producto, cantidad, precio_unitario) values (324, 67, 07, 140.0, 150.0);

/*1. Listar la cantidad de productos que tiene la empresa.*/
/*select count(id_producto) as 'cantidad de productos'
from Producto*/

/*2. Listar la descripción de productos en estado 'en stock' que tiene la empresa.*/
/*select p.descripcion
from Producto p
where p.estado = 'en stock'*7

/*3. Listar los productos que nunca fueron vendidos.*/
/*select p.id_producto
from Producto p join Detalle_Venta dv on p.id_producto = dv.id_producto
where dv.id_producto is null*/

/*4. Listar la cantidad total de unidades que fueron vendidas de cada producto
(descripción).*/
/*select sum(dv.cantidad), p.id_producto
from Detalle_Venta dv join Producto p on dv.id_producto = p.id_producto
group by p.descripcion*/

/*5. Listar el nombre de cada vendedor y la cantidad de ventas realizadas en el año
2015.*/
/*select count(vta.nro_factura)
from Venta vta join Vendedor vdr on vdr.id_vendedor = vta.id_vendedor
where vta.fecha between '2015-01-01' and '2015-12-31'*/

/*6. Listar el monto total vendido por cada cliente (nombre)*/
/*select sum(dv.precio_unitario) as 'monto total', c.nombre
from Detalle_Venta dv join Venta v on dv.nro_factura = v.nro_factura
                    join Cliente c on c.id_cliente = v.id_cliente
group by c.nombre, dv.precio_unitario*/

/*7. Listar la descripción de aquellos productos en estado ‘sin stock’ que se hayan
vendido en el mes de Enero de 2015*/
/*select p.descripcion
from Producto p join Detalle_Venta dv on p.id_producto = dv.id_producto
                join Venta v on v.nro_factura = dv.nro_factura
where p.estado = 'sin stock'
and Month(v.fecha) in 1
and Year(v.fecha) in 2015
group by p.descripción, p.id_producto, v.fecha, dv.nro_factura*/

select p.descripcion
from Producto p
where p.estado = 'sin stock'
and p.id_producto in (select dv.id_producto
                    from Detalle_Venta dv join Venta v on dv.nro_factura = v.nro_factura
                    where v.fecha between '2015-01-01' and '2015-01-31')