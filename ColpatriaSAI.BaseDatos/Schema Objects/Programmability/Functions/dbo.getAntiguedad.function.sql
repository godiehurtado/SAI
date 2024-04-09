-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 21/02/2012
-- Description:	Calcula la antiguedad a partir de dos fechas, de ingreso y actual
-- =============================================
CREATE FUNCTION [dbo].[getAntiguedad]
(
	@FechaIngreso DATETIME,
	@FechaCalculo DATETIME
)
RETURNS FLOAT
AS
BEGIN
	DECLARE
		@Antiguedad FLOAT,
		@AnioCalculo FLOAT,
		@MesCalculo FLOAT,
		@AnioIngreso FLOAT,
		@MesIngreso FLOAT
	
	SELECT
		@AnioCalculo = YEAR(@FechaCalculo)
		, @MesCalculo = MONTH(@FechaCalculo)
		, @AnioIngreso = YEAR(@FechaIngreso)
		, @MesIngreso = MONTH(@FechaIngreso)

	SELECT @Antiguedad = (((@AnioCalculo - @AnioIngreso) * 360) + ((@MesCalculo - @MesIngreso + 1) * 30)) / 360;

	RETURN @Antiguedad
END
