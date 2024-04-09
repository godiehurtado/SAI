-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Generación de la Tabla Maestra y Precalculos para la liquidación del PAI de asesores. --
-- =============================================
CREATE PROCEDURE [dbo].[SAI_TablaMaestra]
AS
BEGIN
	--  Log de Errores
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
		,'Generacion de la Tabla Maestra'
		,1
		,'SAI'
		,'SAI'
		,'TablaMaestra'
		)

	DECLARE @cantidadInicial AS INT = (SELECT COUNT(*) FROM TablaMaestra)

	TRUNCATE TABLE TablaMaestra

	-- Toma el año Vigente configurado en la tabla ParametrosApp que tiene el id = 3
	DECLARE @añoenCurso INT = 2012 /*(SELECT CAST(valor AS INT) FROM ParametrosApp WHERE id = 3)*/

	--  Se insertan en la tabla temporal los Negocios donde el año de cierre sea igual al año en curso.
	SELECT n.compania_id
		,n.lineaNegocio_id
		,n.ramoDetalle_id
		,n.productoDetalle_id
		,n.planDetalle_id
		,n.amparo_id
		,n.cobertura_id
		,n.modalidadPago_id
		,n.formaPago_id
		,n.numeroNegocio
		,n.numeroSolicitud
		,n.codigoAgrupador
		,n.fechaExpedicion
		,n.fechaGrabacion
		,n.fechaRecaudoInicial
		,n.fechaEmisionMaximoEndoso
		,n.fechaCancelacion
		,n.valorAsegurado
		,n.valorProteccion
		,n.valorAhorro
		,n.valorPrimaPensiones
		,n.valorPrimaTotal
		,n.estadoNegocio
		,n.zona_id
		,n.localidad_id
		,n.clave
		,n.participante_id
		,n.porcentajeParticipacion
		,n.segmento_id
		,n.tipoEndoso_id
		,n.grupoEndoso_id
		,n.cuotasPagadas
		,n.cuotasVencidas
		,n.cliente_id
		,n.identificacionSuscriptor
		,n.nombreSuscriptor
		,n.generoSuscriptor
		,n.actividadEconomica_id
		,n.marcaVehiculo_id
		,n.tipoVehiculo_id
		,n.modeloVehiculo
		,n.sistema
		,n.Usuarios
		,n.fechaCarga
		,n.estadoCierre
		,n.mesCierre
		,n.anioCierre
		,rd.ramo_id
		,pd.producto_id
		,pld.plan_id
		,p.nivel_id
		,p.categoria_id
		,p.fechaIngreso
		,prod.plazo_id
	INTO #NegociosxAñoVigente
	FROM Negocio n
	INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
	INNER JOIN ProductoDetalle pd ON pd.id = n.productoDetalle_id
	INNER JOIN PlanDetalle pld ON pld.id = n.planDetalle_id
	INNER JOIN Participante p ON p.id = n.participante_id
	INNER JOIN Producto prod ON prod.id = pd.producto_id
	WHERE anioCierre = @añoenCurso
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

	-- DROP TABLE #NegociosxAñoVigente
	--  Se insertan en la tabla temporal los Recaudos donde el año de cierre sea igual al año en curso.
	SELECT r.redDetalle_id
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
		,r.clave
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
		,r.fechaCarga
		,r.estadoCierre
		,r.mesCierre
		,r.anioCierre
		,rd.ramo_id
		,pd.producto_id
		,pld.plan_id
		,p.nivel_id
		,p.categoria_id
		,p.fechaIngreso
		,prod.plazo_id
	INTO #RecaudoxAñoVigente
	FROM Recaudo r
	INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
	INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
	INNER JOIN PlanDetalle pld ON pld.id = r.planDetalle_id
	INNER JOIN Participante p ON p.id = r.participante_id
	INNER JOIN Producto prod ON prod.id = pd.producto_id
	WHERE anioCierre = @añoenCurso

	-- *********************************************************************************************************
	-- Actualización x Excepciones
	-- *********************************************************************************************************--	
	-- Combinación Excepcion por Ramo, Clave
	UPDATE #RecaudoxAñoVigente
	SET Colquines = ROUND(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(eg.factor AS FLOAT)) AS FLOAT), 3)
	FROM #RecaudoxAñoVigente AS Ra
	INNER JOIN ExcepcionesGenerales eg ON eg.ramo_id = ra.ramo_id
		AND RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(ra.clave))
	INNER JOIN BaseMoneda Bm ON Bm.moneda_id = eg.moneda_id
	WHERE Ra.fechaRecaudo BETWEEN eg.fechaInicio
			AND eg.fechaFin
		AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
			AND MONTH(Bm.fecha_finVigencia)
		AND YEAR(Bm.fecha_inicioVigencia) = @añoenCurso
		AND YEAR(Bm.fecha_finVigencia) = @añoenCurso
		AND Bm.moneda_id = 1
		AND eg.numeroNegocio = 0

	PRINT 'Excepcion por Ramo, Clave'

	-- Combinación Excepcion por Ramo, Clave, NumeroNegocio
	UPDATE #RecaudoxAñoVigente
	SET Colquines = ROUND(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(eg.factor AS FLOAT)) AS FLOAT), 3)
	FROM #RecaudoxAñoVigente AS Ra
	INNER JOIN ExcepcionesGenerales eg ON eg.ramo_id = ra.ramo_id
		AND RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(ra.clave))
		AND eg.numeroNegocio = CAST(ra.numeroNegocio AS BIGINT)
	INNER JOIN BaseMoneda Bm ON Bm.moneda_id = eg.moneda_id
	WHERE Ra.fechaRecaudo BETWEEN eg.fechaInicio
			AND eg.fechaFin
		AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
			AND MONTH(Bm.fecha_finVigencia)
		AND YEAR(Bm.fecha_inicioVigencia) = @añoenCurso
		AND YEAR(Bm.fecha_finVigencia) = @añoenCurso
		AND Bm.moneda_id = 1
		AND eg.numeroNegocio <> 0

	PRINT 'Excepcion por Ramo, Clave, Numero Negocio'

	-- Combinación Excepcion por Clave
	UPDATE #RecaudoxAñoVigente
	SET Colquines = ROUND(CAST(((CAST(Ra.valorRecaudo AS FLOAT) / CAST(Bm.base AS FLOAT)) * CAST(eg.factor AS FLOAT)) AS FLOAT), 3)
	FROM #RecaudoxAñoVigente AS Ra
	INNER JOIN ExcepcionesGenerales eg ON RTRIM(LTRIM(eg.clave)) = RTRIM(LTRIM(ra.clave))
	INNER JOIN BaseMoneda Bm ON Bm.moneda_id = eg.moneda_id
	WHERE Ra.fechaRecaudo BETWEEN eg.fechaInicio
			AND eg.fechaFin
		AND Ra.mesCierre BETWEEN MONTH(Bm.fecha_inicioVigencia)
			AND MONTH(Bm.fecha_finVigencia)
		AND YEAR(Bm.fecha_inicioVigencia) = @añoenCurso
		AND YEAR(Bm.fecha_finVigencia) = @añoenCurso
		AND Bm.moneda_id = 1
		AND eg.numeroNegocio = 0
		AND eg.ramo_id = 0

	PRINT 'Excepcion por Clave'

	-- Se insertan en la tablaMaestra los Negocios de la tabla temporal.
	INSERT INTO TablaMaestra (
		fechaExpedicionNegocio
		,fechaCancelacionNegocio
		,numeroNegocio
		,valorAsegurado
		,compania_id
		,ramoDetalle_id
		,lineaNegocio_id
		,productoDetalle_id
		,participante_id
		,clave
		,primaAhorro
		,primaProteccion
		,primaPensiones
		,primaTotal
		,identificacionSuscriptor
		,generoSuscriptor
		,tipoVehiculo_id
		,porcentajeParticipacion
		,actividadEconomica_id
		,formaPago_id
		,cuotasVencidas
		,cuotasPagadas
		,segmento_id
		,zona_id
		,localidad_id
		,estadoNegocio
		,modalidadPago_id
		,codigoAgrupador
		,amparo_id
		,cobertura_id
		,cantidadSuscriptores
		,planDetalle_id
		,edadSuscriptor
		,estadoCierre
		,mesCierre
		,anioCierre
		,grupoEndoso_id
		,ramo_id
		,producto_id
		,plan_id
		,nivel_id
		,categoria_id
		,fechaIngresoAsesor
		,plazo_id
		) (
		SELECT n.fechaExpedicion
		,n.fechaCancelacion
		,n.numeroNegocio
		,n.valorAsegurado
		,n.compania_id
		,n.ramoDetalle_id
		,n.lineaNegocio_id
		,n.productoDetalle_id
		,n.participante_id
		,RTRIM(LTRIM(n.clave)) AS clave
		,n.valorAhorro
		,n.valorProteccion
		,n.valorPrimaPensiones
		,n.valorPrimaTotal
		,n.identificacionSuscriptor
		,n.generoSuscriptor
		,n.tipoVehiculo_id
		,n.porcentajeParticipacion
		,n.actividadEconomica_id
		,n.formaPago_id
		,n.cuotasVencidas
		,n.cuotasPagadas
		,n.segmento_id
		,n.zona_id
		,n.localidad_id
		,n.estadoNegocio
		,n.modalidadPago_id
		,n.codigoAgrupador
		,n.amparo_id
		,n.cobertura_id
		,n.Usuarios
		,n.planDetalle_id
		,(
			CASE 
				WHEN YEAR(c.fechaNacimiento) <> 1900
					THEN 0
				ELSE DATEDIFF(YEAR, c.fechaNacimiento, GETDATE())
				END
			) AS edadSuscriptor
		,n.estadoCierre
		,n.mesCierre
		,n.anioCierre
		,n.grupoEndoso_id
		,n.ramo_id
		,n.producto_id
		,n.plan_id
		,n.nivel_id
		,n.categoria_id
		,n.fechaIngreso
		,n.plazo_id FROM #NegociosxAñoVigente n LEFT JOIN Cliente c ON c.id = n.cliente_id
		)

	-- Se insertan en la tablaMaestra los Recaudos de la tabla temporal.
	INSERT INTO TablaMaestra (
		numeroNegocio
		,compania_id
		,ramoDetalle_id
		,lineaNegocio_id
		,productoDetalle_id
		,participante_id
		,clave
		,porcentajeParticipacion
		,formaPago_id
		,segmento_id
		,zona_id
		,localidad_id
		,amparo_id
		,cobertura_id
		,planDetalle_id
		,fechaRecaudo
		,fechaGrabacion
		,fechaCobranza
		,valorRecaudo
		,cantidadColquines
		,numeroReciboRecaudo
		,alturaRecaudo
		,red_id
		,estadoCierre
		,mesCierre
		,anioCierre
		,ramo_id
		,producto_id
		,plan_id
		,nivel_id
		,categoria_id
		,fechaIngresoAsesor
		,conceptoDescuento_id
		,plazo_id
		) (
		SELECT r.numeroNegocio
		,r.compania_id
		,r.ramoDetalle_id
		,r.lineaNegocio_id
		,r.productoDetalle_id
		,r.participante_id
		,RTRIM(LTRIM(r.clave)) AS clave
		,r.porcentajeParticipacion
		,r.formaPago_id
		,r.segmento_id
		,r.zona_id
		,r.localidad_id
		,r.amparo_id
		,r.cobertura_id
		,r.planDetalle_id
		,r.fechaRecaudo
		,r.fechaGrabacion
		,r.fechaCobranza
		,r.valorRecaudo
		,r.Colquines
		,r.numeroRecibo
		,r.Altura
		,r.redDetalle_id
		,r.estadoCierre
		,r.mesCierre
		,r.anioCierre
		,r.ramo_id
		,r.producto_id
		,r.plan_id
		,r.nivel_id
		,r.categoria_id
		,r.fechaIngreso
		,0
		,r.plazo_id AS conceptoDescuento_id FROM #RecaudoxAñoVigente r
		)

	-- ACTUALIZACION DE PRE - CALCULOS
	----  Primas x Millón
	--	UPDATE TablaMaestra
	--	SET primasxmillon = CAST(ROUND((primaTotal/1000000), 0,1) AS INT)
	--  Persistencia de CAPI
	UPDATE TablaMaestra
	SET persistenciaCapi = pc.persistenciaAcumulada
	FROM TablaMaestra tm
	INNER JOIN PersistenciadeCAPIAcumulada pc ON pc.participante_id = tm.participante_id
		AND tm.mesCierre = pc.ultimoPeriodo
	INNER JOIN Producto p ON p.id = tm.producto_id
	INNER JOIN Plazo plz ON plz.id = p.plazo_id
	WHERE tm.anioCierre = @añoenCurso
		AND pc.anioCierreNegocio = @añoenCurso

	--  Persistencia de VIDA
	UPDATE TablaMaestra
	SET persistenciaVida = pv.persistenciaDefinitiva
	FROM TablaMaestra tm
	INNER JOIN PersistenciadeVIDA pv ON pv.participante_id = tm.participante_id
		AND pv.compania_id = tm.compania_id
		AND pv.ramo_id = tm.ramo_id
	WHERE tm.anioCierre = @añoenCurso
		AND pv.añoAMedir = @añoenCurso

	--  Siniestralidad de Autos
	UPDATE TablaMaestra
	SET siniestralidadAutos = s.indSiniestralidad
	FROM TablaMaestra tm
	INNER JOIN Siniestralidad s ON s.participante_id = tm.participante_id
		AND s.compania_id = tm.compania_id
		AND s.ramoDetalle_id = tm.ramoDetalle_id
	WHERE tm.anioCierre = @añoenCurso
		AND YEAR(s.fechaCorte) = @añoenCurso

	-- Cantidad de Colquines Año Anterior 
	UPDATE t1
	SET t1.cantidadColquinesAnoAnterior = t2.colquinesAñoAnterior
	FROM TablaMaestra t1
	INNER JOIN (
		SELECT participante_id
			,año
			,tipoMedida_id
			,compania_id
			,ramo_id
			,(SUM(Enero) + SUM(Febrero) + SUM(Marzo) + SUM(Abril) + SUM(Mayo) + SUM(Junio) + SUM(Julio) + SUM(Agosto) + SUM(Septiembre) + SUM(Octubre) + SUM(Noviembre) + SUM(Diciembre)) AS colquinesAñoAnterior
		FROM ConsolidadoMes
		WHERE tipoMedida_id = 2
			AND año = (@añoenCurso - 1)
		GROUP BY participante_id
			,año
			,tipoMedida_id
			,compania_id
			,ramo_id
		) t2 ON t1.participante_id = t2.participante_id
		AND t1.compania_id = t2.compania_id
		AND t1.ramo_id = t2.ramo_id
	WHERE t1.fechaRecaudo IS NOT NULL
		AND t1.anioCierre = @añoenCurso

	--  Comparativo Colquines Año Anterior vs Año Actual
	UPDATE TablaMaestra
	SET porcentajeCrecimientoColquinesTotal = (
			CASE 
				WHEN cantidadColquinesAnoAnterior = 0
					THEN NULL
				ELSE ((cantidadColquines / cantidadColquinesAnoAnterior) * 100)
				END
			)
	WHERE (
			cantidadColquines IS NOT NULL
			OR cantidadColquinesAnoAnterior IS NOT NULL
			)
		AND anioCierre = @añoenCurso

	--  Actualización Año Actual
	UPDATE TablaMaestra
	SET añoActual = @añoenCurso
	WHERE anioCierre = @añoenCurso

	--  Actualización Año Actual
	UPDATE TablaMaestra
	SET añoAnterior = (@añoenCurso - 1)
	WHERE anioCierre = @añoenCurso

	-- Inserción de los Colquines obtenidos por premios.
	INSERT INTO TablaMaestra (
		fechaRecaudo
		,participante_id
		,cantidadColquines
		,anioCierre
		,mesCierre
		)
	SELECT lm.fechaLiquidacion
		,lm.participante_id
		,lm.cantidad
		,YEAR(lm.fechaLiquidacion)
		,MONTH(lm.fechaLiquidacion)
	FROM LiquidacionMoneda lm
	WHERE lm.tipo = 3 -- Colquines por premios pagados.

	INSERT INTO TablaMaestra (
		participante_id
		,compania_id
		,ramo_id
		,ramoDetalle_id
		,anioCierre
		,cantidadColquines
		,conceptoDescuento_id
		,mesCierre
		)
	SELECT s.participante_id
		,s.compania_id
		,rd.ramo_id
		,s.ramoDetalle_id
		,s.anio
		,s.colquinesDescontar
		,1 -- Concepto: Siniestralidad (dbo.ConceptoDescuento)
		,s.ultimoMes
	FROM SiniestralidadAcumulada s
	INNER JOIN RamoDetalle rd ON s.ramoDetalle_id = rd.id
	WHERE s.anio = @añoenCurso
		AND s.colquinesDescontar < 0

	INSERT INTO TablaMaestra (
		participante_id
		,compania_id
		,ramo_id
		,anioCierre
		,cantidadColquines
		,conceptoDescuento_id
		,mesCierre
		,plazo_id
		)
	SELECT pca.participante_id
		,3 -- CAPI
		,pca.ramo_id
		,pca.anioCierreNegocio
		,pca.colquinesDescontar
		,2 -- Concepto: PersistenciadeCAPI (dbo.ConceptoDescuento)
		,pca.ultimoPeriodo
		,pca.plazo_id
	FROM PersistenciadeCAPIAcumulada pca
	WHERE pca.anioCierreNegocio = @añoenCurso
		AND pca.colquinesDescontar < 0

	INSERT INTO TablaMaestra (
		participante_id
		,compania_id
		,ramo_id
		,anioCierre
		,cantidadColquines
		,conceptoDescuento_id
		,mesCierre
		)
	SELECT participante_id
		,compania_id
		,ramo_id
		,añoAMedir
		,colquinesDescontar
		,3 -- Concepto: PersistenciadeVIDA (Def.) (dbo.ConceptoDescuento)
		,mesCorte
	FROM PersistenciadeVIDA
	WHERE añoAMedir = @añoenCurso
		AND LTRIM(RTRIM(tipoPersistencia)) = '2'
		AND colquinesDescontar < 0
		AND persistenciaDefinitiva > 0

	INSERT INTO TablaMaestra (
		participante_id
		,compania_id
		,ramo_id
		,anioCierre
		,cantidadColquines
		,conceptoDescuento_id
		,mesCierre
		)
	SELECT participante_id
		,compania_id
		,ramo_id
		,añoAMedir
		,colquinesDescontar
		,4 -- Concepto: PersistenciadeVIDA (Per.) (dbo.ConceptoDescuento)
		,mesCorte
	FROM PersistenciadeVIDA
	WHERE añoAMedir = @añoenCurso
		AND LTRIM(RTRIM(tipoPersistencia)) = '1'
		AND colquinesDescontar < 0
		AND persistenciaDefinitiva > 0

	INSERT INTO TablaMaestra (
		fechaRecaudo
		,participante_id
		,cantidadColquines
		,anioCierre
		,mesCierre
		,compania_id
		,conceptoDescuento_id
		)
	SELECT lm.fechaCargue
		,lm.participante_id
		,lm.cantidad
		,YEAR(lm.fechaCargue)
		,MONTH(lm.fechaCargue)
		,compania_id
		,5 -- Concepto: Colquines Manuales
	FROM LiquidacionMoneda lm
	WHERE lm.tipo = 4 -- Colquines Manuales.
		AND lm.jerarquiaDetalle_id IS NULL
		AND YEAR(lm.fechaCargue) = @añoenCurso

	INSERT INTO TablaMaestra (
		fechaRecaudo
		,clave
		,cantidadColquines
		,anioCierre
		,mesCierre
		,compania_id
		,conceptoDescuento_id
		,ramo_id
		,localidad_id
		,producto_id
		,participante_id
		)
	SELECT pc.fechaProceso
		,pc.clave
		,pc.cantidad
		,pc.año
		,MONTH(pc.fechaProceso)
		,pc.compania_id
		,6 -- Concepto: Colquines x combo
		,pc.ramo_id
		,pc.localidad_id
		,pc.producto_id
		,p.id AS participante_id
	FROM PremiosxComboCRM pc
	INNER JOIN Participante p ON p.clave = pc.clave

	-- Actualización de campos
	UPDATE TablaMaestra
	SET plazo_id = 0
	WHERE plazo_id IS NULL

	UPDATE TablaMaestra
	SET categoria_id = p.categoria_id
	FROM TablaMaestra tm
	INNER JOIN Participante p ON p.id = tm.participante_id
	WHERE tm.categoria_id IS NULL

	UPDATE TablaMaestra
	SET fechaIngresoAsesor = p.fechaIngreso
	FROM TablaMaestra tm
	INNER JOIN Participante p ON p.id = tm.participante_id
	WHERE tm.fechaIngresoAsesor IS NULL

	ALTER INDEX [PK_TablaMaestra] ON [dbo].[TablaMaestra] REBUILD PARTITION = ALL
		WITH (
				PAD_INDEX = OFF
				,STATISTICS_NORECOMPUTE = OFF
				,ALLOW_ROW_LOCKS = ON
				,ALLOW_PAGE_LOCKS = ON
				,ONLINE = OFF
				,SORT_IN_TEMPDB = OFF
				)

	ALTER INDEX [IX_participante_id] ON [dbo].[TablaMaestra] REBUILD PARTITION = ALL
		WITH (
				PAD_INDEX = OFF
				,STATISTICS_NORECOMPUTE = OFF
				,ALLOW_ROW_LOCKS = ON
				,ALLOW_PAGE_LOCKS = ON
				,ONLINE = OFF
				,SORT_IN_TEMPDB = OFF
				)

	ALTER INDEX [IX_fechaExpedicionNegocio] ON [dbo].[TablaMaestra] REBUILD PARTITION = ALL
		WITH (
				PAD_INDEX = OFF
				,STATISTICS_NORECOMPUTE = OFF
				,ALLOW_ROW_LOCKS = ON
				,ALLOW_PAGE_LOCKS = ON
				,ONLINE = OFF
				,SORT_IN_TEMPDB = OFF
				)

	DROP TABLE #NegociosxAñoVigente

	DROP TABLE #RecaudoxAñoVigente

	--Log Errores
	DECLARE @cantidadFinal AS INT = (SELECT COUNT(*) FROM TablaMaestra)
	DECLARE @delta AS INT = @cantidadFinal - @cantidadInicial
	DECLARE @idActualizacion AS INT = (
		SELECT MAX(id) FROM LogIntegracion WHERE proceso = 'Generacion de la Tabla Maestra'
		AND estado = 1
		)

	UPDATE LogIntegracion
	SET fechaFin = GETDATE()
		,estado = 2
		,cantidad = @delta
	WHERE id = @idActualizacion

	-- *********************************************************************************************************
	-- ACTUALIZACIÓN FIN INTEGRACIÓN SAI
	-- *********************************************************************************************************
	UPDATE LogIntegracion
	SET fechaFin = GETDATE()
		,estado = 2
	WHERE fechaFin IS NULL
		AND proceso = 'Integracion SAI'
		AND estado = 1
END
