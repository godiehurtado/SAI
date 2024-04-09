-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Calculo de la persistencia de VIDA--				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_PersistenciaVIDA]
AS
BEGIN
	DECLARE @añoenCurso AS INT = (
		SELECT anioCierre FROM PeriodoCierre WHERE compania_id = 2
		AND estado = 1
		)
	DECLARE @mesCorte AS INT = (
		SELECT mesCierre FROM PeriodoCierre WHERE compania_id = 2
		AND estado = 1
		AND anioCierre = @añoenCurso
		)
	DECLARE @valorPersistenciaVIDA AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = @añoenCurso
		AND YEAR(c.fecha_fin) = @añoenCurso
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'true'
		AND c.tipoConcurso_id = 1
		)
	DECLARE @valorPersistenciaVIDAEje AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = @añoenCurso
		AND YEAR(c.fecha_fin) = @añoenCurso
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'true'
		AND c.tipoConcurso_id = 2
		)

	IF (@valorPersistenciaVIDA IS NOT NULL)
	BEGIN
		IF EXISTS (
				SELECT *
				FROM sys.objects
				WHERE object_id = OBJECT_ID(N'[dbo].[PersistenciaVIDADetalle]')
					AND type IN (N'U')
				)
			DROP TABLE [dbo].[PersistenciaVIDADetalle]

		-- *********************************************************************************************************
		-- BASE DE CALCULO DE NEGOCIOS.
		-- *********************************************************************************************************--
		SELECT na.*
			,rd.ramo_id
		INTO #Negocios
		FROM Negocio na
		INNER JOIN RamoDetalle rd ON rd.id = na.ramoDetalle_id
		WHERE na.anioCierre = (@añoenCurso - 1)
			AND na.compania_id = 2
			AND rd.ramo_id = 11
			AND na.lineaNegocio_id = 1
			AND NOT EXISTS (
				SELECT n1.id
				FROM Negocio n1
				INNER JOIN RamoDetalle rd ON rd.id = n1.ramoDetalle_id
				INNER JOIN ExcepcionesConsolidados ec ON ec.compania_id = n1.compania_id
					AND ec.ramo_id = rd.ramo_id
					AND ec.lineaNegocio_id = n1.lineaNegocio_id
				WHERE MONTH(n1.fechaEmisionMaximoEndoso) > n1.mesCierre
					AND YEAR(n1.fechaEmisionMaximoEndoso) >= (@añoenCurso - 1)
					AND n1.anioCierre = (@añoenCurso - 1)
					AND n1.id = na.id
				)
		
		UNION
		
		SELECT nb.*
			,rd.ramo_id
		FROM Negocio nb
		INNER JOIN RamoDetalle rd ON rd.id = nb.ramoDetalle_id
		WHERE (
				(
					nb.anioCierre = @añoenCurso
					AND nb.mesCierre <= @mesCorte
					)
				OR (
					nb.anioCierre = (
						CASE 
							WHEN @mesCorte = 12
								THEN (@añoenCurso + 1)
							ELSE 0
							END
						)
					AND nb.mesCierre = (
						CASE 
							WHEN @mesCorte = 12
								THEN 1
							ELSE 0
							END
						)
					)
				)
			AND nb.compania_id = 2
			AND rd.ramo_id = 11
			AND nb.lineaNegocio_id = 1
			AND NOT EXISTS (
				SELECT n1.id
				FROM Negocio n1
				INNER JOIN RamoDetalle rd ON rd.id = n1.ramoDetalle_id
				INNER JOIN ExcepcionesConsolidados ec ON ec.compania_id = n1.compania_id
					AND ec.ramo_id = rd.ramo_id
					AND ec.lineaNegocio_id = n1.lineaNegocio_id
				WHERE MONTH(n1.fechaEmisionMaximoEndoso) > n1.mesCierre
					AND YEAR(n1.fechaEmisionMaximoEndoso) >= @añoenCurso
					AND n1.anioCierre = @añoenCurso
					AND n1.id = nb.id
				)

		-- NEGOCIOS VIGENTES POR GRUPO DE ENDOSO
		SELECT n.compania_id
			,n.numeroNegocio
			,MAX(n.fechaExpedicion) AS fechaExpedicion
			,n.clave
			,n.participante_id
			,n.grupoEndoso_id
			,n.anioCierre
		INTO #NegociosVigentesxEndoso
		FROM #Negocios n
		INNER JOIN #Negocios n1 ON n1.numeroNegocio = n.numeroNegocio
		INNER JOIN GrupoEndoso ge ON ge.id = n1.grupoEndoso_id
		WHERE ge.claseEndoso = 1
		GROUP BY n.compania_id
			,n.numeroNegocio
			,n.clave
			,n.participante_id
			,n.grupoEndoso_id
			,n.anioCierre

		ALTER TABLE #NegociosVigentesxEndoso ADD prima FLOAT

		ALTER TABLE #NegociosVigentesxEndoso ADD claseEndoso INT

		UPDATE #NegociosVigentesxEndoso
		SET claseEndoso = ge.claseEndoso
		FROM #NegociosVigentesxEndoso n
		INNER JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id

		-- Actualiza valor de la prima para los negocios x grupo endoso
		UPDATE t1
		SET t1.Prima = t2.prima
		FROM #NegociosVigentesxEndoso t1
		INNER JOIN (
			SELECT n.numeroNegocio
				,n.fechaExpedicion AS fechaExpedicion
				,n.participante_id
				,n.grupoEndoso_id
				,SUM(n.valorPrimaTotal) AS prima
				,n.anioCierre
			FROM #Negocios n
			GROUP BY n.numeroNegocio
				,n.participante_id
				,n.grupoEndoso_id
				,n.anioCierre
				,n.fechaExpedicion
			) t2 ON t1.participante_id = t2.participante_id
			AND t1.numeroNegocio = t2.numeroNegocio
			AND t1.fechaExpedicion = t2.fechaExpedicion
			AND t1.anioCierre = t2.anioCierre
			AND t1.grupoEndoso_id = t2.grupoEndoso_id

		-- NEGOCIOS VIGENTES
		SELECT n.compania_id
			,n.numeroNegocio
			,MAX(n.fechaExpedicion) AS fechaExpedicion
			,n.clave
			,n.participante_id
			,n.anioCierre
		INTO #NegociosVigentes
		FROM #Negocios n
		INNER JOIN #Negocios n1 ON n1.numeroNegocio = n.numeroNegocio
			AND n1.anioCierre = n.anioCierre
		INNER JOIN GrupoEndoso ge ON ge.id = n1.grupoEndoso_id
		WHERE ge.claseEndoso = 1
		GROUP BY n.compania_id
			,n.numeroNegocio
			,n.clave
			,n.participante_id
			,n.anioCierre

		ALTER TABLE #NegociosVigentes ADD grupoEndoso_id INT

		ALTER TABLE #NegociosVigentes ADD valorPrima FLOAT

		-- Actualiza el grupo de endoso de la última fecha del negocio
		UPDATE t1
		SET t1.grupoEndoso_id = t2.grupoEndoso_id
		FROM #NegociosVigentes t1
		INNER JOIN (
			SELECT n.numeroNegocio
				,MAX(n.fechaExpedicion) AS fechaExpedicion
				,n.participante_id
				,n.grupoEndoso_id
				,SUM(n.prima) AS prima
				,n.anioCierre
			FROM #NegociosVigentesxEndoso n
			GROUP BY n.numeroNegocio
				,n.participante_id
				,n.grupoEndoso_id
				,n.anioCierre
			) t2 ON t1.participante_id = t2.participante_id
			AND t1.numeroNegocio = t2.numeroNegocio
			AND t1.fechaExpedicion = t2.fechaExpedicion
			AND t1.anioCierre = t2.anioCierre

		UPDATE t1
		SET t1.valorPrima = t2.prima
		FROM #NegociosVigentes t1
		INNER JOIN (
			SELECT n.numeroNegocio
				,n.participante_id
				,SUM(n.prima) AS prima
				,n.anioCierre
			FROM #NegociosVigentesxEndoso n
			WHERE claseEndoso = 1
			GROUP BY n.numeroNegocio
				,n.participante_id
				,n.grupoEndoso_id
				,n.anioCierre
			) t2 ON t1.participante_id = t2.participante_id
			AND t1.numeroNegocio = t2.numeroNegocio
			AND t1.anioCierre = t2.anioCierre

		ALTER TABLE #NegociosVigentes ADD estadoReal NVARCHAR(5)

		ALTER TABLE #NegociosVigentes ADD claseEndoso INT

		UPDATE #NegociosVigentes
		SET estadoReal = ge.estadoReal
			,claseEndoso = ge.claseEndoso
		FROM #NegociosVigentes n
		INNER JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id

		ALTER TABLE #Negocios ADD estadoReal NVARCHAR(5)

		ALTER TABLE #Negocios ADD claseEndoso INT

		-- *********************************************************************************************************
		-- EXCEPCIONES POR GRUPO ENDOSO (ESTADO REAL DEL NEGOCIO (VIGENTE O NO VIGENTE)).
		-- *********************************************************************************************************--
		UPDATE #Negocios
		SET estadoReal = ge.estadoReal
			,claseEndoso = ge.claseEndoso
		FROM #Negocios n
		INNER JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id

		-- *********************************************************************************************************
		-- TABLA DETALLE REPORTE.
		-- *********************************************************************************************************--
		SELECT c.id AS compania_id
			,c.nombre AS Compania
			,z.id AS zona_id
			,z.nombre AS zonaNombre
			,l.id AS localidad_id
			,l.nombre AS Localidad
			,jPadre.id AS jPadre_id
			,jPadre.nombre AS Director
			,pa.id AS participante_id
			,RTRIM(LTRIM(n.clave)) AS Clave
			,ca.id AS Canal_id
			,ca.nombre AS Canal
			,LTRIM(RTRIM(pa.nombre)) + ' ' + LTRIM(RTRIM(pa.apellidos)) AS nombreParticipante
			,n.porcentajeParticipacion
			,ln.id AS lineaNegocio_id
			,ln.nombre AS LineaNegocio
			,s.id AS segmento_id
			,s.nombre AS Segmento
			,r.id AS ramo_id
			,r.nombre AS Ramo
			,p.id AS producto_id
			,p.nombre AS Producto
			,pd.id AS plan_id
			,pd.nombre AS [Plan]
			,a.id AS amparo_id
			,a.nombre AS Amparo
			,co.nombre AS Cobertura
			,mp.id AS modalidadPago_id
			,mp.nombre AS ModalidadPago
			,pla.id AS plazo_id
			,pla.nombre AS plazoNombre
			,CAST(n.numeroNegocio AS BIGINT) AS numeroNegocio
			,n.estadoNegocio
			,n.valorAhorro
			,n.valorProteccion
			,n.valorPrimaPensiones
			,n.valorPrimaTotal
			,n.mesCierre
			,n.anioCierre
			,CAST(n.fechaExpedicion AS DATE) AS fechaExpedicion
			,CAST(n.fechaGrabacion AS DATE) AS fechaGrabacion
			,CAST(n.fechaCancelacion AS DATE) AS fechaCancelacion
			,n.identificacionSuscriptor AS cedulaCliente
			,n.nombreSuscriptor AS nombreCliente
			,ac.id AS actividadEconomica_id
			,ac.nombre AS ActividadEconomica
			,n.codigoAgrupador
			,ge.id AS grupoEndoso_id
			,ge.nombre AS grupoEndoso
			,te.id AS tipoEndoso_id
			,te.nombre AS tipoEndoso
			,ge.claseEndoso
			,n.estadoReal
		INTO PersistenciaVIDADetalle
		FROM #Negocios n
		INNER JOIN Compania c ON c.id = n.compania_id
		INNER JOIN LineaNegocio ln ON ln.id = n.lineaNegocio_id
		INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
		INNER JOIN Ramo r ON r.id = rd.ramo_id
		INNER JOIN ProductoDetalle pd ON pd.id = n.productoDetalle_id
		INNER JOIN Producto p ON p.id = pd.producto_id
		INNER JOIN Plazo pla ON pla.id = p.plazo_id
		LEFT JOIN Amparo a ON a.id = n.amparo_id
		LEFT JOIN Cobertura co ON co.id = n.cobertura_id
		LEFT JOIN Segmento s ON s.id = n.segmento_id
		LEFT JOIN ModalidadPago mp ON mp.id = n.modalidadPago_id
		LEFT JOIN ActividadEconomica ac ON ac.id = n.actividadEconomica_id
		INNER JOIN Participante pa ON pa.id = n.participante_id
		INNER JOIN Canal ca ON ca.id = pa.canal_id
		INNER JOIN Localidad l ON l.id = pa.localidad_id
		INNER JOIN Zona z ON z.id = l.zona_id
		LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = pa.id
		LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
		LEFT JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id
		LEFT JOIN TipoEndoso te ON te.id = n.tipoEndoso_id

		-- *********************************************************************************************************
		-- DEFINICIÓN DE FACTORES PARA EL CALCULO.
		-- *********************************************************************************************************--
		DECLARE @p_tipoPersistencia AS INT = 1

		WHILE (@p_tipoPersistencia <= 2)
		BEGIN
			DELETE
			FROM PersistenciadeVIDA
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia
				AND mesCorte = @mesCorte

			DECLARE @PersistenciaAñoAnterior AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 1)
			DECLARE @PersistenciaAñoActual AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 2)
			DECLARE @FactorxPolizas AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 3)
			DECLARE @FactorxPrimas AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 4)
			DECLARE @factorAñoActual AS INT = (
				SELECT (
					CASE @p_tipoPersistencia
						WHEN 1 --'Periodo'
							THEN 100
						ELSE (
								CASE @p_tipoPersistencia
									WHEN 2 --'Definitiva'
										THEN @PersistenciaAñoActual
									END
								)
						END
					)
				)
			DECLARE @factorAñoAnterior AS INT = (
				SELECT (
					CASE 
						WHEN @p_tipoPersistencia = 1 --'Periodo'
							THEN 0
						ELSE @PersistenciaAñoAnterior
						END
					)
				)

			SET LANGUAGE Spanish

			-- Tabla temporal con la Persistencia de VIDA, para el calculo de polizas expedidas, vigentes.
			SELECT n.participante_id
				,n.compania_id AS compania
				,n.ramo_id AS ramo
				,@añoenCurso AS AñoAMedir
				,(@añoenCurso - 1) AS AñoAnterior
				,@p_tipoPersistencia AS Tipopersistencia
				,GETDATE() AS fechaCalculo
				,@mesCorte AS mesCorte
				,0 AS cantidadExpedidosAnioActual
				,0 AS cantidadVigentesAnioActual
				,0 AS cantidadExpedidosAnioAnterior
				,0 AS cantidadVigentesAnioAnterior
			INTO #PersistenciaVIDAtemp
			FROM #Negocios n
			GROUP BY n.participante_id
				,n.compania_id
				,n.ramo_id

			ALTER TABLE #PersistenciaVIDAtemp ADD sumaExpedidosAnioActual FLOAT

			ALTER TABLE #PersistenciaVIDAtemp ADD sumaVigentesAnioActual FLOAT

			ALTER TABLE #PersistenciaVIDAtemp ADD sumaExpedidosAnioAnterior FLOAT

			ALTER TABLE #PersistenciaVIDAtemp ADD sumaVigentesAnioAnterior FLOAT

			-- *********************************************************************************************************
			-- CALCULOS AÑO ACTUAL
			-- *********************************************************************************************************--
			UPDATE t1
			SET t1.cantidadExpedidosAnioActual = t2.cantidadExpedidosAnioActual
			FROM #PersistenciaVIDAtemp t1
			INNER JOIN (
				SELECT n.participante_id
					,COUNT(DISTINCT n.numeroNegocio) AS cantidadExpedidosAnioActual
				FROM #Negocios n
				WHERE n.anioCierre = @añoenCurso
					AND n.claseEndoso = 1
				GROUP BY n.participante_id
				) t2 ON t2.participante_id = t1.participante_id

			UPDATE t1
			SET t1.sumaExpedidosAnioActual = t2.sumaExpedidosAnioActual
			FROM #PersistenciaVIDAtemp t1
			INNER JOIN (
				SELECT n.participante_id
					,SUM(n.valorPrimaTotal) AS sumaExpedidosAnioActual
				FROM #Negocios n
				WHERE n.anioCierre = @añoenCurso
					AND n.claseEndoso = 1
				GROUP BY n.participante_id
				) t2 ON t2.participante_id = t1.participante_id

			-- Se actualiza la cantidad de negocios vigentes.
			UPDATE t1
			SET t1.cantidadVigentesAnioActual = t2.cantidadVigentesAnioActual
			FROM #PersistenciaVIDAtemp t1
			INNER JOIN (
				SELECT n.participante_id
					,COUNT(DISTINCT n.numeroNegocio) AS cantidadVigentesAnioActual
				FROM #NegociosVigentes n
				WHERE n.anioCierre = @añoenCurso
					AND n.estadoReal = 'V'
				GROUP BY n.participante_id
				) t2 ON t2.participante_id = t1.participante_id

			-- Se actualiza la suma de primas de negocios vigentes.
			UPDATE t1
			SET t1.sumaVigentesAnioActual = t2.sumaVigentesAnioActual
			FROM #PersistenciaVIDAtemp t1
			INNER JOIN (
				SELECT n.participante_id
					,SUM(n.valorPrima) AS sumaVigentesAnioActual
				FROM #NegociosVigentes n
				WHERE n.anioCierre = @añoenCurso
					AND n.estadoReal = 'V'
				GROUP BY n.participante_id
				) t2 ON t2.participante_id = t1.participante_id

			-- *********************************************************************************************************
			-- CALCULOS AÑO ANTERIOR
			-- *********************************************************************************************************--
			UPDATE t1
			SET t1.cantidadExpedidosAnioAnterior = t2.cantidadExpedidosAnioAnterior
			FROM #PersistenciaVIDAtemp t1
			INNER JOIN (
				SELECT n.participante_id
					,COUNT(DISTINCT n.numeroNegocio) AS cantidadExpedidosAnioAnterior
				FROM #Negocios n
				WHERE n.anioCierre = (@añoenCurso - 1)
					AND n.claseEndoso = 1
				GROUP BY n.participante_id
				) t2 ON t2.participante_id = t1.participante_id

			UPDATE t1
			SET t1.sumaExpedidosAnioAnterior = t2.sumaExpedidosAnioAnterior
			FROM #PersistenciaVIDAtemp t1
			INNER JOIN (
				SELECT n.participante_id
					,SUM(n.valorPrimaTotal) AS sumaExpedidosAnioAnterior
				FROM #Negocios n
				WHERE n.anioCierre = (@añoenCurso - 1)
					AND n.claseEndoso = 1
				GROUP BY n.participante_id
				) t2 ON t2.participante_id = t1.participante_id

			-- Se actualiza la cantidad de negocios vigentes.
			UPDATE t1
			SET t1.cantidadVigentesAnioAnterior = t2.cantidadVigentesAnioAnterior
			FROM #PersistenciaVIDAtemp t1
			INNER JOIN (
				SELECT n.participante_id
					,COUNT(DISTINCT n.numeroNegocio) AS cantidadVigentesAnioAnterior
				FROM #NegociosVigentes n
				WHERE n.anioCierre = (@añoenCurso - 1)
					AND n.estadoReal = 'V'
				GROUP BY n.participante_id
				) t2 ON t2.participante_id = t1.participante_id

			-- Se actualiza la suma de primas de negocios vigentes.
			UPDATE t1
			SET t1.sumaVigentesAnioAnterior = t2.sumaVigentesAnioAnterior
			FROM #PersistenciaVIDAtemp t1
			INNER JOIN (
				SELECT n.participante_id
					,SUM(n.valorPrima) AS sumaVigentesAnioAnterior
				FROM #NegociosVigentes n
				WHERE n.anioCierre = (@añoenCurso - 1)
					AND n.estadoReal = 'V'
				GROUP BY n.participante_id
				) t2 ON t2.participante_id = t1.participante_id

			UPDATE #PersistenciaVIDAtemp
			SET sumaExpedidosAnioActual = 0
			WHERE sumaExpedidosAnioActual IS NULL

			UPDATE #PersistenciaVIDAtemp
			SET sumaVigentesAnioActual = 0
			WHERE sumaVigentesAnioActual IS NULL

			UPDATE #PersistenciaVIDAtemp
			SET sumaExpedidosAnioAnterior = 0
			WHERE sumaExpedidosAnioAnterior IS NULL

			UPDATE #PersistenciaVIDAtemp
			SET sumaVigentesAnioAnterior = 0
			WHERE sumaVigentesAnioAnterior IS NULL

			-- *********************************************************************************************************
			-- CALCULOS ASESORES
			-- *********************************************************************************************************--
			INSERT INTO PersistenciadeVIDA (
				participante_id
				,compania_id
				,ramo_id
				,añoAMedir
				,añoAnterior
				,tipoPersistencia
				,fechaMedicionPersistencia
				,mesCorte
				,cantidadNegociosAñoActual
				,cantidadNegociosVigentesAñoActual
				,sumaPrimasAñoActual
				,sumaPrimasVigentesAñoActual
				,cantidadNegociosAñoAnterior
				,cantidadNegociosVigentesAñoAnterior
				,sumaPrimasAñoAnterior
				,sumaPrimasVigentesAñoAnterior
				)
			SELECT pvt.participante_id
				,pvt.compania AS compania
				,pvt.ramo AS ramo
				,pvt.AñoAMedir AS AñoAMedir
				,pvt.AñoAnterior AS AñoAnterior
				,pvt.Tipopersistencia AS Tipopersistencia
				,pvt.fechaCalculo AS fechaCalculo
				,pvt.mesCorte AS mesCorte
				,pvt.cantidadExpedidosAnioActual
				,pvt.cantidadVigentesAnioActual
				,pvt.sumaExpedidosAnioActual
				,pvt.sumaVigentesAnioActual
				,pvt.cantidadExpedidosAnioAnterior
				,pvt.cantidadVigentesAnioAnterior
				,pvt.sumaExpedidosAnioAnterior
				,pvt.sumaVigentesAnioAnterior
			FROM #PersistenciaVIDAtemp pvt

			DROP TABLE #PersistenciaVIDAtemp

			-- *********************************************************************************************************
			-- CALCULOS DE PERSISTENCIA DE VIDA
			-- *********************************************************************************************************--	
			UPDATE PersistenciadeVIDA
			SET cantidadNegociosAñoActual = 0
			WHERE cantidadNegociosAñoActual IS NULL
				AND añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET cantidadNegociosVigentesAñoActual = 0
			WHERE cantidadNegociosVigentesAñoActual IS NULL
				AND añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET cantidadNegociosAñoAnterior = 0
			WHERE cantidadNegociosAñoAnterior IS NULL
				AND añoAnterior = (@añoenCurso - 1)
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET cantidadNegociosVigentesAñoAnterior = 0
			WHERE cantidadNegociosVigentesAñoAnterior IS NULL
				AND añoAnterior = (@añoenCurso - 1)
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET sumaPrimasAñoActual = 0
			WHERE (
					sumaPrimasAñoActual IS NULL
					OR sumaPrimasAñoActual < 0
					)
				AND añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET sumaPrimasVigentesAñoActual = 0
			WHERE (
					sumaPrimasVigentesAñoActual IS NULL
					OR sumaPrimasVigentesAñoActual < 0
					)
				AND añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET sumaPrimasAñoAnterior = 0
			WHERE (
					sumaPrimasAñoAnterior IS NULL
					OR sumaPrimasAñoAnterior < 0
					)
				AND añoAnterior = (@añoenCurso - 1)
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET sumaPrimasVigentesAñoAnterior = 0
			WHERE (
					sumaPrimasVigentesAñoAnterior IS NULL
					OR sumaPrimasVigentesAñoAnterior < 0
					)
				AND añoAnterior = (@añoenCurso - 1)
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET cumplimientoNegociosAñoActual = (
					CASE 
						WHEN cantidadNegociosAñoActual = 0
							THEN 0
						ELSE ((cantidadNegociosVigentesAñoActual / cantidadNegociosAñoActual) * 100)
						END
					)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET cumplimientoPrimasAñoActual = (
					CASE 
						WHEN sumaPrimasAñoActual = 0
							THEN 0
						ELSE ((sumaPrimasVigentesAñoActual / sumaPrimasAñoActual) * 100)
						END
					)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET ponderacionNegociosAñoActual = (
					CASE 
						WHEN cantidadNegociosAñoActual = 0
							THEN 0
						ELSE (
								CASE 
									WHEN cantidadnegociosAñoAnterior = 0
										AND cantidadNegociosAñoActual > 0
										THEN cumplimientoNegociosAñoActual
									ELSE (
											CASE 
												WHEN cantidadnegociosAñoAnterior > 0
													AND cantidadNegociosAñoActual > 0
													THEN ((cumplimientoNegociosAñoActual / 100) * @factorAñoActual)
												END
											)
									END
								)
						END
					)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET ponderacionPrimasAñoActual = (
					CASE 
						WHEN sumaPrimasAñoActual = 0
							THEN 0
						ELSE (
								CASE 
									WHEN sumaPrimasAñoAnterior = 0
										AND sumaPrimasAñoActual > 0
										THEN cumplimientoPrimasAñoActual
									ELSE (
											CASE 
												WHEN sumaPrimasAñoAnterior > 0
													AND sumaPrimasAñoActual > 0
													THEN ((cumplimientoPrimasAñoActual / 100) * @factorAñoActual)
												END
											)
									END
								)
						END
					)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET cumplimientoNegociosAñoAnterior = (
					CASE 
						WHEN cantidadNegociosAñoAnterior = 0
							THEN 0
						ELSE ((cantidadNegociosVigentesAñoAnterior / cantidadNegociosAñoAnterior) * 100)
						END
					)
			WHERE añoAnterior = (@añoenCurso - 1)
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET cumplimientoPrimasAñoAnterior = (
					CASE 
						WHEN sumaPrimasAñoAnterior = 0
							THEN 0
						ELSE ((sumaPrimasVigentesAñoAnterior / sumaPrimasAñoAnterior) * 100)
						END
					)
			WHERE añoAnterior = (@añoenCurso - 1)
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET ponderacionNegociosAñoAnterior = (
					CASE 
						WHEN cantidadNegociosAñoAnterior = 0
							THEN 0
						ELSE (
								CASE 
									WHEN cantidadNegociosAñoActual = 0
										AND cantidadNegociosAñoAnterior > 0
										THEN cumplimientoNegociosAñoAnterior
									ELSE (
											CASE 
												WHEN cantidadnegociosAñoAnterior > 0
													AND cantidadNegociosAñoActual > 0
													THEN ((cumplimientoNegociosAñoAnterior / 100) * @factorAñoAnterior)
												END
											)
									END
								)
						END
					)
			WHERE añoAnterior = (@añoenCurso - 1)
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET ponderacionPrimasAñoAnterior = (
					CASE 
						WHEN sumaPrimasAñoAnterior = 0
							THEN 0
						ELSE (
								CASE 
									WHEN sumaPrimasAñoActual = 0
										AND sumaPrimasAñoAnterior > 0
										THEN cumplimientoNegociosAñoAnterior
									ELSE (
											CASE 
												WHEN sumaPrimasAñoAnterior > 0
													AND sumaPrimasAñoActual > 0
													THEN ((cumplimientoNegociosAñoAnterior / 100) * @factorAñoAnterior)
												END
											)
									END
								)
						END
					)
			WHERE añoAnterior = (@añoenCurso - 1)
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET ponderadaNegocios = (
					CASE 
						WHEN RTRIM(LTRIM(tipoPersistencia)) = '1' --'Periodo'
							THEN ROUND(ponderacionNegociosAñoActual, 3)
						ELSE (ROUND(ponderacionNegociosAñoActual, 3) + ROUND(ponderacionNegociosAñoAnterior, 3))
						END
					)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET ponderadaPrimas = (
					CASE 
						WHEN RTRIM(LTRIM(tipoPersistencia)) = '1' --'Periodo'
							THEN ROUND(ponderacionPrimasAñoActual, 3)
						ELSE (ROUND(ponderacionPrimasAñoActual, 3) + ROUND(ponderacionPrimasAñoAnterior, 3))
						END
					)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET subtotalNegocios = ROUND(((ponderadaNegocios * @FactorxPolizas) / 100), 3)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET subtotalPrimas = ROUND(((ponderadaPrimas * @FactorxPrimas) / 100), 3)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			UPDATE PersistenciadeVIDA
			SET persistenciaDefinitiva = ROUND((CAST(subtotalPrimas AS FLOAT) + CAST(subtotalNegocios AS FLOAT)), 3)
			WHERE añoAMedir = @añoenCurso
				AND tipoPersistencia = @p_tipoPersistencia

			-- *********************************************************************************************************
			-- DESCUENTO DE COLQUINES
			-- *********************************************************************************************************--	
			-- Cantidad de colquines a descontar (asesores)
			UPDATE t1
			SET t1.colquinesDescontar = t2.colquinesDescontar
			FROM PersistenciadeVIDA t1
			INNER JOIN (
				SELECT (
						CASE 
							WHEN SUM(r.Colquines) > 0
								THEN (SUM(r.Colquines) * (- 1))
							ELSE 0
							END
						) AS colquinesDescontar
					,r.participante_id
					,r.anioCierre
				FROM Recaudo r
				INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
				WHERE r.compania_id = 2
					AND rd.ramo_id = 11
					AND r.anioCierre = @añoenCurso
					AND r.mesCierre <= @mesCorte
				GROUP BY r.participante_id
					,r.anioCierre
				) t2 ON t1.participante_id = t2.participante_id
				AND t1.añoAMedir = t2.anioCierre
			WHERE t1.añoAMedir = @añoenCurso
				AND t1.mesCorte = @mesCorte
				AND t1.persistenciaDefinitiva < @valorPersistenciaVIDA
				AND t1.tipoPersistencia = @p_tipoPersistencia
				AND t1.participante_id IS NOT NULL

			SET @p_tipoPersistencia = @p_tipoPersistencia + 1
		END
	END

	IF (@valorPersistenciaVIDAEje IS NOT NULL)
	BEGIN
		-- *********************************************************************************************************
		-- ACUMULADO POR EJECUTIVOS
		-- *********************************************************************************************************--		
		INSERT INTO PersistenciadeVIDA (
			jerarquiaDetalle_id
			,compania_id
			,ramo_id
			,añoAMedir
			,añoAnterior
			,tipoPersistencia
			,persistenciaDefinitiva
			,fechaMedicionPersistencia
			,mesCorte
			)
		SELECT jd.id AS nodo
			,pv.compania_id
			,pv.ramo_id
			,pv.añoAMedir
			,pv.añoAnterior
			,pv.tipoPersistencia
			,(SUM(pv.persistenciaDefinitiva) / COUNT(pv.participante_id)) AS persistenciaDefinitiva
			,GETDATE() AS fechaCalculo
			,@mesCorte AS mesCorte
		FROM JerarquiaDetalle AS jd
		CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
		INNER JOIN PersistenciadeVIDA AS pv ON hijos.participante_id = pv.participante_id
		WHERE jd.nivel_id NOT IN (
				0
				,1
				)
			AND pv.añoAMedir = @añoenCurso
			AND RTRIM(LTRIM(pv.tipoPersistencia)) = @p_tipoPersistencia
			AND pv.mesCorte = @mesCorte
		GROUP BY jd.id
			,pv.compania_id
			,pv.ramo_id
			,pv.añoAMedir
			,pv.añoAnterior
			,pv.tipoPersistencia

		PRINT 'Cantidad de colquines a descontar (asesores)'

		-- *********************************************************************************************************
		-- DESCUENTO DE COLQUINES
		-- *********************************************************************************************************--	
		-- Cantidad de colquines a descontar (ejecutivos)
		UPDATE t1
		SET t1.colquinesDescontar = t2.colquinesDescontar
		FROM PersistenciadeVIDA t1
		INNER JOIN (
			SELECT (
					CASE 
						WHEN SUM(r.Colquines) > 0
							THEN (SUM(r.Colquines) * (- 1))
						ELSE 0
						END
					) AS colquinesDescontar
				,jd.id AS nodo_id
				,r.anioCierre
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
			INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			WHERE r.compania_id = 2
				AND rd.ramo_id = 11
				AND r.anioCierre = @añoenCurso
				AND r.mesCierre <= @mesCorte
			GROUP BY jd.id
				,r.anioCierre
			) t2 ON t1.jerarquiaDetalle_id = t2.nodo_id
			AND t1.añoAMedir = t2.anioCierre
		WHERE t1.añoAMedir = @añoenCurso
			AND t1.mesCorte = @mesCorte
			AND t1.persistenciaDefinitiva < @valorPersistenciaVIDAEje
			AND t1.tipoPersistencia = @p_tipoPersistencia
			AND t1.jerarquiaDetalle_id IS NOT NULL

		PRINT 'Cantidad de colquines a descontar (ejecutivos)'

		-- *********************************************************************************************************
		-- DESCUENTO DE RECAUDOS
		-- *********************************************************************************************************--	
		-- Recaudos a descontar (Ejecutivos)
		UPDATE t1
		SET t1.recaudosDescontar = t2.recaudosDescontar
		FROM PersistenciadeVIDA t1
		INNER JOIN (
			SELECT (
					CASE 
						WHEN SUM(r.valorRecaudo) > 0
							THEN (SUM(r.valorRecaudo) * (- 1))
						ELSE 0
						END
					) AS recaudosDescontar
				,jd.id AS nodo_id
				,r.anioCierre
			FROM JerarquiaDetalle AS jd
			CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
			INNER JOIN Recaudo AS r ON hijos.participante_id = r.participante_id
			INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			WHERE r.compania_id = 2
				AND rd.ramo_id = 11
				AND r.anioCierre = @añoenCurso
				AND r.mesCierre <= @mesCorte
			GROUP BY jd.id
				,r.anioCierre
			) t2 ON t1.jerarquiaDetalle_id = t2.nodo_id
			AND t1.añoAMedir = t2.anioCierre
		WHERE t1.añoAMedir = @añoenCurso
			AND t1.mesCorte = @mesCorte
			AND t1.persistenciaDefinitiva < @valorPersistenciaVIDAEje
			AND t1.tipoPersistencia = @p_tipoPersistencia
			AND t1.jerarquiaDetalle_id IS NOT NULL

		PRINT 'Recaudos a descontar (Ejecutivos)'
	END

	UPDATE PersistenciadeVIDA
	SET colquinesDescontar = 0
	WHERE (
			persistenciaDefinitiva = 0
			OR colquinesDescontar IS NULL
			)
		AND añoAMedir = @añoenCurso
		AND mesCorte = @mesCorte

	UPDATE PersistenciadeVIDA
	SET recaudosDescontar = 0
	WHERE (
			persistenciaDefinitiva = 0
			OR recaudosDescontar IS NULL
			)
		AND añoAMedir = @añoenCurso
		AND mesCorte = @mesCorte
		AND jerarquiaDetalle_id IS NOT NULL

	DROP TABLE #Negocios

	DROP TABLE #NegociosVigentes

	DROP TABLE #NegociosVigentesxEndoso
END
