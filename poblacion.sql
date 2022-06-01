CREATE DATABASE IF NOT EXISTS Poblacion;
USE Poblacion;

CREATE TABLE Habitante(
	nro_doc INT NOT NULL,
    tipo_doc VARCHAR(10) NOT NULL,
	nombre VARCHAR(40) NOT NULL,
    apellido VARCHAR(40) NOT NULL,
    f_nacimiento DATE NOT NULL,
    cod_vivienda INT NOT NULL,
    PRIMARY KEY (nro_doc, tipo_doc),
    FOREIGN KEY (cod_vivienda) REFERENCES Vivienda(cod)
);
CREATE TABLE Vivienda(
	cod INT PRIMARY KEY NOT NULL,
    direccion VARCHAR(40) NOT NULL,
    calle VARCHAR(20) NOT NULL,
    nro_calle INT NULL,
    localidad VARCHAR(20) NOT NULL,
    cp INT NOT NULL,
    metros_terreno DOUBLE NOT NULL,
    metros_edificados DOUBLE NOT NULL
);
CREATE TABLE Municipio(
	cod INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    intendente VARCHAR(40) NOT NULL,
    cod_viv INT NOT NULL,
    FOREIGN KEY (cod_viv) REFERENCES Vivienda(cod)
);
CREATE TABLE Propiedad(
	nro_doc_hab INT NOT NULL,
    tipo_doc_hab VARCHAR(10) NOT NULL,
    cod_viv INT NOT NULL,
    PRIMARY KEY (nro_doc_hab, tipo_doc_hab, cod_viv),
    FOREIGN KEY (cod_viv) REFERENCES Vivienda(cod),
    FOREIGN KEY (nro_doc_hab, tipo_doc_hab) REFERENCES Habitante(nro_doc, tipo_doc)
);