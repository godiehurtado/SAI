-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 23/04/2012
-- Description:	Re - calculo de la persistencia de CAPI.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Recalculo_PersistenciaCAPI]
AS
BEGIN
	DECLARE @anioAbierto AS INT = (
		SELECT anioCierre FROM PeriodoCierre WHERE estado = 1
		AND compania_id = 3
		)
	DECLARE @mesAbierto AS INT = (
		SELECT mesCierre FROM PeriodoCierre WHERE estado = 1
		AND compania_id = 3
		)
	DECLARE @valorPersistenciaCAPICortoPlazo AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = (
			CASE 
				WHEN @mesAbierto = 1
					THEN (@anioAbierto - 1)
				ELSE @anioAbierto
				END
			)
		AND YEAR(c.fecha_fin) = (
			CASE 
				WHEN @mesAbierto = 1
					THEN (@anioAbierto - 1)
				ELSE @anioAbierto
				END
			)
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'false'
		AND pe.plazo_id = 1
		AND c.tipoConcurso_id = 1
		)
	DECLARE @valorPersistenciaCAPILargoPlazo AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = (
			CASE 
				WHEN @mesAbierto = 1
					THEN (@anioAbierto - 1)
				ELSE @anioAbierto
				END
			)
		AND YEAR(c.fecha_fin) = (
			CASE 
				WHEN @mesAbierto = 1
					THEN (@anioAbierto - 1)
				ELSE @anioAbierto
				END
			)
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'false'
		AND pe.plazo_id = 2
		AND c.tipoConcurso_id = 1
		)
	DECLARE @valorPersistenciaCAPICortoPlazoEj AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = (
			CASE 
				WHEN @mesAbierto = 1
					THEN (@anioAbierto - 1)
				ELSE @anioAbierto
				END
			)
		AND YEAR(c.fecha_fin) = (
			CASE 
				WHEN @mesAbierto = 1
					THEN (@anioAbierto - 1)
				ELSE @anioAbierto
				END
			)
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'false'
		AND pe.plazo_id = 1
		AND c.tipoConcurso_id = 2
		)
	DECLARE @valorPersistenciaCAPILargoPlazoEj AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = (
			CASE 
				WHEN @mesAbierto = 1
					THEN (@anioAbierto - 1)
				ELSE @anioAbierto
				END
			)
		AND YEAR(c.fecha_fin) = (
			CASE 
				WHEN @mesAbierto = 1
					THEN (@anioAbierto - 1)
				ELSE @anioAbierto
				END
			)
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'false'
		AND pe.plazo_id = 2
		AND c.tipoConcurso_id = 2
		)
	DECLARE @inicio AS INT = (@mesAbierto - 3)
	DECLARE @ciclo AS INT = 4
	DECLARE @DefaultDate DATETIME
	DECLARE @cantidadCuotas AS INT = 3
	DECLARE @cantidadCuotasDic AS INT = 2
	DECLARE @periodoInicioDic AS INT = 10

	SET @DefaultDate = CONVERT(DATETIME, 0)

	--  Condicional de calculo cuando el mes abierto es abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre
	--  La persistencia de capi se empieza a medir desde abril, la cual toma los tres meses previos a cada mes abierto.
	IF (@mesAbierto >= 4)
	BEGIN
		DELETE
		FROM PersistenciadeCAPIPeriodo
		WHERE anioCierreNegocio = @anioAbierto
			AND periodo = @inicio

		DELETE
		FROM PersistenciadeCAPIAcumulada
		WHERE anioCierreNegocio = @anioAbierto
			AND ultimoPeriodo = @inicio

		PRINT 'Borra los registros de la persistencia de capi del año vigente'

		CREATE TABLE #PersistenciaDelPeriodo (
			mes INT
			,clave NVARCHAR(20)
			,participante_id INT
			,plazo_id INT
			,sumatotal FLOAT
			,sumacumple FLOAT
			,ramo_id INT
			,jerarquiaDetalle_id INT
			)

		--  Tabla de calculo de la persistencia del periodo
		INSERT INTO #PersistenciaDelPeriodo (
			mes
			,clave
			,participante_id
			,plazo_id
			,sumatotal
			,sumacumple
			,ramo_id
			)
		SELECT c.mesCierre AS mes
			,c.clave
			,c.participante_id
			,c.plazo_id
			,(
				CASE 
					WHEN SUM(c.valorPrimaTotal) IS NULL
						THEN 0
					ELSE SUM(c.valorPrimaTotal)
					END
				) AS sumatotal
			,(
				SELECT SUM(c1.valorPrimaTotal)
				FROM PersistenciadeCAPIDetalle c1
				WHERE c1.cumple = 1
					AND c.participante_id = c1.participante_id
					AND c.plazo_id = c1.plazo_id
					AND c1.mesCierre = @inicio
					AND c1.anioCierreNegocio = @anioAbierto
				GROUP BY c1.participante_id
					,c1.plazo_id
				) AS sumacumple
			,c.ramo_id
		FROM PersistenciadeCAPIDetalle c
		WHERE c.mesCierre = @inicio
			AND c.anioCierreNegocio = @anioAbierto
		GROUP BY c.clave
			,c.participante_id
			,c.plazo_id
			,c.ramo_id
			,c.mesCierre
		ORDER BY c.clave
			,c.participante_id
			,c.plazo_id

		UPDATE #PersistenciaDelPeriodo
		SET sumacumple = 0
		WHERE sumacumple IS NULL

		ALTER TABLE #PersistenciaDelPeriodo ADD persistenciaPeriodo FLOAT

		--  Calculo de la persistencia del periodo asesores
		UPDATE #PersistenciaDelPeriodo
		SET persistenciaPeriodo = (
				CASE 
					WHEN sumatotal = 0
						THEN 0
					ELSE (ROUND((sumacumple / sumatotal) * 100, 3))
					END
				)
		WHERE participante_id IS NOT NULL

		PRINT 'Calculo de la persistencia del periodo asesores'

		--  Inserta información del calculo del periodo en ASESORES	
		INSERT INTO PersistenciadeCAPIPeriodo (
			clave
			,participante_id
			,periodo
			,plazo_id
			,sumaTotal
			,sumaCumple
			,persistenciaPeriodo
			,anioCierreNegocio
			,fechaCalculo
			,ramo_id
			)
		SELECT pp.clave
			,pp.participante_id
			,pp.mes
			,pp.plazo_id
			,pp.sumatotal
			,pp.sumacumple
			,pp.persistenciaPeriodo
			,@anioAbierto
			,GETDATE() AS fechaCalculo
			,pp.ramo_id
		FROM #PersistenciaDelPeriodo pp

		--  Calculo persistencia periodo ejecutivos.	
		INSERT INTO PersistenciadeCAPIPeriodo (
			periodo
			,plazo_id
			,ramo_id
			,jerarquiaDetalle_id
			,persistenciaPeriodo
			,anioCierreNegocio
			,fechaCalculo
			)
		SELECT pp.periodo
			,pp.plazo_id
			,ramo_id
			,jd.id AS nodo
			,ROUND(SUM(pp.persistenciaPeriodo) / COUNT(pp.participante_id), 3) AS persistencia
			,pp.anioCierreNegocio
			,pp.fechaCalculo
		FROM JerarquiaDetalle AS jd
		CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
		INNER JOIN PersistenciadeCAPIPeriodo AS pp ON hijos.participante_id = pp.participante_id
		WHERE jd.nivel_id NOT IN (
				0
				,1
				)
			AND pp.periodo = @inicio
			AND pp.anioCierreNegocio = @anioAbierto
		GROUP BY pp.periodo
			,pp.plazo_id
			,pp.ramo_id
			,jd.id
			,pp.anioCierreNegocio
			,pp.fechaCalculo

		--  ASESORES:
		--  Tabla de calculo de la persistencia acumulada
		SELECT pp.clave
			,pp.participante_id
			,pp.plazo_id
			,SUM(pp.persistenciaPeriodo) AS persistenciaPeriodo
			,0 AS meses
			,@inicio AS ultimoPeriodo
			,pp.ramo_id
		INTO #PersistenciaAcumulada
		FROM PersistenciadeCAPIPeriodo pp
		WHERE pp.anioCierreNegocio = @anioAbierto
			AND pp.periodo <= @inicio
			AND pp.participante_id IS NOT NULL
		GROUP BY pp.clave
			,pp.participante_id
			,pp.plazo_id
			,pp.ramo_id

		--  Actualiza la cantidad de meses en los que el asesor vendió. Corto Plazo
		UPDATE t1
		SET t1.meses = t2.mesesCortoPlazo
		FROM #PersistenciaAcumulada t1
		INNER JOIN (
			SELECT p.participante_id
				,p.plazo_id
				,COUNT(DISTINCT p.periodo) AS mesesCortoPlazo
			FROM PersistenciadeCAPIPeriodo p
			WHERE p.plazo_id = 1
				AND p.periodo <= @inicio
				AND p.anioCierreNegocio = @anioAbierto
				AND p.participante_id IS NOT NULL
			GROUP BY p.participante_id
				,p.plazo_id
			) t2 ON t2.participante_id = t1.participante_id
			AND t2.plazo_id = t1.plazo_id

		PRINT 'Cantidad de meses en los que el asesor vendió corto plazo'

		--  Actualiza la cantidad de meses en los que el asesor vendió. Largo Plazo
		UPDATE t1
		SET t1.meses = t2.mesesLargoPlazo
		FROM #PersistenciaAcumulada t1
		INNER JOIN (
			SELECT p.participante_id
				,p.plazo_id
				,COUNT(DISTINCT p.periodo) AS mesesLargoPlazo
			FROM PersistenciadeCAPIPeriodo p
			WHERE p.plazo_id = 2
				AND p.periodo <= @inicio
				AND p.anioCierreNegocio = @anioAbierto
				AND p.participante_id IS NOT NULL
			GROUP BY p.participante_id
				,p.plazo_id
			) t2 ON t2.participante_id = t1.participante_id
			AND t2.plazo_id = t1.plazo_id

		PRINT 'Cantidad de meses en los que el asesor vendió largo plazo'

		ALTER TABLE #PersistenciaAcumulada ADD persistenciaAcumulada FLOAT

		--  Calculo persistencia acumulada asesores
		UPDATE #PersistenciaAcumulada
		SET persistenciaAcumulada = (
				CASE 
					WHEN meses = 0
						THEN 0
					ELSE ROUND((persistenciaPeriodo / meses), 3)
					END
				)

		PRINT 'Calculo persistencia acumulada asesores'

		INSERT INTO PersistenciadeCAPIAcumulada (
			clave
			,participante_id
			,plazo_id
			,meses
			,persistenciaPeriodo
			,persistenciaAcumulada
			,anioCierreNegocio
			,fechaCalculo
			,ultimoPeriodo
			,ramo_id
			)
		SELECT pa.clave
			,pa.participante_id
			,pa.plazo_id
			,pa.meses
			,pa.persistenciaPeriodo
			,pa.persistenciaAcumulada
			,@anioAbierto
			,GETDATE() AS fechaCalculo
			,pa.ultimoPeriodo
			,pa.ramo_id
		FROM #PersistenciaAcumulada pa

		--  EJECUTIVOS:
		--  Tabla de calculo de la persistencia acumulada
		SELECT jd.id AS jerarquiaDetalle_id
			,pp.plazo_id
			,(ROUND(SUM(pp.persistenciaAcumulada) / COUNT(pp.participante_id), 4)) AS persistenciaAcumulada
			,@inicio AS ultimoPeriodo
			,pp.ramo_id
		INTO #PersistenciaAcumuladaEjecutivos
		FROM JerarquiaDetalle AS jd
		CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
		INNER JOIN PersistenciadeCAPIAcumulada AS pp ON hijos.participante_id = pp.participante_id
		WHERE jd.nivel_id NOT IN (
				0
				,1
				)
			AND pp.anioCierreNegocio = @anioAbierto
			AND pp.ultimoPeriodo <= @inicio
			AND pp.participante_id IS NOT NULL
		GROUP BY jd.id
			,pp.plazo_id
			,pp.ramo_id

		PRINT 'Calculo persistencia acumulada ejecutivos'

		--  Inserta información del calculo de la acumulada de ejecutivos.	
		INSERT INTO PersistenciadeCAPIAcumulada (
			jerarquiaDetalle_id
			,plazo_id
			,persistenciaAcumulada
			,anioCierreNegocio
			,fechaCalculo
			,ultimoPeriodo
			,ramo_id
			)
		SELECT pa.jerarquiaDetalle_id
			,pa.plazo_id
			,pa.persistenciaAcumulada
			,@anioAbierto
			,GETDATE() AS fechaCalculo
			,pa.ultimoPeriodo
			,pa.ramo_id
		FROM #PersistenciaAcumuladaEjecutivos pa

		DROP TABLE #PersistenciaDelPeriodo

		DROP TABLE #PersistenciaAcumulada

		DROP TABLE #PersistenciaAcumuladaEjecutivos

		-- *********************************************************************************************************
		-- DESCUENTO DE COLQUINES
		-- *********************************************************************************************************--
		-- Cantidad de colquines a descontar asesor: Largo plazo
		UPDATE t1
		SET t1.colquinesDescontar = t2.colquinesDescontar
		FROM PersistenciadeCAPIAcumulada t1
		INNER JOIN (
			SELECT (
					CASE 
						WHEN SUM(r.Colquines) > 0
							THEN (SUM(r.Colquines) * (- 1))
						ELSE 0
						END
					) AS colquinesDescontar
				,r.participante_id
				,r.anioCierre AS anioCierre
				,prod.plazo_id
			FROM Recaudo r
			INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
			INNER JOIN Producto prod ON prod.id = pd.producto_id
			WHERE prod.plazo_id = 2
				AND r.compania_id = 3
				AND r.anioCierre = @anioAbierto
				AND rd.ramo_id = 17
				AND r.mesCierre <= @mesAbierto
			GROUP BY r.participante_id
				,r.anioCierre
				,prod.plazo_id
			) t2 ON t1.participante_id = t2.participante_id
			AND t1.anioCierreNegocio = t2.anioCierre
			AND t1.plazo_id = t2.plazo_id
		WHERE t1.anioCierreNegocio = @anioAbierto
			AND t1.ultimoPeriodo = @inicio
			AND t1.plazo_id = 2
			AND t1.persistenciaAcumulada < @valorPersistenciaCAPILargoPlazo

		-- Cantidad de colquines a descontar asesor: Corto plazo 
		UPDATE t1
		SET t1.colquinesDescontar = t2.colquinesDescontar
		FROM PersistenciadeCAPIAcumulada t1
		INNER JOIN (
			SELECT (
					CASE 
						WHEN SUM(r.Colquines) > 0
							THEN (SUM(r.Colquines) * (- 1))
						ELSE SUM(r.Colquines)
						END
					) AS colquinesDescontar
				,r.participante_id AS participante_id
				,r.anioCierre AS anioCierre
				,prod.plazo_id
			FROM Recaudo r
			INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
			INNER JOIN Producto prod ON prod.id = pd.producto_id
			WHERE prod.plazo_id = 1
				AND r.compania_id = 3
				AND r.anioCierre = @anioAbierto
				AND rd.ramo_id = 17
				AND r.mesCierre <= @mesAbierto
			GROUP BY r.participante_id
				,r.anioCierre
				,prod.plazo_id
			) t2 ON t1.participante_id = t2.participante_id
			AND t1.anioCierreNegocio = t2.anioCierre
			AND t1.plazo_id = t2.plazo_id
		WHERE t1.anioCierreNegocio = @anioAbierto
			AND t1.ultimoPeriodo = @inicio
			AND t1.plazo_id = 1
			AND t1.persistenciaAcumulada < @valorPersistenciaCAPICortoPlazo

		-- Cantidad de colquines a descontar ejecutivos: Largo plazo
		UPDATE t1
		SET t1.colquinesDescontar = t2.colquinesDescontar
		FROM PersistenciadeCAPIAcumulada t1
		INNER JOIN (
			SELECT (
					CASE 
						WHEN SUM(r.Colquines) > 0
							THEN (SUM(r.Colquines) * (- 1))
						ELSE 0
						END
					) AS colquinesDescontar
				,jd.id AS jerarquiaDetalle_id
				,r.anioCierre AS anioCierre
				,prod.plazo_id
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
			INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
			INNER JOIN Producto prod ON prod.id = pd.producto_id
			WHERE jd.nivel_id NOT IN (
					0
					,1
					)
				AND prod.plazo_id = 2
				AND r.compania_id = 3
				AND r.anioCierre = @anioAbierto
				AND rd.ramo_id = 17
				AND r.mesCierre <= @mesAbierto
			GROUP BY jd.id
				,r.anioCierre
				,prod.plazo_id
			) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
			AND t1.anioCierreNegocio = t2.anioCierre
			AND t1.plazo_id = t2.plazo_id
		WHERE t1.anioCierreNegocio = @anioAbierto
			AND t1.ultimoPeriodo = @inicio
			AND t1.plazo_id = 2
			AND t1.persistenciaAcumulada < @valorPersistenciaCAPILargoPlazoEj
			AND t1.jerarquiaDetalle_id IS NOT NULL

		-- Cantidad de colquines a descontar ejecutivos: Corto plazo 
		UPDATE t1
		SET t1.colquinesDescontar = t2.colquinesDescontar
		FROM PersistenciadeCAPIAcumulada t1
		INNER JOIN (
			SELECT (
					CASE 
						WHEN SUM(r.Colquines) > 0
							THEN (SUM(r.Colquines) * (- 1))
						ELSE SUM(r.Colquines)
						END
					) AS colquinesDescontar
				,jd.id AS jerarquiaDetalle_id
				,r.anioCierre AS anioCierre
				,prod.plazo_id
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
			INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
			INNER JOIN Producto prod ON prod.id = pd.producto_id
			WHERE jd.nivel_id NOT IN (
					0
					,1
					)
				AND prod.plazo_id = 1
				AND r.compania_id = 3
				AND r.anioCierre = @anioAbierto
				AND rd.ramo_id = 17
				AND r.mesCierre <= @mesAbierto
			GROUP BY jd.id
				,r.anioCierre
				,prod.plazo_id
			) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
			AND t1.anioCierreNegocio = t2.anioCierre
			AND t1.plazo_id = t2.plazo_id
		WHERE t1.anioCierreNegocio = @anioAbierto
			AND t1.ultimoPeriodo = @inicio
			AND t1.plazo_id = 1
			AND t1.persistenciaAcumulada < @valorPersistenciaCAPICortoPlazoEj
			AND t1.jerarquiaDetalle_id IS NOT NULL

		UPDATE PersistenciadeCAPIAcumulada
		SET colquinesDescontar = 0
		WHERE colquinesDescontar IS NULL

		-- *********************************************************************************************************
		-- DESCUENTO DE RECAUDOS: EJECUTIVOS
		-- *********************************************************************************************************--	
		-- Cantidad de recaudo a descontar ejecutivos: Largo plazo
		UPDATE t1
		SET t1.recaudosDescontar = t2.recaudosDescontar
		FROM PersistenciadeCAPIAcumulada t1
		INNER JOIN (
			SELECT (
					CASE 
						WHEN SUM(r.valorRecaudo) > 0
							THEN (SUM(r.valorRecaudo) * (- 1))
						ELSE 0
						END
					) AS recaudosDescontar
				,jd.id AS jerarquiaDetalle_id
				,r.anioCierre AS anioCierre
				,prod.plazo_id
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
			INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
			INNER JOIN Producto prod ON prod.id = pd.producto_id
			WHERE jd.nivel_id NOT IN (
					0
					,1
					)
				AND prod.plazo_id = 2
				AND r.compania_id = 3
				AND r.anioCierre = @anioAbierto
				AND rd.ramo_id = 17
				AND r.mesCierre <= @mesAbierto
			GROUP BY jd.id
				,r.anioCierre
				,prod.plazo_id
			) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
			AND t1.anioCierreNegocio = t2.anioCierre
			AND t1.plazo_id = t2.plazo_id
		WHERE t1.anioCierreNegocio = @anioAbierto
			AND t1.ultimoPeriodo = @inicio
			AND t1.plazo_id = 2
			AND t1.persistenciaAcumulada < @valorPersistenciaCAPILargoPlazoEj
			AND t1.jerarquiaDetalle_id IS NOT NULL

		-- Cantidad de recaudo a descontar ejecutivos: Corto plazo 
		UPDATE t1
		SET t1.recaudosDescontar = t2.recaudosDescontar
		FROM PersistenciadeCAPIAcumulada t1
		INNER JOIN (
			SELECT (
					CASE 
						WHEN SUM(r.valorRecaudo) > 0
							THEN (SUM(r.valorRecaudo) * (- 1))
						ELSE 0
						END
					) AS recaudosDescontar
				,jd.id AS jerarquiaDetalle_id
				,r.anioCierre AS anioCierre
				,prod.plazo_id
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
			INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
			INNER JOIN Producto prod ON prod.id = pd.producto_id
			WHERE jd.nivel_id NOT IN (
					0
					,1
					)
				AND prod.plazo_id = 1
				AND r.compania_id = 3
				AND r.anioCierre = @anioAbierto
				AND rd.ramo_id = 17
				AND r.mesCierre <= @mesAbierto
			GROUP BY jd.id
				,r.anioCierre
				,prod.plazo_id
			) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
			AND t1.anioCierreNegocio = t2.anioCierre
			AND t1.plazo_id = t2.plazo_id
		WHERE t1.anioCierreNegocio = @anioAbierto
			AND t1.ultimoPeriodo = @inicio
			AND t1.plazo_id = 1
			AND t1.persistenciaAcumulada < @valorPersistenciaCAPICortoPlazoEj
			AND t1.jerarquiaDetalle_id IS NOT NULL

		UPDATE PersistenciadeCAPIAcumulada
		SET recaudosDescontar = 0
		WHERE recaudosDescontar IS NULL
			AND jerarquiaDetalle_id IS NOT NULL
	END
	ELSE
		IF (@mesAbierto = 1)
		BEGIN
			--  Borra los registros de la persistencia de capi del año vigente.
			DELETE
			FROM PersistenciadeCAPIPeriodo
			WHERE anioCierreNegocio = (@anioAbierto - 1)
				AND periodo IN (
					10
					,11
					,12
					)

			DELETE
			FROM PersistenciadeCAPIAcumulada
			WHERE anioCierreNegocio = (@anioAbierto - 1)
				AND ultimoPeriodo IN (
					10
					,11
					,12
					)

			PRINT 'Borra los registros de la persistencia de capi del año vigente'

			CREATE TABLE #PersistenciaDelPeriodo1 (
				mes INT
				,clave NVARCHAR(20)
				,participante_id INT
				,plazo_id INT
				,sumatotal FLOAT
				,sumacumple FLOAT
				,ramo_id INT
				,jerarquiaDetalle_id INT
				)

			--  Tabla de calculo de la persistencia del periodo
			INSERT INTO #PersistenciaDelPeriodo1 (
				mes
				,clave
				,participante_id
				,plazo_id
				,sumatotal
				,sumacumple
				,ramo_id
				)
			SELECT c.mesCierre AS mes
				,c.clave
				,c.participante_id
				,c.plazo_id
				,(
					CASE 
						WHEN SUM(c.valorPrimaTotal) IS NULL
							THEN 0
						ELSE SUM(c.valorPrimaTotal)
						END
					) AS sumatotal
				,(
					SELECT SUM(c1.valorPrimaTotal)
					FROM PersistenciadeCAPIDetalle c1
					WHERE c1.cumple = 1
						AND c.participante_id = c1.participante_id
						AND c.plazo_id = c1.plazo_id
						AND c.mesCierre = c1.mesCierre
						AND c1.mesCierre IN (
							10
							,11
							,12
							)
						AND c1.anioCierreNegocio = (@anioAbierto - 1)
					GROUP BY c1.participante_id
						,c1.plazo_id
					) AS sumacumple
				,c.ramo_id
			FROM PersistenciadeCAPIDetalle c
			WHERE c.mesCierre IN (
					10
					,11
					,12
					)
				AND c.anioCierreNegocio = (@anioAbierto - 1)
			GROUP BY c.clave
				,c.participante_id
				,c.plazo_id
				,c.ramo_id
				,c.mesCierre
			ORDER BY c.clave
				,c.participante_id
				,c.plazo_id

			UPDATE #PersistenciaDelPeriodo1
			SET sumacumple = 0
			WHERE sumacumple IS NULL

			ALTER TABLE #PersistenciaDelPeriodo1 ADD persistenciaPeriodo FLOAT

			--  Calculo de la persistencia del periodo
			UPDATE #PersistenciaDelPeriodo1
			SET persistenciaPeriodo = (
					CASE 
						WHEN sumatotal = 0
							THEN 0
						ELSE (ROUND((sumacumple / sumatotal) * 100, 3))
						END
					)

			PRINT 'Calculo de la persistencia del periodo'

			--  Calculo persistencia periodo asesores.
			INSERT INTO PersistenciadeCAPIPeriodo (
				clave
				,participante_id
				,periodo
				,plazo_id
				,sumaTotal
				,sumaCumple
				,persistenciaPeriodo
				,anioCierreNegocio
				,fechaCalculo
				,ramo_id
				)
			SELECT pp.clave
				,pp.participante_id
				,pp.mes
				,pp.plazo_id
				,pp.sumatotal
				,pp.sumacumple
				,pp.persistenciaPeriodo
				,(@anioAbierto - 1)
				,GETDATE() AS fechaCalculo
				,pp.ramo_id
			FROM #PersistenciaDelPeriodo1 pp

			--  Calculo persistencia periodo ejecutivos.	
			INSERT INTO PersistenciadeCAPIPeriodo (
				periodo
				,plazo_id
				,ramo_id
				,jerarquiaDetalle_id
				,persistenciaPeriodo
				,anioCierreNegocio
				,fechaCalculo
				)
			SELECT pp.periodo
				,pp.plazo_id
				,ramo_id
				,jd.id AS nodo
				,ROUND(SUM(pp.persistenciaPeriodo) / COUNT(pp.participante_id), 3) AS persistencia
				,pp.anioCierreNegocio
				,pp.fechaCalculo
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN PersistenciadeCAPIPeriodo AS pp ON hijos.participante_id = pp.participante_id
			WHERE jd.nivel_id NOT IN (
					0
					,1
					)
				AND pp.periodo IN (
					10
					,11
					,12
					)
				AND pp.anioCierreNegocio = (@anioAbierto - 1)
			GROUP BY pp.periodo
				,pp.plazo_id
				,pp.ramo_id
				,jd.id
				,pp.anioCierreNegocio
				,pp.fechaCalculo

			WHILE (@periodoInicioDic <= 12)
			BEGIN
				--  Tabla de calculo de la persistencia acumulada asesores
				SELECT pp.clave
					,pp.participante_id
					,pp.plazo_id
					,SUM(pp.persistenciaPeriodo) AS persistenciaPeriodo
					,0 AS meses
					,@periodoInicioDic AS ultimoPeriodo
					,pp.ramo_id
				INTO #PersistenciaAcumulada1
				FROM PersistenciadeCAPIPeriodo pp
				WHERE pp.anioCierreNegocio = (@anioAbierto - 1)
					AND pp.periodo <= @periodoInicioDic
					AND pp.participante_id IS NOT NULL
				GROUP BY pp.clave
					,pp.participante_id
					,pp.plazo_id
					,pp.ramo_id

				--  Actualiza la cantidad de meses en los que el asesor vendió. Corto Plazo
				UPDATE t1
				SET t1.meses = t2.mesesCortoPlazo
				FROM #PersistenciaAcumulada1 t1
				INNER JOIN (
					SELECT p.participante_id
						,p.plazo_id
						,COUNT(DISTINCT p.periodo) AS mesesCortoPlazo
					FROM PersistenciadeCAPIPeriodo p
					WHERE p.plazo_id = 1
						AND p.anioCierreNegocio = (@anioAbierto - 1)
						AND p.participante_id IS NOT NULL
						AND p.periodo <= @periodoInicioDic
					GROUP BY p.participante_id
						,p.plazo_id
					) t2 ON t2.participante_id = t1.participante_id
					AND t2.plazo_id = t1.plazo_id

				PRINT 'Cantidad de meses en los que el asesor vendió largo plazo'

				--  Actualiza la cantidad de meses en los que el asesor vendió. Largo Plazo
				UPDATE t1
				SET t1.meses = t2.mesesLargoPlazo
				FROM #PersistenciaAcumulada1 t1
				INNER JOIN (
					SELECT p.participante_id
						,p.plazo_id
						,COUNT(DISTINCT p.periodo) AS mesesLargoPlazo
					FROM PersistenciadeCAPIPeriodo p
					WHERE p.plazo_id = 2
						AND p.anioCierreNegocio = (@anioAbierto - 1)
						AND p.participante_id IS NOT NULL
						AND p.periodo <= @periodoInicioDic
					GROUP BY p.participante_id
						,p.plazo_id
					) t2 ON t2.participante_id = t1.participante_id
					AND t2.plazo_id = t1.plazo_id

				PRINT 'Cantidad de meses en los que el asesor vendió corto plazo'

				ALTER TABLE #PersistenciaAcumulada1 ADD persistenciaAcumulada FLOAT

				--  Calculo persistencia acumulada
				UPDATE #PersistenciaAcumulada1
				SET persistenciaAcumulada = (
						CASE 
							WHEN meses = 0
								THEN 0
							ELSE ROUND((persistenciaPeriodo / meses), 3)
							END
						)

				PRINT 'Calculo persistencia acumulada asesores'

				INSERT INTO PersistenciadeCAPIAcumulada (
					clave
					,participante_id
					,plazo_id
					,meses
					,persistenciaPeriodo
					,persistenciaAcumulada
					,anioCierreNegocio
					,fechaCalculo
					,ultimoPeriodo
					,ramo_id
					)
				SELECT pa.clave
					,pa.participante_id
					,pa.plazo_id
					,pa.meses
					,pa.persistenciaPeriodo
					,pa.persistenciaAcumulada
					,(@anioAbierto - 1)
					,GETDATE() AS fechaCalculo
					,pa.ultimoPeriodo
					,pa.ramo_id
				FROM #PersistenciaAcumulada1 pa

				--  EJECUTIVOS:
				--  Tabla de calculo de la persistencia acumulada
				SELECT jd.id AS jerarquiaDetalle_id
					,pp.plazo_id
					,(ROUND(SUM(pp.persistenciaAcumulada) / COUNT(pp.participante_id), 4)) AS persistenciaAcumulada
					,pp.ultimoPeriodo AS ultimoPeriodo
					,pp.ramo_id
				INTO #PersistenciaAcumulada1Ejecutivos
				FROM JerarquiaDetalle AS jd
				CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
				INNER JOIN PersistenciadeCAPIAcumulada AS pp ON hijos.participante_id = pp.participante_id
				WHERE jd.nivel_id NOT IN (
						0
						,1
						)
					AND pp.anioCierreNegocio = (@anioAbierto - 1)
					AND pp.ultimoPeriodo = @periodoInicioDic
					AND pp.participante_id IS NOT NULL
				GROUP BY jd.id
					,pp.plazo_id
					,pp.ramo_id
					,pp.ultimoPeriodo

				PRINT 'Calculo persistencia acumulada ejecutivos'

				INSERT INTO PersistenciadeCAPIAcumulada (
					jerarquiaDetalle_id
					,plazo_id
					,persistenciaAcumulada
					,anioCierreNegocio
					,fechaCalculo
					,ultimoPeriodo
					,ramo_id
					)
				SELECT pa.jerarquiaDetalle_id
					,pa.plazo_id
					,pa.persistenciaAcumulada
					,(@anioAbierto - 1)
					,GETDATE() AS fechaCalculo
					,pa.ultimoPeriodo
					,pa.ramo_id
				FROM #PersistenciaAcumulada1Ejecutivos pa

				DROP TABLE #PersistenciaAcumulada1

				DROP TABLE #PersistenciaAcumulada1Ejecutivos

				-- *********************************************************************************************************
				-- DESCUENTO DE COLQUINES
				-- *********************************************************************************************************--
				-- Cantidad de colquines a descontar asesor: Largo plazo
				UPDATE t1
				SET t1.colquinesDescontar = t2.colquinesDescontar
				FROM PersistenciadeCAPIAcumulada t1
				INNER JOIN (
					SELECT (
							CASE 
								WHEN SUM(r.Colquines) > 0
									THEN (SUM(r.Colquines) * (- 1))
								ELSE 0
								END
							) AS colquinesDescontar
						,r.participante_id
						,r.anioCierre AS anioCierre
						,prod.plazo_id
					FROM Recaudo r
					INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
					INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
					INNER JOIN Producto prod ON prod.id = pd.producto_id
					WHERE prod.plazo_id = 2
						AND r.compania_id = 3
						AND r.anioCierre = (@anioAbierto - 1)
						AND rd.ramo_id = 17
						AND r.mesCierre <= @periodoInicioDic
					GROUP BY r.participante_id
						,r.anioCierre
						,prod.plazo_id
					) t2 ON t1.participante_id = t2.participante_id
					AND t1.anioCierreNegocio = t2.anioCierre
					AND t1.plazo_id = t2.plazo_id
				WHERE t1.anioCierreNegocio = (@anioAbierto - 1)
					AND t1.ultimoPeriodo = @periodoInicioDic
					AND t1.plazo_id = 2
					AND t1.persistenciaAcumulada < @valorPersistenciaCAPILargoPlazo

				-- Cantidad de colquines a descontar asesor: Corto plazo 
				UPDATE t1
				SET t1.colquinesDescontar = t2.colquinesDescontar
				FROM PersistenciadeCAPIAcumulada t1
				INNER JOIN (
					SELECT (
							CASE 
								WHEN SUM(r.Colquines) > 0
									THEN (SUM(r.Colquines) * (- 1))
								ELSE SUM(r.Colquines)
								END
							) AS colquinesDescontar
						,r.participante_id AS participante_id
						,r.anioCierre AS anioCierre
						,prod.plazo_id
					FROM Recaudo r
					INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
					INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
					INNER JOIN Producto prod ON prod.id = pd.producto_id
					WHERE prod.plazo_id = 1
						AND r.compania_id = 3
						AND r.anioCierre = (@anioAbierto - 1)
						AND rd.ramo_id = 17
						AND r.mesCierre <= @periodoInicioDic
					GROUP BY r.participante_id
						,r.anioCierre
						,prod.plazo_id
					) t2 ON t1.participante_id = t2.participante_id
					AND t1.anioCierreNegocio = t2.anioCierre
					AND t1.plazo_id = t2.plazo_id
				WHERE t1.anioCierreNegocio = (@anioAbierto - 1)
					AND t1.ultimoPeriodo = @periodoInicioDic
					AND t1.plazo_id = 1
					AND t1.persistenciaAcumulada < @valorPersistenciaCAPICortoPlazo

				-- Cantidad de colquines a descontar ejecutivos: Largo plazo
				UPDATE t1
				SET t1.colquinesDescontar = t2.colquinesDescontar
				FROM PersistenciadeCAPIAcumulada t1
				INNER JOIN (
					SELECT (
							CASE 
								WHEN SUM(r.Colquines) > 0
									THEN (SUM(r.Colquines) * (- 1))
								ELSE 0
								END
							) AS colquinesDescontar
						,jd.id AS jerarquiaDetalle_id
						,r.anioCierre AS anioCierre
						,prod.plazo_id
					FROM JerarquiaDetalle AS jd
					CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
					INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
					INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
					INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
					INNER JOIN Producto prod ON prod.id = pd.producto_id
					WHERE jd.nivel_id NOT IN (
							0
							,1
							)
						AND prod.plazo_id = 2
						AND r.compania_id = 3
						AND r.anioCierre = (@anioAbierto - 1)
						AND rd.ramo_id = 17
						AND r.mesCierre <= @periodoInicioDic
					GROUP BY jd.id
						,r.anioCierre
						,prod.plazo_id
					) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
					AND t1.anioCierreNegocio = t2.anioCierre
					AND t1.plazo_id = t2.plazo_id
				WHERE t1.anioCierreNegocio = (@anioAbierto - 1)
					AND t1.ultimoPeriodo = @periodoInicioDic
					AND t1.plazo_id = 2
					AND t1.persistenciaAcumulada < @valorPersistenciaCAPILargoPlazoEj
					AND t1.jerarquiaDetalle_id IS NOT NULL

				-- Cantidad de colquines a descontar ejecutivos: Corto plazo 
				UPDATE t1
				SET t1.colquinesDescontar = t2.colquinesDescontar
				FROM PersistenciadeCAPIAcumulada t1
				INNER JOIN (
					SELECT (
							CASE 
								WHEN SUM(r.Colquines) > 0
									THEN (SUM(r.Colquines) * (- 1))
								ELSE SUM(r.Colquines)
								END
							) AS colquinesDescontar
						,jd.id AS jerarquiaDetalle_id
						,r.anioCierre AS anioCierre
						,prod.plazo_id
					FROM JerarquiaDetalle AS jd
					CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
					INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
					INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
					INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
					INNER JOIN Producto prod ON prod.id = pd.producto_id
					WHERE jd.nivel_id NOT IN (
							0
							,1
							)
						AND prod.plazo_id = 1
						AND r.compania_id = 3
						AND r.anioCierre = (@anioAbierto - 1)
						AND rd.ramo_id = 17
						AND r.mesCierre <= @periodoInicioDic
					GROUP BY jd.id
						,r.anioCierre
						,prod.plazo_id
					) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
					AND t1.anioCierreNegocio = t2.anioCierre
					AND t1.plazo_id = t2.plazo_id
				WHERE t1.anioCierreNegocio = (@anioAbierto - 1)
					AND t1.ultimoPeriodo = @periodoInicioDic
					AND t1.plazo_id = 1
					AND t1.persistenciaAcumulada < @valorPersistenciaCAPICortoPlazoEj
					AND t1.jerarquiaDetalle_id IS NOT NULL

				UPDATE PersistenciadeCAPIAcumulada
				SET colquinesDescontar = 0
				WHERE colquinesDescontar IS NULL

				-- *********************************************************************************************************
				-- DESCUENTO DE RECAUDOS: EJECUTIVOS
				-- *********************************************************************************************************--	
				-- Cantidad de recaudo a descontar ejecutivos: Largo plazo
				UPDATE t1
				SET t1.recaudosDescontar = t2.recaudosDescontar
				FROM PersistenciadeCAPIAcumulada t1
				INNER JOIN (
					SELECT (
							CASE 
								WHEN SUM(r.valorRecaudo) > 0
									THEN (SUM(r.valorRecaudo) * (- 1))
								ELSE 0
								END
							) AS recaudosDescontar
						,jd.id AS jerarquiaDetalle_id
						,r.anioCierre AS anioCierre
						,prod.plazo_id
					FROM JerarquiaDetalle AS jd
					CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
					INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
					INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
					INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
					INNER JOIN Producto prod ON prod.id = pd.producto_id
					WHERE jd.nivel_id NOT IN (
							0
							,1
							)
						AND prod.plazo_id = 2
						AND r.compania_id = 3
						AND r.anioCierre = (@anioAbierto - 1)
						AND rd.ramo_id = 17
						AND r.mesCierre <= @periodoInicioDic
					GROUP BY jd.id
						,r.anioCierre
						,prod.plazo_id
					) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
					AND t1.anioCierreNegocio = t2.anioCierre
					AND t1.plazo_id = t2.plazo_id
				WHERE t1.anioCierreNegocio = (@anioAbierto - 1)
					AND t1.ultimoPeriodo = @periodoInicioDic
					AND t1.plazo_id = 2
					AND t1.persistenciaAcumulada < @valorPersistenciaCAPILargoPlazoEj
					AND t1.jerarquiaDetalle_id IS NOT NULL

				-- Cantidad de recaudo a descontar ejecutivos: Corto plazo 
				UPDATE t1
				SET t1.recaudosDescontar = t2.recaudosDescontar
				FROM PersistenciadeCAPIAcumulada t1
				INNER JOIN (
					SELECT (
							CASE 
								WHEN SUM(r.valorRecaudo) > 0
									THEN (SUM(r.valorRecaudo) * (- 1))
								ELSE 0
								END
							) AS recaudosDescontar
						,jd.id AS jerarquiaDetalle_id
						,r.anioCierre AS anioCierre
						,prod.plazo_id
					FROM JerarquiaDetalle AS jd
					CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
					INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
					INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
					INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
					INNER JOIN Producto prod ON prod.id = pd.producto_id
					WHERE jd.nivel_id NOT IN (
							0
							,1
							)
						AND prod.plazo_id = 1
						AND r.compania_id = 3
						AND r.anioCierre = (@anioAbierto - 1)
						AND rd.ramo_id = 17
						AND r.mesCierre <= @periodoInicioDic
					GROUP BY jd.id
						,r.anioCierre
						,prod.plazo_id
					) t2 ON t1.jerarquiaDetalle_id = t2.jerarquiaDetalle_id
					AND t1.anioCierreNegocio = t2.anioCierre
					AND t1.plazo_id = t2.plazo_id
				WHERE t1.anioCierreNegocio = (@anioAbierto - 1)
					AND t1.ultimoPeriodo = @periodoInicioDic
					AND t1.plazo_id = 1
					AND t1.persistenciaAcumulada < @valorPersistenciaCAPICortoPlazoEj
					AND t1.jerarquiaDetalle_id IS NOT NULL

				UPDATE PersistenciadeCAPIAcumulada
				SET recaudosDescontar = 0
				WHERE recaudosDescontar IS NULL
					AND jerarquiaDetalle_id IS NOT NULL

				SET @periodoInicioDic = @periodoInicioDic + 1
			END

			DROP TABLE #PersistenciaDelPeriodo1
		END
END
