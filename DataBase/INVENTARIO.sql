/* ---------------------------------------------------- */
/*  Generated by Enterprise Architect Version 15.0 		*/
/*  Created On : 19-jun.-2023 18:54:33 				*/
/*  DBMS       : SQL Server 2012 						*/
/* ---------------------------------------------------- */

/* Drop Foreign Key Constraints */

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_INVENTARIO_OFICINA]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [INVENTARIO] DROP CONSTRAINT [FK_INVENTARIO_OFICINA]
GO

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[FK_INVENTARIO_PARTIDA]') AND OBJECTPROPERTY(id, N'IsForeignKey') = 1) 
ALTER TABLE [INVENTARIO] DROP CONSTRAINT [FK_INVENTARIO_PARTIDA]
GO

/* Drop Tables */

IF EXISTS (SELECT 1 FROM dbo.sysobjects WHERE id = object_id(N'[INVENTARIO]') AND OBJECTPROPERTY(id, N'IsUserTable') = 1) 
DROP TABLE [INVENTARIO]
GO

/* Create Tables */

CREATE TABLE [INVENTARIO]
(
	[INV_NO] varchar(50) NOT NULL,
	[DEPTO] varchar(50) NULL,
	[OFICINA_NO] varchar(50) NULL,
	[AUXILIAR] date NULL,
	[PARTIDA_NO] varchar(50) NULL,
	[COD_ENTIDAD] varchar(50) NULL,
	[COD_ANTIGUO] varchar(50) NULL,
	[SERIE] varchar(50) NULL,
	[DESCRIPCION] varchar(50) NULL,
	[ESTADO] varchar(50) NULL,
	[GEOGRAFICA] varchar(50) NULL,
	[EMP_NO] varchar(50) NULL,
	[PROCEDENCIA] varchar(50) NULL,
	[FECHA_INGRESO] varchar(50) NULL,
	[OBSERVACIONES] varchar(50) NULL
)
GO

/* Create Primary Keys, Indexes, Uniques, Checks */

ALTER TABLE [INVENTARIO] 
 ADD CONSTRAINT [PK_INVENTARIO]
	PRIMARY KEY CLUSTERED ([INV_NO] ASC)
GO

/* Create Foreign Key Constraints */

ALTER TABLE [INVENTARIO] ADD CONSTRAINT [FK_INVENTARIO_OFICINA]
	FOREIGN KEY ([OFICINA_NO]) REFERENCES [OFICINA] ([OFICINA_NO]) ON DELETE No Action ON UPDATE No Action
GO

ALTER TABLE [INVENTARIO] ADD CONSTRAINT [FK_INVENTARIO_PARTIDA]
	FOREIGN KEY ([PARTIDA_NO]) REFERENCES [PARTIDA] ([PARTIDA_NO]) ON DELETE No Action ON UPDATE No Action
GO