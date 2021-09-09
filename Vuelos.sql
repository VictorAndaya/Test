CREATE DATABASE VuelosMX;
use VuelosMX;

CREATE TABLE aerolineas (
id_aerolinea INT NOT NULL AUTO_INCREMENT UNIQUE, 
nombre_aerolinea VARCHAR(60) NOT NULL, PRIMARY KEY(id_aerolinea) 
);

INSERT INTO aerolineas (nombre_aerolinea)VALUES ('Volaris');
INSERT INTO aerolineas (nombre_aerolinea)VALUES ('Aeromar');
INSERT INTO aerolineas (nombre_aerolinea)VALUES ('Interjet');
INSERT INTO aerolineas (nombre_aerolinea)VALUES ('Aeromexico');

CREATE TABLE aeropuertos (
id_aeropuerto INT NOT NULL AUTO_INCREMENT UNIQUE,
nombre_aerolinea VARCHAR(60), PRIMARY KEY (id_aeropuerto) 
);
 
 INSERT INTO aeropuertos (nombre_aerolinea)VALUES('Benito Juarez');
 INSERT INTO aeropuertos (nombre_aerolinea)VALUES('Guanajuato');
 INSERT INTO aeropuertos (nombre_aerolinea)VALUES('La Paz');
 INSERT INTO aeropuertos (nombre_aerolinea)VALUES('Oaxaca');
 
 CREATE TABLE movimientos (
 id_movimiento INT NOT NULL AUTO_INCREMENT UNIQUE, 
 descripcion VARCHAR(45), PRIMARY KEY (id_movimiento)
 ); 
 
 INSERT INTO movimientos (descripcion) VALUES ('Salida');
 INSERT INTO movimientos (descripcion) VALUES ('Llegada');

 CREATE TABLE vuelos 
 (id_aerolinea INT, 
 id_aeropuerto INT, 
 id_movimiento INT,
 dia DATE NOT NULL,
 CONSTRAINT FK_AEROLINEA FOREIGN KEY (id_aerolinea) REFERENCES aerolineas(id_aerolinea),
 CONSTRAINT FK_AEROPUERTO FOREIGN KEY (id_aeropuerto) REFERENCES aeropuertos(id_aeropuerto),
 CONSTRAINT FK_MOVIMIENTO FOREIGN KEY (id_movimiento) REFERENCES movimientos(id_movimiento)
 );
 
 INSERT INTO vuelos (ID_AEROLINEA, ID_AEROPUERTO, ID_MOVIMIENTO, DIA) VALUES 
 (1,1,1,'2021-05-02'),
 (2,1,1,'2021-05-02'),
 (3,2,2,'2021-05-02'),
 (4,3,2,'2021-05-02'),
 (1,3,2,'2021-05-02'),
 (2,1,1,'2021-05-02'),
 (2,3,1,'2021-05-04'),
 (3,4,1,'2021-05-04'),
 (3,4,1,'2021-05-04');

SELECT * FROM aeropuertos;
SELECT * FROM aerolineas;
SELECT * FROM movimientos;
SELECT * FROM vuelos;

/*1. ¿Cuál es el nombre aeropuerto que ha tenido mayor movimiento durante el año?*/
SELECT a.nombre_aerolinea AS AEROPUERTO, count(*) AS Movimientos 
from vuelos v 
inner join aeropuertos a ON v.ID_AEROPUERTO=a.ID_AEROPUERTO 
GROUP by v.ID_AEROPUERTO 
ORDER by Movimientos DESC LIMIT 1;

/*2. ¿Cuál es el nombre aerolínea que ha realizado mayor número de vuelos durante el año?*/
SELECT a.NOMBRE_AEROLINEA AS AEROLINEA, count(*)AS Vuelos 
from vuelos v 
inner join aerolineas a ON v.ID_AEROLINEA=a.ID_AEROLINEA 
GROUP by v.ID_AEROLINEA 
ORDER by Vuelos DESC LIMIT 1;

/*3. ¿En qué día se han tenido mayor número de vuelos?*/
SELECT (DIA) AS DIA, count(*) AS Vuelos 
from vuelos 
group by  DIA 
ORDER BY Vuelos DESC LIMIT 1;

/*4. ¿Cuáles son las aerolíneas que tienen mas de 2 vuelos por día?*/
SELECT a.ID_AEROLINEA AS AEROLINEA, count(*) AS Vuelos 
from vuelos v 
inner join aerolineas a ON v.ID_AEROLINEA=a.ID_AEROLINEA 
group by v.ID_AEROLINEA 
HAVING COUNT(DAY(DIA)) > 2 ORDER BY DATE('2021-05-02');