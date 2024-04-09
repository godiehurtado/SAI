-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[ObtenerEscalaCumplimiento]
(
	-- Add the parameters for the function here
	@factorxnota_id_param as int, 
	@cumplimiento_param as float,
	@anio_param as int,
	@mes_param as int
)
RETURNS @Escala TABLE (factorInf float, notaInf int, factorSup float, notaSup int)
AS
BEGIN

	DECLARE @factorxnota_id int = @factorxnota_id_param
	DECLARE @cumplimiento float = @cumplimiento_param
	DECLARE @anio float = @anio_param
	DECLARE @mes float = @mes_param

	-- ************************************
	-- OBTENEMOS LA ESCALA DEL CUMPLIMIENTO
	-- ************************************
	INSERT INTO @Escala(factorInf, notaInf, factorSup, notaSup)
	SELECT 
		e1.factor, e1.nota , e2.factor , e2.nota 
	FROM
		(	
		SELECT top 1 pfxn.id, factor, nota
		FROM periodofactorxnota as pfxn
		INNER JOIN factorxnotadetalle as fxnd ON pfxn.id = fxnd.periodofactorxnota_id
		WHERE factorxnota_id = @factorxnota_id AND
			(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(pfxn.fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(pfxn.fechaIni)) = 1 then '0' + CAST(MONTH(pfxn.fechaIni) AS NVARCHAR) ELSE CAST(MONTH(pfxn.fechaIni) AS NVARCHAR) END))
			AND
			(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(pfxn.fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(pfxn.fechaFin)) = 1 then '0' + CAST(MONTH(pfxn.fechaFin) AS NVARCHAR) ELSE CAST(MONTH(pfxn.fechaFin) AS NVARCHAR) END))				
			AND factor <= @cumplimiento			
		ORDER BY factor DESC
		) AS e1
	INNER JOIN
		(
		SELECT top 1 pfxn.id, factor, nota
		FROM periodofactorxnota as pfxn
		INNER JOIN factorxnotadetalle as fxnd ON pfxn.id = fxnd.periodofactorxnota_id
		WHERE factorxnota_id = @factorxnota_id AND
			(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(pfxn.fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(pfxn.fechaIni)) = 1 then '0' + CAST(MONTH(pfxn.fechaIni) AS NVARCHAR) ELSE CAST(MONTH(pfxn.fechaIni) AS NVARCHAR) END))
			AND
			(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(pfxn.fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(pfxn.fechaFin)) = 1 then '0' + CAST(MONTH(pfxn.fechaFin) AS NVARCHAR) ELSE CAST(MONTH(pfxn.fechaFin) AS NVARCHAR) END))				
			AND factor >= @cumplimiento			
		ORDER BY factor	
		) AS e2 ON e1.id = e2.id
	
	RETURN 
END
