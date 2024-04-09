-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		ALBERTO PALENCIA BENEDETTI
-- Create date: 23/09/2013
-- Description:	GENERA LA DIFERENCIA DEL SAI VS SIG PARA COMPARAR LOS VALORES ACTUALES.
-- =============================================
ALTER PROCEDURE SAI_DiferenciaCargue_SAI_vs_SIG
	@anio int,@mes int
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	---DROP TABLE   #tempComparisson
	
-- Tabla temporal con la informacion del SAI
SELECT SUM(SC.valorPrimaTotal) AS valorPrimaTotalSAI
		, sc.compania_id AS compania
		, r.nombre AS ramo
		, sc.segmento_id AS segmento
		INTO #tempComparisson -- TABLA TEMPORAL
		FROM SAIvsSIGComparisson sc 
		INNER JOIN SAI_RamoDetalle rd ON rd.id = sc.ramoDetalle_id
		INNER JOIN SAI_Ramo r ON r.id = rd.ramo_id
		WHERE sc.anioCierre = @anio
		AND sc.mesCierre = @mes
		AND sc.compania_id = 1 -- por ahora solo vamos a dejarlo con la compañia de generales.
		--AND r.id = 8
		GROUP BY sc.compania_id
		, r.nombre
		, sc.segmento_id
		ORDER BY r.nombre, segmento
		


-- Crea el campo de valor de prima del SIG
ALTER TABLE #tempComparisson ADD valorPrimaSIG FLOAT

-- Actualiza la tabla temporal con el valor de prima del SIG con la misma agrupacion de SAI
	UPDATE t1
	SET t1.valorPrimaSIG = t2.valorPrimaSIG
	FROM #tempComparisson t1
	INNER JOIN (
		SELECT SUM(sa.valorPrimaSIG) AS valorPrimaSIG
		, sa.compania_id AS compania
		, r.nombre AS ramo
		, sa.segmento_id AS segmento
		FROM SIG_Agrupada sa
		INNER JOIN SAI_RamoDetalle rd ON rd.id = sa.ramoDetalle_id
		INNER JOIN SAI_Ramo r ON r.id = rd.ramo_id
		WHERE sa.anioCierre = @anio
			AND sa.mesCierre = @mes
			AND sa.compania_id = 1
			--AND r.id = 8
		GROUP BY sa.compania_id
			, r.nombre
			, sa.segmento_id
		) t2 ON t1.compania = t2.compania
		AND t1.ramo = t2.ramo
		AND t1.segmento = t2.segmento
		

		
ALTER TABLE #tempComparisson ADD diferencia FLOAT

UPDATE #tempComparisson
SET valorPrimaSIG = 0
WHERE valorPrimaSIG IS NULL

-- Diferencia SIG / SAI
UPDATE #tempComparisson
SET diferencia = valorPrimaSIG - valorPrimaTotalSAI


SELECT 
		valorPrimaTotalSAI
		, cp.nombre AS compania
		, ramo
		, sg.nombre AS segmento
		,valorPrimaSIG
		,diferencia
FROM #tempComparisson sc JOIN sai.dbo.compania cp
on sc.compania = cp.id JOIN SAI.dbo.Segmento sg on sc.segmento = sg.id



END




