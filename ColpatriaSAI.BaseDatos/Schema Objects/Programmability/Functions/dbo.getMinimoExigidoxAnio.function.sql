-- =============================================
-- Author:		Diego Armando Bautista lagos
-- Create date: 19/04/2012
-- Description:	Retorna el valor que corresponda según el año del periodo evaluado
-- =============================================
CREATE FUNCTION [dbo].[getMinimoExigidoxAnio]
(
	@periodoIngresado DATETIME,
	@periodoEvaluado DATETIME,
	@minimoExigido FLOAT,
	@minimoExigidoAnterior FLOAT
)
RETURNS FLOAT
AS
BEGIN
	DECLARE @minimo FLOAT
	
	SELECT
		@minimo =
		CASE
			WHEN YEAR(@periodoEvaluado) = YEAR(@periodoIngresado) THEN @minimoExigido
			WHEN YEAR(@periodoEvaluado) < YEAR(@periodoIngresado) THEN @minimoExigidoAnterior
		END
	RETURN @minimo
END