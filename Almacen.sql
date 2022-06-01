CREATE DATABASE IF NOT EXISTS Almacen;
USE Almacen;

CREATE TABLE almacenn(
	nro INT(5) PRIMARY KEY NOT NULL,
    responsable VARCHAR(40) NOT NULL,
    nombre VARCHAR(40) NOT NULL
);

CREATE TABLE articulo(
	cod_art CHAR(5) PRIMARY KEY NOT NULL,
    descrip VARCHAR(100) NOT NULL,
    precio DECIMAL(10,0) NOT NULL
);
CREATE TABLE material(
	cod_mat CHAR(5) PRIMARY KEY NOT NULL,
    descrip VARCHAR(100) NOT NULL
);
CREATE TABLE ciudad(
	cod_ciu CHAR(5) PRIMARY KEY NOT NULL,
	nombre VARCHAR(40) NOT NULL
);
CREATE TABLE proveedor(
	cod_prov CHAR(5) PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    domicilio VARCHAR(100) NOT NULL,
    fecha_alta DATE NOT NULL, 
    cod_ciu CHAR(5) NOT NULL,
    FOREIGN KEY (cod_ciu) REFERENCES ciudad(cod_ciu)
);
CREATE TABLE contiene(
	nro INT NOT NULL,
    cod_art CHAR NOT NULL,
    PRIMARY KEY (nro, cod_art),
    FOREIGN KEY (nro) REFERENCES almacen1(nro),
    FOREIGN KEY (cod_art) REFERENCES articulo(cod_art)
);
CREATE TABLE compuesto_por(
	cod_art CHAR NOT NULL,
    cod_mat CHAR NOT NULL,
    PRIMARY KEY (cod_art, cod_mat),
    FOREIGN KEY (cod_art) REFERENCES articulo(cod_art),
    FOREIGN KEY (cod_mat) REFERENCES material (cod_mat)
);
CREATE TABLE provisto_por(
	cod_mat CHAR NOT NULL,
    cod_prov CHAR NOT NULL,
    PRIMARY KEY (cod_mat, cod_prov),
    FOREIGN KEY (cod_mat) REFERENCES material (cod_mat),
    FOREIGN KEY (cod_prov) REFERENCES proveedor (cod_prov)
);
 INSERT INTO almacenn (nro, responsable, nombre) VALUES (34,'Martin Sanchez', 'Superchino');
 INSERT INTO almacenn (nro, responsable, nombre) VALUES (2,'Pedrita Garcia', 'Aromos');
 INSERT INTO almacenn (nro, responsable, nombre) VALUES (1,'Martin Sanchez', 'Tostaditas');

INSERT INTO articulo (cod_art, descrip, precio) VALUES (5, 'Limpieza', 400);
INSERT INTO articulo (cod_art, descrip, precio) VALUES (1, 'Cocina', 100);
INSERT INTO articulo (cod_art, descrip, precio) VALUES (6, 'Coche', 250);

INSERT INTO material (cod_mat, descrip) VALUES (3, 'no se');
INSERT INTO material (cod_mat, descrip) VALUES (7, 'no se 1');
INSERT INTO material (cod_mat, descrip) VALUES (9, 'no se 2');

INSERT INTO ciudad (cod_ciu, nombre) VALUES (45, 'La Plata');
INSERT INTO ciudad (cod_ciu, nombre) VALUES (41, 'Rosario');
INSERT INTO ciudad (cod_ciu, nombre) VALUES (15, 'Santa fe');

INSERT INTO proveedor (cod_prov, nombre, domicilio, fecha_alta, cod_ciu) VALUES (5, 'Juan Pablo', 'Pedraza 544', '2002-10-26', 45);
INSERT INTO proveedor (cod_prov, nombre, domicilio, fecha_alta, cod_ciu) VALUES (12, 'Agustin Riquelme', 'Acacias 1065', '2010-2-10', 41);
INSERT INTO proveedor (cod_prov, nombre, domicilio, fecha_alta, cod_ciu) VALUES (21, 'Victoria Piola', 'Iturri 912', '1999-5-31', 15);

INSERT INTO contiene(nro, cod_art) VALUES (34,5);
INSERT INTO contiene(nro, cod_art) VALUES (2,1);
INSERT INTO contiene(nro, cod_art) VALUES (1,6);

INSERT INTO compuesto_por(cod_art, cod_mat) VALUES (5,3);
INSERT INTO compuesto_por(cod_art, cod_mat) VALUES (1,7);
INSERT INTO compuesto_por(cod_art, cod_mat) VALUES (6,9);

INSERT INTO provisto_por(cod_mat, cod_prov) VALUES (3,5);
INSERT INTO provisto_por(cod_mat, cod_prov) VALUES (7,12);
INSERT INTO provisto_por(cod_mat, cod_prov) VALUES (9,21);