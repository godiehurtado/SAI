-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 08/06/2012
-- Description:	Reclacula los valores de cumplimiento y crecimiento de la tabla temporal 'ConsolidadoMes_TEMP' y/o colquines de 'TablaMaestra_TEMP' solo del año del periodo que se esta liquidando
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_RecalcularTemporales]
	@añoenCurso	int,
	@reglaId	int
AS
BEGIN
	SET ANSI_WARNINGS OFF
	--DECLARE @crecimientoMinimoEtapa AS FLOAT = (SELECT CAST(valor AS FLOAT) FROM ParametrosApp WHERE id = 14)
	--drop table #tablaTM   drop table #TotalesTM   drop table #tablaCM   drop table #TotalesCM
	DECLARE @anio int=@añoenCurso, @regla_id int=@reglaId, @registrosTM int=0, @registrosCM int=0, @conceptosTM int=0, @conceptosCM int=0
	DECLARE @campo varchar(100)='', @año varchar(4)=@anio, @reglaCad varchar(10)=@regla_id
	
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TablaMaestra_TEMP]') AND type in (N'U'))  SELECT @registrosTM = COUNT(id) FROM TablaMaestra_TEMP WHERE compania_id=-1
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsolidadoMes_TEMP]') AND type in (N'U'))  SELECT @registrosCM = COUNT(id) FROM ConsolidadoMes_TEMP WHERE compania_id=-1
	
	SELECT @conceptosTM = COUNT(DISTINCT v.id) FROM ReglaxConceptoDescuento rxd INNER JOIN ConceptoDescuento cd ON rxd.conceptoDescuento_id=cd.id 
		INNER JOIN SubRegla sr ON rxd.regla_id=sr.regla_id INNER JOIN Condicion c ON c.subregla_id=sr.id INNER JOIN Variable v ON v.id=c.variable_id
	wHERE rxd.regla_id = @regla_id AND v.esFiltro=0 AND v.tipoTabla=1
	
	SELECT @conceptosCM = COUNT(DISTINCT v.id) FROM ReglaxConceptoDescuento rxd INNER JOIN ConceptoDescuento cd ON rxd.conceptoDescuento_id=cd.id 
		INNER JOIN SubRegla sr ON rxd.regla_id=sr.regla_id INNER JOIN Condicion c ON c.subregla_id=sr.id INNER JOIN Variable v ON v.id=c.variable_id
	wHERE rxd.regla_id = @regla_id AND v.esFiltro=0 AND v.tipoTabla=2
	
	--select @registrosTM, @conceptosTM, @registrosCM, @conceptosCM
	
	
	-- DESCUENTOS DE COLQUINES EN TablaMaestra_TEMP
	IF @registrosTM > 0 OR @conceptosTM > 0 BEGIN
		--drop table TablaMaestra_TEMP	SELECT * INTO TablaMaestra_TEMP FROM TablaMaestra WHERE anioCierre IN (2011, 2012)
		--**************************************************************************************************
		-- DESCUENTO DE COLQUINES SOBRE 'ConsolidadoMes_TEMP' (tipomedida: 2): Descuenta los colquines de siniestralidad o persistencia parametrizados
		--**************************************************************************************************
		
		ALTER TABLE TablaMaestra_TEMP ADD actual float
		ALTER TABLE TablaMaestra_TEMP ADD descuento float
		ALTER TABLE TablaMaestra_TEMP ADD colquinesFinales float

		UPDATE t1  SET actual = t2.actual	--select t1.compania_id, t1.ramo_id, t1.participante_id, t1.plazo_id, t1.mesCierre, t1.cantidadColquines, t1.actual, t1.descuento
		FROM TablaMaestra_TEMP t1
			INNER JOIN (
				SELECT compania_id, ramo_id, participante_id, plazo_id, mesCierre, SUM(cantidadColquines) actual, MAX(id) maximoID
				FROM TablaMaestra_TEMP
				WHERE conceptoDescuento_id = 0
					AND anioCierre = @anio  --AND participante_id = (select id from Participante where clave='7977')
				GROUP BY compania_id, ramo_id, participante_id, plazo_id, mesCierre  --order by compania_id, ramo_id, participante_id, plazo_id, mesCierre
			)
			AS t2 ON t1.participante_id = t2.participante_id
			AND t1.compania_id = t2.compania_id
			AND t1.ramo_id = t2.ramo_id
			AND t1.plazo_id = t2.plazo_id
			AND t1.mesCierre = t2.mesCierre
			AND t1.id = t2.maximoID
		WHERE conceptoDescuento_id = 0
			AND anioCierre = @anio  --AND t1.participante_id = (select id from Participante where clave='7977') --order by t1.compania_id, t1.ramo_id, t1.participante_id, t1.plazo_id, t1.mesCierre


		UPDATE AV  SET AV.descuento = D.descuento	--select AV.compania_id, AV.ramo_id, AV.participante_id, AV.plazo_id, AV.cantidadColquines, AV.actual, AV.descuento
		FROM TablaMaestra_TEMP AV
			INNER JOIN (
				SELECT compania_id, ramo_id, participante_id, plazo_id, cd.tipoMedida_id, mesCierre, SUM(cantidadColquines) descuento, MAX(tm.id) AS maximoID
				FROM TablaMaestra_TEMP tm
					INNER JOIN ConceptoDescuento cd ON cd.id = tm.conceptoDescuento_id AND cd.tipoMedida_id <> 0
					INNER JOIN ReglaxConceptoDescuento rcd ON rcd.conceptoDescuento_id = cd.id
				WHERE anioCierre = @anio
					AND producto_id IS NULL
					AND rcd.regla_id = @regla_id  --AND participante_id = (select id from Participante where clave='7977')
				GROUP BY compania_id, ramo_id, participante_id, plazo_id, cd.tipoMedida_id, mesCierre	--order by compania_id, ramo_id, participante_id, plazo_id, mesCierre
			)
			AS D ON D.participante_id = AV.participante_id
			AND D.compania_id = AV.compania_id
			AND D.ramo_id = AV.ramo_id
			AND AV.mesCierre = D.mesCierre
			AND (CASE WHEN D.tipoMedida_id = 23 THEN D.plazo_id ELSE 0 END) = (CASE WHEN D.tipoMedida_id = 23 THEN AV.plazo_id ELSE 0 END)
		WHERE AV.conceptoDescuento_id = 0
			AND anioCierre = @anio
			AND AV.actual IS NOT NULL  --AND AV.participante_id = (select id from Participante where clave='7977')
		

		UPDATE TablaMaestra_TEMP SET descuento=0 WHERE anioCierre=@anio AND actual IS NOT NULL AND descuento IS NULL

		UPDATE TablaMaestra_TEMP SET colquinesFinales=0 WHERE anioCierre=@anio AND actual IS NULL AND descuento IS NULL

		UPDATE TablaMaestra_TEMP SET colquinesFinales = cantidadColquines WHERE año=@anio AND ramo_id IS NULL

		UPDATE TablaMaestra_TEMP
		SET colquinesFinales = (
				CASE WHEN ROUND(ISNULL(actual,0), 2) < 0 AND ROUND(ISNULL(descuento,0), 2) = 0
					THEN ROUND(ISNULL(actual,0), 2)
				ELSE CASE 
						WHEN (ROUND(ISNULL(actual,0), 2) + ROUND(ISNULL(descuento,0), 2)) < 0 THEN 0
						ELSE (ROUND(ISNULL(actual,0), 2) + ROUND(ISNULL(descuento,0), 2))
						END
				END)
		WHERE colquinesFinales IS NULL AND anioCierre=@anio

		UPDATE TablaMaestra_TEMP  SET cantidadColquines = colquinesFinales WHERE actual IS NOT NULL AND anioCierre = @anio
		
		PRINT 'Colquines de la tabla TablaMaestra_TEMP descontado'
	END
	
	
	-- DESCUENTOS DE COLQUINES EN ConsolidadoMes_TEMP
	IF @registrosCM > 0 OR @conceptosCM > 0 BEGIN
		--drop table ConsolidadoMes_TEMP	SELECT * INTO ConsolidadoMes_TEMP FROM ConsolidadoMes WHERE año IN (2011, 2012)
		--**************************************************************************************************
		-- DESCUENTO DE COLQUINES SOBRE 'ConsolidadoMes_TEMP' (tipomedida: 2): Descuenta los colquines de siniestralidad o persistencia parametrizados
		--**************************************************************************************************
		
		DECLARE @Campos CURSOR SET @Campos = CURSOR LOCAL FAST_FORWARD FOR
			SELECT V.columnaTablaMaestra
			FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id = V.id INNER JOIN SubRegla sr ON C.subregla_id=sr.id
			WHERE sr.regla_id = @reglaCad AND V.id IN (172,186,187,188,189)
			GROUP BY V.columnaTablaMaestra
		
		OPEN @Campos
		FETCH NEXT FROM @Campos INTO @campo
		WHILE @@FETCH_STATUS = 0 BEGIN
			
			EXEC ('UPDATE t1  SET actual = t2.actual
					FROM ConsolidadoMes_TEMP t1
						INNER JOIN (
							SELECT compania_id, ramo_id, participante_id, plazo_id, SUM('+ @campo +') actual, MAX(id) maximoID
							FROM ConsolidadoMes_TEMP
							WHERE tipoMedida_id = 2
								AND año = '+ @año +'
							GROUP BY compania_id, ramo_id, participante_id, plazo_id
						)
						AS t2 ON t1.participante_id = t2.participante_id
						AND t1.compania_id = t2.compania_id
						AND t1.ramo_id = t2.ramo_id
						AND t1.plazo_id = t2.plazo_id
						AND t1.id = t2.maximoID
					WHERE tipoMedida_id = 2
						AND año = '+ @año)
				
				
			EXEC ('UPDATE AV  SET AV.descuento = D.descuento
					FROM ConsolidadoMes_TEMP AV
						INNER JOIN (
							SELECT compania_id, ramo_id, participante_id, plazo_id, cd.tipoMedida_id, SUM('+ @campo +') descuento, MAX(cm.id) AS maximoID
							FROM ConsolidadoMes_TEMP cm
								INNER JOIN ConceptoDescuento cd ON cd.tipoMedida_id = cm.tipoMedida_id
								INNER JOIN ReglaxConceptoDescuento rcd ON rcd.conceptoDescuento_id = cd.id
							WHERE año = '+ @año +'
								AND producto_id = 0
								AND rcd.regla_id = '+ @reglaCad +'
							GROUP BY compania_id, ramo_id, participante_id, plazo_id, cd.tipoMedida_id
						)
						AS D ON D.participante_id = AV.participante_id
						AND D.compania_id = AV.compania_id
						AND D.ramo_id = AV.ramo_id
						AND (CASE WHEN D.tipoMedida_id = 23 THEN D.plazo_id ELSE 0 END) = (CASE WHEN D.tipoMedida_id = 23 THEN AV.plazo_id ELSE 0 END)
					WHERE AV.tipoMedida_id = 2
						AND año = '+ @año +'
						AND AV.actual IS NOT NULL')
				

			UPDATE ConsolidadoMes_TEMP SET descuento=0 WHERE año=@anio AND actual IS NOT NULL AND descuento IS NULL

			UPDATE ConsolidadoMes_TEMP SET colquinesFinales=0 WHERE año=@anio AND actual IS NULL AND descuento IS NULL
			
			UPDATE ConsolidadoMes_TEMP SET colquinesFinales=Etapa_3 WHERE año=@anio AND ramo_id IS NULL

			UPDATE ConsolidadoMes_TEMP
			SET colquinesFinales = (
					CASE 
						WHEN ROUND(actual, 2) < 0 AND ROUND(descuento, 2) = 0 THEN ROUND(actual, 2)
						ELSE CASE 
								WHEN (ROUND(actual, 2) + ROUND(descuento, 2)) < 0 THEN 0
								ELSE (ROUND(actual, 2) + ROUND(descuento, 2)) END
						END)
			WHERE colquinesFinales IS NULL

			EXEC ('UPDATE ConsolidadoMes_TEMP SET '+ @campo +' = colquinesFinales WHERE año = '+ @año +' AND ramo_id IS NOT NULL')
			
			FETCH NEXT FROM @Campos INTO @campo
		END CLOSE @Campos DEALLOCATE @Campos
		
		PRINT 'Colquines de la tabla ConsolidadoMes_TEMP descontado'
		
		/*SELECT participante_id, SUM(Etapa_1) FROM ConsolidadoMes_TEMP WHERE tipoMedida_id = 2 AND año = 2012 and participante_id=16
		group by participante_id*/
		
		
		
		--**************************************************************************************************
		-- CRECIMIENTO EN COLQUINES (tipomedida: 18): Recalcula el crecimiento del Colquines x Etapa (sin filtros)
		--**************************************************************************************************
		DECLARE @TipoMedida18 table (compania_id int, tipoMedida_id int, clave nvarchar(200), participante_id int, Etapa_1 float, Etapa_2 float, Etapa_3 float, Etapa_4 float, Etapa_5 float , año int)

		-- Inserta en la tabla temporal '@TipoMedida18' la información recalculada de crecimientos a guardar en ConsolidadoMes_TEMP
		INSERT INTO @TipoMedida18
		SELECT
			 0
			,18 AS CrecimientoColquines
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,(
				CASE 
					WHEN SUM(AV.Etapa_1) > 0 AND (SUM(q1.AAEtapa_1) IS NULL OR SUM(q1.AAEtapa_1) = 0)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_1) - q1.AAEtapa_1) * 100) / NULLIF(q1.AAEtapa_1, 0), NULL))
					END
				) AS Etapa_1
			,(
				CASE 
					WHEN SUM(AV.Etapa_2) > 0 AND (SUM(q1.AAEtapa_2) IS NULL OR SUM(q1.AAEtapa_2) = 0)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_2) - q1.AAEtapa_2) * 100) / NULLIF(q1.AAEtapa_2, 0), NULL))
					END
				) AS Etapa_2
			,(
				CASE 
					WHEN SUM(AV.Etapa_3) > 0 AND (SUM(q1.AAEtapa_3) IS NULL OR SUM(q1.AAEtapa_3) = 0)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_3) - q1.AAEtapa_3) * 100) / NULLIF(q1.AAEtapa_3, 0), NULL))
					END
				) AS Etapa_3
			,(
				CASE 
					WHEN SUM(AV.Etapa_4) > 0 AND (SUM(q1.AAEtapa_4) IS NULL OR SUM(q1.AAEtapa_4) = 0)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_4) - q1.AAEtapa_4) * 100) / NULLIF(q1.AAEtapa_4, 0), NULL))
					END
				) AS Etapa_4
			,(
				CASE 
					WHEN SUM(AV.Etapa_5) > 0 AND (SUM(q1.AAEtapa_5) IS NULL OR SUM(q1.AAEtapa_5) = 0)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_5) - q1.AAEtapa_5) * 100) / NULLIF(q1.AAEtapa_5, 0), NULL))
					END
				) AS Etapa_5
			,CAST(@anio AS INT)
		FROM ConsolidadoMes_TEMP AV
			LEFT JOIN (
				SELECT RTRIM(LTRIM(AA.clave)) AS clave
					,SUM(AA.Etapa_1) AS AAEtapa_1
					,SUM(AA.Etapa_2) AS AAEtapa_2
					,SUM(AA.Etapa_3) AS AAEtapa_3
					,SUM(AA.Etapa_4) AS AAEtapa_4
					,SUM(AA.Etapa_5) AS AAEtapa_5
				FROM ConsolidadoMes_TEMP AA
				WHERE AA.año = CAST(@anio - 1 AS INT) AND AA.tipoMedida_id=2
				GROUP BY AA.clave
					,AA.participante_id
			)
			AS q1 ON AV.clave = q1.clave
		WHERE AV.año = CAST(@anio AS INT) AND AV.tipoMedida_id=2
		GROUP BY
			 AV.clave, AV.participante_id, q1.AAEtapa_1, q1.AAEtapa_2, q1.AAEtapa_3, q1.AAEtapa_4, q1.AAEtapa_5
		
		
		-- Se eliminan los registros con Tipo de Medida 18 del periodo actual
		DELETE FROM ConsolidadoMes_TEMP WHERE tipoMedida_id = 18 AND año = @anio
		
		-- Finalmente se insertan los nuevos datos recalculados de Tipo de Medida 18 en la tabla ConsolidadoMes_TEMP
		INSERT INTO ConsolidadoMes_TEMP (compania_id, tipoMedida_id, clave, participante_id, Etapa_1, Etapa_2, Etapa_3, Etapa_4, Etapa_5, año)
		SELECT * FROM @TipoMedida18
		
		
		
		--**************************************************************************************************
		-- CUMPLIMIENTO EN COLQUINES (tipomedida: 7): Toma el valor Consolidado por colquines de recaudos,  tipomedida: 2
		--**************************************************************************************************
		DECLARE @TipoMedida7 table (
			 compania_id int, tipoMedida_id int, clave nvarchar(200), participante_id int, Enero float, Febrero float, Marzo float, Abril float, Mayo float, Junio float, Julio float, Agosto float,
			 Septiembre float, Octubre float, Noviembre float, Diciembre float, Ene_Mar float, Abr_Jun float, Jul_Sep float, Oct_Dic float, Ene_Jun float, Jul_Dic float, Ene_Dic float, Ene_Mar_Total float,
			 Abr_Jun_Total float, Jul_Sep_Total float, Oct_Dic_Total float, Etapa_1 float, Etapa_2 float, Etapa_3 float, Etapa_4 float, Etapa_5 float, año int
		)
		
		-- Inserta en la tabla temporal '@TipoMedida7' la información recalculada de cumplimientos a guardar en ConsolidadoMes_TEMP
		INSERT INTO @TipoMedida7
		SELECT
			 0--AV.compania_id
			,7 AS CumplimientoColquines
			,RTRIM(LTRIM(AV.clave)) clave
			,AV.participante_id
			,
			CASE 
				WHEN SUM(AV.Enero) IS NOT NULL AND (SUM(q1.AAEnero) IS NULL OR SUM(q1.AAEnero) = 0) THEN 100
				ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
				END AS Enero
			,
			CASE 
				WHEN SUM(AV.Febrero) IS NOT NULL AND (SUM(q1.AAFebrero) IS NULL OR SUM(q1.AAFebrero) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
				END AS Febrero
			,
			CASE 
				WHEN SUM(AV.Marzo) IS NOT NULL AND (SUM(q1.AAMarzo) IS NULL OR SUM(q1.AAMarzo) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
				END AS Marzo
			,
			CASE 
				WHEN SUM(AV.Abril) IS NOT NULL AND (SUM(q1.AAAbril) IS NULL OR SUM(q1.AAAbril) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
				END AS Abril
			,
			CASE 
				WHEN SUM(AV.Mayo) IS NOT NULL AND (SUM(q1.AAMayo) IS NULL OR SUM(q1.AAMayo) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
				END AS Mayo
			,
			CASE 
				WHEN SUM(AV.Junio) IS NOT NULL AND (SUM(q1.AAJunio) IS NULL OR SUM(q1.AAJunio) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
				END AS Junio
			,
			CASE 
				WHEN SUM(AV.Julio) IS NOT NULL AND (SUM(q1.AAJulio) IS NULL OR SUM(q1.AAJulio) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
				END AS Julio
			,
			CASE 
				WHEN SUM(AV.Agosto) IS NOT NULL AND (SUM(q1.AAAgosto) IS NULL OR SUM(q1.AAAgosto) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
				END AS Agosto
			,
			CASE 
				WHEN SUM(AV.Septiembre) IS NOT NULL AND (SUM(q1.AASeptiembre) IS NULL OR SUM(q1.AASeptiembre) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
				END AS Septiembre
			,
			CASE 
				WHEN SUM(AV.Octubre) IS NOT NULL AND (SUM(q1.AAOctubre) IS NULL OR SUM(q1.AAOctubre) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
				END AS Octubre
			,
			CASE 
				WHEN SUM(AV.Noviembre) IS NOT NULL AND (SUM(q1.AANoviembre) IS NULL OR SUM(q1.AANoviembre) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
				END AS Noviembre
			,
			CASE 
				WHEN SUM(AV.Diciembre) IS NOT NULL AND (SUM(q1.AADiciembre) IS NULL OR SUM(q1.AADiciembre) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
				END AS Diciembre
			,
			CASE 
				WHEN SUM(AV.Ene_Mar) IS NOT NULL AND (SUM(q1.AAEne_Mar) IS NULL OR SUM(q1.AAEne_Mar) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
				END AS Ene_Mar
			,
			CASE 
				WHEN SUM(AV.Abr_Jun) IS NOT NULL AND (SUM(q1.AAAbr_Jun) IS NULL OR SUM(q1.AAAbr_Jun) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
				END AS Abr_Jun
			,
			CASE 
				WHEN SUM(AV.Jul_Sep) IS NOT NULL AND (SUM(q1.AAJul_Sep) IS NULL OR SUM(q1.AAJul_Sep) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
				END AS Jul_Sep
			,
			CASE 
				WHEN SUM(AV.Oct_Dic) IS NOT NULL AND (SUM(q1.AAOct_Dic) IS NULL OR SUM(q1.AAOct_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
				END AS Oct_Dic
			,
			CASE 
				WHEN SUM(AV.Ene_Jun) IS NOT NULL AND (SUM(q1.AAEne_Jun) IS NULL OR SUM(q1.AAEne_Jun) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
				END AS Ene_Jun
			,
			CASE 
				WHEN SUM(AV.Jul_Dic) IS NOT NULL AND (SUM(q1.AAJul_Dic) IS NULL OR SUM(q1.AAJul_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
				END AS Jul_Dic
			,
			CASE 
				WHEN SUM(AV.Ene_Dic) IS NOT NULL AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Ene_Dic
			,
			CASE 
				WHEN SUM(AV.Ene_Mar) IS NOT NULL AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Ene_Mar) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Ene_Mar_Total
			,
			CASE 
				WHEN SUM(AV.Abr_Jun) IS NOT NULL AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Abr_Jun) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Abr_Jun_Total
			,
			CASE 
				WHEN SUM(AV.Jul_Sep) IS NOT NULL AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Jul_Sep) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Jul_Sep_Total
			,
			CASE 
				WHEN SUM(AV.Oct_Dic) IS NOT NULL AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Oct_Dic) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Oct_Dic_Total
			,
			CASE 
				WHEN SUM(AV.Etapa_1) >= 0 AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Etapa_1) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Etapa_1
			,
			CASE 
				WHEN SUM(AV.Etapa_2) >= 0 AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Etapa_2) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Etapa_2
			,
			CASE 
				WHEN SUM(AV.Etapa_3) >= 0 AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Etapa_3) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Etapa_3
			,
			CASE 
				WHEN SUM(AV.Etapa_4) >= 0 AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Etapa_4) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Etapa_4
			,
			CASE 
				WHEN SUM(AV.Etapa_5) >= 0 AND (SUM(q1.AAEne_Dic) IS NULL OR SUM(q1.AAEne_Dic) = 0)
					THEN 100
				ELSE (ISNULL(((SUM(AV.Etapa_5) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
				END AS Etapa_5
			,CAST(@anio AS INT) anio
		FROM ConsolidadoMes_TEMP AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
				--,AA.compania_id
				,SUM(AA.Enero) AS AAEnero
				,SUM(AA.Febrero) AS AAFebrero
				,SUM(AA.Marzo) AS AAMarzo
				,SUM(AA.Abril) AS AAAbril
				,SUM(AA.Mayo) AS AAMayo
				,SUM(AA.Junio) AS AAJunio
				,SUM(AA.Julio) AS AAJulio
				,SUM(AA.Agosto) AS AAAgosto
				,SUM(AA.Septiembre) AS AASeptiembre
				,SUM(AA.Octubre) AS AAOctubre
				,SUM(AA.Noviembre) AS AANoviembre
				,SUM(AA.Diciembre) AS AADiciembre
				,SUM(AA.Ene_Mar) AS AAEne_Mar
				,SUM(AA.Abr_Jun) AS AAAbr_Jun
				,SUM(AA.Jul_Sep) AS AAJul_Sep
				,SUM(AA.Oct_Dic) AS AAOct_Dic
				,SUM(AA.Ene_Jun) AS AAEne_Jun
				,SUM(AA.Jul_Dic) AS AAJul_Dic
				,SUM(AA.Ene_Dic) AS AAEne_Dic
			FROM ConsolidadoMes_TEMP AA
			WHERE AA.año = CAST(@anio - 1 AS INT) AND AA.tipoMedida_id=2
			GROUP BY AA.clave
				,AA.participante_id
				--,AA.compania_id
			) AS q1 ON AV.clave = q1.clave
			--AND AV.compania_id = q1.compania_id
		WHERE AV.año = CAST(@anio AS INT) AND AV.tipoMedida_id=2
		GROUP BY
			 AV.clave
			,AV.participante_id
			--,AV.compania_id
			,q1.AAEnero, q1.AAFebrero, q1.AAMarzo, q1.AAAbril, q1.AAMayo, q1.AAJunio, q1.AAJulio, q1.AAAgosto, q1.AASeptiembre, q1.AAOctubre, q1.AANoviembre
			,q1.AADiciembre, q1.AAEne_Mar, q1.AAAbr_Jun, q1.AAJul_Sep, q1.AAOct_Dic, q1.AAEne_Jun, q1.AAJul_Dic, q1.AAEne_Dic
		
		
		-- Se eliminan los registros con Tipo de Medida 7 del periodo actual
		DELETE FROM ConsolidadoMes_TEMP WHERE tipoMedida_id = 7 AND año = @anio
		
		-- Finalmente se insertan los nuevos datos recalculados de Tipo de Medida 7 en la tabla ConsolidadoMes_TEMP
		INSERT INTO ConsolidadoMes_TEMP (
			 compania_id, tipoMedida_id, clave, participante_id, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre, Ene_Mar, Abr_Jun,
			 Jul_Sep, Oct_Dic, Ene_Jun, Jul_Dic, Ene_Dic, Ene_Mar_Total, Abr_Jun_Total, Jul_Sep_Total, Oct_Dic_Total, Etapa_1, Etapa_2, Etapa_3, Etapa_4, Etapa_5, año
		)
		SELECT * FROM @TipoMedida7

		PRINT 'Colquines, Cumplimientos y Crecimientos de la tabla ConsolidadoMes_TEMP recalculado'
	
	END
	
	SET ANSI_WARNINGS ON
	
END