
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Proceso de Precierre de Negocios y Recaudos. Durante la carga de Negocios y Recaudos 
--              se valida si la fecha del día de hoy es la fecha de cierre por compañía, si es el día
--              de cierre, los Negocios y Recaudos se marcan con estado 2, de lo contrario se marcan con 1.				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_PreCierre] @compania_id AS NVARCHAR(5)
	,@sistema AS NVARCHAR(20)
	,@tabla AS NVARCHAR(50)
AS
BEGIN
	DECLARE @fechaDia AS DATETIME = (SELECT CONVERT(DATETIME, CONVERT(VARCHAR(10), GETDATE(), 103), 103))
	DECLARE @fechaCierre AS DATETIME = (
		SELECT CONVERT(DATETIME, CONVERT(VARCHAR(10), fechaCierre, 103), 103) FROM PeriodoCierre WHERE compania_id = @compania_id
		AND estado = 1
		)
	DECLARE @mesCierre AS NVARCHAR(5) = (
		SELECT mesCierre FROM PeriodoCierre WHERE compania_id = @compania_id
		AND estado = 1
		)
	DECLARE @anioCierre AS NVARCHAR(5) = (
		SELECT anioCierre FROM PeriodoCierre WHERE compania_id = @compania_id
		AND estado = 1
		)
	DECLARE @tabladef AS NVARCHAR(20) = (SELECT SUBSTRING(@tabla, 1, 7))
	DECLARE @Consulta VARCHAR(500)

	--  Si existen registros en Recaudostemp[...]compania o Negociostemp[...]compania, se borran los registros de la tabla Recaudo o Negocio donde el estado sea abierto (1)
	IF (@tabladef = 'Recaudo')
	BEGIN
		DELETE
		FROM Recaudo
		WHERE estadoCierre = 1
			AND compania_id = @compania_id
			AND sistema = @sistema
	END
	ELSE
		IF (@tabladef = 'Negocio')
		BEGIN
			DELETE
			FROM Negocio
			WHERE estadoCierre = 1
				AND compania_id = @compania_id
				AND sistema = @sistema
		END
	
	--  Actualiza los registros de la compania a estado abierto.
	SET @Consulta = 'UPDATE ' + @tabla + ' SET estadoCierre = 1
		, mesCierre = ' + @mesCierre + ' ,anioCierre = ' + @anioCierre + ' WHERE compania_id = ' + @compania_id + ' AND sistema = ''' + @sistema + ''' AND (estadoCierre <> 2 OR estadoCierre IS NULL)'		
	
	EXEC (@Consulta)

	-- Si el dia actual es igual a la fecha de cierre por compañía.
	IF (@fechaDia = @fechaCierre)
	BEGIN
		--  Si existen registros en Recaudostemp[...]compania o Negociostemp[...]compania éstos se actualizan a estado cerrado (2)				
		SET @Consulta = 'UPDATE ' + @tabla + ' SET estadoCierre = 2
		, mesCierre = ' + @mesCierre + ' ,anioCierre = ' + @anioCierre + ' WHERE compania_id = ' + @compania_id + ' AND sistema = ''' + @sistema + ''' AND (estadoCierre <> 2 OR estadoCierre IS NULL)'

	EXEC (@Consulta)

	END
END