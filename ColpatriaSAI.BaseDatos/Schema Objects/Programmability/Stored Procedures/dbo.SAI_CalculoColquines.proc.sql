-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Calculo de Colquines x Recaudo de acuerdo a las combinaciones parametrizadas en dbo.MonedaxNegocio.
--              Calculo de Topes x Moneda y Topes x Edad.
-- Modified date: 17/05/2012
-- Change Description: Se ajusta el calculo de Topes x Colquines para que sea por el total de recaudos de un mismo negocio y no recaudo a recaudo. --
-- =============================================
CREATE PROCEDURE [dbo].[SAI_CalculoColquines]
AS
BEGIN
	-- *********************************************************************************************************
	-- INICIO LOG ERRORES.
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
		,'Liquidación de Colquines'
		,1
		,'SAI'
		,'SAI'
		,'LiquidacionMoneda'
		)

	-- *********************************************************************************************************
	-- DECLARACIÓN DE PARAMETROS GENERALES DE PROCEDIMIENTO.
	-- *********************************************************************************************************--
	--  Borra los datos de la tabla LiquidacionMoneda con los tipo 1 --> Colquines, tipo 2 --> Siniestralidad, tipo 5 --> PersistenciaVIDA, 
	--  tipo 6 --> PersistenciaCAPI Corto Plazo, tipo 7 --> PersistenciaCAPI Corto Plazo, los cuales se calculan en el procedimiento que sigue.
	DELETE
	FROM LiquidacionMoneda
	WHERE tipo IN (
			1
			,2
			,5
			,6
			,7
			)
		AND anioCierreRecaudo IN (
			(YEAR(GETDATE()) - 1)
			,(YEAR(GETDATE()))
			)

	PRINT 'Borrar información de Liquidacion Moneda del año actual y anterior'

	DECLARE @maxId AS INT = (SELECT MAX(id) FROM LiquidacionMoneda)

	SET @maxId = (
			CASE 
				WHEN @maxId IS NULL
					THEN 0
				ELSE @maxId
				END
			)

	DBCC CHECKIDENT (
			LiquidacionMoneda
			,RESEED
			,@maxId
			)

	-- Toma el año Vigente configurado en la tabla ParametrosApp que tiene el id = 3
	DECLARE @AñoLiquidacion AS INT = (YEAR(GETDATE()) - 1)

	WHILE (@AñoLiquidacion <= YEAR(GETDATE()))
	BEGIN
		-- Toma la BaseMoneda para Colquines para los recaudos que estén entre las fechas del maestroMoneda y que esté en el año vigente.
		DECLARE @baseMonedaActual AS VARCHAR(2048) = (
			SELECT DISTINCT Bm.base FROM BaseMoneda Bm WHERE YEAR(bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.id > 0
			AND Bm.moneda_id = 1
			)
		--  El factor de Siniestralidad lo define el usuario en la tabla parametrosApp.
		DECLARE @factorSiniestralidad AS FLOAT = (SELECT CAST(p.valor AS FLOAT) FROM ParametrosApp p WHERE p.id = 12)

		-- *********************************************************************************************************
		-- CREACIÓN DE TABLAS AGRUPADAS. 
		-- *********************************************************************************************************--
		-- Tabla temporal con los negocios del año vigente y con los ramos, productos  y planes agrupados.	
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
			,n.ramoDetalle_id
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
			,rd.ramo_id AS ramo_id
			,pd.producto_id AS producto_id
			,pld.plan_id AS plan_id
		INTO #NegociosAgrupados
		FROM Negocio n
		INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
		INNER JOIN ProductoDetalle pd ON pd.id = n.productoDetalle_id
		INNER JOIN PlanDetalle pld ON pld.id = n.planDetalle_id
		WHERE n.anioCierre = @AñoLiquidacion

		PRINT 'Creación de la tabla temporal #NegociosAgrupados'

		-- Tabla temporal con los recaudos del año vigente y con los ramos, productos  y planes agrupados.	
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
			,RTRIM(LTRIM(r.clave)) AS clave
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
			,r.sistema
			,r.codigoOcupacion
			,r.segmento_id
			,r.estadoCierre
			,r.mesCierre
			,r.anioCierre
			,rd.ramo_id AS ramo_id
			,pd.producto_id AS producto_id
			,pld.plan_id AS plan_id
			,0 AS actividadEconomica_id
			,0 AS cliente_id
			,0 AS tipoVehiculo_id
			,r.bancoDetalle_id
			,bd.banco_id AS banco_id
			,red.red_id AS red_id
		INTO #RecaudosAgrupados
		FROM Recaudo r
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
		INNER JOIN PlanDetalle pld ON pld.id = r.planDetalle_id
		INNER JOIN BancoDetalle bd ON bd.id = r.bancoDetalle_id
		INNER JOIN RedDetalle red ON red.id = r.redDetalle_id
		WHERE r.anioCierre = @AñoLiquidacion

		PRINT 'Creación de la tabla temporal #RecaudosAgrupados'

		UPDATE #RecaudosAgrupados
		SET cliente_id = isnull(n.cliente_id,0)
			,actividadEconomica_id = isnull(n.actividadEconomica_id,0)
			,tipoVehiculo_id = isnull(n.tipoVehiculo_id,0)
		FROM #RecaudosAgrupados r
		INNER JOIN #NegociosAgrupados n ON CAST(n.numeroNegocio AS BIGINT) = CAST(r.numeroNegocio AS BIGINT)
			AND n.compania_id = r.compania_id
			AND n.ramoDetalle_id = r.ramoDetalle_id
			AND n.productoDetalle_id = r.productoDetalle_id
			AND n.localidad_id = r.localidad_id
			AND n.participante_id = r.participante_id

		ALTER TABLE #RecaudosAgrupados ADD Colquines FLOAT

		ALTER TABLE #RecaudosAgrupados ADD factor FLOAT

		-- *********************************************************************************************************
		-- Calculo de Colquines por parametrización tabla MonedaxNegocio de acuerdo a las combinaciones permitidas.
		-- *********************************************************************************************************--
		
		-- x2
		
		-- Combinación por Compania, Ramo
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0

		PRINT 'Por Compania - Ramo'

		-- x3
		
		-- Combinación por Compania, Ramo, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0

		PRINT 'Por Compania - Ramo - Zona'

		--  Combinación por Compania, Ramo, Linea de Negocio
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio'

		--  Combinación por: Compania, Ramo, Segmento
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.segmento_id = Ra.segmento_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.lineaNegocio_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.segmento_id <> 0

		PRINT 'Por Compania - Ramo - Segmento'

		--  Combinación por: Compania, Ramo, Producto
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto'

		-- Combinación por: Compania, Ramo, Amparo
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.amparo_id = Ra.amparo_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.producto_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.amparo_id <> 0

		PRINT 'Por Compania - Ramo - Amparo'
		
		-- Combinación por: Compania, Ramo, Red
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.red_id = Ra.red_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.red_id <> 0

		PRINT 'Por Compania - Ramo - Red'
		
		-- x4
		
		-- Combinación por Compania, Ramo, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0

		PRINT 'Por Compania - Ramo - Zona - Localidad'
		
		--  Combinación por Compania, Ramo, Linea de Negocio, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Zona'

		--  Combinación por: Compania, Ramo, Segmento, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.lineaNegocio_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.segmento_id <> 0

		PRINT 'Por Compania - Ramo - Segmento - Zona'

		--  Combinación por: Compania, Ramo, Producto, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Zona'

		-- Combinación por: Compania, Ramo, Amparo, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.producto_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.amparo_id <> 0

		PRINT 'Por Compania - Ramo - Amparo - Zona'
		
		-- Combinación por: Compania, Ramo, Red, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.red_id = Ra.red_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0

		PRINT 'Por Compania - Ramo - Red - Zona'

		-- Combinación por: Compania, Ramo, Producto, Plan
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.plan_id = Ra.plan_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Plan'
		
		-- Combinación por Compania, Ramo, Producto, Linea de Negocio
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio'

		-- Combinación por: Compania, Ramo, Linea de Negocio, Segmento
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.producto_id = 0
			AND Mn.banco_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0			
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Segmento'

		-- Combinación por: Compania, Ramo, Producto, TipoVehiculo
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.tipoVehiculo_id = Ra.tipoVehiculo_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.plan_id = 0
			AND Mn.segmento_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.tipoVehiculo_id <> 0			
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - TipoVehiculo'

		-- Combinación por: Compania, Ramo, Producto, Amparo
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.plan_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Amparo'
		
		-- Combinación por: Compania, Ramo, Red, Banco
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.red_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Red - Banco'

		-- Combinación por: Compania, Ramo, Producto, Red
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red'
		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Red
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.producto_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Red'
		
		-- x5
		
		--  Combinación por Compania, Ramo, Linea de Negocio, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Zona - Localidad'

		--  Combinación por: Compania, Ramo, Segmento, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.producto_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.lineaNegocio_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.segmento_id <> 0

		PRINT 'Por Compania - Ramo - Segmento - Zona - Localidad'

		--  Combinación por: Compania, Ramo, Producto, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Amparo, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.producto_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.amparo_id <> 0

		PRINT 'Por Compania - Ramo - Amparo - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Red, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.red_id = Ra.red_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0

		PRINT 'Por Compania - Ramo - Red - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Plan - Zona'
		
		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio - Zona'

		-- Combinación por: Compania, Ramo, Linea de Negocio, Segmento, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.producto_id = 0
			AND Mn.banco_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0		
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Segmento - Zona'

		-- Combinación por: Compania, Ramo, Producto, TipoVehiculo - Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.tipoVehiculo_id = Ra.tipoVehiculo_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.plan_id = 0
			AND Mn.segmento_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.tipoVehiculo_id <> 0			
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - TipoVehiculo - Zona'

		-- Combinación por: Compania, Ramo, Producto, Amparo, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.plan_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Amparo - Zona'
		
		-- Combinación por: Compania, Ramo, Red, Banco, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Red - Banco - Zona'

		-- Combinación por: Compania, Ramo, Producto, Red, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red - Zona'
		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Red, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.producto_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Red - Zona'

		-- Combinación por: Compania, Ramo, Producto, Red, Banco
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red - Banco'

		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0		
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Plan - Linea de Negocio'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, TipoVehiculo
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.tipoVehiculo_id = Ra.tipoVehiculo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.tipoVehiculo_id <> 0
			AND Ra.lineaNegocio_id <> 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio - TipoVehiculo'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Segmento
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Segmento - Linea de Negocio'

		-- Combinación por: Compania, Ramo, Producto, Linea dee Negocio, Banco
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.segmento_id = 0
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Banco - Linea de Negocio'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Red
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id <> 0
			AND Mn.segmento_id = 0
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id = 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red - Linea de Negocio'

		-- Combinación por: Compania, Ramo, Producto, Amparo, Linea de Negocio
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Amparo - Linea de Negocio'
		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Red, Banco
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.producto_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Red - Banco'

		-- Combinación por: Compania, Ramo, Linea de Negocio, Amparo, Actividad Economica
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.actividadeconomica_id = Ra.actividadEconomica_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.amparo_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Amparo - Actividad Economica'
		
		-- x6
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Plan - Zona - Localidad'
		
		-- Combinación por Compania, Ramo, Producto, Linea de Negocio, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Linea de Negocio, Segmento, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.producto_id = 0
			AND Mn.banco_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0			
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Segmento - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, TipoVehiculo, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.tipoVehiculo_id = Ra.tipoVehiculo_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.plan_id = 0
			AND Mn.segmento_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.tipoVehiculo_id <> 0			
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - TipoVehiculo - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, Amparo, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.plan_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Amparo - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Red, Banco, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.red_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Red - Banco - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, Red, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Red, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.producto_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Red - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Producto, Red, Banco, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red - Banco - Zona'

		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0	
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Plan - Linea de Negocio - Zona'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, TipoVehiculo, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.tipoVehiculo_id = Ra.tipoVehiculo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.tipoVehiculo_id <> 0
			AND Ra.lineaNegocio_id <> 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio - TipoVehiculo - Zona'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Segmento, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Segmento - Linea de Negocio - Zona'

		-- Combinación por: Compania, Ramo, Producto, Linea dee Negocio, Banco, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.segmento_id = 0
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Banco - Linea de Negocio - Zona'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Red, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id <> 0
			AND Mn.segmento_id = 0
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id = 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red - Linea de Negocio - Zona'

		-- Combinación por: Compania, Ramo, Producto, Amparo, Linea de Negocio, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Amparo - Linea de Negocio - Zona'
		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Red, Banco, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.producto_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Red - Banco - Zona'
		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Amparo, Actividad Economica, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.actividadeconomica_id = Ra.actividadEconomica_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Amparo - Actividad Economica - Zona'

		-- Combinación por_ Compania, Ramo, Producto, Plan, Linea de Negocio, Segmento
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.segmento_id = Ra.segmento_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Plan - Linea de Negocio - Segmento'
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Banco
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.banco_id = Ra.banco_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.segmento_id = 0			
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania, Ramo, Producto, Plan, Linea de Negocio, Banco'
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Red
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.red_id = Ra.banco_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.segmento_id = 0
			AND Mn.banco_id = 0			
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Plan - Linea de Negocio - Red'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Amparo, Modalidad Pago
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadpago_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Linea de Negocio - Amparo - Modalidad Pago'

		-- Combinación por: Compania, Ramo, Linea de Negocio, Amparo, Modalidad Pago, Actividad Economica
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadPago_id
			AND Mn.actividadeconomica_id = Ra.actividadEconomica_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Linea de Negocio - Amparo - Modalidad Pago - Actividad Economica'

		-- Combinación por: Compania, Ramo, Producto, Linea Negocio, Red, Banco
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio - Red - Banco'
		
		-- x7
		
		-- Combinación por: Compania, Ramo, Producto, Red, Banco
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.lineaNegocio_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red - Banco - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0		
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Plan - Linea de Negocio - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, TipoVehiculo, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.tipoVehiculo_id = Ra.tipoVehiculo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.tipoVehiculo_id <> 0
			AND Ra.lineaNegocio_id <> 0
			AND Ra.producto_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio - TipoVehiculo - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Segmento, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Segmento - Linea de Negocio - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, Linea dee Negocio, Banco, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0
			AND Mn.red_id = 0
			AND Mn.segmento_id = 0
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Banco - Linea de Negocio - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Red, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.red_id = Ra.red_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.amparo_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.plan_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.banco_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0			
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Red - Linea de Negocio - Zona - Localidad'

		-- Combinación por: Compania, Ramo, Producto, Amparo, Linea de Negocio, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.lineaNegocio_id = Ra.zona_id
			AND Mn.zona_id = Ra.localidad_id
			AND Mn.localidad_id = Ra.lineaNegocio_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Amparo - Linea de Negocio - Zona - Localidad'
 		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Red, Banco, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.producto_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0
			AND Ra.banco_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Red - Banco - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Amparo, Actividad Economica, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.actividadeconomica_id = Ra.actividadEconomica_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.modalidadPago_id = 0
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Linea de Negocio - Amparo - Actividad Economica - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Segmento, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Plan - Linea de Negocio - Segmento- Zona'
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Banco, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.segmento_id = 0			
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Plan - Linea de Negocio - Banco - Zona'
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Red, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.red_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.segmento_id = 0
			AND Mn.banco_id = 0			
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Plan - Linea de Negocio - Red - Zona'
		
		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Amparo, Modalidad Pago, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadpago_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Linea de Negocio - Amparo - Modalidad Pago - Zona'
		
		-- Combinación por: Compania, Ramo, Linea de Negocio, Amparo, Modalidad Pago, Actividad Economica, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadPago_id
			AND Mn.actividadeconomica_id = Ra.actividadEconomica_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Linea de Negocio - Amparo - ModalidadPago - Actividad Economica - Zona'
		
		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Red, Banco, Zona
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio - Red - Banco - Zona'

		-- Combinación por: Compañía, Ramo, Producto, Línea de Negocio, Amparo, Modalidad Pago, Actividad Económica 
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadpago_id
			AND Mn.actividadEconomica_id = Ra.actividadEconomica_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Mn.zona_id = 0
			AND Mn.localidad_id = 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compañía - Ramo - Producto - Línea de Negocio - Amparo - Modalidad Pago - Actividad Económica'
		
		-- x8
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Segmento, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.segmento_id = Ra.segmento_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.segmento_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Plan - Linea de Negocio - Segmento- Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Banco, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.red_id = 0
			AND Mn.segmento_id = 0			
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Plan - Linea de Negocio - Banco - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Producto, Plan, Linea de Negocio, Red, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.plan_id = Ra.plan_id
			AND Mn.red_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.segmento_id = 0
			AND Mn.banco_id = 0			
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.plan_id <> 0
			AND Ra.red_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Plan - Linea de Negocio - Red - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Amparo, Modalidad Pago, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadpago_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Producto - Linea de Negocio - Amparo - Modalidad Pago - Zona - Localidad'
		
		-- Combinación por Compania, Ramo, Linea de Negocio, Amparo, Modalidad Pago, Actividad Economica, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadPago_id
			AND Mn.actividadeconomica_id = Ra.actividadEconomica_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.producto_id = 0
			AND Mn.plan_id = 0
			AND Mn.red_id = 0
			AND Mn.banco_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Compania - Ramo - Linea de Negocio - Amparo - Modalidad Pago - Actividad Economica - Zona - Localidad'
		
		-- Combinación por: Compania, Ramo, Producto, Linea de Negocio, Red, Banco, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.red_id = Ra.red_id
			AND Mn.banco_id = Ra.banco_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.actividadeconomica_id = 0
			AND Mn.amparo_id = 0
			AND Mn.modalidadPago_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0
			AND Ra.zona_id <> 0
			AND Ra.localidad_id <> 0
			AND Ra.red_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.banco_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compania - Ramo - Producto - Linea de Negocio - Red - Banco - Zona - Localidad'
		
		-- Combinación por: Compañía, Ramo, Producto, Línea de Negocio, Amparo, Modalidad Pago, Actividad Económica, Zona 
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadpago_id
			AND Mn.actividadEconomica_id = Ra.actividadEconomica_id
			AND Mn.zona_id = Ra.zona_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Mn.localidad_id = 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compañía - Ramo - Producto - Línea de Negocio - Amparo - Modalidad Pago - Actividad Económica - Zona'
		
		-- x9
		
		-- Combinación por: Compañía, Ramo, Producto, Línea de Negocio, Amparo, Modalidad Pago, Actividad Económica, Zona, Localidad
		UPDATE #RecaudosAgrupados
		SET Colquines = STR(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(Mn.factor AS FLOAT)) AS FLOAT), 13, 10)
			,factor = Mn.factor
		FROM #RecaudosAgrupados AS Ra
		INNER JOIN MonedaxNegocio Mn ON Mn.compania_id = Ra.compania_id
			AND Mn.ramo_id = Ra.ramo_id
			AND Mn.lineaNegocio_id = Ra.lineaNegocio_id
			AND Mn.producto_id = Ra.producto_id
			AND Mn.amparo_id = Ra.amparo_id
			AND Mn.modalidadPago_id = Ra.modalidadpago_id
			AND Mn.actividadEconomica_id = Ra.actividadEconomica_id
			AND Mn.zona_id = Ra.zona_id
			AND Mn.localidad_id = Ra.localidad_id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE Ra.mesCierre BETWEEN MONTH(Mmn.fecha_inicial)
				AND MONTH(Mmn.fecha_final)
			AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion
			AND Bm.moneda_id = 1
			AND Mn.red_id = 0
			AND Mn.banco_id = 0
			AND Mn.plan_id = 0			
			AND Mn.segmento_id = 0
			AND Mn.tipoVehiculo_id = 0			
			AND Ra.localidad_id <> 0
			AND Ra.zona_id <> 0
			AND Ra.producto_id <> 0
			AND Ra.amparo_id <> 0
			AND Ra.modalidadpago_id <> 0
			AND Ra.actividadEconomica_id <> 0
			AND Ra.lineaNegocio_id <> 0

		PRINT 'Por Compañía - Ramo - Producto - Línea de Negocio - Amparo - Modalidad Pago - Actividad Económica - Zona - Localidad'

		-- *********************************************************************************************************
		-- Liquidación x Combos
		-- *********************************************************************************************************--
		--  Tabla que contiene los recaudos con producto principal (1) parametrizados en la tabla ProductoCombo
		--  y que forman parte de combos validados (1)
		SELECT ra.id AS recaudo_id
			,ra.compania_id
			,ra.ramo_id
			,ra.producto_id
			,ra.valorRecaudo
			,ra.localidad_id
			,ra.clave
			,ra.participante_id
			,ra.Colquines
			,ra.cliente_id
			,pc.combo_id
			,ra.fechaRecaudo
			,ra.mesCierre
			,ra.anioCierre
		INTO #ProductoPrincipal
		FROM #RecaudosAgrupados ra
		INNER JOIN ProductoCombo pc ON pc.producto_id = ra.producto_id
		INNER JOIN Combo c ON c.id = pc.combo_id
		WHERE pc.es_principal = 1
			AND ra.anioCierre = @AñoLiquidacion
			AND c.validado = 1

		--  Tabla que contiene los recaudos con producto secundario (0) parametrizados en la tabla ProductoCombo
		--  y que forman parte de combos validados (1)
		SELECT ra.id AS recaudo_id
			,ra.compania_id
			,ra.ramo_id
			,ra.producto_id
			,ra.valorRecaudo
			,ra.localidad_id
			,ra.clave
			,ra.participante_id
			,ra.Colquines
			,ra.cliente_id
			,pc.combo_id
			,ra.mesCierre
			,ra.anioCierre
		INTO #ProductoSecundario
		FROM #RecaudosAgrupados ra
		INNER JOIN ProductoCombo pc ON pc.producto_id = ra.producto_id
		INNER JOIN Combo c ON c.id = pc.combo_id
		WHERE pc.es_principal = 0
			AND ra.anioCierre = @AñoLiquidacion
			AND c.validado = 1

		-- Tabla que contiene los recaudos que forman parte de combos parametrizados en MonedaxNegocio
		-- de productos principales
		SELECT DISTINCT mn.factor
			,mn.combo_id
			,pp.producto_id
			,pp.recaudo_id
			,pp.valorRecaudo
			,pp.Colquines
			,pp.fechaRecaudo
			,pp.cliente_id
			,pp.participante_id
			,Bm.base
		INTO #principalxCombo
		FROM Combo c
		INNER JOIN MonedaxNegocio mn ON mn.combo_id = c.id
		INNER JOIN #ProductoPrincipal pp ON pp.combo_id = c.id
		INNER JOIN MaestroMonedaxNegocio Mmn ON Mmn.id = mn.maestromoneda_id
		INNER JOIN BaseMoneda Bm ON Bm.moneda_id = Mmn.moneda_id
		WHERE mn.combo_id > 0
			AND mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
				AND MONTH(Bm.fecha_finVigencia)
			AND YEAR(Bm.fecha_inicioVigencia) = @AñoLiquidacion
			AND YEAR(Bm.fecha_finVigencia) = @AñoLiquidacion

		-- Tabla que contiene los recaudos que forman parte de combos parametrizados en MonedaxNegocio
		-- de productos secundarios
		SELECT DISTINCT mn.factor
			,mn.combo_id
			,ps.producto_id
			,ps.cliente_id
			,ps.participante_id
		INTO #secundarioxCombo
		FROM Combo c
		INNER JOIN MonedaxNegocio mn ON mn.combo_id = c.id
		INNER JOIN #ProductoSecundario ps ON ps.combo_id = c.id
		WHERE mn.combo_id > 0

		--  Tabla en donde se liquida el combo y donde se evaluan las condiciones del Combo: cliente y participantes iguales.
		SELECT DISTINCT pc.combo_id
			,pc.factor
			,pc.producto_id AS principal
			,pc.recaudo_id
			,pc.valorRecaudo
			,pc.Colquines
			,pc.base
		INTO #colquinesFinalesxcombo
		FROM #principalxCombo pc
		INNER JOIN #secundarioxCombo sc ON pc.combo_id = sc.combo_id
			AND pc.cliente_id = sc.cliente_id
			AND pc.participante_id = sc.participante_id
		ORDER BY principal

		ALTER TABLE #colquinesFinalesxcombo ADD colquinesxcombo FLOAT

		ALTER TABLE #colquinesFinalesxcombo ADD colquinesFinales FLOAT

		UPDATE #colquinesFinalesxcombo
		SET colquinesxcombo = ROUND(((CAST(valorRecaudo AS FLOAT) / CAST(base AS FLOAT)) * CAST(factor AS FLOAT)), 3)

		UPDATE #colquinesFinalesxcombo
		SET colquinesxcombo = 0
		WHERE colquinesxcombo IS NULL

		UPDATE #colquinesFinalesxcombo
		SET colquinesFinales = ROUND(CAST(colquinesxcombo AS FLOAT) + CAST(Colquines AS FLOAT), 3)

		UPDATE #RecaudosAgrupados
		SET Colquines = cfc.colquinesFinales
		FROM #RecaudosAgrupados ra
		INNER JOIN #colquinesFinalesxcombo cfc ON cfc.recaudo_id = ra.id

		DROP TABLE #ProductoPrincipal

		DROP TABLE #ProductoSecundario

		DROP TABLE #principalxCombo

		DROP TABLE #secundarioxCombo

		DROP TABLE #colquinesFinalesxcombo

		UPDATE #RecaudosAgrupados
		SET Colquines = 0
		WHERE Colquines IS NULL

		PRINT 'Fin Liquidación por Combos'

		-- Inserta la información de los recaudos a los cuales se le ha liquidado los Colquines en la tabla LiquidacionMoneda
		INSERT INTO LiquidacionMoneda (
			moneda_id
			,compania_id
			,cantidad
			,participante_id
			,tipo
			,recaudo_id
			,fechaLiquidacion
			,anioCierreRecaudo
			,factor
			)
		SELECT 1 -- Moneda (Colquines)
			,Ra.compania_id
			,Ra.Colquines
			,Ra.participante_id
			,1 --Tipo (Liquidacion Colquines x Recaudo)
			,Ra.id
			,GETDATE()
			,anioCierre
			,Ra.factor
		FROM #RecaudosAgrupados Ra

		PRINT 'Insertar en Liquidacion Moneda'

		-- *********************************************************************************************************
		-- Validacion Tope Moneda: Actualiza la cantidad de colquines de x negocio de acuerdo a los topes parametrizados en la tabla TopeMoneda
		-- *********************************************************************************************************--
		UPDATE Recaudo
		SET Colquines = ROUND(CAST(lm.cantidad AS FLOAT), 3)
		FROM Recaudo AS r
		INNER JOIN LiquidacionMoneda lm ON lm.recaudo_id = r.id
		WHERE lm.tipo = 1

		SELECT T1.id AS recaudo_id
			,T1.numeroNegocio
			,T1.compania_id
			,T1.ramoDetalle_id
			,T1.productoDetalle_id
			,T1.localidad_id
			,T1.clave
			,T1.mesCierre
			,ROUND(T1.Colquines, 3) AS Colquines
			,(
				SELECT ROUND(SUM(r2.Colquines), 3)
				FROM Recaudo r2
				WHERE r2.id <= T1.id
					AND r2.compania_id = T1.compania_id
					AND r2.ramoDetalle_id = t1.ramoDetalle_id
					AND r2.productoDetalle_id = t1.productoDetalle_id
					AND r2.localidad_id = t1.localidad_id
					AND r2.clave = t1.clave
					AND r2.numeroNegocio = t1.numeroNegocio
					AND r2.anioCierre = t1.anioCierre
				) AS acumuladoColquines
		INTO #RecaudosAcumulados
		FROM Recaudo T1
		WHERE T1.anioCierre = @AñoLiquidacion
		ORDER BY T1.numeroNegocio
			,T1.compania_id
			,T1.ramoDetalle_id
			,T1.productoDetalle_id
			,T1.localidad_id
			,T1.clave
			,T1.id ASC

		ALTER TABLE #RecaudosAcumulados ADD tope FLOAT

		--  Tope por combinación: compania
		UPDATE #RecaudosAcumulados
		SET tope = tm.tope
		FROM #RecaudosAcumulados ra
		INNER JOIN TopeMoneda tm ON tm.compania_id = ra.compania_id
		INNER JOIN MaestroMonedaxNegocio mmn ON mmn.id = tm.maestromoneda_id
		WHERE YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND tm.ramo_id = 0
			AND tm.producto_id = 0

		--  Tope por combinación: compania + ramo
		UPDATE #RecaudosAcumulados
		SET tope = tm.tope
		FROM #RecaudosAcumulados ra
		INNER JOIN TopeMoneda tm ON tm.compania_id = ra.compania_id
		INNER JOIN MaestroMonedaxNegocio mmn ON mmn.id = tm.maestromoneda_id
		INNER JOIN RamoDetalle rd ON rd.id = ra.ramoDetalle_id
			AND tm.ramo_id = rd.ramo_id
		WHERE YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND tm.ramo_id <> 0
			AND tm.producto_id = 0

		--  Tope por combinación: compania + ramo + producto
		UPDATE #RecaudosAcumulados
		SET tope = tm.tope
		FROM #RecaudosAcumulados ra
		INNER JOIN TopeMoneda tm ON tm.compania_id = ra.compania_id
		INNER JOIN MaestroMonedaxNegocio mmn ON mmn.id = tm.maestromoneda_id
		INNER JOIN RamoDetalle rd ON rd.id = ra.ramoDetalle_id
			AND tm.ramo_id = rd.ramo_id
		INNER JOIN ProductoDetalle pd ON pd.id = ra.productoDetalle_id
			AND tm.producto_id = pd.producto_id
		WHERE YEAR(Mmn.fecha_inicial) = @AñoLiquidacion
			AND YEAR(Mmn.fecha_final) = @AñoLiquidacion
			AND tm.ramo_id <> 0
			AND tm.producto_id <> 0

		DELETE
		FROM #RecaudosAcumulados
		WHERE tope IS NULL

		SELECT recaudo_id
			,numeroNegocio
			,compania_id
			,ramoDetalle_id
			,productoDetalle_id
			,localidad_id
			,clave
			,Colquines
			,acumuladoColquines
			,tope
			,mesCierre
		INTO #Recaudosxtope
		FROM #RecaudosAcumulados
		ORDER BY numeroNegocio
			,compania_id
			,ramoDetalle_id
			,productoDetalle_id
			,localidad_id
			,clave

		ALTER TABLE #Recaudosxtope ADD colquinesFinales FLOAT

		UPDATE #Recaudosxtope
		SET acumuladoColquines = 0
		WHERE acumuladoColquines IS NULL

		UPDATE #Recaudosxtope
		SET Colquines = 0
		WHERE Colquines IS NULL

		UPDATE #Recaudosxtope
		SET colquinesFinales = (
				CASE 
					WHEN CAST(acumuladoColquines AS FLOAT) <= CAST(tope AS FLOAT)
						THEN (
								CASE 
									WHEN CAST(Colquines AS FLOAT) <= (CAST(tope AS FLOAT) * (- 1))
										THEN (CAST(tope AS FLOAT) * (- 1))
									ELSE (
											CASE 
												WHEN CAST(Colquines AS FLOAT) > CAST(tope AS FLOAT)
													THEN CAST(tope AS FLOAT)
												ELSE CAST(Colquines AS FLOAT)
												END
											)
									END
								)
					ELSE CASE 
							WHEN (CAST(acumuladoColquines AS FLOAT) - CAST(tope AS FLOAT) - CAST(Colquines AS FLOAT)) <= 0
								AND (CAST(Colquines AS FLOAT) > CAST(tope AS FLOAT))
								THEN CAST(tope AS FLOAT)
							ELSE CASE 
									WHEN (CAST(acumuladoColquines AS FLOAT) - CAST(tope AS FLOAT) - CAST(Colquines AS FLOAT)) <= 0
										THEN ((CAST(acumuladoColquines AS FLOAT) - CAST(tope AS FLOAT) - CAST(Colquines AS FLOAT)) * (- 1))
									ELSE 0
									END
							END
					END
				)

		UPDATE LiquidacionMoneda
		SET cantidad = ROUND(CAST(rt.colquinesFinales AS FLOAT), 3)
			,concepto = 'Tope x Moneda'
		FROM LiquidacionMoneda lm
		INNER JOIN #Recaudosxtope rt ON rt.recaudo_id = lm.recaudo_id
		WHERE lm.tipo = 1

		DROP TABLE #Recaudosxtope

		DROP TABLE #RecaudosAcumulados

		PRINT 'Fin Validacion Tope Moneda'

		-- Validacion Tope Edad: Actualiza la cantidad de colquines del recaudo de acuerdo a los topes parametrizados en la tabla TopexEdad
		--  Tope por combinación: compania + ramo	
		UPDATE LiquidacionMoneda
		SET cantidad = t.tope
			,concepto = 'Tope x Edad'
		FROM LiquidacionMoneda lm
		INNER JOIN #RecaudosAgrupados ra ON ra.id = lm.recaudo_id
		INNER JOIN TopexEdad t ON t.compania_id = ra.compania_id
			AND lm.cantidad > t.tope
			AND ra.ramo_id = t.ramo_id
		INNER JOIN Cliente c ON c.id = ra.cliente_id
			AND DATEDIFF(YEAR, c.fechaNacimiento, GETDATE()) > t.edad
		WHERE YEAR(c.fechaNacimiento) <> 1900
			AND t.ramo_id <> 0
			AND t.producto_id = 0

		--  Tope por combinación: compania + ramo + producto
		UPDATE LiquidacionMoneda
		SET cantidad = t.tope
			,concepto = 'Tope x Edad'
		FROM LiquidacionMoneda lm
		INNER JOIN #RecaudosAgrupados ra ON ra.id = lm.recaudo_id
		INNER JOIN TopexEdad t ON t.compania_id = ra.compania_id
			AND lm.cantidad > t.tope
			AND ra.ramo_id = t.ramo_id
			AND ra.producto_id = t.producto_id
		INNER JOIN Cliente c ON c.id = ra.cliente_id
			AND DATEDIFF(YEAR, c.fechaNacimiento, GETDATE()) > t.edad
		WHERE YEAR(c.fechaNacimiento) <> 1900
			AND t.ramo_id <> 0
			AND t.producto_id <> 0

		PRINT 'Fin Validacion Tope Edad'

		-- Actualiza el valor de la cantidad de colquines en la tabla recaudo
		UPDATE Recaudo
		SET Colquines = CAST(lm.cantidad AS FLOAT)
		FROM Recaudo AS r
		INNER JOIN LiquidacionMoneda lm ON lm.recaudo_id = r.id
		WHERE lm.tipo = 1

		PRINT 'Actualizacion Colquines Finales en dbo.Recaudo'

		UPDATE Recaudo
		SET Colquines = RTRIM(LTRIM(STR(CAST(Colquines AS FLOAT), 13, 2)))
		WHERE Colquines LIKE '%E%'

		UPDATE LiquidacionMoneda
		SET cantidad = RTRIM(LTRIM(STR(CAST(cantidad AS FLOAT), 13, 2)))
		WHERE cantidad LIKE '%E%'

		--**************** FIN EJECUTIVOS ****************-- 
		-- Borra las tablas temporales
		DROP TABLE #RecaudosAgrupados

		DROP TABLE #NegociosAgrupados

		PRINT 'Se borrar las tablas temporales'

		-- Validaciones Adicionales
		UPDATE Recaudo
		SET participante_id = p.id
		FROM Recaudo r
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(r.clave))
			AND r.participante_id IS NULL

		UPDATE Recaudo
		SET zona_id = l.zona_id
		FROM Recaudo r
		INNER JOIN Localidad l ON l.id = r.localidad_id
			AND r.zona_id IS NULL

		-- Actualizar participante_id en LiquidacionMoneda
		UPDATE LiquidacionMoneda
		SET participante_id = r.participante_id
		FROM LiquidacionMoneda lm
		INNER JOIN Recaudo r ON r.id = lm.recaudo_id
		WHERE lm.participante_id IS NULL

		PRINT 'Actualizar participante_id en LiquidacionMoneda'

		-- Actualizar del valor de Colquines (valores float)
		UPDATE LiquidacionMoneda
		SET cantidad = STR(CAST(cantidad AS FLOAT), 13, 10)
		WHERE tipo IN (
				1
				,2
				,5
				,6
				,7
				)
			AND anioCierreRecaudo = @AñoLiquidacion

		PRINT 'Actualizar del valor de Colquines (valores float)'
		
		SET @AñoLiquidacion = @AñoLiquidacion + 1
	END

	--  Log Errores
	DECLARE @cantidadFinal AS INT = (
		SELECT COUNT(*) FROM LiquidacionMoneda WHERE tipo IN (
			1
			,2
			,5
			,6
			,7
			)
		)
	DECLARE @idActualizacion AS INT = (
		SELECT MAX(id) FROM LogIntegracion WHERE proceso = 'Liquidación de Colquines'
		AND estado = 1
		)

	UPDATE LogIntegracion
	SET fechaFin = GETDATE()
		,estado = 2
		,cantidad = @cantidadFinal
	WHERE id = @idActualizacion
END
