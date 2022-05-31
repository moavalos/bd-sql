CREATE SCHEMA IF NOT EXISTS Ejercicio4;
USE Ejercicio4;

CREATE TABLE Persona(
	nro_persona CHAR(5) PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    calle VARCHAR(40) NOT NULL,
    ciudad VARCHAR(20) NOT NULL,
	nro_supervisor CHAR(5) NOT NULL,
	FOREIGN KEY (nro_supervisor) REFERENCES Persona(nro_persona)
);
CREATE TABLE Empresa(
	nro_empresa CHAR(5) PRIMARY KEY NOT NULL,
    razon_social VARCHAR(40) NOT NULL,
    calle VARCHAR(40) NOT NULL,
    ciudad VARCHAR(20) NOT NULL
);
CREATE TABLE Trabaja(
	nro_empresa CHAR(5) NOT NULL,
    nro_persona CHAR(5) NOT NULL,
    salario DECIMAL(5,2) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    CONSTRAINT trabaja_pk PRIMARY KEY (nro_empresa, nro_persona),
    FOREIGN KEY (nro_empresa) REFERENCES Empresa(nro_empresa),
	FOREIGN KEY (nro_persona) REFERENCES Persona(nro_persona)
);
