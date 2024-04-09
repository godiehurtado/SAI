-- =============================================
-- Author:		<Juan Fernando Rojas>
-- Create date: <15/11/2012>
-- Description:	<Calculo de información para el reporte de Informe de productividad>
-- =============================================
CREATE PROCEDURE [dbo].[SAI_InformeProductividad]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	TRUNCATE TABLE InformeProductividad

	DECLARE @anioVigente AS INT = (SELECT valor FROM ParametrosApp WHERE id = 3)
	DECLARE @mesInicio AS INT = 1
	DECLARE @mesFin AS INT = 12

	CREATE TABLE #informeProductividad (
		mes INT
		,jerarquiaDetalle_id INT
		,compania_id INT
		,ramo_id INT
		,producto_id INT
		,cantidadNegociosPAA INT
		,primasPAA FLOAT
		,asesoresPAA INT
		,productividadMensualPAA FLOAT -- NN Año Anterior / Asesores que vendieron año anterior / No mes transcurridos
		,primaPromedioPAA FLOAT
		,cantidadNegociosPAV INT
		,primasPAV FLOAT
		,asesoresPAV INT
		,productividadMensualPAV FLOAT -- NN Año Actual / Asesores que vendieron año actual / No mes transcurridos
		,primaPromedioPAV FLOAT
		,asesoresVAA INT -- No Asesores Vigentes de cada director al mes de evaluación (año Actual)	
		,asesoresVAV INT -- No Asesores Vigentes de cada director al mes de evaluación (año Actual)
		)

	PRINT 'Se crea la tabla temporal #informeProductividad'

	-- *********************************************************************************************************
	-- CALCULOS NEGOCIOS (Compañías diferentes a CAPI)
	-- *********************************************************************************************************--
	CREATE NONCLUSTERED INDEX [IX_temporalNegocio1] ON [dbo].[temporalNegocio] (
		[segmento_id]
		,[anioCierre]
		) INCLUDE (
		[compania_id]
		,[lineaNegocio_id]
		,[ramoDetalle_id]
		,[productoDetalle_id]
		,[numeroNegocio]
		,[valorPrimaTotal]
		,[participante_id]
		,[grupoEndoso_id]
		,[mesCierre]
		)

	CREATE NONCLUSTERED INDEX [IX_temporalNegocio2] ON [dbo].[temporalNegocio] (
		[participante_id]
		,[segmento_id]
		,[anioCierre]
		) INCLUDE (
		[compania_id]
		,[lineaNegocio_id]
		,[ramoDetalle_id]
		,[productoDetalle_id]
		,[numeroNegocio]
		,[valorPrimaTotal]
		,[grupoEndoso_id]
		,[mesCierre]
		)

	PRINT 'Se crean los indices de la tabla temporalNegocio'

	--  Negocios año anterior (Periodo)	
	INSERT INTO #informeProductividad (
		mes
		,jerarquiaDetalle_id
		,compania_id
		,ramo_id
		,producto_id
		,cantidadNegociosPAA
		,asesoresPAA
		,primasPAA
		)
	SELECT n.mesCierre
		,jd.id AS jerarquiaDetalle_id
		,n.compania_id
		,rd.ramo_id
		,pd.producto_id
		,COUNT(DISTINCT n.numeroNegocio) AS cantidadNegociosPAA
		,COUNT(DISTINCT n.participante_id) AS asesoresPAA
		,ROUND(SUM(n.valorPrimaTotal), 3) AS primasPAA
	FROM JerarquiaDetalle AS jd
	CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
	INNER JOIN temporalNegocio AS n ON hijos.participante_id = n.participante_id
	INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
	INNER JOIN Ramo ra ON ra.id = rd.ramo_id
	INNER JOIN ProductoDetalle pd ON pd.id = n.productoDetalle_id
	INNER JOIN Producto pr ON pr.id = pd.producto_id
		AND pr.ramo_id = ra.id
	INNER JOIN Participante p ON p.id = n.participante_id
	INNER JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id
	WHERE n.anioCierre = (@anioVigente - 1)
		AND jd.nivel_id NOT IN (
			0
			,1
			)
		AND (
			(
				n.compania_id = 2
				AND ge.claseEndoso = 1
				AND n.lineaNegocio_id = 1
				) -- VIDA NUEVOS NEGOCIOS
			OR (
				n.compania_id IN (
					1
					,4
					,5
					)
				)
			) -- GENERALES, ARP y SALUD 	
		AND n.segmento_id = 1
	GROUP BY jd.id
		,n.compania_id
		,rd.ramo_id
		,pd.producto_id
		,n.mesCierre

	PRINT 'Calculos negocios año anterior (Periodo)'

	-- Negocios año actual (Periodo)
	UPDATE t1
	SET t1.cantidadNegociosPAV = t2.cantidadNegociosPAV
		,t1.asesoresPAV = t2.asesoresPAV
		,t1.primasPAV = t2.primasPAV
	FROM #informeProductividad t1
	INNER JOIN (
		SELECT n.mesCierre
			,jd.id AS jerarquiaDetalle_id
			,pd.producto_id
			,n.compania_id
			,rd.ramo_id
			,COUNT(DISTINCT n.numeroNegocio) AS cantidadNegociosPAV
			,COUNT(DISTINCT n.participante_id) AS asesoresPAV
			,ROUND(SUM(n.valorPrimaTotal), 3) AS primasPAV
		FROM JerarquiaDetalle AS jd
		CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
		INNER JOIN temporalNegocio AS n ON hijos.participante_id = n.participante_id
		INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
		INNER JOIN Ramo ra ON ra.id = rd.ramo_id
		INNER JOIN ProductoDetalle pd ON pd.id = n.productoDetalle_id
		INNER JOIN Producto pr ON pr.id = pd.producto_id
			AND pr.ramo_id = ra.id
		INNER JOIN Participante p ON p.id = n.participante_id
		INNER JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id
		WHERE n.anioCierre = @anioVigente
			AND jd.nivel_id NOT IN (
				0
				,1
				)
			AND (
				(
					n.compania_id = 2
					AND ge.claseEndoso = 1
					AND n.lineaNegocio_id = 1
					) -- VIDA NUEVOS NEGOCIOS
				OR (
					n.compania_id IN (
						1
						,4
						,5
						)
					)
				)
			AND n.segmento_id = 1
		GROUP BY jd.id
			,n.compania_id
			,rd.ramo_id
			,pd.producto_id
			,n.mesCierre
		) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
		AND t1.producto_id = t2.producto_id
		AND t1.mes = t2.mesCierre
		AND t1.compania_id = t2.compania_id
		AND t1.ramo_id = t2.ramo_id

	PRINT 'Calculos negocios año vigente (Periodo)'

	IF EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE object_id = OBJECT_ID(N'[dbo].[temporalNegocio]')
				AND NAME = N'IX_temporalNegocio1'
			)
		DROP INDEX [IX_temporalNegocio1] ON [dbo].[temporalNegocio]
		WITH (ONLINE = OFF)

	IF EXISTS (
			SELECT *
			FROM sys.indexes
			WHERE object_id = OBJECT_ID(N'[dbo].[temporalNegocio]')
				AND NAME = N'IX_temporalNegocio2'
			)
		DROP INDEX [IX_temporalNegocio2] ON [dbo].[temporalNegocio]
		WITH (ONLINE = OFF)

	PRINT 'Se borran los indices de la tabla temporalNegocio'

	-- *********************************************************************************************************
	-- CALCULOS RECAUDOS (CAPI)
	-- *********************************************************************************************************--
	SELECT *
	INTO #Recaudos
	FROM Recaudo
	WHERE anioCierre IN (
			(@anioVigente - 1)
			,@anioVigente
			)

	PRINT 'Se crea la tabla temporal #Recaudos'

	CREATE NONCLUSTERED INDEX [IX_Recaudos1] ON [dbo].[#Recaudos] (
		[segmento_id]
		,[compania_id]
		,[anioCierre]
		) INCLUDE (
		[ramoDetalle_id]
		,[productoDetalle_id]
		,[participante_id]
		,[numeroNegocio]
		,[valorRecaudo]
		,[mesCierre]
		)

	PRINT 'Se crean los indices de la tabla temporal #Recaudos'

	--  Negocios año anterior (Periodo)	
	INSERT INTO #informeProductividad (
		mes
		,jerarquiaDetalle_id
		,compania_id
		,ramo_id
		,producto_id
		,cantidadNegociosPAA
		,asesoresPAA
		,primasPAA
		)
	SELECT r.mesCierre
		,jd.id AS jerarquiaDetalle_id
		,r.compania_id
		,rd.ramo_id
		,pd.producto_id
		,COUNT(DISTINCT r.numeroNegocio) AS cantidadNegociosPAA
		,COUNT(DISTINCT r.participante_id) AS asesoresPAA
		,ROUND(SUM(r.valorRecaudo), 3) AS primasPAA
	FROM JerarquiaDetalle AS jd
	CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
	INNER JOIN #Recaudos AS r ON hijos.participante_id = r.participante_id
	INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
	INNER JOIN Ramo ra ON ra.id = rd.ramo_id
	INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
	INNER JOIN Producto pr ON pr.id = pd.producto_id
		AND pr.ramo_id = ra.id
	INNER JOIN Participante p ON p.id = r.participante_id
	WHERE r.anioCierre = (@anioVigente - 1)
		AND jd.nivel_id NOT IN (
			0
			,1
			)
		AND r.compania_id = 3
		AND r.segmento_id = 1
	GROUP BY jd.id
		,r.compania_id
		,rd.ramo_id
		,pd.producto_id
		,r.mesCierre

	PRINT 'Calculo recaudos CAPI año anterior (Periodo)'

	-- Negocios año anterior (Periodo)
	UPDATE t1
	SET t1.cantidadNegociosPAV = t2.cantidadNegociosPAV
		,t1.asesoresPAV = t2.asesoresPAV
		,t1.primasPAV = t2.primasPAV
	FROM #informeProductividad t1
	INNER JOIN (
		SELECT r.mesCierre
			,jd.id AS jerarquiaDetalle_id
			,rd.ramo_id
			,pd.producto_id
			,COUNT(DISTINCT r.numeroNegocio) AS cantidadNegociosPAV
			,COUNT(DISTINCT r.participante_id) AS asesoresPAV
			,ROUND(SUM(r.valorRecaudo), 3) AS primasPAV
		FROM JerarquiaDetalle AS jd
		CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
		INNER JOIN #Recaudos AS r ON hijos.participante_id = r.participante_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		INNER JOIN Ramo ra ON ra.id = rd.ramo_id
		INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
		INNER JOIN Producto pr ON pr.id = pd.producto_id
			AND pr.ramo_id = ra.id
		INNER JOIN Participante p ON p.id = r.participante_id
		WHERE r.anioCierre = @anioVigente
			AND jd.nivel_id NOT IN (
				0
				,1
				)
			AND r.compania_id = 3
			AND r.segmento_id = 1
		GROUP BY jd.id
			,r.compania_id
			,rd.ramo_id
			,pd.producto_id
			,r.mesCierre
		) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
		AND t1.ramo_id = t2.ramo_id
		AND t1.producto_id = t2.producto_id
		AND t1.mes = t2.mesCierre
		AND t1.compania_id = 3

	PRINT 'Calculo recaudo CAPI año actual (Periodo)'

	WHILE (@mesInicio <= @mesFin)
	BEGIN
		UPDATE t1
		SET t1.asesoresVAA = t2.asesoresVAA
		FROM #informeProductividad t1
		INNER JOIN (
			SELECT @mesInicio AS mesIngreso
				,jd.id AS jerarquiaDetalle_id
				,COUNT(DISTINCT p.id) AS asesoresVAA
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN Participante AS p ON hijos.participante_id = p.id
			WHERE jd.nivel_id NOT IN (
					0
					,1
					)
				AND (
					YEAR(p.fechaIngreso) <= (@anioVigente - 1)
					AND MONTH(p.fechaIngreso) <= @mesInicio
					OR YEAR(p.fechaIngreso) < (@anioVigente - 1)
					)
				AND p.estadoParticipante_id <> 7
				AND (
					MONTH(p.fechaRetiro) >= @mesInicio
					AND YEAR(p.fechaRetiro) >= (@anioVigente - 1)
					OR p.estadoParticipante_id = 1
					)
			GROUP BY jd.id
			) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
			AND t1.mes = t2.mesIngreso

		SET @mesInicio = @mesInicio + 1
	END

	SET @mesInicio = 1

	WHILE (@mesInicio <= @mesFin)
	BEGIN
		UPDATE t1
		SET t1.asesoresVAV = t2.asesoresVAV
		FROM #informeProductividad t1
		INNER JOIN (
			SELECT @mesInicio AS mesIngreso
				,jd.id AS jerarquiaDetalle_id
				,COUNT(DISTINCT p.id) AS asesoresVAV
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN Participante AS p ON hijos.participante_id = p.id
			WHERE jd.nivel_id NOT IN (
					0
					,1
					)
				AND (
					YEAR(p.fechaIngreso) <= @anioVigente
					AND MONTH(p.fechaIngreso) <= @mesInicio
					OR YEAR(p.fechaIngreso) < @anioVigente
					)
				AND p.estadoParticipante_id <> 7
				AND (
					MONTH(p.fechaRetiro) >= @mesInicio
					AND YEAR(p.fechaRetiro) >= @anioVigente
					OR p.estadoParticipante_id = 1
					)
			GROUP BY jd.id
			) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
			AND t1.mes = t2.mesIngreso

		SET @mesInicio = @mesInicio + 1
	END

	-- Se actualizan los campos en NULL
	UPDATE #informeProductividad
	SET cantidadNegociosPAA = 0
	WHERE cantidadNegociosPAA IS NULL

	UPDATE #informeProductividad
	SET asesoresPAA = 0
	WHERE asesoresPAA IS NULL

	UPDATE #informeProductividad
	SET primasPAA = 0
	WHERE primasPAA IS NULL

	UPDATE #informeProductividad
	SET cantidadNegociosPAV = 0
	WHERE cantidadNegociosPAV IS NULL

	UPDATE #informeProductividad
	SET asesoresPAV = 0
	WHERE asesoresPAV IS NULL

	UPDATE #informeProductividad
	SET primasPAV = 0
	WHERE primasPAV IS NULL

	UPDATE #informeProductividad
	SET asesoresVAA = 0
	WHERE asesoresVAA IS NULL

	UPDATE #informeProductividad
	SET asesoresVAV = 0
	WHERE asesoresVAV IS NULL

	INSERT INTO InformeProductividad (
		mes
		,jerarquiaDetalle_id
		,compania_id
		,ramo_id
		,producto_id
		,cantidadNegociosAA
		,asesoresAA
		,cantidadNegociosAV
		,asesoresAV
		,primasAA
		,primasAV
		,asesoresVAA
		,asesoresVAV
		)
	SELECT mes
		,jerarquiaDetalle_id
		,compania_id
		,ramo_id
		,producto_id
		,cantidadNegociosPAA
		,asesoresPAA
		,cantidadNegociosPAV
		,asesoresPAV
		,primasPAA
		,primasPAV
		,asesoresVAA
		,asesoresVAV
	FROM #informeProductividad

	DROP TABLE #informeProductividad

	DROP TABLE #Recaudos

	-- *********************************************************************************************************
	-- CALCULOS PRODUCTIVIDAD Y PRIMA PROMEDIO
	-- *********************************************************************************************************--
	-- PRODUCTIVIDAD AÑO ANTERIOR	
	UPDATE InformeProductividad
	SET productividadMensualAA = (
			CASE 
				WHEN asesoresAA = 0
					THEN 0
				ELSE ROUND(CAST(cantidadNegociosAA AS FLOAT) / CAST(asesoresAA AS FLOAT), 3)
				END
			)

	-- PRODUCTIVIDAD AÑO VIGENTE
	UPDATE InformeProductividad
	SET productividadMensualAV = (
			CASE 
				WHEN asesoresAV = 0
					THEN 0
				ELSE ROUND(CAST(cantidadNegociosAV AS FLOAT) / CAST(asesoresAV AS FLOAT), 3)
				END
			)

	-- PRIMA PROMEDIO AÑO ANTERIOR
	UPDATE InformeProductividad
	SET primaPromedioAA = (
			CASE 
				WHEN cantidadNegociosAA = 0
					THEN 0
				ELSE ROUND(CAST(primasAA AS FLOAT) / CAST(cantidadNegociosAA AS FLOAT), 3)
				END
			)

	-- PRIMA PROMEDIO AÑO VIGENTE
	UPDATE InformeProductividad
	SET primaPromedioAV = (
			CASE 
				WHEN cantidadNegociosAV = 0
					THEN 0
				ELSE ROUND(CAST(primasAV AS FLOAT) / CAST(cantidadNegociosAV AS FLOAT), 3)
				END
			)
END