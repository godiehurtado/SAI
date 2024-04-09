CREATE PROCEDURE [dbo].[ActualizarPremioConsolidadoMes]

@clave AS NVARCHAR (50),
@anio AS INT,
@tipo AS INT

AS
BEGIN

		IF (@tipo = 0)
		BEGIN

		UPDATE ConsolidadoMes
		SET LIMRA = pa.año
		FROM ConsolidadoMes cm		
		INNER JOIN PremiosAnteriores pa ON RTRIM(LTRIM(pa.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE cm.año = @anio
		AND cm.clave = @clave
		AND pa.LIMRA = 1

		UPDATE ConsolidadoMes
		SET FASECOLDA = pa.año
		FROM ConsolidadoMes cm
		INNER JOIN PremiosAnteriores pa ON RTRIM(LTRIM(pa.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE cm.año = @anio
		AND cm.clave = @clave
		AND pa.FASECOLDA = 1
		
		END
		
		ELSE
		BEGIN 
		
		UPDATE ConsolidadoMes
		SET LIMRA = 0
		FROM ConsolidadoMes cm		
		INNER JOIN PremiosAnteriores pa ON RTRIM(LTRIM(pa.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE cm.año = @anio
		AND cm.clave = @clave
		AND pa.LIMRA = 1

		UPDATE ConsolidadoMes
		SET FASECOLDA = 0
		FROM ConsolidadoMes cm
		INNER JOIN PremiosAnteriores pa ON RTRIM(LTRIM(pa.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE cm.año = @anio
		AND cm.clave = @clave
		AND pa.FASECOLDA = 1
		
		END

END