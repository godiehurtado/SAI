-- =============================================
-- Author:		Frank Payares
-- Create date: 22/09/2011 
-- Description:	Obtener porcentaje por antiguedad del asesor
-- =============================================
CREATE FUNCTION [dbo].[getPorcentajexAntig] (
	@FechaLiqui datetime,
	@FechaIngreso datetime,
	@idCompania int,
	@idRamo int,
	@idLineaNegocio int
)
RETURNS float
AS
BEGIN
	--DECLARE @FechaLiqui datetime='08/01/2010'   DECLARE @FechaIngreso datetime='05/20/2009'   DECLARE @idCompania int=2   DECLARE @idRamo int=1   DECLARE @idLineaNegocio int=1
	DECLARE @Porcentaje float
	
	SELECT @Porcentaje = porcentaje
	FROM	Participaciones
	WHERE	MONTH(fechaIni) = MONTH(@FechaLiqui) AND
			DATEDIFF("M", @FechaIngreso, GETDATE()) = mesesAntiguedad AND
			Participaciones.compania_id = @idCompania AND
			Participaciones.ramo_id = @idRamo AND
			Participaciones.lineaNegocio_id = @idLineaNegocio
	--SELECT @Porcentaje
	RETURN @Porcentaje
END