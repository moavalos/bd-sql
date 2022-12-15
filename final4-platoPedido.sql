CREATE TABLE Localidad(
id_localidad INT PRIMARY KEY AUTO_INCREMENT,
descripcion VARCHAR(50) NOT NULL);

CREATE TABLE Plato (
id_plato INT PRIMARY KEY AUTO_INCREMENT,
descripcion VARCHAR (30) NOT NULL,
precio DOUBLE NOT NULL);

CREATE TABLE Cliente(
id_cliente INT PRIMARY KEY AUTO_INCREMENT,
nombre VARCHAR (20) NOT NULL,
apellido VARCHAR (20) NOT NULL,
calle VARCHAR (30) NOT NULL,
nro INT NOT NULL,
id_localidad INT NOT NULL,
FOREIGN KEY (id_localidad) REFERENCES Localidad(id_localidad));

CREATE TABLE Pedido_Encabezado(
id_pedido INT PRIMARY KEY AUTO_INCREMENT,
id_cliente INT NOT NULL,
fecha DATE NOT NULL,
FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente));

CREATE TABLE Pedido_Detalle(
id_detalle INT PRIMARY KEY AUTO_INCREMENT,
id_pedido INT NOT NULL,
id_plato INT NOT NULL,
cantidad INT NOT NULL,
FOREIGN KEY(id_pedido) REFERENCES Pedido_Encabezado(id_pedido),
FOREIGN KEY(id_plato) REFERENCES Plato(id_plato));

INSERT INTO Localidad (descripcion) VALUES
('Ramos Mejía'),
('San Justo'),
('Liniers'),
('Moron');

INSERT INTO Plato (descripcion, precio) VALUES
('Empanada', 150.0),
('Milanesa', 600.0),
('Pizza', 1200.0),
('Spaghetti', 800.0),
('Hamburguesa', 700.0);

INSERT INTO Cliente (nombre, apellido, calle, nro, id_localidad) VALUES
('Carlos', 'Monzon', 'Tatacua', 1832, 3),
('Ricardo', 'Echeverria', 'Cuba', 1743, 2),
('Alberto', 'Estebanez', 'Castelli', 983, 1),
('Jose', 'Bogarin', 'Av Mayo', 732, 1),
('Maria', 'Elena', 'Arieta', 1582, 2);


INSERT INTO Cliente (nombre, apellido, calle, nro, id_localidad) VALUES
('Aina', 'Monzon', 'Tatacua', 1832, 3);

INSERT INTO Pedido_Encabezado (id_cliente, fecha) VALUES
(1, '2022-01-01'),
(3, '2022-02-23'),
(5, '2022-04-09'),
(2, '2022-05-14'),
(1, '2022-03-13'),
(4, '2022-01-10');

INSERT INTO Pedido_Detalle (id_pedido, id_plato, cantidad) VALUES
(1, 4, 2),
(1, 1, 6),
(2, 5, 4),
(3, 4, 2),
(4, 2, 2),
(5, 1, 12),
(6, 2, 4),
(6, 3, 2);

INSERT INTO Pedido_Detalle (id_pedido, id_plato, cantidad) VALUES
(1, 1, 6),
(1, 2, 4),
(1, 3, 3),
(1, 5, 1);

/*2-Obtener los datos de todos los clientes, ordenados por Localidad, Nombre y Apellido*/
select c.*
from Cliente c join Localidad l on c.id_localidad = l.id_localidad
order by l.id_localidad, c.nombre, c.apellido

/*3-Informar: número de Pedido, Cantidad de Platos Distintos, Cantidad de unidades total, Importe total del pedido*/
select pd.id_pedido, count(distinct pd.id_detalle) as 'cantidad de platos', sum(pd.cantidad) as 'cantidad unidades', sum(p.precio*pd.cantidad) as 'importe total'
from Pedido_Detalle pd join Plato p on pd.id_plato = p.id_plato
group by pd.id_pedido

/*4-Mostrar un detalle de los clientes que han realizado pedidos en el mes de Enero y no realizaron ningún pedido en el mes de marzo*/
select c.*
from Cliente c
where exists (select 1
            from Pedido_Encabezado pe
            where c.id_cliente = pe.id_cliente
            and Month(pe.fecha) = 1)
and not exists (select 1
                from Pedido_Encabezado pe
                where c.id_cliente = pe.id_cliente
                and Month(pe.fecha) = 3)

/*5 Informar el nombre del plato mas barato de la cartaSELECT * */
select *
from Plato
group by id_plato, descripcion
having min(precio)*/

/*OTRA FORMA
select *
from plato p
where precio = (select min (p2.precio)
                from plato p2)*/

/*6 informar los datos completos de los clientes, la fecha de última compra y el total gastado. Deben informarse la totalidad de los clientes existentes.*/
select c.*, max(pe.fecha) as 'fecha ultima compra', sum(precio * pd.cantidad) as 'total gastado'
from Cliente c join Pedido_Encabezado pe on c.id_cliente = pe.id_cliente 
                join Pedido_Detalle pd on pe.id_pedido = pd.id_pedido
                join Plato p on pd.id_plato = p.id_plato
group by c.id_cliente

/*7 Informar los platos que han sido comprados por mas de un cliente*/
select p.*
from Plato p 
where exists ( select 1
            from Pedido_Detalle pd join Pedido_Encabezado pe on pd.id_pedido = pe.id_pedido
            where pd.id_plato = p.id_plato
            group by pd.id_plato
            having count(distinct pe.id_cliente) > 1)

/*8 Mostrar los clientes que han pedido todos los platos del menú*/
select c.*
from Cliente c
join Pedido_Encabezado pe on pe.id_cliente = c.id_cliente
join Pedido_Detalle pd on pd.id_pedido = pe.id_pedido
group by c.id_cliente
having count(distinct pd.id_plato) = (select count(*)
                                        from Plato p)

/*9-Informar la descripción y precio de los platos que no han sido comprados por ningún cliente.*/
select p.descripcion, p.precio
from Plato p
where not exists (select 1
                from Pedido_Detalle pd
                where pd.id_plato = p.id_plato)