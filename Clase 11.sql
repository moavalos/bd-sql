#Clase 11
/***** Crear Base *****/
CREATE SCHEMA IF NOT EXISTS Clase11;
USE Clase11;

/***** Crear Tablas *****/
CREATE TABLE Area(
	cod_area CHAR(2) PRIMARY KEY,
    descripcion VARCHAR(40)
);

CREATE TABLE Especialidad(
	cod_esp INT PRIMARY KEY,
    descripcion VARCHAR(40)
);

CREATE TABLE Empleado(
	nro INT PRIMARY KEY,
    nombre VARCHAR(40) NOT NULL,
    cod_esp INT NOT NULL,
    nro_jefe INT NULL,
    sueldo DECIMAL(10,2) NOT NULL,
    f_ingreso DATE NOT NULL,
    FOREIGN KEY (cod_esp) REFERENCES Especialidad(cod_esp),
    FOREIGN KEY (nro_jefe) REFERENCES Empleado(nro)
);
#ALTER TABLE Empleado ADD CONSTRAINT FOREIGN KEY (nro_jefe) REFERENCES Empleado(nro)

CREATE TABLE Trabaja(
	nro_emp INT NOT NULL,
    cod_area CHAR(2) NOT NULL,
    PRIMARY KEY (nro_emp, cod_area),
    FOREIGN KEY (nro_emp) REFERENCES Empleado(nro),
    FOREIGN KEY (cod_area) REFERENCES Area(cod_area)
);
/***** Insertar Datos *****/
INSERT INTO area (cod_area, descripcion) VALUES ('A1', 'Area 1');
INSERT INTO area (cod_area, descripcion) VALUES ('A2', 'Area 2');

INSERT INTO especialidad (cod_esp, descripcion) VALUES (1, 'Gerente');
INSERT INTO especialidad (cod_esp, descripcion) VALUES (2, 'Operario');

INSERT INTO empleado (nro, nombre, cod_esp, nro_jefe, sueldo, f_ingreso) VALUES ('1000', 'Juan', '1', null, '10000', '2000-01-01');
INSERT INTO empleado (nro, nombre, cod_esp, nro_jefe, sueldo, f_ingreso) VALUES ('1001', 'Pedro', '2', '1000', '5000', '2008-05-01');
INSERT INTO empleado (nro, nombre, cod_esp, nro_jefe, sueldo, f_ingreso) VALUES ('1002', 'Daniel', '2', '1000', '2000', '2009-10-01');

INSERT INTO trabaja (nro_emp, cod_area) VALUES (1000, 'A1');
INSERT INTO trabaja (nro_emp, cod_area) VALUES (1000, 'A2');
INSERT INTO trabaja (nro_emp, cod_area) VALUES (1001, 'A1');
INSERT INTO trabaja (nro_emp, cod_area) VALUES (1002, 'A2');


