-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Calculo de Consolidados x Mes, Cumplimientos y Crecimientos. --
-- =============================================
CREATE PROCEDURE [dbo].[SAI_ConsolidadoMes]
AS
BEGIN
	-- *********************************************************************************************************
	-- INICIO LOG.
	-- *********************************************************************************************************--
	INSERT INTO LogIntegracion (
		fechaInicio
		,proceso
		,estado
		,sistemaOrigen
		,sistemaDestino
		,tablaDestino
		)
	VALUES (
		GETDATE()
		,'Generacion de los Consolidados x Clave'
		,1
		,'SAI'
		,'SAI'
		,'ConsolidadoMes'
		)

	-- *********************************************************************************************************
	-- PARAMETROS GENERALES DEL PROCEDIMIENTO. 
	-- *********************************************************************************************************--	
	-- Borra los datos de la tabla ConsolidadoMes del año Vigente
	DELETE
	FROM ConsolidadoMes
	WHERE año IN (
			(YEAR(GETDATE()) - 1)
			,(YEAR(GETDATE()))
			)

	PRINT 'Borrar Consolidado Mes año en curso'

	DECLARE @maxId AS INT = (SELECT MAX(id) FROM ConsolidadoMes)

	SET @maxId = (
			CASE 
				WHEN @maxId IS NULL
					THEN 0
				ELSE @maxId
				END
			)

	DBCC CHECKIDENT (
			ConsolidadoMes
			,RESEED
			,@maxId
			)

	DECLARE @añoenCurso AS INT = (YEAR(GETDATE()) - 1)

	WHILE (@añoenCurso <= YEAR(GETDATE()))
	BEGIN
		-- *********************************************************************************************************
		-- RECAUDO: Toma los recaudos correspondientes al año Vigente y actualiza el valor del ramo_id, producto_id y plan_id con los valores agrupados
		-- de las tablas ramoDetalle_id (ramo_id), productoDetalle_id (producto_id), plANDetalle_id (plan_id)
		-- *********************************************************************************************************--	
		SELECT r.id
			,r.redDetalle_id
			,r.compania_id
			,r.lineaNegocio_id
			,r.ramoDetalle_id
			,r.amparo_id
			,r.cobertura_id
			,r.modalidadpago_id
			,r.productoDetalle_id
			,r.planDetalle_id
			,r.tipoRecaudo_id
			,r.formaPago_id
			,r.zona_id
			,r.localidad_id
			,r.participante_id
			,RTRIM(LTRIM(r.clave)) AS Clave
			,r.numeroNegocio
			,r.fechaRecaudo
			,r.fechaGrabacion
			,r.fechaCobranza
			,r.valorRecaudo
			,r.numeroRecibo
			,r.periodoFacturado
			,r.Altura
			,r.porcentajeParticipacion
			,r.Concepto
			,r.porcentajeAhorro_Inversion
			,r.bancoDetalle_id
			,r.sistema
			,r.codigoOcupacion
			,r.segmento_id
			,r.Colquines
			,r.estadoCierre
			,r.mesCierre
			,r.anioCierre
			,rd.ramo_id AS ramo_id
			,pd.producto_id AS producto_id
			,pld.plan_id AS plan_id
			,prod.plazo_id
		INTO #RecaudosAgrupados
		FROM Recaudo r
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
		INNER JOIN PlanDetalle pld ON pld.id = r.planDetalle_id
		INNER JOIN Producto prod ON prod.id = pd.producto_id
		WHERE anioCierre = @añoenCurso

		PRINT 'Cargar a #RecaudosAgrupados año en curso'

		-- *********************************************************************************************************
		-- CONSOLIDADOS
		-- *********************************************************************************************************--	
		------------------- CAPI: PRIMAS = RECAUDOS
		-- Se insertan los valores de la tabla temporal #RecaudosAgrupados en ConsolidadoMes (compañía CAPI).
		-- Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. 
		-- TipoMedida 3--> Recaudos = Primas
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			)
		SELECT Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,3 AS tipoMedida_id -- Recaudos
			,Ra.zona_id
			,Ra.localidad_id
			,RTRIM(LTRIM(Ra.clave))
			,Ra.participante_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,@añoenCurso AS año
			,Ra.modalidadpago_id
			,Ra.segmento_id
		FROM #RecaudosAgrupados ra
		WHERE YEAR(Ra.fechaRecaudo) <> 1900
			AND Ra.compania_id = 3
		GROUP BY ra.clave
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Ra.modalidadpago_id
			,Ra.participante_id
			,Ra.segmento_id

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de ENERO del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerovCRecaudos (
			EnerovCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoEnerovCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 1
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cer.EnerovCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovCRecaudos cer ON cer.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de FEBRERO del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovCRecaudos (
			FebrerovCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoFebrerovCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 2
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cfr.FebrerovCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovCRecaudos cfr ON cfr.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovCRecaudos (
			MarzovCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoMarzovCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 3
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmr.MarzovCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovCRecaudos cmr ON cmr.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvCRecaudos (
			AbrilvCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoAbrilvCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = cm.ramo_id
			AND Ra.producto_id = cm.producto_id
			AND Ra.localidad_id = cm.localidad_id
			AND Ra.lineaNegocio_id = cm.lineaNegocio_id
			AND Ra.amparo_id = cm.amparo_id
			AND Ra.modalidadpago_id = cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 4
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = car.AbrilvCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvCRecaudos car ON car.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovCRecaudos (
			MayovCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoMayovCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 5
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmr.MayovCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovCRecaudos cmr ON cmr.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovCRecaudos (
			JuniovCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoJuniovCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 6
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cjr.JuniovCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovCRecaudos cjr ON cjr.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovCRecaudos (
			JuliovCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoJuliovCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 7
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cjr.JuliovCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovCRecaudos cjr ON cjr.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovCRecaudos (
			AgostovCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoAgostovCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 8
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = car.AgostovCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovCRecaudos car ON car.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevCRecaudos (
			SeptiembrevCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoSeptiembrevCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 9
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = csr.SeptiembrevCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevCRecaudos csr ON csr.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevCRecaudos (
			OctubrevCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoOctubrevCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 10
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cor.OctubrevCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevCRecaudos cor ON cor.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevCRecaudos (
			NoviembrevCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoNoviembrevCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 11
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cnr.NoviembrevCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevCRecaudos cnr ON cnr.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevCRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de CAPI de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevCRecaudos (
			DiciembrevCRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevCRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoDiciembrevCRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 12
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Ra.compania_id = 3
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo de CAPI en diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cdr.DiciembrevCRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevCRecaudos cdr ON cdr.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevCRecaudos

		PRINT 'Consolidados x valorRecaudo = valorPrima (Enero - Diciembre) de CAPI'

		-- Se insertan los valores de la tabla temporal #RecaudosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. 
		-- TipoMedida 1--> Recaudos
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			)
		SELECT Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,1 AS tipoMedida_id -- Recaudos
			,Ra.zona_id
			,Ra.localidad_id
			,RTRIM(LTRIM(Ra.clave))
			,Ra.participante_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,@añoenCurso AS año
			,Ra.modalidadpago_id
			,Ra.segmento_id
		FROM #RecaudosAgrupados ra
		WHERE YEAR(Ra.fechaRecaudo) <> 1900
		GROUP BY ra.clave
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Ra.modalidadpago_id
			,Ra.participante_id
			,Ra.segmento_id

		CREATE NONCLUSTERED INDEX [AIX_#RecaudosAgrupados] ON #RecaudosAgrupados (
			compania_id
			,lineaNegocio_id
			,amparo_id
			,localidad_id
			,ramo_id
			,producto_id
			) INCLUDE (
			zona_id
			,clave
			,fechaRecaudo
			,valorRecaudo
			)

		-- Tabla temporal que Consolida los valores de recaudo de ENERO del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerovRecaudos (
			EnerovRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoEnerovRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 1
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cer.EnerovRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovRecaudos cer ON cer.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de FEBRERO del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovRecaudos (
			FebrerovRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoFebrerovRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 2
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cfr.FebrerovRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovRecaudos cfr ON cfr.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovRecaudos (
			MarzovRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoMarzovRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 3
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmr.MarzovRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovRecaudos cmr ON cmr.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvRecaudos (
			AbrilvRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoAbrilvRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = cm.ramo_id
			AND Ra.producto_id = cm.producto_id
			AND Ra.localidad_id = cm.localidad_id
			AND Ra.lineaNegocio_id = cm.lineaNegocio_id
			AND Ra.amparo_id = cm.amparo_id
			AND Ra.modalidadpago_id = cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 4
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = car.AbrilvRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvRecaudos car ON car.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovRecaudos (
			MayovRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoMayovRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 5
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmr.MayovRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovRecaudos cmr ON cmr.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovRecaudos (
			JuniovRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoJuniovRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 6
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cjr.JuniovRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovRecaudos cjr ON cjr.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovRecaudos (
			JuliovRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoJuliovRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 7
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cjr.JuliovRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovRecaudos cjr ON cjr.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovRecaudos (
			AgostovRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoAgostovRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 8
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = car.AgostovRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovRecaudos car ON car.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevRecaudos (
			SeptiembrevRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoSeptiembrevRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 9
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = csr.SeptiembrevRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevRecaudos csr ON csr.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevRecaudos (
			OctubrevRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoOctubrevRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 10
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cor.OctubrevRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevRecaudos cor ON cor.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevRecaudos (
			NoviembrevRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoNoviembrevRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 11
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cnr.NoviembrevRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevRecaudos cnr ON cnr.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevRecaudos

		-- Tabla temporal que Consolida los valores de recaudo de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevRecaudos (
			DiciembrevRecaudos FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevRecaudos
		SELECT ROUND(CAST(SUM(valorRecaudo) AS FLOAT), 3) AS ConsolidadoDiciembrevRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 12
			AND Cm.tipoMedida_id = 1
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.plazo_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.zona_id

		-- Actualiza el valor consolidado del recaudo en diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cdr.DiciembrevRecaudos
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevRecaudos cdr ON cdr.CmID = cm.id
		WHERE cm.tipoMedida_id = 1
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevRecaudos

		PRINT 'Consolidados x valorRecaudo (Enero - Diciembre)'		

		-------------------------------------  COLQUINES SIN EXCEPCIONES
		-- Se insertan los valores de la tabla temporal #RecaudosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. 
		--  TipoMedida 21 --> Colquines sin Excepciones
		CREATE NONCLUSTERED INDEX [IX_ConsolidadoMesxAño] ON [dbo].[ConsolidadoMes] (
			tipoMedida_id
			,año
			) INCLUDE (
			id
			,compania_id
			,ramo_id
			,producto_id
			,localidad_id
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,segmento_id
			)

		CREATE NONCLUSTERED INDEX [IX_#RecaudosAgrupadosxMesCierre] ON [dbo].[#RecaudosAgrupados] ([mesCierre]) INCLUDE (
			[compania_id]
			,[lineaNegocio_id]
			,[amparo_id]
			,[modalidadpago_id]
			,[localidad_id]
			,[participante_id]
			,[segmento_id]
			,[Colquines]
			,[ramo_id]
			,[producto_id]
			)

		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,21 AS tipoMedida_id
			,Ra.zona_id
			,Ra.localidad_id
			,RTRIM(LTRIM(Ra.clave))
			,Ra.participante_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,@añoenCurso AS año
			,Ra.modalidadpago_id
			,Ra.segmento_id
			,Ra.plazo_id
		FROM #RecaudosAgrupados Ra
		WHERE YEAR(Ra.fechaRecaudo) <> 1900
		GROUP BY Ra.clave
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Ra.modalidadpago_id
			,Ra.participante_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Tabla temporal que Consolida los valores de colquines de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerovColquines (
			EnerovColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoEnerovColquines
			,Cm.id AS CmID
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 1
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovColquines

		-- Tabla temporal que Consolida los valores de colquines de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovColquines (
			FebrerovColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoFebrerovColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 2
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovColquines

		-- Tabla temporal que Consolida los valores de colquines de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovColquines (
			MarzovColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoMarzovColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 3
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovColquines

		-- Tabla temporal que Consolida los valores de colquines de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvColquines (
			AbrilvColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoAbrilvColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 4
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvColquines

		-- Tabla temporal que Consolida los valores de colquines de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovColquines (
			MayovColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoMayovColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 5
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovColquines

		-- Tabla temporal que Consolida los valores de colquines de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovColquines (
			JuniovColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoJuniovRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 6
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovColquines

		-- Tabla temporal que Consolida los valores de colquines de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovColquines (
			JuliovColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoJuliovColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 7
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovColquines

		-- Tabla temporal que Consolida los valores de colquines de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovColquines (
			AgostovColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoAgostovColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 8
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovColquines

		-- Tabla temporal que Consolida los valores de colquines de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevColquines (
			SeptiembrevColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoSeptiembrevColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 9
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevColquines

		-- Tabla temporal que Consolida los valores de colquines de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevColquines (
			OctubrevColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoOctubrevColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 10
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevColquines

		-- Tabla temporal que Consolida los valores de colquines de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevColquines (
			NoviembrevColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoNoviembrevRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 11
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevColquines

		-- Tabla temporal que Consolida los valores de colquines de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevColquines (
			DiciembrevColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoDiciembrevColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 12
			AND Cm.tipoMedida_id = 21
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id
			,Ra.zona_id

		-- Actualiza el valor consolidado de colquines en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 21
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevColquines

		PRINT 'Consolidados x Colquines sin Excepciones (Enero - Diciembre)'		
		
		------------------------------ NEGOCIOS
		-- Toma los negocios correspondientes al año Vigente y actualiza el valor del ramo_id, producto_id y plan_id con los valores agrupados
		-- de las tablas ramoDetalle_id (ramo_id), productoDetalle_id (producto_id), planDetalle_id (plan_id)			
		SELECT n.id
			,n.productoDetalle_id
			,n.localidad_id
			,n.cliente_id
			,n.numeroNegocio
			,n.fechaExpedicion
			,n.segmento_id
			,n.tipoEndoso_id
			,n.grupoEndoso_id
			,n.valorAsegurado
			,n.lineaNegocio_id
			,n.compania_id
			,n.RamoDetalle_id
			,n.amparo_id
			,n.cobertura_id
			,n.modalidadPago_id
			,n.planDetalle_id
			,n.zona_id
			,n.participante_id
			,RTRIM(LTRIM(n.clave)) AS clave
			,n.fechaGrabacion
			,n.fechaRecaudoInicial
			,n.numeroSolicitud
			,n.cuotasPagadas
			,n.cuotasVencidas
			,n.identificacionSuscriptor
			,n.nombreSuscriptor
			,n.generoSuscriptor
			,n.marcaVehiculo_id
			,n.tipoVehiculo_id
			,n.modeloVehiculo
			,n.sistema
			,n.porcentajeParticipacion
			,n.actividadEconomica_id
			,n.formaPago_id
			,n.valorProteccion
			,n.valorAhorro
			,n.valorPrimaPensiones
			,n.valorPrimaTotal
			,n.estadoNegocio
			,n.codigoAgrupador
			,n.fechaEmisionMaximoEndoso
			,n.fechaCancelacion
			,n.Usuarios
			,n.estadoCierre
			,n.mesCierre
			,n.anioCierre
			,rd.ramo_id
			,pd.producto_id
			,pld.plan_id
			,prod.plazo_id
		INTO #NegociosAgrupados
		FROM Negocio n
		INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
		INNER JOIN ProductoDetalle pd ON pd.id = n.productoDetalle_id
		INNER JOIN PlanDetalle pld ON pld.id = n.planDetalle_id
		INNER JOIN Producto prod ON prod.id = pd.producto_id
		WHERE n.anioCierre = @añoenCurso
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
					AND n1.id = n.id
				)

		PRINT 'Tabla #NegociosAgrupados del año en curso'		

		CREATE NONCLUSTERED INDEX [AIX_#NegociosAgrupados] ON #NegociosAgrupados (
			compania_id
			,lineaNegocio_id
			,amparo_id
			,localidad_id
			,Ramo_id
			,producto_id
			) INCLUDE (
			zona_id
			,clave
			,fechaExpedicion
			,valorPrimaTotal
			)

		CREATE NONCLUSTERED INDEX [#NegociosAgrupadosxSumaPrima] ON #NegociosAgrupados (mesCierre) INCLUDE (
			localidad_id
			,segmento_id
			,lineaNegocio_id
			,compania_id
			,amparo_id
			,modalidadPago_id
			,zona_id
			,clave
			,valorPrimaTotal
			,ramo_id
			,producto_id
			)

		CREATE NONCLUSTERED INDEX [#NegociosAgrupados] ON #NegociosAgrupados (
			lineaNegocio_id
			,estadoNegocio
			,mesCierre
			) INCLUDE (
			localidad_id
			,cliente_id
			,numeroNegocio
			,segmento_id
			,grupoEndoso_id
			,compania_id
			,zona_id
			,participante_id
			,clave
			,ramo_id
			,producto_id
			)

		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 3 --> Primas	
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,3 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,@añoenCurso AS año
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Na.modalidadPago_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida los valores de primas de Enero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoEnerovNegocios (
			EnerovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoEnerovNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS EnerovNegocios
			,Cm.id AS CmID
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 1
			AND Cm.tipoMedida_id = 3
			AND Cm.año = @añoenCurso
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovNegocios

		-- Tabla temporal que Consolida los valores de primas de Febrero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoFebrerovNegocios (
			FebrerovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoFebrerovNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoFebrerovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 2
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovNegocios

		-- Tabla temporal que Consolida los valores de primas de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovNegocios (
			MarzovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMarzovNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoMarzovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 3
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovNegocios

		-- Tabla temporal que Consolida los valores de primas de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvNegocios (
			AbrilvNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoAbrilvNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoAbrilvNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 4
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvNegocios

		-- Tabla temporal que Consolida los valores de primas de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovNegocios (
			MayovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMayovNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoMayovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 5
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovNegocios

		-- Tabla temporal que Consolida los valores de primas de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovNegocios (
			JuniovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuniovNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoJuniovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 6
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovNegocios

		-- Tabla temporal que Consolida los valores de primas de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovNegocios (
			JuliovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuliovNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoJuliovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 7
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovNegocios

		-- Tabla temporal que Consolida los valores de primas de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovNegocios (
			AgostovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoAgostovNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoAgostovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 8
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovNegocios

		-- Tabla temporal que Consolida los valores de primas de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevNegocios (
			SeptiembrevNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoSeptiembrevNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoSeptiembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 9
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevNegocios

		-- Tabla temporal que Consolida los valores de primas de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevNegocios (
			OctubrevNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoOctubrevNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoOctubrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 10
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevNegocios

		-- Tabla temporal que Consolida los valores de primas de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevNegocios (
			NoviembrevNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoNoviembrevNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoNoviembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 11
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevNegocios

		-- Tabla temporal que Consolida los valores de primas de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevNegocios (
			DiciembrevNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoDiciembrevNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoDiciembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 12
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 3
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 3
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevNegocios

		PRINT 'Consolidado x Valor de primas (Enero - Diciembre): VIDA, GENERALES, ARP, SALUD'
		
		-------------------------------------  NUMERO DE NEGOCIO ----------------------
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 4 --> Negocios		
		CREATE NONCLUSTERED INDEX [IX_#NegociosxCantidadNegocios] ON [dbo].[#NegociosAgrupados] ([lineaNegocio_id]) INCLUDE (
			[localidad_id]
			,[fechaExpedicion]
			,[segmento_id]
			,[compania_id]
			,[amparo_id]
			,[modalidadPago_id]
			,[zona_id]
			,[participante_id]
			,[clave]
			,[ramo_id]
			,[producto_id]
			,[plazo_id]
			)

		CREATE NONCLUSTERED INDEX [IX_#NegociosxCantidadNegocios_Actualizacion] ON [dbo].[#NegociosAgrupados] (
			[lineaNegocio_id]
			,[mesCierre]
			) INCLUDE (
			[localidad_id]
			,[numeroNegocio]
			,[segmento_id]
			,[compania_id]
			,[amparo_id]
			,[modalidadPago_id]
			,[participante_id]
			,[ramo_id]
			,[producto_id]
			,[plazo_id]
			)

		CREATE NONCLUSTERED INDEX [IX_NegociosAgrupadosxZona] ON [dbo].[#NegociosAgrupados] (
			[lineaNegocio_id]
			,[mesCierre]
			) INCLUDE (
			[localidad_id]
			,[numeroNegocio]
			,[segmento_id]
			,[compania_id]
			,[amparo_id]
			,[modalidadPago_id]
			,[zona_id]
			,[participante_id]
			,[ramo_id]
			,[producto_id]
			,[plazo_id]
			)

		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,4 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,@añoenCurso AS año
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Na.modalidadPago_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida la cantidad de negocios de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerovnNegocio (
			EnerovnNegocio FLOAT NULL
			,CmID INT NULL			
			)

		INSERT INTO #ConsolidadoEnerovnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoEnerovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 1
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovnNegocio (
			FebrerovnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoFebrerovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 2
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovnNegocio (
			MarzovnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoMarzovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 3
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvnNegocio (
			AbrilvnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoAbrilvnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 4
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovnNegocio (
			MayovnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoMayovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 5
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovnNegocio (
			JuniovnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoJuniovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 6
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovnNegocio (
			JuliovnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoJuliovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 7
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovnNegocio (
			AgostovnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoAgostovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 8
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevnNegocio (
			SeptiembrevnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoSeptiembrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 9
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevnNegocio (
			OctubrevnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoOctubrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 10
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevnNegocio (
			NoviembrevnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoNoviembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 11
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevnNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevnNegocio (
			DiciembrevnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevnNegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoDiciembrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 12
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 4
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevnNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 4
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevnNegocio

		PRINT 'Consolidado x Cantidad de Negocios (Enero - Diciembre)'	
		
		-------------------------------------  CANTIDAD DE DIFERENTES SUSCRIPTORES X NEGOCIO 
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 19 --> Cantidad de diferentes
		-- suscriptores x negocio.	
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,0 AS producto_id
			,19 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave))
			,Na.participante_id
			,Na.lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadPago_id
			,Na.segmento_id
			,0 AS plazo_id
		FROM #NegociosAgrupados Na
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND (
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					) -- VIDA y GENERALES			NUEVOS NEGOCIOS
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.estadoNegocio = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.ramo_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id

		-- Tabla temporal que Consolida la cantidad de diferentes suscriptores por negocio de Enero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoEnerovncNegocio (
			EnerovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovncNegocio
		SELECT COUNT(cantidad) AS Enero
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.ramo_id = Cm.ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 1
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovncNegocio (
			FebrerovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovncNegocio
		SELECT COUNT(cantidad) AS Febrero
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 2
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovncNegocio (
			MarzovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovncNegocio
		SELECT COUNT(cantidad) AS Marzo
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 3
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvncNegocio (
			AbrilvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvncNegocio
		SELECT COUNT(cantidad) AS Abril
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 4
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovncNegocio (
			MayovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovncNegocio
		SELECT COUNT(cantidad) AS Mayo
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 5
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovncNegocio (
			JuniovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovncNegocio
		SELECT COUNT(cantidad) AS Junio
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 6
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovncNegocio (
			JuliovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovncNegocio
		SELECT COUNT(cantidad) AS Julio
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 7
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovncNegocio (
			AgostovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovncNegocio
		SELECT COUNT(cantidad) AS Agosto
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 8
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevncNegocio (
			SeptiembrevncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevncNegocio
		SELECT COUNT(cantidad) AS Septiembre
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 9
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevncNegocio (
			OctubrevncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevncNegocio
		SELECT COUNT(cantidad) AS Octubre
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 10
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevncNegocio (
			NoviembrevncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevncNegocio
		SELECT COUNT(cantidad) AS Noviembre
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 11
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevncNegocio (
			DiciembrevncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevncNegocio
		SELECT COUNT(cantidad) AS Diciembre
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 12
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevncNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Ene_Mar del año vigente. (x Trimestre)
		CREATE TABLE #ConsolidadoEne_MarvncNegocio (
			Ene_MarvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEne_MarvncNegocio
		SELECT COUNT(cantidad) AS Ene_Mar
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						1
						,2
						,3
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Ene_Mar = cmm.Ene_MarvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEne_MarvncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEne_MarvncNegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Enero - Marzo)'

		-- Tabla temporal que Consolida la cantidad de negocios de Abr_Jun del año vigente. (x Trimestre)
		CREATE TABLE #ConsolidadoAbr_JunvncNegocio (
			Abr_JunvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbr_JunvncNegocio
		SELECT COUNT(cantidad) AS Abr_Jun
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						4
						,5
						,6
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Abr_Jun = cmm.Abr_JunvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbr_JunvncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbr_JunvncNegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Abril - Junio)'

		-- Tabla temporal que Consolida la cantidad de negocios de Jul_Sep del año vigente. (x Trimestre)
		CREATE TABLE #ConsolidadoJul_SepvncNegocio (
			Jul_SepvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJul_SepvncNegocio
		SELECT COUNT(cantidad) AS Jul_Sep
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						7
						,8
						,9
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Jul_Sep = cmm.Jul_SepvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJul_SepvncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJul_SepvncNegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Julio - Septiembre)'

		-- Tabla temporal que Consolida la cantidad de negocios de Oct_Dic del año vigente. (x Trimestre)
		CREATE TABLE #ConsolidadoOct_DicvncNegocio (
			Oct_DicvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOct_DicvncNegocio
		SELECT COUNT(cantidad) AS Oct_Dic
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						10
						,11
						,12
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Oct_Dic = cmm.Oct_DicvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOct_DicvncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOct_DicvncNegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Octubre - Diciembre)'

		-- Tabla temporal que Consolida la cantidad de negocios de Ene_Jun del año vigente. (x Semestre)
		CREATE TABLE #ConsolidadoEne_JunvncNegocio (
			Ene_JunvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEne_JunvncNegocio
		SELECT COUNT(cantidad) AS Ene_Jun
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						1
						,2
						,3
						,4
						,5
						,6
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Ene_Jun = cmm.Ene_JunvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEne_JunvncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEne_JunvncNegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Enero - Junio)'

		-- Tabla temporal que Consolida la cantidad de negocios de Jul_Dic del año vigente. (x Semestre)
		CREATE TABLE #ConsolidadoJul_DicvncNegocio (
			Jul_DicvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJul_DicvncNegocio
		SELECT COUNT(cantidad) AS Jul_Dic
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						7
						,8
						,9
						,10
						,11
						,12
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Jul_Dic = cmm.Jul_DicvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJul_DicvncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJul_DicvncNegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Julio - Diciembre)'

		-- Tabla temporal que Consolida la cantidad de negocios de Ene_Dic del año vigente. (x Año)
		CREATE TABLE #ConsolidadoEne_DicvncNegocio (
			Ene_DicvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEne_DicvncNegocio
		SELECT COUNT(cantidad) AS Ene_Dic
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,19 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						1
						,2
						,3
						,4
						,5
						,6
						,7
						,8
						,9
						,10
						,11
						,12
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 19
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Ene_Dic = cmm.Ene_DicvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEne_DicvncNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 19
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEne_DicvncNegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Enero - Diciembre)'

		-------------------------------------  CANTIDAD DE DIFERENTES ASESORES VENDIENDO
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 19 --> Cantidad de diferentes
		-- suscriptores x negocio.			
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,17 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND (
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					) -- VIDA y GENERALES			NUEVOS NEGOCIOS
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida la cantidad de diferentes suscriptores por negocio de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerovacNegocio (
			EnerovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 1
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovacNegocio (
			FebrerovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 2
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovacNegocio (
			MarzovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 3
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvacNegocio (
			AbrilvacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 4
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovacNegocio (
			MayovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 5
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovacNegocio (
			JuniovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 6
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovacNegocio (
			JuliovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 7
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovacNegocio (
			AgostovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 8
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevacNegocio (
			SeptiembrevacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 9
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevacNegocio (
			OctubrevacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 10
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevacNegocio (
			NoviembrevacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 11
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevacNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevacNegocio (
			DiciembrevacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevacNegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 12
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 17
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevacNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 17
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevacNegocio

		PRINT 'Consolidado x Cantidad de diferentes asesores vendiendo nuevos negocios (Enero - Diciembre)'

		-------------------------------------  NUMERO DE NEGOCIO x USUARIOS
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 10 --> Usuarios
		CREATE NONCLUSTERED INDEX [IX_#NegociosAgrupadosxmesCierre] ON [dbo].[#NegociosAgrupados] (
			[lineaNegocio_id]
			,[estadoNegocio]
			,[mesCierre]
			) INCLUDE (
			[localidad_id]
			,[segmento_id]
			,[grupoEndoso_id]
			,[compania_id]
			,[amparo_id]
			,[modalidadPago_id]
			,[participante_id]
			,[ramo_id]
			,[producto_id]
			)

		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,10 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,@añoenCurso AS año
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND (
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					) -- VIDA y GENERALES			NUEVOS NEGOCIOS
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Na.modalidadPago_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida la cantidad de usuarios de Enero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoEnerovxuNegocio (
			EnerovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoEnerovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 1
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovxuNegocio

		-- Tabla temporal que Consolida la cantidad de usuarios de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovxuNegocio (
			FebrerovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoFebrerovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 2
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovxuNegocio

		-- Tabla temporal que Consolida la cantidad de usuarios de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovxuNegocio (
			MarzovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoMarzovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 3
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovxuNegocio

		-- Tabla temporal que Consolida la cantidad de usuarios de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvxuNegocio (
			AbrilvxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoAbrilvnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 4
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvxuNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovxuNegocio (
			MayovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoMayovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 5
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovxuNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovxuNegocio (
			JuniovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoJuniovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 6
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovxuNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovxuNegocio (
			JuliovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoJuliovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 7
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovxuNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovxuNegocio (
			AgostovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoAgostovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 8
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovxuNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevxuNegocio (
			SeptiembrevxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoSeptiembrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 9
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevxuNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevxuNegocio (
			OctubrevxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoOctubrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 10
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevxuNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevxuNegocio (
			NoviembrevxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoNoviembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 11
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevxuNegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevxuNegocio (
			DiciembrevxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevxuNegocio
		SELECT SUM(Usuarios) AS ConsolidadoDiciembrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 12
				AND Cm.tipoMedida_id = 10
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevxuNegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 10
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevxuNegocio

		PRINT 'Consolidado x Cantidad de usuarios x Negocio (Enero - Diciembre)'

		-- TipoMedida 20: Suma de Primas por Nuevos Negocios.
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 3 --> Primas		
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,20 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,@añoenCurso AS año
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND (
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					) -- VIDA y GENERALES			NUEVOS NEGOCIOS
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Na.modalidadPago_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida los valores de primas de Enero del año vigente. (x Mes)		
		CREATE TABLE #ConsolidadoEnerovpnNegocios (
			EnerovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoEnerovpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS EnerovpnNegocios
			,Cm.id AS CmID
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 1
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Febrero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoFebrerovpnNegocios (
			FebrerovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoFebrerovpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoFebrerovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 2
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovpnNegocios (
			MarzovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMarzovpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoMarzovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 3
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvpnNegocios (
			AbrilvpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoAbrilvpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoAbrilvpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 4
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovpnNegocios (
			MayovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMayovpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoMayovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 5
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovpnNegocios (
			JuniovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuniovpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoJuniovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 6
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovpnNegocios (
			JuliovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuliovpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoJuliovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 7
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovpnNegocios (
			AgostovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoAgostovpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoAgostovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 8
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevpnNegocios (
			SeptiembrevpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoSeptiembrevpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoSeptiembrevpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 9
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevpnNegocios (
			OctubrevpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoOctubrevpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoOctubrevpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 10
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevpnNegocios (
			NoviembrevpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoNoviembrevpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoNoviembrevpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 11
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevpnNegocios

		-- Tabla temporal que Consolida los valores de primas de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevpnNegocios (
			DiciembrevpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoDiciembrevpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoDiciembrevpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 12
				AND Cm.tipoMedida_id = 20
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevpnNegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 20
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevpnNegocios

		PRINT 'Consolidado x Valor de primas de Nuevos Negocios (Enero - Diciembre)'			
		
		----****** NEGOCIOS CON EXCEPCIONES *********--
		
		---- *****  DELETE COMBINACIONES COMPAÑIA, RAMO, CLAVE Y NÚMERONEGOCIO
		DELETE Na		
		FROM #NegociosAgrupados AS Na
		INNER JOIN ExcepcionesGenerales eg ON eg.compania_id = Na.compania_id
			AND eg.ramo_id = Na.ramo_id
			AND RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(Na.clave))	
			AND eg.numeroNegocio = CAST(Na.numeroNegocio AS BIGINT)
		WHERE CAST(Na.fechaExpedicion AS DATE) BETWEEN eg.fechaInicio
				AND eg.fechaFin			
			AND eg.numeroNegocio <> 0
			AND eg.compania_id <> 0
			AND eg.ramo_id <> 0
			AND eg.tipoMedida_id = 27
			
		-- ****************** FIN COMBINACIONES COMPAÑIA, RAMO, CLAVE Y NÚMERONEGOCIO ********
			
		---- *****  DELETE COMBINACIONES COMPAÑIA, RAMO, CLAVE
		DELETE Na		
		FROM #NegociosAgrupados AS Na
		INNER JOIN ExcepcionesGenerales eg ON eg.compania_id = Na.compania_id
			AND eg.ramo_id = Na.ramo_id
			AND RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(Na.clave))		
		WHERE CAST(Na.fechaExpedicion AS DATE) BETWEEN eg.fechaInicio
				AND eg.fechaFin			
			AND eg.numeroNegocio = 0
			AND eg.compania_id <> 0
			AND eg.ramo_id <> 0
			AND eg.tipoMedida_id = 27
			
		-- ****************** FIN COMBINACIONES COMPAÑIA, RAMO, CLAVE ********
			
		---- *****  DELETE COMBINACIONES CLAVE *********************		
		DELETE Na		
		FROM #NegociosAgrupados AS Na
		INNER JOIN ExcepcionesGenerales eg ON RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(Na.clave))		
		WHERE CAST(Na.fechaExpedicion AS DATE) BETWEEN eg.fechaInicio
				AND eg.fechaFin			
			AND eg.numeroNegocio = 0
			AND eg.compania_id = 0
			AND eg.ramo_id = 0
			AND eg.tipoMedida_id = 27
		
		---- ****************** FIN COMBINACIONES CLAVE ********			
		---- ***************************************** FIN DEL DELETE ***********************************
		
		---- **** CANTIDAD NEGOCIOS CON EXCEPCIONES ****		
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,28 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,@añoenCurso AS año
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Na.modalidadPago_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida la cantidad de negocios de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerovnCENegocio (
			EnerovnNegocio FLOAT NULL
			,CmID INT NULL		
			)

		INSERT INTO #ConsolidadoEnerovnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoEnerovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 1
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovnCENegocio (
			FebrerovnNegocio FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoFebrerovnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoFebrerovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 2
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovnCENegocio (
			MarzovnNegocio FLOAT NULL
			,CmID INT NULL			
			)

		INSERT INTO #ConsolidadoMarzovnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoMarzovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 3
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvnCENegocio (
			AbrilvnNegocio FLOAT NULL
			,CmID INT NULL
						)

		INSERT INTO #ConsolidadoAbrilvnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoAbrilvnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 4
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovnCENegocio (
			MayovnNegocio FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMayovnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoMayovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 5
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovnCENegocio (
			JuniovnNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoJuniovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 6
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovnCENegocio (
			JuliovnNegocio FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuliovnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoJuliovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 7
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovnCENegocio (
			AgostovnNegocio FLOAT NULL
			,CmID INT NULL
						)

		INSERT INTO #ConsolidadoAgostovnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoAgostovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 8
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevnCENegocio (
			SeptiembrevnNegocio FLOAT NULL
			,CmID INT NULL
			
			)

		INSERT INTO #ConsolidadoSeptiembrevnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoSeptiembrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 9
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevnCENegocio (
			OctubrevnNegocio FLOAT NULL
			,CmID INT NULL
		
			)

		INSERT INTO #ConsolidadoOctubrevnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoOctubrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 10
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevnCENegocio (
			NoviembrevnNegocio FLOAT NULL
			,CmID INT NULL
			
			)

		INSERT INTO #ConsolidadoNoviembrevnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoNoviembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 11
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevnCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevnCENegocio (
			DiciembrevnNegocio FLOAT NULL
			,CmID INT NULL
			
			)

		INSERT INTO #ConsolidadoDiciembrevnCENegocio
		SELECT COUNT(Na.numeroNegocio) AS ConsolidadoDiciembrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 12
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 28
			AND Na.lineaNegocio_id = 1
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevnNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevnCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 28
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevnCENegocio

		PRINT 'Consolidado x Cantidad de Negocios CON EXCEPCIONES (Enero - Diciembre)'
		
		---- ************************************** FIN NEGOCIOS CON EXCEPCIONES *******************************************				
		---- PRIMAS CON EXCEPCION
		
		CREATE NONCLUSTERED INDEX [IX_NegociosAgrupadosxExcepcion]
		ON [dbo].[#NegociosAgrupados] ([mesCierre],[compania_id])
		INCLUDE ([localidad_id],[segmento_id],[lineaNegocio_id],[amparo_id],[modalidadPago_id],[zona_id],[participante_id],[valorPrimaTotal],[ramo_id],[producto_id],[plazo_id])
		
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,27 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,@añoenCurso AS año
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Na.modalidadPago_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida los valores de primas de Enero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoEneroPCENegocios (
			EnerovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoEneroPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS EnerovNegocios
			,Cm.id AS CmID
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 1
			AND Cm.tipoMedida_id = 27
			AND Cm.año = @añoenCurso
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEneroPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEneroPCENegocios
		
		
		CREATE TABLE #ConsolidadoFebreroPCENegocios (
			FebrerovNegocios FLOAT NULL
			,CmID INT NULL
			)

		
		INSERT INTO #ConsolidadoFebreroPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoFebrerovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 2
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Febrero por clave (x Mes)			
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebreroPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebreroPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovPCENegocios (
			MarzovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMarzovPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoMarzovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 3
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvPCENegocios (
			AbrilvNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoAbrilvPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoAbrilvNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 4
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovPCENegocios (
			MayovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMayovPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoMayovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 5
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovPCENegocios (
			JuniovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuniovPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoJuniovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 6
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovPCENegocios (
			JuliovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuliovPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoJuliovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 7
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovPCENegocios (
			AgostovNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoAgostovPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoAgostovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 8
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevPCENegocios (
			SeptiembrevNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoSeptiembrevPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoSeptiembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 9
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevPCENegocios (
			OctubrevNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoOctubrevPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoOctubrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 10
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevPCENegocios (
			NoviembrevNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoNoviembrevPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoNoviembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 11
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Cm.id
			,Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id			
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevPCENegocios

		-- Tabla temporal que Consolida los valores de primas de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevPCENegocios (
			DiciembrevNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoDiciembrevPCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoDiciembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
			AND Na.zona_id = cm.zona_id
		WHERE Na.mesCierre = 12
			AND Cm.año = @añoenCurso
			AND Cm.tipoMedida_id = 27
			AND Na.compania_id IN (
				1
				,2
				,4
				,5
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
			,Na.zona_id

		-- Actualiza el valor consolidado de primas en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevPCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 27
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevPCENegocios

		PRINT 'Consolidado x Valor de primas CON EXCEPCION (Enero - Diciembre): VIDA, GENERALES, ARP, SALUD'
		
		-----******************************************************** FIN PRIMAS CON EXCEPCIONES *********************************************
		
		-------------------------------------  CANTIDAD DE DIFERENTES SUSCRIPTORES X NEGOCIO (CON EXCEPCIONES) 
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 31 --> Cantidad de diferentes
		-- suscriptores x negocio (Con excepciones).	
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,0 AS producto_id
			,31 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave))
			,Na.participante_id
			,Na.lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadPago_id
			,Na.segmento_id
			,0 AS plazo_id
		FROM #NegociosAgrupados Na
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND (
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					) -- VIDA y GENERALES			NUEVOS NEGOCIOS
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.estadoNegocio = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.ramo_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id

		-- Tabla temporal que Consolida la cantidad de diferentes suscriptores por negocio de Enero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoEnerovncCENegocio (
			EnerovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovncCENegocio
		SELECT COUNT(cantidad) AS Enero
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.ramo_id = Cm.ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 1
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovncCENegocio (
			FebrerovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovncCENegocio
		SELECT COUNT(cantidad) AS Febrero
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 2
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovncCENegocio (
			MarzovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovncCENegocio
		SELECT COUNT(cantidad) AS Marzo
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 3
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvncCENegocio (
			AbrilvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvncCENegocio
		SELECT COUNT(cantidad) AS Abril
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 4
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovncCENegocio (
			MayovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovncCENegocio
		SELECT COUNT(cantidad) AS Mayo
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 5
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovncCENegocio (
			JuniovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovncCENegocio
		SELECT COUNT(cantidad) AS Junio
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 6
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovncCENegocio (
			JuliovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovncCENegocio
		SELECT COUNT(cantidad) AS Julio
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 7
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovncCENegocio (
			AgostovncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovncCENegocio
		SELECT COUNT(cantidad) AS Agosto
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 8
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevncCENegocio (
			SeptiembrevncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevncCENegocio
		SELECT COUNT(cantidad) AS Septiembre
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 9
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevncCENegocio (
			OctubrevncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevncCENegocio
		SELECT COUNT(cantidad) AS Octubre
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 10
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevncCENegocio (
			NoviembrevncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevncCENegocio
		SELECT COUNT(cantidad) AS Noviembre
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 11
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevncCENegocio (
			DiciembrevncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevncCENegocio
		SELECT COUNT(cantidad) AS Diciembre
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre = 12
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevncCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Ene_Mar del año vigente. (x Trimestre)
		CREATE TABLE #ConsolidadoEne_MarvncCENegocio (
			Ene_MarvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEne_MarvncCENegocio
		SELECT COUNT(cantidad) AS Ene_Mar
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						1
						,2
						,3
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Ene_Mar = cmm.Ene_MarvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEne_MarvncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEne_MarvncCENegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Enero - Marzo)'

		-- Tabla temporal que Consolida la cantidad de negocios de Abr_Jun del año vigente. (x Trimestre)
		CREATE TABLE #ConsolidadoAbr_JunvncCENegocio (
			Abr_JunvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbr_JunvncCENegocio
		SELECT COUNT(cantidad) AS Abr_Jun
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						4
						,5
						,6
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Abr_Jun = cmm.Abr_JunvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbr_JunvncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbr_JunvncCENegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Abril - Junio)'

		-- Tabla temporal que Consolida la cantidad de negocios de Jul_Sep del año vigente. (x Trimestre)
		CREATE TABLE #ConsolidadoJul_SepvncCENegocio (
			Jul_SepvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJul_SepvncCENegocio
		SELECT COUNT(cantidad) AS Jul_Sep
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						7
						,8
						,9
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Jul_Sep = cmm.Jul_SepvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJul_SepvncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJul_SepvncCENegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Julio - Septiembre)'

		-- Tabla temporal que Consolida la cantidad de negocios de Oct_Dic del año vigente. (x Trimestre)
		CREATE TABLE #ConsolidadoOct_DicvncCENegocio (
			Oct_DicvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOct_DicvncCENegocio
		SELECT COUNT(cantidad) AS Oct_Dic
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						10
						,11
						,12
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Oct_Dic = cmm.Oct_DicvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOct_DicvncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOct_DicvncCENegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Octubre - Diciembre)'

		-- Tabla temporal que Consolida la cantidad de negocios de Ene_Jun del año vigente. (x Semestre)
		CREATE TABLE #ConsolidadoEne_JunvncCENegocio (
			Ene_JunvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEne_JunvncCENegocio
		SELECT COUNT(cantidad) AS Ene_Jun
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						1
						,2
						,3
						,4
						,5
						,6
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Ene_Jun = cmm.Ene_JunvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEne_JunvncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEne_JunvncCENegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Enero - Junio)'

		-- Tabla temporal que Consolida la cantidad de negocios de Jul_Dic del año vigente. (x Semestre)
		CREATE TABLE #ConsolidadoJul_DicvncCENegocio (
			Jul_DicvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJul_DicvncCENegocio
		SELECT COUNT(cantidad) AS Jul_Dic
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						7
						,8
						,9
						,10
						,11
						,12
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Jul_Dic = cmm.Jul_DicvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJul_DicvncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJul_DicvncCENegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Julio - Diciembre)'

		-- Tabla temporal que Consolida la cantidad de negocios de Ene_Dic del año vigente. (x Año)
		CREATE TABLE #ConsolidadoEne_DicvncCENegocio (
			Ene_DicvncNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEne_DicvncCENegocio
		SELECT COUNT(cantidad) AS Ene_Dic
			,t1.cmid
		FROM (
			SELECT COUNT(DISTINCT Na.numeroNegocio) AS cantidad
				,Na.compania_id
				,Na.ramo_id
				,31 AS tipoMedida_id
				,Na.zona_id
				,Na.localidad_id
				,Na.clave
				,Na.participante_id
				,Na.lineaNegocio_id
				,@añoenCurso AS anio
				,Na.segmento_id
				,Na.identificacionSuscriptor
				,Cm.id AS cmid
			FROM #NegociosAgrupados Na
			INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
				AND Na.participante_id = Cm.participante_id
				AND Na.Ramo_id = Cm.Ramo_id
				AND Na.localidad_id = Cm.localidad_id
				AND Na.lineaNegocio_id = Cm.lineaNegocio_id
				AND Na.segmento_id = cm.segmento_id
			INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
			WHERE (
					-- VIDA y GENERALES			NUEVOS NEGOCIOS
					(
						Na.compania_id IN (
							1
							,2
							)
						AND ge.claseEndoso = 1
						)
					OR Na.compania_id IN (
						3
						,4
						,5
						) -- CAPI, ARP y SALUD 
					)
				AND (
					Na.mesCierre IN (
						1
						,2
						,3
						,4
						,5
						,6
						,7
						,8
						,9
						,10
						,11
						,12
						)
					AND Cm.año = @añoenCurso
					AND Cm.tipoMedida_id = 31
					AND Na.estadoNegocio = 'V'
					AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
					)
			GROUP BY Na.identificacionSuscriptor
				,Na.clave
				,Na.compania_id
				,Na.Ramo_id
				,Na.zona_id
				,Na.localidad_id
				,Na.lineaNegocio_id
				,Na.participante_id
				,Na.segmento_id
				,Cm.id
			) AS t1
		GROUP BY t1.clave
			,t1.compania_id
			,t1.ramo_id
			,t1.lineaNegocio_id
			,t1.zona_id
			,t1.localidad_id
			,t1.participante_id
			,t1.segmento_id
			,t1.tipoMedida_id
			,t1.cmid

		UPDATE ConsolidadoMes
		SET Ene_Dic = cmm.Ene_DicvncNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEne_DicvncCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 31
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEne_DicvncCENegocio

		PRINT 'Consolidado x Cantidad de diferentes suscriptores x Negocio (Enero - Diciembre)'

		-------------------------------------  CANTIDAD DE DIFERENTES ASESORES VENDIENDO (Con excepciones)
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 32 --> Cantidad de diferentes
		-- suscriptores x negocio (Con excepciones).			
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,32 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND (
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					) -- VIDA y GENERALES			NUEVOS NEGOCIOS
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida la cantidad de diferentes suscriptores por negocio de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerovacCENegocio (
			EnerovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 1
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovacCENegocio (
			FebrerovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 2
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovacCENegocio (
			MarzovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 3
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvacCENegocio (
			AbrilvacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 4
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovacCENegocio (
			MayovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 5
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovacCENegocio (
			JuniovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 6
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovacCENegocio (
			JuliovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 7
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovacCENegocio (
			AgostovacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 8
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevacCENegocio (
			SeptiembrevacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 9
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevacCENegocio (
			OctubrevacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 10
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevacCENegocio (
			NoviembrevacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 11
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevacCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevacCENegocio (
			DiciembrevacNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevacCENegocio
		SELECT COUNT(DISTINCT Na.participante_id) AS cantidad
			,Cm.id AS cmid
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 12
				AND Cm.año = @añoenCurso
				AND Cm.tipoMedida_id = 32
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.cliente_id
			,Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.participante_id
			,Na.segmento_id
			,Cm.id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevacNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevacCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 32
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevacCENegocio

		PRINT 'Consolidado x Cantidad de diferentes asesores vendiendo nuevos negocios (Enero - Diciembre)'

		-------------------------------------  NUMERO DE NEGOCIO x USUARIOS (Con excepciones)
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 33 --> Usuarios (Con excepciones)
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,33 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,@añoenCurso AS año
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND (
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					) -- VIDA y GENERALES			NUEVOS NEGOCIOS
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Na.modalidadPago_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida la cantidad de usuarios de Enero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoEnerovxuCENegocio (
			EnerovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoEnerovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 1
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovxuCENegocio

		-- Tabla temporal que Consolida la cantidad de usuarios de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovxuCENegocio (
			FebrerovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoFebrerovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 2
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovxuCENegocio

		-- Tabla temporal que Consolida la cantidad de usuarios de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovxuCENegocio (
			MarzovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoMarzovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.ramo_id = Cm.ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 3
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.ramo_id
			,Na.producto_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovxuCENegocio

		-- Tabla temporal que Consolida la cantidad de usuarios de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvxuCENegocio (
			AbrilvxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoAbrilvnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 4
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvxuCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovxuCENegocio (
			MayovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoMayovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 5
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovxuCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovxuCENegocio (
			JuniovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoJuniovNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 6
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovxuCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovxuCENegocio (
			JuliovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoJuliovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 7
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovxuCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovxuCENegocio (
			AgostovxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoAgostovnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 8
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovxuCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevxuCENegocio (
			SeptiembrevxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoSeptiembrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 9
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevxuCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevxuCENegocio (
			OctubrevxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoOctubrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 10
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevxuCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevxuCENegocio (
			NoviembrevxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoNoviembrevNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 11
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevxuCENegocio

		-- Tabla temporal que Consolida la cantidad de negocios de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevxuCENegocio (
			DiciembrevxuNegocio FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevxuCENegocio
		SELECT SUM(Usuarios) AS ConsolidadoDiciembrevnNegocio
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 12
				AND Cm.tipoMedida_id = 33
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevxuNegocio
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevxuCENegocio cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 33
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevxuCENegocio

		PRINT 'Consolidado x Cantidad de usuarios x Negocio (Enero - Diciembre)'

		-- TipoMedida 30: Suma de Primas por Nuevos Negocios (Con excepciones).
		-- Se insertan los valores de la tabla temporal #NegociosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. TipoMedida 30 --> Suma de Primas por Nuevos Negocios (Con excepciones)
		INSERT INTO ConsolidadoMes (
			compania_id
			,Ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,30 AS tipoMedida_id
			,Na.zona_id
			,Na.localidad_id
			,RTRIM(LTRIM(Na.clave)) AS clave
			,Na.participante_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,@añoenCurso AS año
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id
		FROM #NegociosAgrupados Na
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE YEAR(Na.fechaExpedicion) <> 1900
			AND (
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					) -- VIDA y GENERALES			NUEVOS NEGOCIOS
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.clave
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Na.modalidadPago_id
			,Na.participante_id
			,Na.segmento_id
			,Na.plazo_id

		-- Tabla temporal que Consolida los valores de primas de Enero del año vigente. (x Mes)		
		CREATE TABLE #ConsolidadoEnerovpnCENegocios (
			EnerovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoEnerovpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS EnerovpnNegocios
			,Cm.id AS CmID
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 1
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Febrero del año vigente. (x Mes)	
		CREATE TABLE #ConsolidadoFebrerovpnCENegocios (
			FebrerovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoFebrerovpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoFebrerovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 2
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovpnCENegocios (
			MarzovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMarzovpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoMarzovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 3
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvpnCENegocios (
			AbrilvpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoAbrilvpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoAbrilvpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 4
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovpnCENegocios (
			MayovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoMayovpnNegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoMayovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 5
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovpnCENegocios (
			JuniovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuniovpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoJuniovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 6
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovpnCENegocios (
			JuliovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoJuliovpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoJuliovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 7
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovpnCENegocios (
			AgostovpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoAgostovpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoAgostovpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 8
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevpnCENegocios (
			SeptiembrevpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoSeptiembrevpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoSeptiembrevpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 9
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevpnCENegocios (
			OctubrevpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoOctubrevpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoOctubrevpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 10
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevpnCENegocios (
			NoviembrevpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoNoviembrevpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoNoviembrevpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 11
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevpnCENegocios

		-- Tabla temporal que Consolida los valores de primas de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevpnCENegocios (
			DiciembrevpnNegocios FLOAT NULL
			,CmID INT NULL
			)

		INSERT INTO #ConsolidadoDiciembrevpnCENegocios
		SELECT ROUND(CAST(SUM(valorPrimaTotal) AS FLOAT), 3) AS ConsolidadoDiciembrevpnNegocios
			,Cm.id
		FROM #NegociosAgrupados Na
		INNER JOIN ConsolidadoMes Cm ON Na.compania_id = Cm.compania_id
			AND Na.participante_id = Cm.participante_id
			AND Na.Ramo_id = Cm.Ramo_id
			AND Na.producto_id = Cm.producto_id
			AND Na.localidad_id = Cm.localidad_id
			AND Na.lineaNegocio_id = Cm.lineaNegocio_id
			AND Na.amparo_id = Cm.amparo_id
			AND Na.modalidadpago_id = Cm.modalidadPago_id
			AND Na.segmento_id = cm.segmento_id
			AND Na.plazo_id = cm.plazo_id
		INNER JOIN GrupoEndoso ge ON ge.id = Na.grupoEndoso_id
		WHERE (
				-- VIDA y GENERALES			NUEVOS NEGOCIOS
				(
					Na.compania_id IN (
						1
						,2
						)
					AND ge.claseEndoso = 1
					)
				OR Na.compania_id IN (
					3
					,4
					,5
					) -- CAPI, ARP y SALUD 
				)
			AND (
				Na.mesCierre = 12
				AND Cm.tipoMedida_Id = 30
				AND Cm.año = @añoenCurso
				AND RTRIM(LTRIM(Na.estadoNegocio)) = 'V'
				AND Na.lineaNegocio_id = 1 -- NUEVOS NEGOCIOS
				)
		GROUP BY Na.participante_id
			,Na.compania_id
			,Na.Ramo_id
			,Na.producto_id
			,Na.zona_id
			,Na.localidad_id
			,Na.lineaNegocio_id
			,Na.amparo_id
			,Cm.id
			,Na.modalidadPago_id
			,Na.segmento_id
			,Na.plazo_id

		-- Actualiza el valor consolidado de primas en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevpnNegocios
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevpnCENegocios cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_Id = 30
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevpnCENegocios

		PRINT 'Consolidado x Valor de primas de Nuevos Negocios (Enero - Diciembre)'	
		
		-- *********************************************************************************************************
		-- Actualización x Excepciones (COLQUINES)
		-- *********************************************************************************F************************--	
		-- Combinación Excepcion  por compañia,  Ramo, Clave, NumeroNegocio
		UPDATE #RecaudosAgrupados
		SET Colquines = ROUND(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(eg.factor AS FLOAT)) AS FLOAT), 3)
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN ExcepcionesGenerales eg ON eg.compania_id = Ra.compania_id and eg.ramo_id = ra.ramo_id
			AND RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(ra.clave))
			AND eg.numeroNegocio = CAST(ra.numeroNegocio AS BIGINT)
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = eg.moneda_id
		WHERE CAST(Ra.fechaRecaudo AS DATE) BETWEEN eg.fechaInicio
				AND eg.fechaFin
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Bm.fecha_inicioVigencia) = @añoenCurso
			AND YEAR(Bm.fecha_finVigencia) = @añoenCurso
			AND Bm.moneda_id = 1
			AND eg.numeroNegocio <> 0
			AND eg.compania_id <> 0
			AND eg.ramo_id <> 0
			AND eg.tipomedida_id = 2

		PRINT 'Excepcion por Compañia, Ramo, Clave, NumeroNegocio con excepcion'		
		
		-- Combinación Excepcion por Compañia, Ramo, Clave
		UPDATE #RecaudosAgrupados
		SET Colquines = ROUND(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(eg.factor AS FLOAT)) AS FLOAT), 3)
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN ExcepcionesGenerales eg ON eg.compania_id = Ra.compania_id 
			AND eg.ramo_id = ra.ramo_id
			AND RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(ra.clave))
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = eg.moneda_id
		WHERE CAST(Ra.fechaRecaudo AS DATE) BETWEEN eg.fechaInicio
				AND eg.fechaFin
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Bm.fecha_inicioVigencia) = @añoenCurso
			AND YEAR(Bm.fecha_finVigencia) = @añoenCurso
			AND Bm.moneda_id = 1
			AND eg.numeroNegocio = 0
			AND eg.compania_id <> 0
			AND eg.ramo_id <> 0			
			AND eg.tipomedida_id = 2

		PRINT 'Excepcion por Compañia, Ramo, Clave con excepcion'

		-- Combinación Excepcion por Clave
		UPDATE #RecaudosAgrupados
		SET Colquines = ROUND(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(eg.factor AS FLOAT)) AS FLOAT), 3)
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN ExcepcionesGenerales eg ON RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(ra.clave))
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = eg.moneda_id
		WHERE CAST(Ra.fechaRecaudo AS DATE) BETWEEN eg.fechaInicio
				AND eg.fechaFin
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Bm.fecha_inicioVigencia) = @añoenCurso
			AND YEAR(Bm.fecha_finVigencia) = @añoenCurso
			AND Bm.moneda_id = 1
			AND eg.numeroNegocio = 0
			AND eg.compania_id = 0
			AND eg.ramo_id = 0			
			AND eg.tipomedida_id = 2			

		PRINT 'Excepcion por Clave con excepcion'
		
		-------------------------------------  COLQUINES CON EXCEPCIONES
		-- Se insertan los valores de la tabla temporal #RecaudosAgrupados en ConsolidadoMes, haciendo el join con Producto para tomar el 
		-- plazo_id relacionado al Producto. Se agrupa el SELECT por: clave, compania, ramo, producto, zona, localidad, lineaNegocio, plazo y amparo. 
		--  TipoMedida 2 --> Colquines con Excepciones
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,2 AS tipoMedida_id
			,Ra.zona_id
			,Ra.localidad_id
			,RTRIM(LTRIM(Ra.clave)) AS clave
			,Ra.participante_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,@añoenCurso AS año
			,Ra.modalidadpago_id
			,Ra.segmento_id
			,Ra.plazo_id
		FROM #RecaudosAgrupados Ra
		WHERE YEAR(Ra.fechaRecaudo) <> 1900
		GROUP BY Ra.clave
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Ra.modalidadpago_id
			,Ra.participante_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Tabla temporal que Consolida los valores de colquines de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerovcceColquines (
			EnerovcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerovcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoEnerovcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 1
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerovcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerovcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerovcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerovcceColquines (
			FebrerovcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerovcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoFebrerovcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 2
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerovcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerovcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerovcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzovcceColquines (
			MarzovcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzovcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoMarzovcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 3
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzovcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzovcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzovcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilvcceColquines (
			AbrilvcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilvcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoAbrilvcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 4
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilvcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilvcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilvcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayovcceColquines (
			MayovcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayovcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoMayovcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE mesCierre = 5
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayovcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayovcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayovcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniovcceColquines (
			JuniovcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniovcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoJuniovcceRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 6
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniovcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniovcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniovcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliovcceColquines (
			JuliovcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliovcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoJuliovcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 7
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliovcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliovcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliovcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostovcceColquines (
			AgostovcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostovcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoAgostovcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 8
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostovcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostovcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostovcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrevcceColquines (
			SeptiembrevcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrevcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoSeptiembrevcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 9
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrevcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrevcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrevcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrevcceColquines (
			OctubrevcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrevcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoOctubrevcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 10
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrevcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrevcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrevcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrevcceColquines (
			NoviembrevcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrevcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoNoviembrevcceRecaudos
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 11
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrevcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrevcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrevcceColquines

		-- Tabla temporal que Consolida los valores de colquines de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrevcceColquines (
			DiciembrevcceColquines FLOAT NULL
			,CmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrevcceColquines
		SELECT ROUND(CAST(SUM(Colquines) AS FLOAT), 3) AS ConsolidadoDiciembrevcceColquines
			,Cm.id
		FROM #RecaudosAgrupados Ra
		INNER JOIN ConsolidadoMes Cm ON Ra.compania_id = Cm.compania_id
			AND Ra.participante_id = Cm.participante_id
			AND Ra.ramo_id = Cm.ramo_id
			AND Ra.producto_id = Cm.producto_id
			AND Ra.localidad_id = Cm.localidad_id
			AND Ra.lineaNegocio_id = Cm.lineaNegocio_id
			AND Ra.amparo_id = Cm.amparo_id
			AND Ra.modalidadpago_id = Cm.modalidadPago_id
			AND Ra.segmento_id = cm.segmento_id
			AND Ra.plazo_id = cm.plazo_id
			AND Ra.zona_id = cm.zona_id
		WHERE Ra.mesCierre = 12
			AND Cm.tipoMedida_id = 2
			AND Cm.año = @añoenCurso
		GROUP BY Ra.participante_id
			,Ra.compania_id
			,Ra.ramo_id
			,Ra.producto_id
			,Ra.zona_id
			,Ra.localidad_id
			,Ra.lineaNegocio_id
			,Ra.amparo_id
			,Cm.id
			,Ra.modalidadPago_id
			,Ra.segmento_id
			,Ra.plazo_id

		-- Actualiza el valor consolidado de colquines en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrevcceColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrevcceColquines cmm ON cmm.CmID = cm.id
		WHERE cm.tipoMedida_id = 2
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrevcceColquines

		PRINT 'Consolidados x Colquines con Excepciones (Enero - Diciembre)'

		-------------------------------------  Colquines a descontar x siniestralidad
		-- Se insertan los valores de la tabla SiniestralidadAcumulada en ConsolidadoMes, Se agrupa el SELECT por: clave, compania, ramo, plazo. 
		--  TipoMedida 22	
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT s.compania_id
			,rd.ramo_id
			,0 AS producto_id
			,22 AS tipoMedida_id
			,0 AS zona_id
			,0 AS localidad_id
			,RTRIM(LTRIM(s.clave)) AS clave
			,s.participante_id
			,0 AS lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadpago_id
			,0 AS segmento_id
			,0 AS plazo_id
		FROM SiniestralidadAcumulada s
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
		WHERE s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.clave
			,s.compania_id
			,rd.ramo_id
			,s.participante_id

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerocdsColquines (
			EnerocdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerocdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoEnerocdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 1
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerocdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerocdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerocdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerocdsColquines (
			FebrerocdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerocdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoFebrerocdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 2
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerocdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerocdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerocdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzocdsColquines (
			MarzocdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzocdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoMarzocdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 3
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzocdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzocdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzocdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilcdsColquines (
			AbrilcdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilcdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoAbrilcdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 4
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilcdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilcdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilcdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayocdsColquines (
			MayocdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayocdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoMayocdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 5
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayocdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayocdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayocdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniocdsColquines (
			JuniocdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniocdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoJuniocdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 6
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniocdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniocdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniocdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliocdsColquines (
			JuliocdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliocdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoJuliocdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 7
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliocdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliocdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliocdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostocdsColquines (
			AgostocdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostocdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoAgostocdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 8
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostocdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostocdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostocdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrecdsColquines (
			SeptiembrecdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrecdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoSeptiembrecdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 9
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrecdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrecdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrecdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrecdsColquines (
			OctubrecdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrecdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoOctubrecdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 10
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrecdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrecdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrecdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrecdsColquines (
			NoviembrecdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrecdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoNoviembrecdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 11
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrecdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrecdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrecdsColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x siniestralidad de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrecdsColquines (
			DiciembrecdsColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrecdsColquines
		SELECT ROUND(CAST(SUM(s.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoDiciembrecdsColquines
			,cm.id
		FROM SiniestralidadAcumulada s
		INNER JOIN ConsolidadoMes cm ON s.compania_id = cm.compania_id
		INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
			AND s.participante_id = cm.participante_id
			AND rd.ramo_id = cm.ramo_id
		WHERE s.ultimoMes = 12
			AND cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso
			AND s.anio = @añoenCurso
			AND s.colquinesDescontar < 0
		GROUP BY s.participante_id
			,s.compania_id
			,rd.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x siniestralidad en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrecdsColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrecdsColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 22
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrecdsColquines

		PRINT 'Consolidados x Colquines a descontar x siniestralidad (Enero - Diciembre)'

		-------------------------------------  Colquines a descontar x persistencia de capi
		-- Se insertan los valores de la tabla PersistenciadeCAPIAcumulada en ConsolidadoMes, Se agrupa el SELECT por: clave, compania, ramo, plazo. 
		--  TipoMedida 23
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT 3 AS compania_id
			,17 AS ramo_id --> TRADICIONAL
			,0 AS producto_id
			,23 AS tipoMedida_id
			,0 AS zona_id
			,0 AS localidad_id
			,RTRIM(LTRIM(pca.clave)) AS clave
			,pca.participante_id
			,0 AS lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadpago_id
			,0 AS segmento_id
			,pca.plazo_id
		FROM PersistenciadeCAPIAcumulada pca
		WHERE pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.clave
			,pca.participante_id
			,pca.plazo_id

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilcdpcColquines (
			AbrilcdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilcdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoAbrilcdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 1
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilcdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilcdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilcdpcColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayocdpcColquines (
			MayocdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayocdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoMayocdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 2
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayocdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayocdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayocdpcColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniocdpcColquines (
			JuniocdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniocdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoJuniocdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 3
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniocdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniocdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniocdpcColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliocdpcColquines (
			JuliocdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliocdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoJuliocdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 4
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliocdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliocdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliocdpcColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostocdpcColquines (
			AgostocdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostocdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoAgostocdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 5
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostocdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostocdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostocdpcColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrecdpcColquines (
			SeptiembrecdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrecdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoSeptiembrecdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 6
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrecdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrecdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrecdpcColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrecdpcColquines (
			OctubrecdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrecdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoOctubrecdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 7
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrecdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrecdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrecdpcColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrecdpcColquines (
			NoviembrecdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrecdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoNoviembrecdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 8
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrecdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrecdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrecdpcColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de capi de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrecdpcColquines (
			DiciembrecdpcColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrecdpcColquines
		SELECT ROUND(CAST(SUM(pca.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoDiciembrecdpcColquines
			,cm.id
		FROM PersistenciadeCAPIAcumulada pca
		INNER JOIN ConsolidadoMes cm ON pca.participante_id = cm.participante_id
			AND pca.plazo_id = cm.plazo_id
		WHERE pca.ultimoPeriodo = 9
			AND cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso
			AND pca.anioCierreNegocio = @añoenCurso
			AND pca.colquinesDescontar < 0
		GROUP BY pca.participante_id
			,pca.plazo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de capi en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrecdpcColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrecdpcColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 23
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrecdpcColquines

		PRINT 'Consolidados x Colquines a descontar x persistencia de CAPI (Enero - Diciembre)'

		-------------------------------------  Colquines a descontar x persistencia de vida (Def.)
		-- Se insertan los valores de la tabla PersistenciadeVIDA (Def.) en ConsolidadoMes, Se agrupa el SELECT por: clave, compania, ramo. 
		--  TipoMedida 24
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT pv.compania_id
			,pv.ramo_id --> VIDA INDIVIDUAL
			,0 AS producto_id
			,24 AS tipoMedida_id
			,0 AS zona_id
			,0 AS localidad_id
			,RTRIM(LTRIM(p.clave)) AS clave
			,pv.participante_id
			,0 AS lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadpago_id
			,0 AS segmento_id
			,0 AS plazo_id
		FROM PersistenciadeVIDA pv
		INNER JOIN Participante p ON p.id = pv.participante_id
		WHERE pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY p.clave
			,pv.participante_id
			,pv.ramo_id
			,pv.compania_id

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerocdpvColquines (
			EnerocdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerocdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoEnerocdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 1
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerocdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerocdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerocdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerocdpvColquines (
			FebrerocdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerocdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoFebrerocdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 2
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerocdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerocdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerocdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzocdpvColquines (
			MarzocdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzocdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoMarzocdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 3
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzocdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzocdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzocdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilcdpvColquines (
			AbrilcdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilcdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoAbrilcdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 4
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilcdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilcdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilcdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayocdpvColquines (
			MayocdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayocdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoMayocdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 5
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayocdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayocdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayocdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniocdpvColquines (
			JuniocdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniocdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoJuniocdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 6
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniocdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniocdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniocdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliocdpvColquines (
			JuliocdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliocdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoJuliocdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 7
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliocdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliocdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliocdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostocdpvColquines (
			AgostocdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostocdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoAgostocdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 8
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostocdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostocdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostocdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrecdpvColquines (
			SeptiembrecdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrecdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoSeptiembrecdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 9
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrecdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrecdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrecdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrecdpvColquines (
			OctubrecdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrecdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoOctubrecdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 10
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrecdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrecdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrecdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrecdpvColquines (
			NoviembrecdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrecdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoNoviembrecdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 11
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrecdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrecdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrecdpvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Def.) de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrecdpvColquines (
			DiciembrecdpvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrecdpvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoDiciembrecdpvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 12
			AND cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '2'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Def.) en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrecdpvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrecdpvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 24
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrecdpvColquines

		PRINT 'Consolidados x Colquines a descontar x persistencia de VIDA (Def.) (Enero - Diciembre)'

		-------------------------------------  Colquines a descontar x persistencia de vida (Def.)
		-- Se insertan los valores de la tabla PersistenciadeVIDA (Per.) en ConsolidadoMes, Se agrupa el SELECT por: clave, compania, ramo. 
		--  TipoMedida 25
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT pv.compania_id
			,pv.ramo_id --> VIDA INDIVIDUAL
			,0 AS producto_id
			,25 AS tipoMedida_id
			,0 AS zona_id
			,0 AS localidad_id
			,RTRIM(LTRIM(p.clave)) AS clave
			,pv.participante_id
			,0 AS lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadpago_id
			,0 AS segmento_id
			,0 AS plazo_id
		FROM PersistenciadeVIDA pv
		INNER JOIN Participante p ON p.id = pv.participante_id
		WHERE pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY p.clave
			,pv.participante_id
			,pv.ramo_id
			,pv.compania_id

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEnerocppvColquines (
			EnerocppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEnerocppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoEnerocppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 1
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Enero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EnerocppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEnerocppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEnerocppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebrerocppvColquines (
			FebrerocppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebrerocppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoFebrerocppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 2
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Febrero por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebrerocppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebrerocppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebrerocppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzocppvColquines (
			MarzocppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzocppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoMarzocppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 3
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzocppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzocppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzocppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilcppvColquines (
			AbrilcppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilcppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoAbrilcppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 4
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilcppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilcppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilcppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayocppvColquines (
			MayocppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayocppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoMayocppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 5
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayocppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayocppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayocppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniocppvColquines (
			JuniocppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniocppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoJuniocppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 6
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniocppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniocppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniocppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliocppvColquines (
			JuliocppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliocppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoJuliocppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 7
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliocppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliocppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliocppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostocppvColquines (
			AgostocppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostocppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoAgostocppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 8
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostocppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostocppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostocppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrecppvColquines (
			SeptiembrecppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrecppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoSeptiembrecppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 9
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrecppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrecppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrecppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrecppvColquines (
			OctubrecppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrecppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoOctubrecppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 10
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrecppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrecppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrecppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrecppvColquines (
			NoviembrecppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrecppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoNoviembrecppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 11
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrecppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrecppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrecppvColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrecppvColquines (
			DiciembrecppvColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrecppvColquines
		SELECT ROUND(CAST(SUM(pv.colquinesDescontar) AS FLOAT), 3) AS ConsolidadoDiciembrecppvColquines
			,cm.id
		FROM PersistenciadeVIDA pv
		INNER JOIN ConsolidadoMes cm ON pv.compania_id = cm.compania_id
			AND pv.ramo_id = cm.ramo_id
			AND pv.participante_id = cm.participante_id
		WHERE pv.mesCorte = 12
			AND cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso
			AND pv.añoAMedir = @añoenCurso
			AND LTRIM(RTRIM(pv.tipoPersistencia)) = '1'
			AND pv.colquinesDescontar < 0
			AND pv.persistenciaDefinitiva > 0
		GROUP BY pv.participante_id
			,pv.compania_id
			,pv.ramo_id
			,cm.id

		-- Actualiza el valor consolidado de colquines a descontar x persistencia de vida (Per.) en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrecppvColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrecppvColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 25
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrecppvColquines

		PRINT 'Consolidados x Colquines a descontar x persistencia de VIDA (Per.) (Enero - Diciembre)'

		-------------------------------------  Colquines x combo
		-- Se insertan los valores de la tabla PremiosxComboCRM en ConsolidadoMes, Se agrupa el SELECT por: participante, localidad, compania, ramo. 
		--  TipoMedida 26
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,amparo_id
			,año
			,modalidadPago_id
			,segmento_id
			,plazo_id
			)
		SELECT pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,26 AS tipoMedida_id
			,l.zona_id AS zona_id
			,pc.localidad_id
			,RTRIM(LTRIM(pc.clave)) AS clave
			,p.id AS participante_id
			,0 AS lineaNegocio_id
			,0 AS amparo_id
			,@añoenCurso AS año
			,0 AS modalidadpago_id
			,0 AS segmento_id
			,0 AS plazo_id
		FROM PremiosxComboCRM pc
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(pc.clave))
		INNER JOIN Localidad l ON l.id = pc.localidad_id
		GROUP BY p.id
			,pc.clave
			,pc.ramo_id
			,pc.compania_id
			,pc.producto_id
			,pc.localidad_id
			,l.zona_id

		-- Tabla temporal que Consolida los valores de colquines x combo en Enero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoEneropccColquines (
			EneropccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoEneropccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoEneropccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 1
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en en Enero (x Mes)
		UPDATE ConsolidadoMes
		SET Enero = cmm.EneropccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoEneropccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoEneropccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Febrero del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoFebreropccColquines (
			FebreropccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoFebreropccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoFebreropccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 2
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Febrero (x Mes)
		UPDATE ConsolidadoMes
		SET Febrero = cmm.FebreropccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoFebreropccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoFebreropccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Marzo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMarzopccColquines (
			MarzopccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMarzopccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoMarzopccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 3
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Marzo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Marzo = cmm.MarzopccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMarzopccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMarzopccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Abril del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAbrilpccColquines (
			AbrilpccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAbrilpccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoAbrilpccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 4
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Abril por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Abril = cmm.AbrilpccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAbrilpccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAbrilpccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Mayo del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoMayopccColquines (
			MayopccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoMayopccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoMayopccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 5
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Mayo por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Mayo = cmm.MayopccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoMayopccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoMayopccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Junio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuniopccColquines (
			JuniopccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuniopccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoJuniopccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Junio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Junio = cmm.JuniopccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuniopccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuniopccColquines

		-- Tabla temporal que Consolida los valores de colquines a descontar x persistencia de vida (Per.) de Julio del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoJuliopccColquines (
			JuliopccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoJuliopccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoJuliopccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 7
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Julio por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Julio = cmm.JuliopccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoJuliopccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoJuliopccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Agosto del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoAgostopccColquines (
			AgostopccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoAgostopccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoAgostopccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 8
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Agosto por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Agosto = cmm.AgostopccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoAgostopccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoAgostopccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Septiembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoSeptiembrepccColquines (
			SeptiembrepccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoSeptiembrepccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoSeptiembrepccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 9
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Septiembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Septiembre = cmm.SeptiembrepccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoSeptiembrepccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoSeptiembrepccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Octubre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoOctubrepccColquines (
			OctubrepccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoOctubrepccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoOctubrepccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 10
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Octubre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Octubre = cmm.OctubrepccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoOctubrepccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoOctubrepccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Noviembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoNoviembrepccColquines (
			NoviembrepccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoNoviembrepccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoNoviembrepccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 11
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Noviembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Noviembre = cmm.NoviembrepccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoNoviembrepccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoNoviembrepccColquines

		-- Tabla temporal que Consolida los valores de colquines x combo en Diciembre del año vigente. (x Mes)
		CREATE TABLE #ConsolidadoDiciembrepccColquines (
			DiciembrepccColquines FLOAT NULL
			,cmID INT NULL
			,
			)

		INSERT INTO #ConsolidadoDiciembrepccColquines
		SELECT ROUND(CAST(SUM(pc.cantidad) AS FLOAT), 3) AS ConsolidadoDiciembrepccColquines
			,cm.id
		FROM PremiosxComboCRM pc
		INNER JOIN ConsolidadoMes cm ON pc.compania_id = cm.compania_id
			AND pc.ramo_id = cm.ramo_id
			AND pc.producto_id = cm.producto_id
			AND pc.localidad_id = cm.localidad_id
			AND RTRIM(LTRIM(pc.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE MONTH(pc.fechaProceso) = 12
			AND cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso
		GROUP BY pc.clave
			,pc.compania_id
			,pc.ramo_id
			,pc.producto_id
			,pc.localidad_id
			,cm.id

		-- Actualiza el valor consolidado de colquines x combo en Diciembre por clave (x Mes)
		UPDATE ConsolidadoMes
		SET Diciembre = cmm.DiciembrepccColquines
		FROM ConsolidadoMes cm
		INNER JOIN #ConsolidadoDiciembrepccColquines cmm ON cmm.cmID = cm.id
		WHERE cm.tipoMedida_id = 26
			AND cm.año = @añoenCurso

		DROP TABLE #ConsolidadoDiciembrepccColquines

		PRINT 'Consolidados x Colquines Combo CRM (Enero - Diciembre)'

		DROP TABLE #RecaudosAgrupados

		DROP TABLE #NegociosAgrupados

		PRINT 'Borra tablas Temporales de Negocios y Recaudos Agrupados'

		-- Actualización x Periodos del año -- CAMBIO PARA AGREGAR LAS NUEVAS TIPOS DE MEDIDAS NEGOCIO CON EXCEPCION Y PRIMAS CON EXCEPCION
		UPDATE ConsolidadoMes
		SET Enero = 0
		WHERE Enero IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Febrero = 0
		WHERE Febrero IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Marzo = 0
		WHERE Marzo IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Abril = 0
		WHERE Abril IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Mayo = 0
		WHERE Mayo IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Junio = 0
		WHERE Junio IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Julio = 0
		WHERE Julio IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Agosto = 0
		WHERE Agosto IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Septiembre = 0
		WHERE Septiembre IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Octubre = 0
		WHERE Octubre IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Noviembre = 0
		WHERE Noviembre IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Diciembre = 0
		WHERE Diciembre IS NULL
			AND año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,19
				,20
				,17
				,21
				,22
				,23
				,24
				,25
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		--  X TRIMESTRE --**********************
		UPDATE ConsolidadoMes
		SET Ene_Mar = (Enero + Febrero + Marzo)
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,20
				,17
				,21
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Abr_Jun = (Abril + Mayo + Junio)
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,20
				,17
				,21
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Jul_Sep = (Julio + Agosto + Septiembre)
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,20
				,17
				,21
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Oct_Dic = (Octubre + Noviembre + Diciembre)
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,20
				,17
				,21
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		--  X TRIMESTRE --**********************
		--  X SEMESTRE --**********************
		UPDATE ConsolidadoMes
		SET Ene_Jun = (Ene_Mar + Abr_Jun)
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,20
				,17
				,21
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		UPDATE ConsolidadoMes
		SET Jul_Dic = (Jul_Sep + Oct_Dic)
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,20
				,17
				,21
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		--  X SEMESTRE --**********************	
		--  X AÑO --**********************
		UPDATE ConsolidadoMes
		SET Ene_Dic = (Ene_Jun + Jul_Dic)
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				1
				,2
				,3
				,4
				,10
				,20
				,17
				,21
				,26
				,27
				,28
				,29
				,30
				,31
				,32
				,33
				)

		--  X AÑO --**********************	FIN ----
		--  ETAPAS:
		UPDATE ConsolidadoMes
		SET Etapa_1 = Ene_Mar + Abril
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				2
				,21
				,26
				)

		UPDATE ConsolidadoMes
		SET Etapa_2 = Ene_Jun
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				2
				,21
				,26
				)

		UPDATE ConsolidadoMes
		SET Etapa_3 = Ene_Jun + Julio + Agosto
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				2
				,21
				,26
				)

		UPDATE ConsolidadoMes
		SET Etapa_4 = Ene_Jun + Julio + Agosto + Septiembre + Octubre
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				2
				,21
				,26
				)

		UPDATE ConsolidadoMes
		SET Etapa_5 = Ene_Dic
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				2
				,21
				,26
				)

		PRINT 'Consolidados x Colquines Etapa'

		-- x PERIODO ETAPAS (Descuentos: Siniestralidad, Persistencia de CAPI, Persistencia de VIDA):
		UPDATE ConsolidadoMes
		SET Ene_Mar = Marzo
			,Abr_Jun = Junio
			,Jul_Sep = Septiembre
			,Oct_Dic = Diciembre
			,Ene_Jun = Junio
			,Jul_Dic = Diciembre
			,Ene_Dic = Diciembre
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				22
				,23
				,24
				,25
				)

		--  ETAPAS (Descuentos: Siniestralidad, Persistencia de CAPI, Persistencia de VIDA):
		UPDATE ConsolidadoMes
		SET Etapa_1 = Abril
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				22
				,23
				,24
				,25
				)

		UPDATE ConsolidadoMes
		SET Etapa_2 = Junio
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				22
				,23
				,24
				,25
				)

		UPDATE ConsolidadoMes
		SET Etapa_3 = Agosto
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				22
				,23
				,24
				,25
				)

		UPDATE ConsolidadoMes
		SET Etapa_4 = Octubre
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				22
				,23
				,24
				,25
				)

		UPDATE ConsolidadoMes
		SET Etapa_5 = Diciembre
		WHERE año = @añoenCurso
			AND tipoMedida_id IN (
				22
				,23
				,24
				,25
				)

		PRINT 'ETAPAS (Descuentos: Siniestralidad, Persistencia de CAPI, Persistencia de VIDA)'

		UPDATE ConsolidadoMes
		SET Ene_Mar = 0
		WHERE Ene_Mar IS NULL
			AND tipoMedida_id = 19
			AND año = @añoenCurso

		UPDATE ConsolidadoMes
		SET Abr_Jun = 0
		WHERE Abr_Jun IS NULL
			AND tipoMedida_id = 19
			AND año = @añoenCurso

		UPDATE ConsolidadoMes
		SET Jul_Sep = 0
		WHERE Jul_Sep IS NULL
			AND tipoMedida_id = 19
			AND año = @añoenCurso

		UPDATE ConsolidadoMes
		SET Oct_Dic = 0
		WHERE Oct_Dic IS NULL
			AND tipoMedida_id = 19
			AND año = @añoenCurso

		UPDATE ConsolidadoMes
		SET Ene_Jun = 0
		WHERE Ene_Jun IS NULL
			AND tipoMedida_id = 19
			AND año = @añoenCurso

		UPDATE ConsolidadoMes
		SET Jul_Dic = 0
		WHERE Jul_Dic IS NULL
			AND tipoMedida_id = 19
			AND año = @añoenCurso

		UPDATE ConsolidadoMes
		SET Ene_Dic = 0
		WHERE Ene_Dic IS NULL
			AND tipoMedida_id = 19
			AND año = @añoenCurso

		--------------------------------------------  CRECIMIENTOS
		-- En Recaudos, Colquines, Primas y Negocios se calcula el crecimiento del año vigente vs. año anterior: ((año Vigente - año Anterior) *100) / año Vigente
		--  CUMPLIMIENTO EN PRIMAS (tipomedida: 5): Toma el valor Consolidado por primas de negocio,  tipomedida: 3
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Enero
			,Febrero
			,Marzo
			,Abril
			,Mayo
			,Junio
			,Julio
			,Agosto
			,Septiembre
			,Octubre
			,Noviembre
			,Diciembre
			,Ene_Mar
			,Abr_Jun
			,Jul_Sep
			,Oct_Dic
			,Ene_Jun
			,Jul_Dic
			,Ene_Dic
			,año
			,segmento_id
			)
		SELECT AV.compania_id
			,AV.ramo_id
			,AV.producto_id
			,5 AS cumplimientoPrimas
			,AV.zona_id
			,AV.localidad_id
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,AV.lineaNegocio_id
			,AV.plazo_id
			,AV.amparo_id
			,AV.modalidadPago_id
			,(
				CASE 
					WHEN SUM(AV.Enero) > 0
						AND SUM(q1.AAEnero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
					END
				) AS Enero
			,(
				CASE 
					WHEN SUM(AV.Febrero) > 0
						AND SUM(q1.AAFebrero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
					END
				) AS Febrero
			,(
				CASE 
					WHEN SUM(AV.Marzo) > 0
						AND SUM(q1.AAMarzo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
					END
				) AS Marzo
			,(
				CASE 
					WHEN SUM(AV.Abril) > 0
						AND SUM(q1.AAAbril) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
					END
				) AS Abril
			,(
				CASE 
					WHEN SUM(AV.Mayo) > 0
						AND SUM(q1.AAMayo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
					END
				) AS Mayo
			,(
				CASE 
					WHEN SUM(AV.Junio) > 0
						AND SUM(q1.AAJunio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
					END
				) AS Junio
			,(
				CASE 
					WHEN SUM(AV.Julio) > 0
						AND SUM(q1.AAJulio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
					END
				) AS Julio
			,(
				CASE 
					WHEN SUM(AV.Agosto) > 0
						AND SUM(q1.AAAgosto) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
					END
				) AS Agosto
			,(
				CASE 
					WHEN SUM(AV.Septiembre) > 0
						AND SUM(q1.AASeptiembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
					END
				) AS Septiembre
			,(
				CASE 
					WHEN SUM(AV.Octubre) > 0
						AND SUM(q1.AAOctubre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
					END
				) AS Octubre
			,(
				CASE 
					WHEN SUM(AV.Noviembre) > 0
						AND SUM(q1.AANoviembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
					END
				) AS Noviembre
			,(
				CASE 
					WHEN SUM(AV.Diciembre) > 0
						AND SUM(q1.AADiciembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
					END
				) AS Diciembre
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) > 0
						AND SUM(q1.AAEne_Mar) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
					END
				) AS Ene_Mar
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) > 0
						AND SUM(q1.AAAbr_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
					END
				) AS Abr_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) > 0
						AND SUM(q1.AAJul_Sep) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
					END
				) AS Jul_Sep
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) > 0
						AND SUM(q1.AAOct_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
					END
				) AS Oct_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Jun) > 0
						AND SUM(q1.AAEne_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
					END
				) AS Ene_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Dic) > 0
						AND SUM(q1.AAJul_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
					END
				) AS Jul_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Dic) > 0
						AND SUM(q1.AAEne_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Dic
			,CAST(@añoenCurso AS INT)
			,AV.segmento_id
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
				,AA.compania_id
				,AA.lineaNegocio_id
				,AA.ramo_id
				,AA.producto_id
				,AA.localidad_id
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
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 3
			GROUP BY AA.clave
				,AA.participante_id
				,AA.compania_id
				,AA.ramo_id
				,AA.producto_id
				,AA.localidad_id
				,AA.lineaNegocio_id
			) AS q1 ON AV.clave = q1.clave
			AND AV.compania_id = q1.compania_id
			AND AV.ramo_id = q1.ramo_id
			AND AV.producto_id = q1.producto_id
			AND AV.lineaNegocio_id = q1.lineaNegocio_id
			AND AV.localidad_id = q1.localidad_id
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 3
		GROUP BY AV.clave
			,AV.participante_id
			,AV.compania_id
			,AV.ramo_id
			,AV.producto_id
			,AV.lineaNegocio_id
			,AV.localidad_id
			,AV.zona_id
			,AV.plazo_id
			,AV.amparo_id
			,AV.modalidadPago_id
			,AV.segmento_id
			,q1.AAEnero
			,q1.AAFebrero
			,q1.AAMarzo
			,q1.AAAbril
			,q1.AAMayo
			,q1.AAJunio
			,q1.AAJulio
			,q1.AAAgosto
			,q1.AASeptiembre
			,q1.AAOctubre
			,q1.AANoviembre
			,q1.AADiciembre
			,q1.AAEne_Mar
			,q1.AAAbr_Jun
			,q1.AAJul_Sep
			,q1.AAOct_Dic
			,q1.AAEne_Jun
			,q1.AAJul_Dic
			,q1.AAEne_Dic

		PRINT 'Crecimiento y cumplimiento en Primas'

		--  CUMPLIMIENTO EN RECAUDOS (tipomedida: 6): Toma el valor Consolidado por valor de recaudo,  tipomedida: 2
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Enero
			,Febrero
			,Marzo
			,Abril
			,Mayo
			,Junio
			,Julio
			,Agosto
			,Septiembre
			,Octubre
			,Noviembre
			,Diciembre
			,Ene_Mar
			,Abr_Jun
			,Jul_Sep
			,Oct_Dic
			,Ene_Jun
			,Jul_Dic
			,Ene_Dic
			,año
			,segmento_id
			)
		SELECT AV.compania_id
			,AV.ramo_id
			,AV.producto_id
			,6 AS cumplimientoRecaudos
			,AV.zona_id
			,AV.localidad_id
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,AV.lineaNegocio_id
			,AV.plazo_id
			,AV.amparo_id
			,AV.modalidadPago_id
			,(
				CASE 
					WHEN SUM(AV.Enero) > 0
						AND SUM(q1.AAEnero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
					END
				) AS Enero
			,(
				CASE 
					WHEN SUM(AV.Febrero) > 0
						AND SUM(q1.AAFebrero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
					END
				) AS Febrero
			,(
				CASE 
					WHEN SUM(AV.Marzo) > 0
						AND SUM(q1.AAMarzo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
					END
				) AS Marzo
			,(
				CASE 
					WHEN SUM(AV.Abril) > 0
						AND SUM(q1.AAAbril) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
					END
				) AS Abril
			,(
				CASE 
					WHEN SUM(AV.Mayo) > 0
						AND SUM(q1.AAMayo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
					END
				) AS Mayo
			,(
				CASE 
					WHEN SUM(AV.Junio) > 0
						AND SUM(q1.AAJunio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
					END
				) AS Junio
			,(
				CASE 
					WHEN SUM(AV.Julio) > 0
						AND SUM(q1.AAJulio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
					END
				) AS Julio
			,(
				CASE 
					WHEN SUM(AV.Agosto) > 0
						AND SUM(q1.AAAgosto) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
					END
				) AS Agosto
			,(
				CASE 
					WHEN SUM(AV.Septiembre) > 0
						AND SUM(q1.AASeptiembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
					END
				) AS Septiembre
			,(
				CASE 
					WHEN SUM(AV.Octubre) > 0
						AND SUM(q1.AAOctubre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
					END
				) AS Octubre
			,(
				CASE 
					WHEN SUM(AV.Noviembre) > 0
						AND SUM(q1.AANoviembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
					END
				) AS Noviembre
			,(
				CASE 
					WHEN SUM(AV.Diciembre) > 0
						AND SUM(q1.AADiciembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
					END
				) AS Diciembre
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) > 0
						AND SUM(q1.AAEne_Mar) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
					END
				) AS Ene_Mar
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) > 0
						AND SUM(q1.AAAbr_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
					END
				) AS Abr_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) > 0
						AND SUM(q1.AAJul_Sep) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
					END
				) AS Jul_Sep
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) > 0
						AND SUM(q1.AAOct_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
					END
				) AS Oct_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Jun) > 0
						AND SUM(q1.AAEne_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
					END
				) AS Ene_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Dic) > 0
						AND SUM(q1.AAJul_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
					END
				) AS Jul_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Dic) > 0
						AND SUM(q1.AAEne_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Dic
			,CAST(@añoenCurso AS INT)
			,AV.segmento_id
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
				,AA.compania_id
				,AA.lineaNegocio_id
				,AA.ramo_id
				,AA.producto_id
				,AA.localidad_id
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
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 1
			GROUP BY AA.clave
				,AA.participante_id
				,AA.compania_id
				,AA.ramo_id
				,AA.producto_id
				,AA.localidad_id
				,AA.lineaNegocio_id
			) AS q1 ON AV.clave = q1.clave
			AND AV.compania_id = q1.compania_id
			AND AV.ramo_id = q1.ramo_id
			AND AV.producto_id = q1.producto_id
			AND AV.lineaNegocio_id = q1.lineaNegocio_id
			AND AV.localidad_id = q1.localidad_id
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 1
		GROUP BY AV.clave
			,AV.participante_id
			,AV.compania_id
			,AV.ramo_id
			,AV.producto_id
			,AV.lineaNegocio_id
			,AV.localidad_id
			,AV.zona_id
			,AV.plazo_id
			,AV.amparo_id
			,AV.modalidadPago_id
			,AV.segmento_id
			,q1.AAEnero
			,q1.AAFebrero
			,q1.AAMarzo
			,q1.AAAbril
			,q1.AAMayo
			,q1.AAJunio
			,q1.AAJulio
			,q1.AAAgosto
			,q1.AASeptiembre
			,q1.AAOctubre
			,q1.AANoviembre
			,q1.AADiciembre
			,q1.AAEne_Mar
			,q1.AAAbr_Jun
			,q1.AAJul_Sep
			,q1.AAOct_Dic
			,q1.AAEne_Jun
			,q1.AAJul_Dic
			,q1.AAEne_Dic

		PRINT 'Crecimiento y cumplimiento x valor del recaudo'

		--  CUMPLIMIENTO EN COLQUINES (tipomedida: 7): Toma el valor Consolidado por colquines de recaudos,  tipomedida: 2
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Enero
			,Febrero
			,Marzo
			,Abril
			,Mayo
			,Junio
			,Julio
			,Agosto
			,Septiembre
			,Octubre
			,Noviembre
			,Diciembre
			,Ene_Mar
			,Abr_Jun
			,Jul_Sep
			,Oct_Dic
			,Ene_Jun
			,Jul_Dic
			,Ene_Dic
			,Ene_Mar_Total
			,Abr_Jun_Total
			,Jul_Sep_Total
			,Oct_Dic_Total
			,Etapa_1
			,Etapa_2
			,Etapa_3
			,Etapa_4
			,Etapa_5
			,año
			,segmento_id
			)
		SELECT AV.compania_id
			,AV.ramo_id
			,AV.producto_id
			,7 AS CumplimientoColquines
			,AV.zona_id
			,AV.localidad_id
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,AV.lineaNegocio_id
			,AV.plazo_id
			,AV.amparo_id
			,AV.modalidadPago_id
			,(
				CASE 
					WHEN SUM(AV.Enero) IS NOT NULL
						AND (
							SUM(q1.AAEnero) IS NULL
							OR SUM(q1.AAEnero) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
					END
				) AS Enero
			,(
				CASE 
					WHEN SUM(AV.Febrero) IS NOT NULL
						AND (
							SUM(q1.AAFebrero) IS NULL
							OR SUM(q1.AAFebrero) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
					END
				) AS Febrero
			,(
				CASE 
					WHEN SUM(AV.Marzo) IS NOT NULL
						AND (
							SUM(q1.AAMarzo) IS NULL
							OR SUM(q1.AAMarzo) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
					END
				) AS Marzo
			,(
				CASE 
					WHEN SUM(AV.Abril) IS NOT NULL
						AND (
							SUM(q1.AAAbril) IS NULL
							OR SUM(q1.AAAbril) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
					END
				) AS Abril
			,(
				CASE 
					WHEN SUM(AV.Mayo) IS NOT NULL
						AND (
							SUM(q1.AAMayo) IS NULL
							OR SUM(q1.AAMayo) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
					END
				) AS Mayo
			,(
				CASE 
					WHEN SUM(AV.Junio) IS NOT NULL
						AND (
							SUM(q1.AAJunio) IS NULL
							OR SUM(q1.AAJunio) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
					END
				) AS Junio
			,(
				CASE 
					WHEN SUM(AV.Julio) IS NOT NULL
						AND (
							SUM(q1.AAJulio) IS NULL
							OR SUM(q1.AAJulio) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
					END
				) AS Julio
			,(
				CASE 
					WHEN SUM(AV.Agosto) IS NOT NULL
						AND (
							SUM(q1.AAAgosto) IS NULL
							OR SUM(q1.AAAgosto) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
					END
				) AS Agosto
			,(
				CASE 
					WHEN SUM(AV.Septiembre) IS NOT NULL
						AND (
							SUM(q1.AASeptiembre) IS NULL
							OR SUM(q1.AASeptiembre) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
					END
				) AS Septiembre
			,(
				CASE 
					WHEN SUM(AV.Octubre) IS NOT NULL
						AND (
							SUM(q1.AAOctubre) IS NULL
							OR SUM(q1.AAOctubre) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
					END
				) AS Octubre
			,(
				CASE 
					WHEN SUM(AV.Noviembre) IS NOT NULL
						AND (
							SUM(q1.AANoviembre) IS NULL
							OR SUM(q1.AANoviembre) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
					END
				) AS Noviembre
			,(
				CASE 
					WHEN SUM(AV.Diciembre) IS NOT NULL
						AND (
							SUM(q1.AADiciembre) IS NULL
							OR SUM(q1.AADiciembre) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
					END
				) AS Diciembre
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) IS NOT NULL
						AND (
							SUM(q1.AAEne_Mar) IS NULL
							OR SUM(q1.AAEne_Mar) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
					END
				) AS Ene_Mar
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) IS NOT NULL
						AND (
							SUM(q1.AAAbr_Jun) IS NULL
							OR SUM(q1.AAAbr_Jun) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
					END
				) AS Abr_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) IS NOT NULL
						AND (
							SUM(q1.AAJul_Sep) IS NULL
							OR SUM(q1.AAJul_Sep) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
					END
				) AS Jul_Sep
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) IS NOT NULL
						AND (
							SUM(q1.AAOct_Dic) IS NULL
							OR SUM(q1.AAOct_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
					END
				) AS Oct_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Jun) IS NOT NULL
						AND (
							SUM(q1.AAEne_Jun) IS NULL
							OR SUM(q1.AAEne_Jun) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
					END
				) AS Ene_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Dic) IS NOT NULL
						AND (
							SUM(q1.AAJul_Dic) IS NULL
							OR SUM(q1.AAJul_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
					END
				) AS Jul_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Dic) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Mar_Total
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Abr_Jun_Total
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Jul_Sep_Total
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Oct_Dic_Total
			,(
				CASE 
					WHEN SUM(AV.Etapa_1) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_1) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_1
			,(
				CASE 
					WHEN SUM(AV.Etapa_2) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_2) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_2
			,(
				CASE 
					WHEN SUM(AV.Etapa_3) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_3) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_3
			,(
				CASE 
					WHEN SUM(AV.Etapa_4) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_4) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_4
			,(
				CASE 
					WHEN SUM(AV.Etapa_5) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_5) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_5
			,CAST(@añoenCurso AS INT)
			,0
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
				,AA.compania_id
				,AA.lineaNegocio_id
				,AA.ramo_id
				,AA.producto_id
				,AA.localidad_id
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
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 2
			GROUP BY AA.clave
				,AA.participante_id
				,AA.compania_id
				,AA.ramo_id
				,AA.producto_id
				,AA.localidad_id
				,AA.lineaNegocio_id
			) AS q1 ON AV.clave = q1.clave
			AND AV.compania_id = q1.compania_id
			AND AV.ramo_id = q1.ramo_id
			AND AV.producto_id = q1.producto_id
			AND AV.lineaNegocio_id = q1.lineaNegocio_id
			AND AV.localidad_id = q1.localidad_id
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 2
		GROUP BY AV.clave
			,AV.participante_id
			,AV.compania_id
			,AV.ramo_id
			,AV.producto_id
			,AV.lineaNegocio_id
			,AV.localidad_id
			,AV.zona_id
			,AV.plazo_id
			,AV.amparo_id
			,AV.modalidadPago_id
			,AV.segmento_id
			,q1.AAEnero
			,q1.AAFebrero
			,q1.AAMarzo
			,q1.AAAbril
			,q1.AAMayo
			,q1.AAJunio
			,q1.AAJulio
			,q1.AAAgosto
			,q1.AASeptiembre
			,q1.AAOctubre
			,q1.AANoviembre
			,q1.AADiciembre
			,q1.AAEne_Mar
			,q1.AAAbr_Jun
			,q1.AAJul_Sep
			,q1.AAOct_Dic
			,q1.AAEne_Jun
			,q1.AAJul_Dic
			,q1.AAEne_Dic

		PRINT 'Crecimiento y cumplimiento en Colquines'

		--  CUMPLIMIENTO EN NEGOCIOS (tipomedida: 8): Toma el valor Consolidado por cantidad de negocios,  tipomedida: 4
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Enero
			,Febrero
			,Marzo
			,Abril
			,Mayo
			,Junio
			,Julio
			,Agosto
			,Septiembre
			,Octubre
			,Noviembre
			,Diciembre
			,Ene_Mar
			,Abr_Jun
			,Jul_Sep
			,Oct_Dic
			,Ene_Jun
			,Jul_Dic
			,Ene_Dic
			,año
			,segmento_id
			)
		SELECT AV.compania_id
			,AV.ramo_id
			,AV.producto_id
			,8 AS cumplimientoNegocios
			,AV.zona_id
			,AV.localidad_id
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,AV.lineaNegocio_id
			,AV.plazo_id
			,AV.amparo_id
			,AV.modalidadPago_id
			,(
				CASE 
					WHEN SUM(AV.Enero) > 0
						AND SUM(q1.AAEnero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
					END
				) AS Enero
			,(
				CASE 
					WHEN SUM(AV.Febrero) > 0
						AND SUM(q1.AAFebrero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
					END
				) AS Febrero
			,(
				CASE 
					WHEN SUM(AV.Marzo) > 0
						AND SUM(q1.AAMarzo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
					END
				) AS Marzo
			,(
				CASE 
					WHEN SUM(AV.Abril) > 0
						AND SUM(q1.AAAbril) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
					END
				) AS Abril
			,(
				CASE 
					WHEN SUM(AV.Mayo) > 0
						AND SUM(q1.AAMayo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
					END
				) AS Mayo
			,(
				CASE 
					WHEN SUM(AV.Junio) > 0
						AND SUM(q1.AAJunio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
					END
				) AS Junio
			,(
				CASE 
					WHEN SUM(AV.Julio) > 0
						AND SUM(q1.AAJulio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
					END
				) AS Julio
			,(
				CASE 
					WHEN SUM(AV.Agosto) > 0
						AND SUM(q1.AAAgosto) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
					END
				) AS Agosto
			,(
				CASE 
					WHEN SUM(AV.Septiembre) > 0
						AND SUM(q1.AASeptiembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
					END
				) AS Septiembre
			,(
				CASE 
					WHEN SUM(AV.Octubre) > 0
						AND SUM(q1.AAOctubre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
					END
				) AS Octubre
			,(
				CASE 
					WHEN SUM(AV.Noviembre) > 0
						AND SUM(q1.AANoviembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
					END
				) AS Noviembre
			,(
				CASE 
					WHEN SUM(AV.Diciembre) > 0
						AND SUM(q1.AADiciembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
					END
				) AS Diciembre
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) > 0
						AND SUM(q1.AAEne_Mar) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
					END
				) AS Ene_Mar
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) > 0
						AND SUM(q1.AAAbr_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
					END
				) AS Abr_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) > 0
						AND SUM(q1.AAJul_Sep) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
					END
				) AS Jul_Sep
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) > 0
						AND SUM(q1.AAOct_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
					END
				) AS Oct_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Jun) > 0
						AND SUM(q1.AAEne_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
					END
				) AS Ene_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Dic) > 0
						AND SUM(q1.AAJul_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
					END
				) AS Jul_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Dic) > 0
						AND SUM(q1.AAEne_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Dic
			,CAST(@añoenCurso AS INT)
			,AV.segmento_id
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
				,AA.compania_id
				,AA.lineaNegocio_id
				,AA.ramo_id
				,AA.producto_id
				,AA.localidad_id
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
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 4
			GROUP BY AA.clave
				,AA.participante_id
				,AA.compania_id
				,AA.ramo_id
				,AA.producto_id
				,AA.localidad_id
				,AA.lineaNegocio_id
			) AS q1 ON AV.clave = q1.clave
			AND AV.compania_id = q1.compania_id
			AND AV.ramo_id = q1.ramo_id
			AND AV.producto_id = q1.producto_id
			AND AV.lineaNegocio_id = q1.lineaNegocio_id
			AND AV.localidad_id = q1.localidad_id
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 4
		GROUP BY AV.clave
			,AV.participante_id
			,AV.compania_id
			,AV.ramo_id
			,AV.producto_id
			,AV.lineaNegocio_id
			,AV.localidad_id
			,AV.zona_id
			,AV.plazo_id
			,AV.amparo_id
			,AV.modalidadPago_id
			,AV.segmento_id
			,q1.AAEnero
			,q1.AAFebrero
			,q1.AAMarzo
			,q1.AAAbril
			,q1.AAMayo
			,q1.AAJunio
			,q1.AAJulio
			,q1.AAAgosto
			,q1.AASeptiembre
			,q1.AAOctubre
			,q1.AANoviembre
			,q1.AADiciembre
			,q1.AAEne_Mar
			,q1.AAAbr_Jun
			,q1.AAJul_Sep
			,q1.AAOct_Dic
			,q1.AAEne_Jun
			,q1.AAJul_Dic
			,q1.AAEne_Dic

		PRINT 'Crecimiento y cumplimiento en cantidad de Negocios'

		--------------------------------------------  CRECIMIENTOS TOTALES X CLAVE
		-- En Recaudos, Colquines, Primas y Negocios se calcula el crecimiento del año vigente vs. año anterior: ((año Vigente - año Anterior) *100) / año Vigente
		-- Solamente se agrupa por participante, ya que para la liquidación de reglas no se requiere de agrupación por otros criterios.
		--  CUMPLIMIENTO EN PRIMAS (tipomedida: 5): Toma el valor Consolidado por Primas de negocios,  tipomedida: 3
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Enero
			,Febrero
			,Marzo
			,Abril
			,Mayo
			,Junio
			,Julio
			,Agosto
			,Septiembre
			,Octubre
			,Noviembre
			,Diciembre
			,Ene_Mar
			,Abr_Jun
			,Jul_Sep
			,Oct_Dic
			,Ene_Jun
			,Jul_Dic
			,Ene_Dic
			,año
			,segmento_id
			)
		SELECT 0
			,0
			,0
			,5 AS cumplimientoPrimas
			,0
			,0
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,0
			,0
			,0
			,0
			,(
				CASE 
					WHEN SUM(AV.Enero) > 0
						AND SUM(q1.AAEnero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
					END
				) AS Enero
			,(
				CASE 
					WHEN SUM(AV.Febrero) > 0
						AND SUM(q1.AAFebrero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
					END
				) AS Febrero
			,(
				CASE 
					WHEN SUM(AV.Marzo) > 0
						AND SUM(q1.AAMarzo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
					END
				) AS Marzo
			,(
				CASE 
					WHEN SUM(AV.Abril) > 0
						AND SUM(q1.AAAbril) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
					END
				) AS Abril
			,(
				CASE 
					WHEN SUM(AV.Mayo) > 0
						AND SUM(q1.AAMayo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
					END
				) AS Mayo
			,(
				CASE 
					WHEN SUM(AV.Junio) > 0
						AND SUM(q1.AAJunio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
					END
				) AS Junio
			,(
				CASE 
					WHEN SUM(AV.Julio) > 0
						AND SUM(q1.AAJulio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
					END
				) AS Julio
			,(
				CASE 
					WHEN SUM(AV.Agosto) > 0
						AND SUM(q1.AAAgosto) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
					END
				) AS Agosto
			,(
				CASE 
					WHEN SUM(AV.Septiembre) > 0
						AND SUM(q1.AASeptiembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
					END
				) AS Septiembre
			,(
				CASE 
					WHEN SUM(AV.Octubre) > 0
						AND SUM(q1.AAOctubre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
					END
				) AS Octubre
			,(
				CASE 
					WHEN SUM(AV.Noviembre) > 0
						AND SUM(q1.AANoviembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
					END
				) AS Noviembre
			,(
				CASE 
					WHEN SUM(AV.Diciembre) > 0
						AND SUM(q1.AADiciembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
					END
				) AS Diciembre
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) > 0
						AND SUM(q1.AAEne_Mar) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
					END
				) AS Ene_Mar
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) > 0
						AND SUM(q1.AAAbr_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
					END
				) AS Abr_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) > 0
						AND SUM(q1.AAJul_Sep) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
					END
				) AS Jul_Sep
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) > 0
						AND SUM(q1.AAOct_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
					END
				) AS Oct_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Jun) > 0
						AND SUM(q1.AAEne_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
					END
				) AS Ene_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Dic) > 0
						AND SUM(q1.AAJul_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
					END
				) AS Jul_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Dic) > 0
						AND SUM(q1.AAEne_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Dic
			,CAST(@añoenCurso AS INT)
			,0
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
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
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 3
			GROUP BY AA.clave
				,AA.participante_id
			) AS q1 ON AV.clave = q1.clave
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 3
		GROUP BY AV.clave
			,AV.participante_id
			,q1.AAEnero
			,q1.AAFebrero
			,q1.AAMarzo
			,q1.AAAbril
			,q1.AAMayo
			,q1.AAJunio
			,q1.AAJulio
			,q1.AAAgosto
			,q1.AASeptiembre
			,q1.AAOctubre
			,q1.AANoviembre
			,q1.AADiciembre
			,q1.AAEne_Mar
			,q1.AAAbr_Jun
			,q1.AAJul_Sep
			,q1.AAOct_Dic
			,q1.AAEne_Jun
			,q1.AAJul_Dic
			,q1.AAEne_Dic

		PRINT 'Crecimiento y cumplimiento en Primas sin agrupación (comparación clave)'

		--  CUMPLIMIENTO EN RECAUDOS (tipomedida: 6): Toma el valor Consolidado por valor de recaudo,  tipomedida: 1
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Enero
			,Febrero
			,Marzo
			,Abril
			,Mayo
			,Junio
			,Julio
			,Agosto
			,Septiembre
			,Octubre
			,Noviembre
			,Diciembre
			,Ene_Mar
			,Abr_Jun
			,Jul_Sep
			,Oct_Dic
			,Ene_Jun
			,Jul_Dic
			,Ene_Dic
			,año
			,segmento_id
			)
		SELECT 0
			,0
			,0
			,6 AS cumplimientoRecaudos
			,0
			,0
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,0
			,0
			,0
			,0
			,(
				CASE 
					WHEN SUM(AV.Enero) > 0
						AND SUM(q1.AAEnero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
					END
				) AS Enero
			,(
				CASE 
					WHEN SUM(AV.Febrero) > 0
						AND SUM(q1.AAFebrero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
					END
				) AS Febrero
			,(
				CASE 
					WHEN SUM(AV.Marzo) > 0
						AND SUM(q1.AAMarzo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
					END
				) AS Marzo
			,(
				CASE 
					WHEN SUM(AV.Abril) > 0
						AND SUM(q1.AAAbril) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
					END
				) AS Abril
			,(
				CASE 
					WHEN SUM(AV.Mayo) > 0
						AND SUM(q1.AAMayo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
					END
				) AS Mayo
			,(
				CASE 
					WHEN SUM(AV.Junio) > 0
						AND SUM(q1.AAJunio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
					END
				) AS Junio
			,(
				CASE 
					WHEN SUM(AV.Julio) > 0
						AND SUM(q1.AAJulio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
					END
				) AS Julio
			,(
				CASE 
					WHEN SUM(AV.Agosto) > 0
						AND SUM(q1.AAAgosto) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
					END
				) AS Agosto
			,(
				CASE 
					WHEN SUM(AV.Septiembre) > 0
						AND SUM(q1.AASeptiembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
					END
				) AS Septiembre
			,(
				CASE 
					WHEN SUM(AV.Octubre) > 0
						AND SUM(q1.AAOctubre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
					END
				) AS Octubre
			,(
				CASE 
					WHEN SUM(AV.Noviembre) > 0
						AND SUM(q1.AANoviembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
					END
				) AS Noviembre
			,(
				CASE 
					WHEN SUM(AV.Diciembre) > 0
						AND SUM(q1.AADiciembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
					END
				) AS Diciembre
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) > 0
						AND SUM(q1.AAEne_Mar) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
					END
				) AS Ene_Mar
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) > 0
						AND SUM(q1.AAAbr_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
					END
				) AS Abr_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) > 0
						AND SUM(q1.AAJul_Sep) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
					END
				) AS Jul_Sep
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) > 0
						AND SUM(q1.AAOct_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
					END
				) AS Oct_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Jun) > 0
						AND SUM(q1.AAEne_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
					END
				) AS Ene_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Dic) > 0
						AND SUM(q1.AAJul_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
					END
				) AS Jul_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Dic) > 0
						AND SUM(q1.AAEne_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Dic
			,CAST(@añoenCurso AS INT)
			,0
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
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
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 1
			GROUP BY AA.clave
				,AA.participante_id
			) AS q1 ON AV.clave = q1.clave
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 1
		GROUP BY AV.clave
			,AV.participante_id
			,q1.AAEnero
			,q1.AAFebrero
			,q1.AAMarzo
			,q1.AAAbril
			,q1.AAMayo
			,q1.AAJunio
			,q1.AAJulio
			,q1.AAAgosto
			,q1.AASeptiembre
			,q1.AAOctubre
			,q1.AANoviembre
			,q1.AADiciembre
			,q1.AAEne_Mar
			,q1.AAAbr_Jun
			,q1.AAJul_Sep
			,q1.AAOct_Dic
			,q1.AAEne_Jun
			,q1.AAJul_Dic
			,q1.AAEne_Dic

		PRINT 'Crecimiento y cumplimiento x valor del Recaudo sin agrupación (comparación clave)'

		--  CUMPLIMIENTO EN COLQUINES (tipomedida: 7): Toma el valor Consolidado por Colquines de recaudo,  tipomedida: 2		
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Enero
			,Febrero
			,Marzo
			,Abril
			,Mayo
			,Junio
			,Julio
			,Agosto
			,Septiembre
			,Octubre
			,Noviembre
			,Diciembre
			,Ene_Mar
			,Abr_Jun
			,Jul_Sep
			,Oct_Dic
			,Ene_Jun
			,Jul_Dic
			,Ene_Dic
			,Ene_Mar_Total
			,Abr_Jun_Total
			,Jul_Sep_Total
			,Oct_Dic_Total
			,Etapa_1
			,Etapa_2
			,Etapa_3
			,Etapa_4
			,Etapa_5
			,año
			,segmento_id
			)
		SELECT 0
			,0
			,0
			,7 AS CumplimientoColquines
			,0
			,0
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,0
			,0
			,0
			,0
			,(
				CASE 
					WHEN SUM(AV.Enero) IS NOT NULL
						AND (
							SUM(q1.AAEnero) IS NULL
							OR SUM(q1.AAEnero) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
					END
				) AS Enero
			,(
				CASE 
					WHEN SUM(AV.Febrero) IS NOT NULL
						AND (
							SUM(q1.AAFebrero) IS NULL
							OR SUM(q1.AAFebrero) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
					END
				) AS Febrero
			,(
				CASE 
					WHEN SUM(AV.Marzo) IS NOT NULL
						AND (
							SUM(q1.AAMarzo) IS NULL
							OR SUM(q1.AAMarzo) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
					END
				) AS Marzo
			,(
				CASE 
					WHEN SUM(AV.Abril) IS NOT NULL
						AND (
							SUM(q1.AAAbril) IS NULL
							OR SUM(q1.AAAbril) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
					END
				) AS Abril
			,(
				CASE 
					WHEN SUM(AV.Mayo) IS NOT NULL
						AND (
							SUM(q1.AAMayo) IS NULL
							OR SUM(q1.AAMayo) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
					END
				) AS Mayo
			,(
				CASE 
					WHEN SUM(AV.Junio) IS NOT NULL
						AND (
							SUM(q1.AAJunio) IS NULL
							OR SUM(q1.AAJunio) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
					END
				) AS Junio
			,(
				CASE 
					WHEN SUM(AV.Julio) IS NOT NULL
						AND (
							SUM(q1.AAJulio) IS NULL
							OR SUM(q1.AAJulio) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
					END
				) AS Julio
			,(
				CASE 
					WHEN SUM(AV.Agosto) IS NOT NULL
						AND (
							SUM(q1.AAAgosto) IS NULL
							OR SUM(q1.AAAgosto) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
					END
				) AS Agosto
			,(
				CASE 
					WHEN SUM(AV.Septiembre) IS NOT NULL
						AND (
							SUM(q1.AASeptiembre) IS NULL
							OR SUM(q1.AASeptiembre) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
					END
				) AS Septiembre
			,(
				CASE 
					WHEN SUM(AV.Octubre) IS NOT NULL
						AND (
							SUM(q1.AAOctubre) IS NULL
							OR SUM(q1.AAOctubre) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
					END
				) AS Octubre
			,(
				CASE 
					WHEN SUM(AV.Noviembre) IS NOT NULL
						AND (
							SUM(q1.AANoviembre) IS NULL
							OR SUM(q1.AANoviembre) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
					END
				) AS Noviembre
			,(
				CASE 
					WHEN SUM(AV.Diciembre) IS NOT NULL
						AND (
							SUM(q1.AADiciembre) IS NULL
							OR SUM(q1.AADiciembre) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
					END
				) AS Diciembre
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) IS NOT NULL
						AND (
							SUM(q1.AAEne_Mar) IS NULL
							OR SUM(q1.AAEne_Mar) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
					END
				) AS Ene_Mar
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) IS NOT NULL
						AND (
							SUM(q1.AAAbr_Jun) IS NULL
							OR SUM(q1.AAAbr_Jun) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
					END
				) AS Abr_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) IS NOT NULL
						AND (
							SUM(q1.AAJul_Sep) IS NULL
							OR SUM(q1.AAJul_Sep) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
					END
				) AS Jul_Sep
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) IS NOT NULL
						AND (
							SUM(q1.AAOct_Dic) IS NULL
							OR SUM(q1.AAOct_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
					END
				) AS Oct_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Jun) IS NOT NULL
						AND (
							SUM(q1.AAEne_Jun) IS NULL
							OR SUM(q1.AAEne_Jun) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
					END
				) AS Ene_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Dic) IS NOT NULL
						AND (
							SUM(q1.AAJul_Dic) IS NULL
							OR SUM(q1.AAJul_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
					END
				) AS Jul_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Dic) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Mar_Total
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Abr_Jun_Total
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Jul_Sep_Total
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) IS NOT NULL
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Oct_Dic_Total
			,(
				CASE 
					WHEN SUM(AV.Etapa_1) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_1) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_1
			,(
				CASE 
					WHEN SUM(AV.Etapa_2) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_2) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_2
			,(
				CASE 
					WHEN SUM(AV.Etapa_3) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_3) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_3
			,(
				CASE 
					WHEN SUM(AV.Etapa_4) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_4) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_4
			,(
				CASE 
					WHEN SUM(AV.Etapa_5) >= 0
						AND (
							SUM(q1.AAEne_Dic) IS NULL
							OR SUM(q1.AAEne_Dic) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_5) * 100)) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Etapa_5
			,CAST(@añoenCurso AS INT)
			,0
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
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
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 2
			GROUP BY AA.clave
				,AA.participante_id
			) AS q1 ON AV.clave = q1.clave
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 2
		GROUP BY AV.clave
			,AV.participante_id
			,q1.AAEnero
			,q1.AAFebrero
			,q1.AAMarzo
			,q1.AAAbril
			,q1.AAMayo
			,q1.AAJunio
			,q1.AAJulio
			,q1.AAAgosto
			,q1.AASeptiembre
			,q1.AAOctubre
			,q1.AANoviembre
			,q1.AADiciembre
			,q1.AAEne_Mar
			,q1.AAAbr_Jun
			,q1.AAJul_Sep
			,q1.AAOct_Dic
			,q1.AAEne_Jun
			,q1.AAJul_Dic
			,q1.AAEne_Dic

		PRINT 'Crecimiento y cumplimiento en Colquines sin agrupación (comparación clave)'

		--  CUMPLIMIENTO EN NEGOCIOS (tipomedida: 8): Toma el valor Consolidado por cantidad de negocios,  tipomedida: 4
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Enero
			,Febrero
			,Marzo
			,Abril
			,Mayo
			,Junio
			,Julio
			,Agosto
			,Septiembre
			,Octubre
			,Noviembre
			,Diciembre
			,Ene_Mar
			,Abr_Jun
			,Jul_Sep
			,Oct_Dic
			,Ene_Jun
			,Jul_Dic
			,Ene_Dic
			,año
			,segmento_id
			)
		SELECT 0
			,0
			,0
			,8 AS cumplimientoNegocios
			,0
			,0
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,0
			,0
			,0
			,0
			,(
				CASE 
					WHEN SUM(AV.Enero) > 0
						AND SUM(q1.AAEnero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Enero) - q1.AAEnero) * 100) / NULLIF(q1.AAEnero, 0), NULL))
					END
				) AS Enero
			,(
				CASE 
					WHEN SUM(AV.Febrero) > 0
						AND SUM(q1.AAFebrero) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Febrero) - q1.AAFebrero) * 100) / NULLIF(q1.AAFebrero, 0), NULL))
					END
				) AS Febrero
			,(
				CASE 
					WHEN SUM(AV.Marzo) > 0
						AND SUM(q1.AAMarzo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Marzo) - q1.AAMarzo) * 100) / NULLIF(q1.AAMarzo, 0), NULL))
					END
				) AS Marzo
			,(
				CASE 
					WHEN SUM(AV.Abril) > 0
						AND SUM(q1.AAAbril) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abril) - q1.AAAbril) * 100) / NULLIF(q1.AAAbril, 0), NULL))
					END
				) AS Abril
			,(
				CASE 
					WHEN SUM(AV.Mayo) > 0
						AND SUM(q1.AAMayo) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Mayo) - q1.AAMayo) * 100) / NULLIF(q1.AAMayo, 0), NULL))
					END
				) AS Mayo
			,(
				CASE 
					WHEN SUM(AV.Junio) > 0
						AND SUM(q1.AAJunio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Junio) - q1.AAJunio) * 100) / NULLIF(q1.AAJunio, 0), NULL))
					END
				) AS Junio
			,(
				CASE 
					WHEN SUM(AV.Julio) > 0
						AND SUM(q1.AAJulio) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Julio) - q1.AAJulio) * 100) / NULLIF(q1.AAJulio, 0), NULL))
					END
				) AS Julio
			,(
				CASE 
					WHEN SUM(AV.Agosto) > 0
						AND SUM(q1.AAAgosto) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Agosto) - q1.AAAgosto) * 100) / NULLIF(q1.AAAgosto, 0), NULL))
					END
				) AS Agosto
			,(
				CASE 
					WHEN SUM(AV.Septiembre) > 0
						AND SUM(q1.AASeptiembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Septiembre) - q1.AASeptiembre) * 100) / NULLIF(q1.AASeptiembre, 0), NULL))
					END
				) AS Septiembre
			,(
				CASE 
					WHEN SUM(AV.Octubre) > 0
						AND SUM(q1.AAOctubre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Octubre) - q1.AAOctubre) * 100) / NULLIF(q1.AAOctubre, 0), NULL))
					END
				) AS Octubre
			,(
				CASE 
					WHEN SUM(AV.Noviembre) > 0
						AND SUM(q1.AANoviembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Noviembre) - q1.AANoviembre) * 100) / NULLIF(q1.AANoviembre, 0), NULL))
					END
				) AS Noviembre
			,(
				CASE 
					WHEN SUM(AV.Diciembre) > 0
						AND SUM(q1.AADiciembre) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Diciembre) - q1.AADiciembre) * 100) / NULLIF(q1.AADiciembre, 0), NULL))
					END
				) AS Diciembre
			,(
				CASE 
					WHEN SUM(AV.Ene_Mar) > 0
						AND SUM(q1.AAEne_Mar) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Mar) - q1.AAEne_Mar) * 100) / NULLIF(q1.AAEne_Mar, 0), NULL))
					END
				) AS Ene_Mar
			,(
				CASE 
					WHEN SUM(AV.Abr_Jun) > 0
						AND SUM(q1.AAAbr_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Abr_Jun) - q1.AAAbr_Jun) * 100) / NULLIF(q1.AAAbr_Jun, 0), NULL))
					END
				) AS Abr_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Sep) > 0
						AND SUM(q1.AAJul_Sep) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Sep) - q1.AAJul_Sep) * 100) / NULLIF(q1.AAJul_Sep, 0), NULL))
					END
				) AS Jul_Sep
			,(
				CASE 
					WHEN SUM(AV.Oct_Dic) > 0
						AND SUM(q1.AAOct_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Oct_Dic) - q1.AAOct_Dic) * 100) / NULLIF(q1.AAOct_Dic, 0), NULL))
					END
				) AS Oct_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Jun) > 0
						AND SUM(q1.AAEne_Jun) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Jun) - q1.AAEne_Jun) * 100) / NULLIF(q1.AAEne_Jun, 0), NULL))
					END
				) AS Ene_Jun
			,(
				CASE 
					WHEN SUM(AV.Jul_Dic) > 0
						AND SUM(q1.AAJul_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Jul_Dic) - q1.AAJul_Dic) * 100) / NULLIF(q1.AAJul_Dic, 0), NULL))
					END
				) AS Jul_Dic
			,(
				CASE 
					WHEN SUM(AV.Ene_Dic) > 0
						AND SUM(q1.AAEne_Dic) IS NULL
						THEN 100
					ELSE (ISNULL(((SUM(AV.Ene_Dic) - q1.AAEne_Dic) * 100) / NULLIF(q1.AAEne_Dic, 0), NULL))
					END
				) AS Ene_Dic
			,CAST(@añoenCurso AS INT)
			,0
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
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
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 4
			GROUP BY AA.clave
				,AA.participante_id
			) AS q1 ON AV.clave = q1.clave
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 4
		GROUP BY AV.clave
			,AV.participante_id
			,q1.AAEnero
			,q1.AAFebrero
			,q1.AAMarzo
			,q1.AAAbril
			,q1.AAMayo
			,q1.AAJunio
			,q1.AAJulio
			,q1.AAAgosto
			,q1.AASeptiembre
			,q1.AAOctubre
			,q1.AANoviembre
			,q1.AADiciembre
			,q1.AAEne_Mar
			,q1.AAAbr_Jun
			,q1.AAJul_Sep
			,q1.AAOct_Dic
			,q1.AAEne_Jun
			,q1.AAJul_Dic
			,q1.AAEne_Dic

		PRINT 'Crecimiento y cumplimiento x cantidad de negocios sin agrupación (comparación clave)'

		--  CRECIMIENTO EN COLQUINES (tipomedida: 18): Calcula el crecimiento del Colquines x Etapa (sin filtros)
		INSERT INTO ConsolidadoMes (
			compania_id
			,ramo_id
			,producto_id
			,tipoMedida_id
			,zona_id
			,localidad_id
			,clave
			,participante_id
			,lineaNegocio_id
			,plazo_id
			,amparo_id
			,modalidadPago_id
			,Etapa_1
			,Etapa_2
			,Etapa_3
			,Etapa_4
			,Etapa_5
			,año
			,segmento_id
			)
		SELECT 0
			,0
			,0
			,18 AS CrecimientoColquines
			,0
			,0
			,RTRIM(LTRIM(AV.clave))
			,AV.participante_id
			,0
			,0
			,0
			,0
			,(
				CASE 
					WHEN SUM(AV.Etapa_1) > 0
						AND (
							SUM(q1.AAEtapa_1) IS NULL
							OR SUM(q1.AAEtapa_1) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_1) - q1.AAEtapa_1) * 100) / NULLIF(q1.AAEtapa_1, 0), NULL))
					END
				) AS Etapa_1
			,(
				CASE 
					WHEN SUM(AV.Etapa_2) > 0
						AND (
							SUM(q1.AAEtapa_2) IS NULL
							OR SUM(q1.AAEtapa_2) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_2) - q1.AAEtapa_2) * 100) / NULLIF(q1.AAEtapa_2, 0), NULL))
					END
				) AS Etapa_2
			,(
				CASE 
					WHEN SUM(AV.Etapa_3) > 0
						AND (
							SUM(q1.AAEtapa_3) IS NULL
							OR SUM(q1.AAEtapa_3) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_3) - q1.AAEtapa_3) * 100) / NULLIF(q1.AAEtapa_3, 0), NULL))
					END
				) AS Etapa_3
			,(
				CASE 
					WHEN SUM(AV.Etapa_4) > 0
						AND (
							SUM(q1.AAEtapa_4) IS NULL
							OR SUM(q1.AAEtapa_4) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_4) - q1.AAEtapa_4) * 100) / NULLIF(q1.AAEtapa_4, 0), NULL))
					END
				) AS Etapa_4
			,(
				CASE 
					WHEN SUM(AV.Etapa_5) > 0
						AND (
							SUM(q1.AAEtapa_5) IS NULL
							OR SUM(q1.AAEtapa_5) = 0
							)
						THEN 100
					ELSE (ISNULL(((SUM(AV.Etapa_5) - q1.AAEtapa_5) * 100) / NULLIF(q1.AAEtapa_5, 0), NULL))
					END
				) AS Etapa_5
			,CAST(@añoenCurso AS INT)
			,0
		FROM ConsolidadoMes AV
		LEFT JOIN (
			SELECT RTRIM(LTRIM(AA.clave)) AS clave
				,SUM(AA.Etapa_1) AS AAEtapa_1
				,SUM(AA.Etapa_2) AS AAEtapa_2
				,SUM(AA.Etapa_3) AS AAEtapa_3
				,SUM(AA.Etapa_4) AS AAEtapa_4
				,SUM(AA.Etapa_5) AS AAEtapa_5
			FROM ConsolidadoMes AA
			WHERE AA.año = CAST(@añoenCurso - 1 AS INT)
				AND AA.tipoMedida_id = 2
			GROUP BY AA.clave
				,AA.participante_id
			) AS q1 ON AV.clave = q1.clave
		WHERE AV.año = CAST(@añoenCurso AS INT)
			AND AV.tipoMedida_id = 2
		GROUP BY AV.clave
			,AV.participante_id
			,q1.AAEtapa_1
			,q1.AAEtapa_2
			,q1.AAEtapa_3
			,q1.AAEtapa_4
			,q1.AAEtapa_5

		PRINT 'Crecimiento en Colquines sin agrupación (comparación clave)'	
		
		--- FIN ***************

		--  Actualización de la Zona
		UPDATE ConsolidadoMes
		SET zona_id = l.zona_id
		FROM ConsolidadoMes cm
		INNER JOIN Localidad AS l ON l.id = cm.localidad_id
		WHERE cm.año = @añoenCurso
			AND cm.zona_id IS NULL

		--  Actualización del Participante
		UPDATE ConsolidadoMes
		SET participante_id = p.id
		FROM ConsolidadoMes cm
		INNER JOIN Participante AS p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE cm.año = @añoenCurso
			AND cm.participante_id IS NULL

		-- Actualizacion categoria x participante
		UPDATE ConsolidadoMes
		SET categoria_id = p.categoria_id
		FROM ConsolidadoMes cm
		INNER JOIN Participante AS p ON p.id = cm.participante_id
		WHERE cm.año = @añoenCurso
			AND cm.categoria_id IS NULL

		-- Actualizacion fecha ingreso x participante
		UPDATE ConsolidadoMes
		SET fechaIngresoAsesor = p.fechaIngreso
		FROM ConsolidadoMes cm
		INNER JOIN Participante AS p ON p.id = cm.participante_id
		WHERE cm.año = @añoenCurso
			AND cm.fechaIngresoAsesor IS NULL

		--*********** Actualizacion Premios Anteriores ***********
		UPDATE ConsolidadoMes
		SET LIMRA = pa.año
		FROM ConsolidadoMes cm
		INNER JOIN PremiosAnteriores pa ON RTRIM(LTRIM(pa.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE cm.año = @añoenCurso
			AND pa.LIMRA = 1

		UPDATE ConsolidadoMes
		SET FASECOLDA = pa.año
		FROM ConsolidadoMes cm
		INNER JOIN PremiosAnteriores pa ON RTRIM(LTRIM(pa.clave)) = RTRIM(LTRIM(cm.clave))
		WHERE cm.año = @añoenCurso
			AND pa.FASECOLDA = 1

		UPDATE ConsolidadoMes
		SET plazo_id = 0
		WHERE plazo_id IS NULL

		IF EXISTS (
				SELECT *
				FROM sys.indexes
				WHERE object_id = OBJECT_ID(N'[dbo].[ConsolidadoMes]')
					AND NAME = N'IX_ConsolidadoMesxAño'
				)
			DROP INDEX [IX_ConsolidadoMesxAño] ON [dbo].[ConsolidadoMes]
			WITH (ONLINE = OFF)

		IF EXISTS (
				SELECT *
				FROM sys.indexes
				WHERE object_id = OBJECT_ID(N'[dbo].[ConsolidadoMes]')
					AND NAME = N'IX_ConsolidadoMesxNegocioZona'
				)
			DROP INDEX [IX_ConsolidadoMesxNegocioZona] ON [dbo].[ConsolidadoMes]
			WITH (ONLINE = OFF)

		SET @añoenCurso = @añoenCurso + 1
	END

	--*********** Actualizacion Premios Anteriores ***********
	--  Log Errores
	DECLARE @cantidadFinal AS INT = (SELECT COUNT(*) FROM ConsolidadoMes WHERE año = @añoenCurso)
	DECLARE @idActualizacion AS INT = (
		SELECT MAX(id) FROM LogIntegracion WHERE proceso = 'Generacion de los Consolidados x Clave'
		AND estado = 1
		)

	UPDATE LogIntegracion
	SET fechaFin = GETDATE()
		,estado = 2
		,cantidad = @cantidadFinal
	WHERE id = @idActualizacion
END
