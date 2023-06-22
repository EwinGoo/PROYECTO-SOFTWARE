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
	[ESTADO] char(1),
	[ROL_NO] INT,
	CONSTRAINT FK_USUARIO_1 FOREIGN KEY([ROL_NO]) REFERENCES [ROLES]([ROL_NO])  
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
/*		TABLA OFICINA		*/

CREATE TABLE [OFICINA]
(
	[OFICINA_NO] varchar(10) primary key NOT NULL,
	[DEPTO] varchar(50) NULL,
	[COD_OFICINA] int NULL,
	[NOMBRE_OF] varchar(100) NULL,
	[EMP_NO] varchar(10) NULL,
	[UBICACION] varchar(500) NULL
)
GO
CREATE SEQUENCE seq_ofi_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;	
GO
CREATE TRIGGER trg_asigna_id_ofi
ON oficina
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @SiguienteValor INT;
    DECLARE @NuevoID VARCHAR(10);
    SET @SiguienteValor = NEXT VALUE FOR seq_ofi_id;
    SET @NuevoID = 'OF-' + RIGHT('00' + CAST(@SiguienteValor AS VARCHAR(10)), 2);
    INSERT INTO oficina (oficina_no,depto,cod_oficina,nombre_of,emp_no,ubicacion)
    SELECT @NuevoID,depto,cod_oficina,nombre_of,emp_no,ubicacion
    FROM inserted;
END;
GO
DECLARE @contador INT
SET @contador = 1

WHILE @contador <= 13
BEGIN
    SELECT NEXT VALUE FOR seq_ofi_id AS ValorSecuencia

    SET @contador = @contador + 1
END
GO
/*		TABLA EMPLEADO		*/

CREATE TABLE [EMPLEADO]
(
	[EMP_NO] varchar(10) primary key NOT NULL,
	[CI] varchar(50) NOT NULL,
	[EXP] varchar(50) NULL,
	[NOMBRE] varchar(150) NULL,
	[CARGO] varchar(100) NULL,
	[OFICINA_NO] varchar(10) NULL,
	[UNIDAD] varchar(100) NULL,
	[AREA_TRAB] varchar(150) NULL,
	[CELULAR] int NULL,
	[PROFESION] varchar(50) NULL,
	[DPTO] varchar(50) NULL,
	[USUARIO_NO] varchar(10) NULL,
	constraint fk_empleado_1 FOREIGN KEY ([USUARIO_NO]) REFERENCES [USUARIO] ([USUARIO_NO]),
	constraint fk_empleado_2 FOREIGN KEY ([OFICINA_NO]) REFERENCES [OFICINA] ([OFICINA_NO])
)
GO
CREATE SEQUENCE seq_emp_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;	
GO
CREATE TRIGGER trg_asigna_id_emp
ON empleado
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @SiguienteValor INT;
    DECLARE @NuevoID VARCHAR(10);
    SET @SiguienteValor = NEXT VALUE FOR seq_emp_id;
    SET @NuevoID = 'E-' + RIGHT('000' + CAST(@SiguienteValor AS VARCHAR(10)), 3);
    INSERT INTO empleado (emp_no,ci,exp,nombre,cargo,oficina_no,unidad,area_trab,celular,profesion,usuario_no)
    SELECT @NuevoID,ci,exp,nombre,cargo,oficina_no,unidad,area_trab,celular,profesion,usuario_no
    FROM inserted;
END;
GO
DECLARE @contador INT
SET @contador = 1

WHILE @contador <= 206
BEGIN
    SELECT NEXT VALUE FOR seq_emp_id AS ValorSecuencia

    SET @contador = @contador + 1
END
GO

/* TABLA INVENTARIO */

CREATE TABLE [INVENTARIO]
(
	[INV_NO] varchar(10) PRIMARY KEY NOT NULL,
	[DEPTO] varchar(50) NULL,
	[OFICINA_NO] varchar(10) NULL,
	[AUXILIAR] varchar(50) NULL,
	[PARTIDA_NO] varchar(10) NULL,
	[COD_ENTIDAD] varchar(50) NULL,
	[COD_ANTIGUO] varchar(150) NULL,
	[SERIE] varchar(250) NULL,
	[DESCRIPCION] varchar(250) NULL,
	[ESTADO] varchar(50) NULL,
	[GEOGRAFICA] varchar(250) NULL,
	[ESPECIFICA] varchar(50) NULL,
	[EMP_NO] varchar(10) NULL,
	[PROCEDENCIA] varchar(50) NULL,
	[FECHA_INGRESO] date NULL,
	[OBSERVACIONES] varchar(350) NULL,
	constraint fk_inventario_1 FOREIGN KEY ([OFICINA_NO]) REFERENCES [OFICINA] ([OFICINA_NO]),
	constraint fk_inventario_2 FOREIGN KEY ([PARTIDA_NO]) REFERENCES [PARTIDA] ([PARTIDA_NO]),
	constraint fk_inventario_3 FOREIGN KEY ([EMP_NO]) REFERENCES [EMPLEADO] ([EMP_NO])
)
GO
CREATE SEQUENCE seq_inv_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;	
GO
CREATE TRIGGER trg_asigna_id_inv
ON inventario
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @SiguienteValor INT;
    DECLARE @NuevoID VARCHAR(10);
    SET @SiguienteValor = NEXT VALUE FOR seq_inv_id;
    SET @NuevoID = 'AF-' + RIGHT('0000' + CAST(@SiguienteValor AS VARCHAR(10)), 4);
    INSERT INTO inventario (inv_no,depto,oficina_no,auxiliar,partida_no,cod_entidad,cod_antiguo,serie,descripcion,estado,geografica,especifica,emp_no,procedencia,fecha_ingreso,observaciones)
    SELECT @NuevoID,depto,oficina_no,auxiliar,partida_no,cod_entidad,cod_antiguo,serie,descripcion,estado,geografica,especifica,emp_no,procedencia,fecha_ingreso,observaciones
    FROM inserted;
