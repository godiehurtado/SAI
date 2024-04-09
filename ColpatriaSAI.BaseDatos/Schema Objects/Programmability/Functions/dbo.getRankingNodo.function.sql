-- =============================================
-- Author:		Andres Bravo
-- Create date: 21/02/2012
-- Description:	Obtiene el ranking de un nodo en un periodo
-- =============================================
CREATE FUNCTION [dbo].[getRankingNodo] (
	@fechaIni date,
    @fechaFin date,
	@jerarquiaDetalle_id int
)
RETURNS float
AS
BEGIN

	--DECLARE @fechaIni date = '2011-02-01' 
	--DECLARE @fechaFin date = '2011-03-28' 
	DECLARE @anioIni int, @mesIni int, @anioFin int, @mesFin int
	DECLARE @posicionRanking float = 0
	
	SET @anioIni = YEAR(@fechaIni)
	SET @mesIni = MONTH(@fechaIni)
	SET @anioFin = YEAR(@fechaFin)
	SET @mesFin = MONTH(@fechaFin)  

	SELECT @posicionRanking = AVG(posicionRanking)
	FROM VistaRanking
	WHERE
		(CAST(anio AS NVARCHAR) + (CASE WHEN LEN(mes) = 1 then '0' + CAST(mes AS NVARCHAR) ELSE CAST(mes AS NVARCHAR) END)) >= (CAST(@anioIni AS NVARCHAR) + (CASE WHEN LEN(@mesIni) = 1 then '0' + CAST(@mesIni AS NVARCHAR) ELSE CAST(@mesIni AS NVARCHAR) END))
		AND
		(CAST(anio AS NVARCHAR) + (CASE WHEN LEN(mes) = 1 then '0' + CAST(mes AS NVARCHAR) ELSE CAST(mes AS NVARCHAR) END)) <= (CAST(@anioFin AS NVARCHAR) + (CASE WHEN LEN(@mesFin) = 1 then '0' + CAST(@mesFin AS NVARCHAR) ELSE CAST(@mesFin AS NVARCHAR) END))			
		AND jerarquiaDetalle_id = @jerarquiaDetalle_id	
		
	RETURN @posicionRanking
END