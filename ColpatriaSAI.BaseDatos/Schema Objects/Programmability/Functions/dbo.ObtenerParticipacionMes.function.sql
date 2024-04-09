-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ObtenerParticipacionMes]
(
	-- Add the parameters for the function here
	@mesesAntiguedad_param as int, 
	@anio_param as int,
	@mes_param as int,
	@compania_id_param as int,
	@ramo_id_param as int,
	@lineaNegocio_id_param as int
)
RETURNS @Participacion TABLE (compania_id int, ramo_id int, lineaNegocio_id int, porcentaje float)
AS
BEGIN

	DECLARE @mesesAntiguedad int = @mesesAntiguedad_param
	DECLARE @anio int = @anio_param
	DECLARE @mes int = @mes_param
	DECLARE @compania_id int = @compania_id_param
	DECLARE @ramo_id int = @ramo_id_param
	DECLARE @lineaNegocio_id int = @lineaNegocio_id_param

	-- *****************************************************
	-- OBTENEMOS LA PARTICIPACION SEGUN EL MES DE ANTIGUEDAD
	-- *****************************************************
	INSERT INTO @Participacion(compania_id, ramo_id, lineaNegocio_id, porcentaje)
	SELECT top 1 compania_id, ramo_id, lineaNegocio_id, porcentaje--,mesesAntiguedad
	FROM participaciones as pa
	WHERE
		pa.compania_id = @compania_id AND pa.ramo_id = @ramo_id AND pa.lineaNegocio_id = @lineaNegocio_id AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(pa.fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(pa.fechaIni)) = 1 then '0' + CAST(MONTH(pa.fechaIni) AS NVARCHAR) ELSE CAST(MONTH(pa.fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(pa.fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(pa.fechaFin)) = 1 then '0' + CAST(MONTH(pa.fechaFin) AS NVARCHAR) ELSE CAST(MONTH(pa.fechaFin) AS NVARCHAR) END))				
		AND pa.mesesAntiguedad > @mesesAntiguedad AND @mesesAntiguedad < pa.mesesAntiguedad
	ORDER BY pa.mesesAntiguedad	
	
	RETURN 
END