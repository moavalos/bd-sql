CREATE DATABASE IF NOT EXISTS Ejercicio3;
USE Ejercicio3;

CREATE TABLE Proveedor(
	id_proveedor CHAR(5) PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    cuit CHAR(10) NOT NULL
);
CREATE TABLE Producto(
	id_producto CHAR(5) PRIMARY KEY NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    estado VARCHAR(20) NOT NULL,
    id_proveedor CHAR(5) NOT NULL,
    FOREIGN KEY (id_proveedor) REFERENCES Proveedor(id_proveedor)
);
CREATE TABLE Cliente(
	id_cliente CHAR(5) PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL
);
CREATE TABLE Vendedor(
	id_vendedor CHAR(5) PRIMARY KEY NOT NULL,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    dni INT(8) NOT NULL
);
CREATE TABLE Venta(
	nro_factura INT(5) PRIMARY KEY NOT NULL,
    id_cliente CHAR(5) NOT NULL,
    fecha DATE NOT NULL,
    id_vendedor CHAR(5) NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
    FOREIGN KEY (id_vendedor) REFERENCES Vendedor(id_vendedor)
);
CREATE TABLE Detalle_Venta(
	nro_factura INT(5) NOT NULL,
    nro_detalle INT(5) NOT NULL,
    id_producto CHAR(5) NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(6,2) NOT NULL,
    CONSTRAINT detalle_venta_pk PRIMARY KEY (nro_factura, nro_detalle),
    FOREIGN KEY (nro_factura) REFERENCES Venta(nro_factura),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);

INSERT INTO Proveedor(id_proveedor, nombre, cuit) VALUES (322, 'Juan Pedrito Garcia', 2744318876);
INSERT INTO Proveedor(id_proveedor, nombre, cuit) VALUES (1072, 'Kurt Cobain', 1234567891);
INSERT INTO Proveedor(id_proveedor, nombre, cuit) VALUES (111, 'Lara Caamaño', 293710253);

INSERT INTO Producto(id_producto, descripcion, estado, id_proveedor) VALUES (324, 'Galletitas saladas', 'Bueno', 322);
INSERT INTO Producto(id_producto, descripcion, estado, id_proveedor) VALUES (1012, 'Ayudin lavandina', 'Vencido', 1072);
INSERT INTO Producto(id_producto, descripcion, estado, id_proveedor) VALUES (541, 'Serenisima dulce de leche', 'Malo', 111);

INSERT INTO Cliente(id_cliente, nombre) VALUES (1234, 'Juan Domingo Perón');
INSERT INTO Cliente(id_cliente, nombre) VALUES (12, 'Celeste Romina');
INSERT INTO Cliente(id_cliente, nombre) VALUES (621, 'Lucila Redondo');

INSERT INTO Vendedor(id_vendedor, nombre, apellido, dni) VALUES (801, 'Mora', 'Avalos', 44318877);
INSERT INTO Vendedor(id_vendedor, nombre, apellido, dni) VALUES (1, 'Juana', 'Rodriguez', 32963791);
INSERT INTO Vendedor(id_vendedor, nombre, apellido, dni) VALUES (900, 'Maria', 'Garcia', 12345678);

INSERT INTO Venta(nro_factura, id_cliente, fecha, id_vendedor) VALUES (102, 1234, '2009-02-21', 322);
INSERT INTO Venta(nro_factura, id_cliente, fecha, id_vendedor) VALUES (431, 12, '2021-09-09', 1072);
INSERT INTO Venta(nro_factura, id_cliente, fecha, id_vendedor) VALUES (711, 621, '2005-11-03', 111);

INSERT INTO Detalle_venta(nro_factura, nro_detalle, id_producto, cantidad, precio_unitario) VALUES (102, 20, 324, 100, 3000.00);
INSERT INTO Detalle_venta(nro_factura, nro_detalle, id_producto, cantidad, precio_unitario) VALUES (431, 50, 1012, 40, 1000.50);
INSERT INTO Detalle_venta(nro_factura, nro_detalle, id_producto, cantidad, precio_unitario) VALUES (711, 105, 541, 300, 6350.00);




