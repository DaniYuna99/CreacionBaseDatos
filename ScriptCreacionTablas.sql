DROP DATABASE IF EXISTS daniel_carpintero;

CREATE DATABASE daniel_carpintero;
USE daniel_carpintero;

DROP TABLE IF EXISTS Distribuidor;
DROP TABLE IF EXISTS Madera;
DROP TABLE IF EXISTS DistribuidorMadera;
DROP TABLE IF EXISTS Carpintero;
DROP TABLE IF EXISTS CarpinteroMadera;
DROP TABLE IF EXISTS Mueble;
DROP TABLE IF EXISTS MuebleCarpintero;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS PedidoMueble;
DROP TABLE IF EXISTS Cliente;


CREATE TABLE Distribuidor (
    nombre VARCHAR(30) NOT NULL,
    localizacion VARCHAR(50),
    fechaFundacion DATE,

    PRIMARY KEY (nombre)
);


CREATE TABLE Madera (
    tipoMadera VARCHAR(30) NOT NULL,
    nombreDistribuidor VARCHAR(30) NOT NULL,

    PRIMARY KEY (tipoMadera)
);


/*La relacion entre Distribuidor y Madera es N:M, por lo que creo una tabla nueva*/
CREATE TABLE DistribuidorMadera (
    tipoMadera VARCHAR(30) NOT NULL,
    nombreDistribuidor VARCHAR(30) NOT NULL,

    PRIMARY KEY (tipoMadera, nombreDistribuidor),
    CONSTRAINT FK_DistriMadera_Madera_tipoMadera FOREIGN KEY (tipoMadera)
    REFERENCES Madera(tipoMadera),
    CONSTRAINT FK_Distribuidor_nombre FOREIGN KEY (nombreDistribuidor)
    REFERENCES Distribuidor(nombre)
);


CREATE TABLE Carpintero (
    nombre VARCHAR(30) NOT NULL,
    apellidos VARCHAR(50),
    anyosExperiencia INT,
    especialidad VARCHAR(30),

    PRIMARY KEY (nombre)  
);


/*La relacion entre Carpintero y Madera es N:M, por lo que creo una tabla nueva*/
CREATE TABLE CarpinteroMadera (
    tipoDeMadera VARCHAR(30) NOT NULL,
    nombreCarpintero VARCHAR(30) NOT NULL,

    PRIMARY KEY (tipoDeMadera, nombreCarpintero),
    CONSTRAINT FK_CarpMadera_Madera_tipoMadera FOREIGN KEY (tipoDeMadera)
    REFERENCES Madera(tipoMadera),
    CONSTRAINT FK_CarpMadera_Carpintero_nombre FOREIGN KEY (nombreCarpintero)
    REFERENCES Carpintero(nombre)
);


CREATE TABLE Mueble (
    tipo VARCHAR(40) NOT NULL,
    precio INT,

    PRIMARY KEY (tipo)
);


/*La relacion entre Mueble y Carpintero es N:M, por lo que creo una tabla nueva*/
CREATE TABLE MuebleCarpintero (
    nombreCarpintero VARCHAR(30) NOT NULL,
    tipoMueble VARCHAR(40) NOT NULL,

    PRIMARY KEY (nombreCarpintero, tipoMueble),
    CONSTRAINT FK_MuebleCarp_nombreCarp FOREIGN KEY (nombreCarpintero)
    REFERENCES Carpintero (nombre),
    CONSTRAINT FK_MuebleCarp_tipoMueble FOREIGN KEY (tipoMueble)
    REFERENCES Mueble (tipo)
);


CREATE TABLE Pedido (
    codigo VARCHAR(10) NOT NULL,
    precioTotal INT,

    PRIMARY KEY (codigo)
);


/*La relacion entre Pedido y Mueble es N:M, por lo que creo una tabla nueva*/
CREATE TABLE PedidoMueble (
    tipoMueble VARCHAR(40) NOT NULL,
    codigoPedido VARCHAR(10) NOT NULL,

    PRIMARY KEY (tipoMueble, codigoPedido),
    CONSTRAINT FK_PedMueble_tipo FOREIGN KEY (tipoMueble)
    REFERENCES Mueble(tipo),
    CONSTRAINT FK_PedMueble_codigo FOREIGN KEY (codigoPedido)
    REFERENCES Pedido(codigo)
);


CREATE TABLE Cliente (
    direccion VARCHAR(50) NOT NULL,
    nombre VARCHAR(30),
    apellidos VARCHAR(50),
    codigoPedido VARCHAR(10) NOT NULL,

    PRIMARY KEY (direccion),
    CONSTRAINT FK_Cliente_codPedido FOREIGN KEY (codigoPedido)
    REFERENCES Pedido(codigo)
);