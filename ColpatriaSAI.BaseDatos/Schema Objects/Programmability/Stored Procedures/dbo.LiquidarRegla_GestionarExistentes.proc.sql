-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 03/10/2011
-- Description:	Gestiona tablas utilizadas en la liquidación de reglas agrupadas para almacenar las agrupaciones de subreglas creando la tabla 'SubReglasTemp' y 'liquidacionReglasAgrupadas'
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_GestionarExistentes]
	@iCrear int,
	@subregla_id int
AS
BEGIN
	DECLARE @crear int=@iCrear, @SubRegla int=@subregla_id
	IF @crear = 1 BEGIN
		-- Crear tabla para almacenar subreglas simples y otra para guardar las agrupadas
		IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubReglasTemp]') AND type in (N'U'))  DROP TABLE SubReglasTemp
		CREATE TABLE SubReglasTemp (id int)
		
		IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[liquidacionReglasAgrupadas]') AND type in (N'U')) DROP TABLE liquidacionReglasAgrupadas
		CREATE TABLE liquidacionReglasAgrupadas (subregla_id int NULL, subregla_id1 int NULL, resultado1 bit NULL, subregla_id2 int NULL, resultado2 bit NULL, operador varchar(50) NULL, resultado bit NULL)
	END
	ELSE IF @crear = 0 BEGIN
		-- Eliminar tabla para almacenar subreglas simples, la de agrupaciones se elimina al final de la liquidación
		IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SubReglasTemp]') AND type in (N'U')) DROP TABLE SubReglasTemp
	END
	ELSE IF @crear = 2 BEGIN
		-- Almacena una subregla simple
		IF NOT EXISTS(SELECT * FROM SubReglasTemp WHERE id = @SubRegla) BEGIN
			INSERT INTO SubReglasTemp VALUES (@SubRegla)
		END
	END
END-- SELECT * FROM #SubReglasTemp