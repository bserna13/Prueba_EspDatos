
-- Abra el SQL Management y Cree las siguientes tablas en una base datos de sql 


-- PUNTO 1:
-- Crear la tabla CRM_CARTERA
CREATE TABLE CRM_CARTERA (
    NroFra FLOAT,
    TipoFra NCHAR(4),
    Facturador NCHAR(10),
    EstadoPago NCHAR(4),
    FechaFra DATETIME,
    Total FLOAT,
    Vence DATETIME,
    FechaDcto DATETIME,
    Clasifica NCHAR(3),
    CondPago NCHAR(3),
    FechaConsigna DATETIME
);
-- PUNTO 2:
-- Crear la tabla CRM_TERCEROS
CREATE TABLE CRM_TERCEROS (
    Facturador NCHAR(10),
    Nombre NCHAR(100),
    Ciudad NCHAR(30),
    Depto NCHAR(30),
    Año NCHAR(30)  
);
-- PUNTO 3:
-- Crear la tabla PREDICTIVO
CREATE TABLE PREDICTIVO (
    Año INT,  
    MES INT,
    AnioMes VARCHAR(7),
    PKID VARCHAR(12),
    CantidadVentaMes FLOAT
);


-- PUNTO 4: LLENADO DE DATOS POR MEDIO DE BULK COPY:
BULK INSERT CRM_CARTERA
FROM 'C:\Users\Brahi\Documents\GitHub\Prueba_EspDatos\CRM_CARTERA.csv'
WITH
(
    FIELDTERMINATOR = ';',  -- Especifica el separador de campos
    ROWTERMINATOR = '\n',   -- Especifica el separador de filas
    FIRSTROW = 2,           -- Si tu CSV tiene encabezados, usa esta opción para empezar desde la segunda fila
    CODEPAGE = '65001',     -- Asegura que se use la codificación UTF-8
    TABLOCK                -- Utiliza un bloqueo de tabla para la operación de inserción masiva
);

BULK INSERT CRM_TERCEROS
FROM 'C:\Users\Brahi\Documents\GitHub\Prueba_EspDatos\CRM_TERCEROS.csv'
WITH
(
    FIELDTERMINATOR = ';',  -- Especifica el separador de campos
    ROWTERMINATOR = '\n',   -- Especifica el separador de filas
    FIRSTROW = 2,           -- Si tu CSV tiene encabezados, usa esta opción para empezar desde la segunda fila
    CODEPAGE = '65001',     -- Asegura que se use la codificación UTF-8
    TABLOCK                -- Utiliza un bloqueo de tabla para la operación de inserción masiva
);

BULK INSERT PREDICTIVO
FROM 'C:\Users\Brahi\Documents\GitHub\Prueba_EspDatos\PREDICTIVO.csv'
WITH
(
    FIELDTERMINATOR = ';',  -- Separador de campos
    ROWTERMINATOR = '\n',   -- Especifica el separador de filas
    FIRSTROW = 2,           -- Empezar desde la segunda fila
    CODEPAGE = '65001',     -- Codificación UTF-8
    TABLOCK                -- Utiliza un bloqueo de tabla para la operación de inserción
);

-- PUNTO 5:
SELECT top 10 * FROM CRM_TERCEROS
WHERE Ciudad like '%Medellin%'; 

-- PUNTO 6:
SELECT Ciudad, COUNT(Facturador) AS TotalFacturadores
FROM CRM_Terceros
GROUP BY Ciudad;

-- PUNTO 7:
SELECT NroFra, TipoFra, SUM(Total) AS TotalSumado
FROM CRM_Cartera
WHERE Vence < GETDATE()
GROUP BY NroFra, TipoFra;

-- PUNTO 8:
SELECT TOP 100 Facturador FROM CRM_TERCEROS;

-- PUNTO 9:
SELECT TOP 20 *,
    DATEDIFF(day, FechaConsigna, VENCE) AS DiasDisponibles
FROM CRM_CARTERA
ORDER BY DiasDisponibles DESC;
