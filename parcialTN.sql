CREATE DATABASE IF NOT EXISTS ParcialTN;
USE ParcialTN;

CREATE TABLE localidad(
	cod CHAR(5) PRIMARY KEY NOT NULL,
    descripcion VARCHAR(40) NOT NULL
);
CREATE TABLE Cliente(
	id CHAR(5) PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL, 
    fecha_nac DATE NOT NULL,
    cod_loc CHAR(5) NOT NULL,
    FOREIGN KEY (cod_loc) REFERENCES Localidad(cod)
);
CREATE TABLE Empleado(
	cuil INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    sueldo DECIMAL NOT NULL,
    cod_loc CHAR(5) NOT NULL,
    FOREIGN KEY (cod_loc) REFERENCES Localidad(cod)
);
CREATE TABLE Reparacion(
	nro INT PRIMARY KEY NOT NULL,
    fecha DATE NOT NULL,
    importe DECIMAL NOT NULL,
    id_cliente CHAR(5) NOT NULL,
    cuil_empleado INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id),
    FOREIGN KEY (cuil_empleado) REFERENCES Empleado(cuil)
);
CREATE TABLE Proveedor(
	cuit INT PRIMARY KEY NOT NULL,
    razon_social VARCHAR(40) NOT NULL,
    telefono INT NOT NULL
);
CREATE TABLE Insumo(
	nro INT PRIMARY KEY NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    costo DECIMAL NOT NULL,
    cuit_proveedor INT NOT NULL,
    FOREIGN KEY (cuit_proveedor) REFERENCES Proveedor(cuit)
);
CREATE TABLE Reparacion_Insumo(
	nro_reparacion INT NOT NULL,
    nro_insumo INT NOT NULL,
    CONSTRAINT pk_rep_ins PRIMARY KEY (nro_reparacion, nro_insumo),
    FOREIGN KEY (nro_reparacion) REFERENCES Reparacion(nro),
    FOREIGN KEY (nro_insumo) REFERENCES Insumo(nro)
);
