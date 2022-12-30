/*
UNIVERSIDAD DOMINICANA O&M


Gabriel Antonio Carrasco Vásquez
21-MIIT-1-010

Administración de Base de Datos

Sección 0541

*/

USE [master];
GO 
IF DB_ID('traveler') IS NOT NULL
BEGIN
	ALTER DATABASE traveler SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE traveler SET ONLINE;
	DROP DATABASE  traveler;
END
GO

CREATE DATABASE traveler;
GO

USE traveler;


CREATE TABLE Destinos (id INT NOT NULL  PRIMARY KEY IDENTITY,
nombre NVARCHAR(75) NOT NULL, region NVARCHAR(75) NOT NULL,
estrellas DECIMAL (2,1) NOT NULL);

CREATE TABLE Clientes (id INT NOT NULL PRIMARY KEY IDENTITY,
nombre NVARCHAR(75), telefono NVARCHAR(14) NOT NULL, ciudad
 NVARCHAR(45))


CREATE TABLE Tours (id INT NOT NULL PRIMARY KEY IDENTITY,
destino_id INT NOT NULL FOREIGN KEY REFERENCES Destinos(id),
fecha DATE NOT NULL, precio DECIMAL(8,2) NOT NULL)


CREATE TABLE Reservas (id INT NOT NULL PRIMARY KEY IDENTITY,
cliente_id INT NOT NULL FOREIGN KEY REFERENCES Clientes(id),
tour_id INT NOT NULL FOREIGN KEY REFERENCES Tours(id),
cant_personas INTEGER NOT NULL, costo Decimal (8,1) NOT NULL)


CREATE TABLE Pagos  (id INT NOT NULL PRIMARY KEY IDENTITY,
reserva_id  INT NOT NULL FOREIGN KEY REFERENCES Reservas(id),
monto DECIMAL (8,2) NOT NULL, fecha DATE NOT NULL)


INSERT INTO Destinos VALUES
('Playa Macao', 'Punta Cana', 4.0),
('Bahía Las Águilas', 'Pedernales', 4.5),
('Dunas de Baní', 'Baní', 4.3),
('Los Tres Ojos', 'Santo Domingo', 4.7),
('Cueva de la Virgen', 'Bahoruco', 4.2),
('Playa Dorada', 'Puerto Plata', 4.6),
('Isla Saona', 'La Altagracia', 4.5),
('Charcos de Damajagua', 'Puerto Plata', 4.6),
('Isla Catalina', 'La Roma', 4.7),
('Jarabacoa', 'Jarabacoa', 4.8),
('Playa Dorada', 'Puerto Plata', 4.6),
('Cap Cana', 'Punta Cana', 4.6)

INSERT INTO Clientes VALUES
('Bielka Valdez','829-778-4523','Santo Domingo'),
('Nicanor Santana','809-458-2658','Santo Domingo'),
('Julissa García','829-365-5489','Monte Plata'),
('Cesarina Ambrosio','849-414-5874','San Cristóbal'),
('Jaison Otáñez','829-668-3358','San Cristóbal'),
('Claudio Mella','849-885-6998','Santo Domingo'),
('Lucinda Vivieca','809-770-1058','Monte Plata'),
('Rosanna Caamaño','849-785-4789','Haina'),
('Isabel Puentes','829-847-5878','Santo Domingo'),
('Santa Trinidad','809-695-4780','San Pedro de Macorís')


INSERT INTO Tours VALUES
(1, '2023-01-07',2500),
(1, '2023-01-14',2500),
(1, '2023-01-21',2900),
(2, '2023-01-08',2700),
(2, '2023-01-15',2800),
(2, '2023-01-22',2700),
(3, '2023-01-08',2400),
(4, '2023-01-21',2200),
(4, '2023-02-05',1800),
(5, '2023-02-05',2500),
(6, '2023-02-11',1850),
(7, '2023-02-12',2800),
(8, '2023-02-11',2200),
(9, '2023-02-19',1900),
(10, '2023-02-19',2100)


INSERT INTO Reservas VALUES
(1,1,2,(SELECT precio*2 from Tours Where id=1)), 
(2,1,4,(SELECT precio*4 from Tours Where id=1)), 
(3,5,1,(SELECT precio*1 from Tours Where id=5)), 
(4,3,3,(SELECT precio*3 from Tours Where id=3)), 
(5,6,2,(SELECT precio*2 from Tours Where id=6)), 
(6,4,2,(SELECT precio*2 from Tours Where id=4)), 
(7,8,4,(SELECT precio*4 from Tours Where id=8)), 
(8,2,1,(SELECT precio*1 from Tours Where id=2)), 
(9,3,2,(SELECT precio*2 from Tours Where id=3)), 
(10,1,1,(SELECT precio*1 from Tours Where id=1))


INSERT INTO Pagos VALUES
(1, (SELECT costo*0.5 FROM Reservas WHERE id=1), '2022-12-15'),
(2, (SELECT costo*0.5 FROM Reservas WHERE id=2), '2022-12-17'),
(3, (SELECT costo*0.5 FROM Reservas WHERE id=3), '2022-12-20'),
(4, (SELECT costo*0.5 FROM Reservas WHERE id=4), '2022-12-21'),
(5, (SELECT costo*0.5 FROM Reservas WHERE id=5), '2022-12-20'),
(6, (SELECT costo*0.5 FROM Reservas WHERE id=6), '2022-12-15'),
(7, (SELECT costo*0.5 FROM Reservas WHERE id=7), '2022-12-20'),
(8, (SELECT costo*0.5 FROM Reservas WHERE id=8), '2022-12-22'),
(9, (SELECT costo*0.5 FROM Reservas WHERE id=9), '2022-12-17'),
(10, (SELECT costo*0.5 FROM Reservas WHERE id=10), '2022-12-19')

SELECT * FROM Destinos;
SELECT * FROM Tours;
SELECT * FROM Clientes;
SELECT * FROM Reservas;
SELECT * FROM Pagos;

SELECT c.nombre AS Cliente, d.nombre AS Destino, d.region AS Lugar, 
t.fecha as Fecha, t.precio AS 'P/P', r.cant_personas AS 'Cant.', 
r.costo as Costo, p.monto AS
Pagado FROM Pagos p LEFT JOIN Reservas r ON p.reserva_id=r.id
LEFT JOIN Tours t ON r.tour_id=t.id LEFT JOIN Clientes c on 
r.cliente_id=c.id LEFT JOIN Destinos d ON t.destino_id=d.id

