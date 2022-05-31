CREATE DATABASE IF NOT EXISTS Secretaria_de_Energia_BD;
USE Secretaria_de_Energia_BD;

CREATE TABLE Productores(
	nombre VARCHAR(40) PRIMARY KEY NOT NULL,
    produccion_media INT NOT NULL,
    produccion_alta INT NOT NULL,
    fecha_entrega_funcionamiento DATE NOT NULL
);
CREATE TABLE Hidroelectrica(
	nombre_prod VARCHAR(40) PRIMARY KEY NOT NULL,
    ocupacion TEXT(20) NOT NULL,
    capacidad_maxima INT NOT NULL,
    nro_turbinas INT NOT NULL,
    FOREIGN KEY (nombre_prod) REFERENCES Productores(nombre)
);
CREATE TABLE Solar(
	nombre_prod VARCHAR(40) PRIMARY KEY NOT NULL,
    superficie_total_ocupada_paneles DOUBLE NOT NULL,
    cantidad_paneles INT NOT NULL,
    media_anual_horas_sol DOUBLE NOT NULL,
	FOREIGN KEY (nombre_prod) REFERENCES Productores(nombre)
);
CREATE TABLE Nuclear(
	nombre_prod VARCHAR(40) PRIMARY KEY NOT NULL,
    nro_reactores INT NOT NULL,
    vol_plutonio_consumido DOUBLE NOT NULL, 
    vol_residuos_nucleares DOUBLE NOT NULL,
	FOREIGN KEY (nombre_prod) REFERENCES Productores(nombre)
);

CREATE TABLE Termica(
	nombre_prod VARCHAR(40) PRIMARY KEY NOT NULL,
    nro_hornos INT NOT NULL,
    vol_carbón DOUBLE NOT NULL,
	vol_emisiones_gases DOUBLE NOT NULL,
    FOREIGN KEY (nombre_prod) REFERENCES Productores(nombre)
);

CREATE TABLE Proveedor(
	cod_prov INT PRIMARY KEY NOT NULL,
	nombre VARCHAR(40) NOT NULL,
	pais VARCHAR(40) NOT NULL
);
CREATE TABLE Transportista(
	matricula INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL
);
CREATE TABLE Plutonio(
	nombre_prod VARCHAR(40) PRIMARY KEY NOT NULL,
    cod_prov INT PRIMARY KEY NOT NULL,
    matricula_tran INT PRIMARY KEY NOT NULL,
    cant_plutonio DOUBLE NOT NULL,
    FOREIGN KEY (nombre_prod) REFERENCES Productores(nombre),
    FOREIGN KEY (cod_prov) REFERENCES Proveedor(cod_prov),
    FOREIGN KEY (matricula_tran) REFERENCES Transportista(matricula)
);

CREATE TABLE Estaciones_primarias(
	nombre_EP VARCHAR(40) PRIMARY KEY NOT NULL,
    cant_transformadores_baja_tension INT NOT NULL,
    cant_transformadores_alta_tension INT NOT NULL
);
CREATE TABLE Redes_distribucion(
	nro_redes INT PRIMARY KEY NOT NULL,
    nombre_EP VARCHAR(40) NOT NULL,
    vol_total_energia DOUBLE NOT NULL,
	FOREIGN KEY (nombre_EP) REFERENCES Estaciones_primarias(nombre_EP)
);
CREATE TABLE Compañia_electrica(
	nombreCE VARCHAR(40) PRIMARY KEY NOT NULL,
    nro_redes INT NOT NULL,
    FOREIGN KEY (nro_redes) REFERENCES Redes_distribucion(nro_redes)
);
CREATE TABLE Linea(
	nro INT PRIMARY KEY NOT NULL,
    longitud DOUBLE NOT NULL,
    nro_redes INT NOT NULL,
    FOREIGN KEY (nro_redes) REFERENCES Redes_distribucion(nro_redes)
);
CREATE TABLE Subestaciones(
	cod_subs INT PRIMARY KEY NOT NULL,
    nro_linea INT NOT NULL,
    FOREIGN KEY (nro_linea) REFERENCES Linea(nro)
);
CREATE TABLE Provincia(
	cod_prov INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL
);
CREATE TABLE Zona_servicio(
	cod INT PRIMARY KEY NOT NULL,
    consumo VARCHAR(40) NOT NULL,
    consumidores VARCHAR(40) NOT NULL,
    particulares VARCHAR(40) NOT NULL,
    empresariales VARCHAR(40) NOT NULL,
    institucionales VARCHAR(40) NOT NULL,
    cod_prov INT NOT NULL,
    FOREIGN KEY (cod_prov) REFERENCES Provincia(cod_prov)
    /*cod_subs INT NOT NULL,
	FOREIGN KEY (cod_subs) REFERENCES Subestaciones(cod_subs)*/
);
CREATE TABLE Distribuye(
	cod INT PRIMARY KEY NOT NULL,
    cod_subs INT PRIMARY KEY NOT NULL,
	FOREIGN KEY (cod) REFERENCES Zona_servicio(cod),
	FOREIGN KEY (cod_subs) REFERENCES Subestaciones(cod_subs)
);




















