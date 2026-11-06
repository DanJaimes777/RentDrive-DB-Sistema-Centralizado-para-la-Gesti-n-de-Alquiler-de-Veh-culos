/* RentDrive: Sistema de gestión de alquiler de vehículos */

CREATE DATABASE rentdrive;
USE rentdrive;

CREATE TABLE membresia (
    id_membresia INT AUTO_INCREMENT,
    precio       DECIMAL(10,2) NOT NULL,
    descuento    DECIMAL(5,2)  NOT NULL,
    duracion     INT           NOT NULL,
    beneficios   VARCHAR(255),
    PRIMARY KEY (id_memebresia)
);

CREATE TABLE ciudad (
    id_ciudad INT AUTO_INCREMENT,
    nombre    VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_ciudad)
);

CREATE TABLE usuario (
    id_usuario   INT AUTO_INCREMENT,
    telefono     VARCHAR(20),
    direccion    VARCHAR(100),
    id_membresia INT,
    tipo         VARCHAR(1) NOT NULL,          /*'O' = Ocasional, 'E' = Empresarial*/
    PRIMARY KEY(id_usuario),
    FOREIGN KEY (id_membresia) REFERENCES membresia(id_membresia)
);

CREATE TABLE ocasional (
    id_usuario INT,
    dni        VARCHAR(20) NOT NULL UNIQUE,
    nombre     VARCHAR(50) NOT NULL,
    apellido   VARCHAR(50) NOT NULL,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE TABLE empresarial (
    id_usuario   INT,
    nit          VARCHAR(20)  NOT NULL UNIQUE,
    razon_social VARCHAR(100) NOT NULL,
    PRIMARY KEY (id_usuario),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);


CREATE TABLE vehiculo (
    id_vehiculo INT AUTO_INCREMENT,
    matricula   VARCHAR(15)   NOT NULL UNIQUE,
    tipo        VARCHAR(30)   NOT NULL,
    precio      DECIMAL(10,2) NOT NULL,
    id_ciudad   INT           NOT NULL,
    PRIMARY KEY (id_vehiculo),
    FOREIGN KEY (id_ciudad) REFERENCES ciudad(id_ciudad)
);


CREATE TABLE reserva (
    id_reserva   INT AUTO_INCREMENT,
    fecha_inicio DATE        NOT NULL,
    fecha_fin    DATE        NOT NULL,
    estado       VARCHAR(20) NOT NULL,
    id_usuario   INT         NOT NULL,
    id_vehiculo  INT         NOT NULL,
    PRIMARY KEY (id_reserva),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo)
);

CREATE TABLE alquila (
    id_vehiculo  INT,
    id_usuario   INT,
    fecha_inicio DATE,
    fecha_fin    DATE,
    factura      VARCHAR(50),
    PRIMARY KEY (id_vehiculo, id_usuario, fecha_inicio),
    FOREIGN KEY (id_vehiculo) REFERENCES vehiculo(id_vehiculo),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);