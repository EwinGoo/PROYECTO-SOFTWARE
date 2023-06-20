USE [master]
GO
----------------------------------------------------------
-- CREAMOS LA BASE DE DATOS ASIGNACION
CREATE DATABASE ASIGNACION
ON PRIMARY  
(NAME = ASIGNACION_DATA,  
FILENAME = 'C:\IDS\BASE DE DATOS\DB_ASIGNACION.mdf',  
SIZE = 5MB,  MAXSIZE = 10MB,  
FILEGROWTH  = 2%)  
LOG ON  
(NAME = ASIGNACION_LOGICO,  
FILENAME = 'C:\IDS\BASE DE DATOS\DB_ASIGNACION.ldf',  
SIZE = 3MB,  
MAXSIZE = 5MB,  
FILEGROWTH = 1MB);
GO
USE ASIGNACION; -- USAMOS LA BD ASIGNACION
GO
/*		CREAMOS TABLA ROL		*/
CREATE TABLE [ROLES]
(
	[ROL_NO] INT primary key identity(1,1) NOT NULL,
	[ROL] varchar(50) NULL,
	[DESCRIPCION] varchar(50) NULL
)
GO

/*		CREADOS TABLA USUARIOS		*/
CREATE TABLE [USUARIO]
(
	[USUARIO_NO] varchar(10) primary key NOT NULL,
	[CI] varchar(50) NULL,
	[NOMBRE] varchar(50) NULL,
	[PATERNO] varchar(50) NULL,
	[MATERNO] varchar(50) NULL,
	[CARGO] varchar(50) NULL,
	[PROFESION] varchar(50) NULL,
	[USUARIO] varchar(50) NOT NULL unique,
	[PASSWORD] varchar(255) NULL,
	[ESTADO] char(1)
)
GO

CREATE SEQUENCE seq_usu_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;	
GO

CREATE TRIGGER trg_asigna_id_usu
ON usuario
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @SiguienteValor INT;
    DECLARE @NuevoID VARCHAR(10);
    SET @SiguienteValor = NEXT VALUE FOR seq_usu_id;
    SET @NuevoID = 'USU-' + RIGHT('00' + CAST(@SiguienteValor AS VARCHAR(10)), 2);
    INSERT INTO usuario (usuario_no, ci, nombre,paterno,materno,cargo,profesion,usuario,password,estado)
    SELECT @NuevoID, ci, nombre,paterno,materno,cargo,profesion,usuario,password,estado
    FROM inserted;
END;
GO
DECLARE @contador INT
SET @contador = 1

WHILE @contador <= 3
BEGIN
    SELECT NEXT VALUE FOR seq_usu_id AS ValorSecuencia

    SET @contador = @contador + 1
END
GO
/*		TABLA USUARIO_ROLES		*/

CREATE TABLE [USUARIO_ROL]
(
	[USUARIO_ROL_NO] int primary key identity(1,1) not null,
	[ROL_NO] int,
	[USUARIO_NO] varchar(10) NULL,
	constraint [FK_USUARIO_ROL_1] FOREIGN KEY ([ROL_NO]) REFERENCES [ROLES] ([ROL_NO]),
	constraint [FK_USUARIO_ROL_2] FOREIGN KEY ([USUARIO_NO]) REFERENCES [USUARIO] ([USUARIO_NO])
)
GO

/*		TABLA PARTIDA		*/

CREATE TABLE [PARTIDA]
(
	[PARTIDA_NO] varchar(10) primary key NOT NULL,
	[NOMBRE] varchar(150) NULL,
	[PARTIDA] int NULL,
	[VIDA_UTIL] decimal(12,2) NULL,
	[COEFICIENTE] decimal(12,2) NULL,
	[DEPRECIACION] char(1) NULL,
	[ACTUALIZA] char(1) NULL,
	[USUARIO_NO] varchar(10) NULL
	constraint fk_partida_1 FOREIGN KEY ([USUARIO_NO]) REFERENCES [USUARIO] ([USUARIO_NO])
)
GO

CREATE SEQUENCE seq_par_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;	
GO

CREATE TRIGGER trg_asigna_id_par
ON partida
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @SiguienteValor INT;
    DECLARE @NuevoID VARCHAR(10);
    SET @SiguienteValor = NEXT VALUE FOR seq_par_id;
    SET @NuevoID = 'PART-' + RIGHT('00' + CAST(@SiguienteValor AS VARCHAR(10)), 2);
    INSERT INTO partida (partida_no,nombre,partida,vida_util,coeficiente,depreciacion,actualiza,usuario_no)
    SELECT @NuevoID,nombre,partida,vida_util,coeficiente,depreciacion,actualiza,usuario_no
    FROM inserted;
END;
GO
DECLARE @contador INT
SET @contador = 1

WHILE @contador <= 8
BEGIN
    SELECT NEXT VALUE FOR seq_par_id AS ValorSecuencia

    SET @contador = @contador + 1
END
GO



























