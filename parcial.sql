CREATE DATABASE IF NOT EXISTS parcial;
USE parcial;

CREATE TABLE Producto(
	id_producto INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    fecha_creacion DATE NOT NULL,
    precio DECIMAL NOT NULL
);
CREATE TABLE Color(
	id_color INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL
);
CREATE TABLE Tema(
	id_tema INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL,
    color1 VARCHAR(10) NOT NULL,
    color2 VARCHAR(10) NOT NULL,
    color3 VARCHAR(10) NOT NULL
);
CREATE TABLE Temas_Producidos(
	id_tema INT NOT NULL,
    id_producto INT NOT NULL,
    CONSTRAINT tem_prod_pk PRIMARY KEY (id_tema, id_producto),
    FOREIGN KEY (id_tema) REFERENCES Tema(id_tema),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto)
);
CREATE TABLE Componente(
	id_componente INT PRIMARY KEY NOT NULL,
    descripcion VARCHAR(40) NOT NULL,
    id_color_predominante INT NOT NULL,
    es_personalizado CHAR NOT NULL,
    costo DECIMAL NOT NULL,
    FOREIGN KEY (id_color_predominante) REFERENCES Color(id_color)
);
CREATE TABLE Composicion(
	id_producto INT NOT NULL,
    id_componente INT NOT NULL,
    vencimiento DATE NOT NULL,
    cantidad_componente INT NOT NULL,
    CONSTRAINT composicion_pk PRIMARY KEY (id_componente, id_producto),
    FOREIGN KEY (id_producto) REFERENCES Producto(id_producto),
    FOREIGN KEY (id_componente) REFERENCES Componente(id_componente)
);
CREATE TABLE Ingrediente(
	id_ingrediente INT PRIMARY KEY NOT NULL,
    nombre VARCHAR(40) NOT NULL
);
CREATE TABLE Receta(
	id_componente INT NOT NULL,
    paso VARCHAR(20) NOT NULL,
    id_ingrediente INT NOT NULL,
    medida DECIMAL NOT NULL,
    cantidad DECIMAL NOT NULL,
    elaboracion VARCHAR(50) NOT NULL,
	CONSTRAINT receta_pk PRIMARY KEY (id_componente, id_ingrediente, paso),
    FOREIGN KEY (id_componente) REFERENCES Componente(id_componente),
    FOREIGN KEY (id_ingrediente) REFERENCES Ingrediente(id_ingrediente)
);

