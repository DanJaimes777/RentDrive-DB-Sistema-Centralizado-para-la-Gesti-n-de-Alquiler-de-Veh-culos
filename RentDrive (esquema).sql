/* RentDrive: Sistema de gestión de alquiler de vehículos */

CREATE DATABASE rentdrive;
USE rentdrive;

CREATE TABLE membresia (
    id_membresia INT AUTO_INCREMENT,
    precio       DECIMAL(10,2) NOT NULL,
    descuento    DECIMAL(5,2)  NOT NULL,
    duracion     INT           NOT NULL,
    beneficios   VARCHAR(255),
    PRIMARY KEY (id_membresia)
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

INSERT INTO membresia (precio, descuento, duracion, beneficios) VALUES
(50000.00, 5.00, 1, 'Descuento en alquileres y atencion prioritaria'),
(120000.00, 10.00, 3, 'Descuento en alquileres y un conductor adicional gratis'),
(220000.00, 15.00, 6, 'Descuento en alquileres, conductor adicional y cancelacion gratis'),
(400000.00, 20.00, 12, 'Descuento en alquileres, seguro incluido y vehiculo de reemplazo'),
(650000.00, 25.00, 24, 'Todos los beneficios y mantenimiento incluido');

/* id_ciudad: 1 Bucaramanga, 2 Bogota, 3 Medellin, 4 Cali, 5 Barranquilla */
INSERT INTO ciudad (nombre) VALUES
('Bucaramanga'),
('Bogota'),
('Medellin'),
('Cali'),
('Barranquilla');

/* ids 1 a 5: Ocasionales ('O') | ids 6 a 10: Empresariales ('E') */
INSERT INTO usuario (telefono, direccion, id_membresia, tipo) VALUES
('3101234567', 'Carrera 27 # 45-10', 1, 'O'),
('3207654321', 'Calle 36 # 15-22', NULL, 'O'),
('3159876543', 'Avenida Libertadores # 8-31', 3, 'O'),
('3012345678', 'Carrera 33 # 52-14', 2, 'O'),
('3186543210', 'Calle 52 # 23-40', NULL, 'O'),
('3112223344', 'Carrera 29 # 41-05', 4, 'E'),
('3223334455', 'Calle 72 # 10-34', 5, 'E'),
('3134445566', 'Avenida Libertadores # 20-15', NULL, 'E'),
('3045556677', 'Calle 5 # 38-20', 3, 'E'),
('3156667788', 'Carrera 51 # 80-15', NULL, 'E');

INSERT INTO ocasional (id_usuario, dni, nombre, apellido) VALUES
(1, '1098123456', 'Carlos', 'Ruiz'),
(2, '1098765432', 'Ana', 'Torres'),
(3, '1005555123', 'Luis', 'Pardo'),
(4, '1098444789', 'Maria', 'Gomez'),
(5, '1005987654', 'Andres', 'Rojas');

INSERT INTO empresarial (id_usuario, nit, razon_social) VALUES
(6,  '9001234561', 'Transportes Andinos S.A.S.'),
(7,  '9002345672', 'Constructora Horizonte Ltda.'),
(8,  '9003456783', 'Logistica Express S.A.S.'),
(9,  '9004567894', 'Inversiones del Caribe S.A.'),
(10, '9005678905', 'Turismo y Aventura S.A.S.');

INSERT INTO vehiculo (matricula, tipo, precio, id_ciudad) VALUES
('BGA123', 'Automovil',   150000.00, 1),
('BOG456', 'Camioneta',   250000.00, 2),
('MED789', 'Motocicleta',  60000.00, 3),
('CAL321', 'Van',         300000.00, 4),
('BAQ654', 'Automovil',   140000.00, 5),
('BGA987', 'Camioneta',   260000.00, 1);

INSERT INTO reserva (fecha_inicio, fecha_fin, estado, id_usuario, id_vehiculo) VALUES
('2026-11-15', '2026-11-18', 'Confirmada', 1, 1),
('2026-11-20', '2026-11-25', 'Pendiente',  6, 2),
('2026-10-05', '2026-10-08', 'Finalizada', 3, 3),
('2026-11-12', '2026-11-14', 'Cancelada',  2, 4),
('2026-12-01', '2026-12-10', 'Confirmada', 7, 5),
('2026-10-20', '2026-10-22', 'Finalizada', 8, 6);

INSERT INTO alquila (id_vehiculo, id_usuario, fecha_inicio, fecha_fin, factura) VALUES
(3, 3,  '2026-10-05', '2026-10-08', 'FAC-0001'),
(6, 8,  '2026-10-20', '2026-10-22', 'FAC-0002'),
(1, 1,  '2026-09-10', '2026-09-13', 'FAC-0003'),
(2, 9,  '2026-09-15', '2026-09-20', 'FAC-0004'),
(4, 5,  '2026-08-01', '2026-08-05', 'FAC-0005');


SELECT o.nombre, o.apellido, u.telefono
FROM ocasional o
JOIN usuario u ON o.id_usuario = u.id_usuario
WHERE o.nombre LIKE 'A%';

SELECT v.matricula, v.tipo, v.precio, c.nombre AS ciudad
FROM vehiculo v
JOIN ciudad c ON v.id_ciudad = c.id_ciudad
WHERE v.precio BETWEEN 100000 AND 250000;

SELECT e.razon_social, m.descuento, m.beneficios
FROM empresarial e
JOIN usuario u ON e.id_usuario = u.id_usuario
LEFT JOIN membresia m ON u.id_membresia = m.id_membresia
WHERE e.razon_social LIKE '%S.A.S.%';


SELECT r.id_reserva, r.estado, v.matricula
FROM reserva r
JOIN vehiculo v ON r.id_vehiculo = v.id_vehiculo
WHERE r.fecha_inicio >= '2026-11-01' AND r.fecha_inicio <= '2026-11-30';


SELECT id_membresia, precio, beneficios
FROM membresia
WHERE precio < 300000 AND beneficios LIKE '%conductor%';


SELECT a.factura, v.matricula, v.tipo, a.fecha_inicio
FROM alquila a
JOIN vehiculo v ON a.id_vehiculo = v.id_vehiculo
WHERE a.fecha_inicio > '2026-09-30';

SELECT v.matricula, v.tipo, v.precio, c.nombre AS ciudad
FROM vehiculo v
JOIN ciudad c ON v.id_ciudad = c.id_ciudad
WHERE v.tipo LIKE 'C%' AND v.precio > 200000;

SELECT r.estado, o.nombre, o.apellido, r.fecha_inicio
FROM reserva r
JOIN usuario u ON r.id_usuario = u.id_usuario
JOIN ocasional o ON u.id_usuario = o.id_usuario
WHERE r.estado LIKE '%ada';

SELECT u.id_usuario, u.direccion, m.duracion
FROM usuario u
LEFT JOIN membresia m ON u.id_membresia = m.id_membresia
WHERE m.duracion IS NULL OR m.duracion < 6;


SELECT e.razon_social, a.factura, a.fecha_inicio, a.fecha_fin
FROM alquila a
JOIN usuario u ON a.id_usuario = u.id_usuario
JOIN empresarial e ON u.id_usuario = e.id_usuario
WHERE a.fecha_fin < '2026-10-31';