END;
GO
DECLARE @contador INT
SET @contador = 1

WHILE @contador <= 4780
BEGIN
    SELECT NEXT VALUE FOR seq_inv_id AS ValorSecuencia

    SET @contador = @contador + 1
END
GO

/*		TABLA ASIGNACION		*/

CREATE TABLE [ASIGNACION]
(
	[ASIGNACION_NO] varchar(10) primary key NOT NULL,
	[EMP_NO] varchar(10) NULL,
	[INV_NO] varchar(10) NULL,
	[FECHA_ASIGNACION] date NULL,
	[FECHA_ENTREGA] date NULL,
	[ESTADO] varchar(50) NULL
	constraint fk_asignacion_1 FOREIGN KEY ([EMP_NO]) REFERENCES [EMPLEADO] ([EMP_NO]),
	constraint fk_asignacion_2 FOREIGN KEY ([INV_NO]) REFERENCES [INVENTARIO] ([INV_NO])

)

GO
CREATE SEQUENCE seq_asig_id
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 9999;	
GO
CREATE TRIGGER trg_asigna_id_asig
ON asignacion
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @SiguienteValor INT;
    DECLARE @NuevoID VARCHAR(10);
    SET @SiguienteValor = NEXT VALUE FOR seq_asig_id;
    SET @NuevoID = 'ASI-' + RIGHT('00' + CAST(@SiguienteValor AS VARCHAR(10)), 2);
    INSERT INTO asignacion (asignacion_no,emp_no,inv_no,fecha_asignacion,fecha_entrega,estado)
    SELECT @NuevoID,emp_no,inv_no,fecha_asignacion,fecha_entrega,estado
    FROM inserted;
END;
GO

/*		TABLA AUDITORIA		*/

CREATE TABLE [AUDITORIA]
(
	[AUDITORIA_NO] INT IDENTITY(1,1) PRIMARY KEY,
	[EMP_NO] varchar(50) NULL,
	[INV_NO] varchar(50) NULL,
	[ASIGNACION_NO] varchar(50) NULL,
	[USUARIO_SYS] varchar(50) NULL,
	[FECHA] datetime NULL,
	[OPERACION] varchar(50) NULL
)
GO

--APLICAMOS EL TRIGGER PARA DAR DE BAJA (ELIMINAR)
CREATE TRIGGER [ELIMINAR]
ON ASIGNACION
FOR DELETE
AS
	SET NOCOUNT ON
	INSERT INTO AUDITORIA(EMP_NO,INV_NO,ASIGNACION_NO,USUARIO_SYS,FECHA,OPERACION)
	SELECT EMP_NO,INV_NO,ASIGNACION_NO,SYSTEM_USER,GETDATE(),'ELIMINADO'
	FROM DELETED
GO
CREATE TRIGGER [INSERTAR]
ON ASIGNACION
FOR INSERT     --FOR AFTER DESPUES
AS 
	INSERT INTO AUDITORIA(EMP_NO,INV_NO,ASIGNACION_NO,USUARIO_SYS,FECHA,OPERACION)
	SELECT EMP_NO,INV_NO,ASIGNACION_NO,SYSTEM_USER,GETDATE(),'INSERCION'
	FROM INSERTED
GO
--CREAMOS TRIGGER PARA ACTUALIZAR A LA TABLA CLIENTE.
CREATE TRIGGER [ACTUALIZAR]
ON ASIGNACION
AFTER UPDATE
AS
	SET NOCOUNT ON
	INSERT INTO AUDITORIA(EMP_NO,INV_NO,ASIGNACION_NO,USUARIO_SYS,FECHA,OPERACION)
	SELECT EMP_NO,INV_NO,ASIGNACION_NO,SYSTEM_USER,GETDATE(),'ACTUALIZADO'
	FROM INSERTED;
GO















