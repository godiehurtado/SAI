-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarFranquiciasDetalleTotal]
	-- Add the parameters for the stored procedure here
	@idLiquidacion int,
	@fechaini datetime,
	@fechafin datetime 
AS
BEGIN

	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @idLiquidacionParam int = @idLiquidacion
	DECLARE @fechainiParam datetime = @fechaini
	DECLARE @fechafinParam datetime = @fechafin
	
	--delete from DetalleLiquidacionFranquicia where liquidacionFranquicia_id = 131

	-- PROCESOS UTILIZADOS EN LA LIQUIDACION DE FRANQUICIAS
	-- Proceso 0: Iniciando Liquidacion
	-- Proceso 1: Obteniendo Recaudos
	-- Proceso 2: Liquidando Excepciones
	-- Proceso 3: Liquidando Porcentajes por Participacion
	-- Proceso 4: Obteniendo informacion para liquidar porcentajes por rangos
	-- Proceso 5: Liquidando Porcentajes Participacion Por Rangos
	-- Proceso 6: Terminando Liquidacion Franquicias

	-- *********************************************************************************************************
	-- CREAMOS TABLA TEMPORAL CON LOS RECAUDOS POR LA FECHA SELECCIONADA
	-- *********************************************************************************************************
	--DROP TABLE #Recaudos
	CREATE TABLE #Recaudos(
		compania_id int NULL,
		ramoDetalle_id int NULL,
		productoDetalle_id int NULL,
		valorRecaudo float,
		numeroNegocio nvarchar(250) COLLATE Modern_Spanish_CI_AS NULL,
		clave nvarchar(250) COLLATE Modern_Spanish_CI_AS NULL,
		modalidadpago_id int NULL,
		localidad_id int NULL,
		numeroRecibo nvarchar(250) COLLATE Modern_Spanish_CI_AS NULL,
		fechaRecaudo datetime NULL,
		fechaCobranza datetime NULL, 
		amparo_id int NULL,
		lineaNegocio_id int NULL,
		zona_id int NULL,
		Altura int NULL,
		participante_id int NULL,
		Concepto nvarchar(250) COLLATE Modern_Spanish_CI_AS NULL,
		segmento_id int NULL
	)	
	

    Create Index i1 ON #Recaudos(compania_id)
    Create Index i2 ON #Recaudos(ramoDetalle_id)
    Create Index i3 ON #Recaudos(productoDetalle_id)
    Create Index i4 ON #Recaudos(numeroNegocio)
    Create Index i5 ON #Recaudos(clave)
    Create Index i6 ON #Recaudos(modalidadpago_id)
    Create Index i7 ON #Recaudos(localidad_id)	

	INSERT INTO #Recaudos(compania_id, ramoDetalle_id, productoDetalle_id, valorRecaudo, numeroNegocio, clave, modalidadpago_id, localidad_id,numeroRecibo, fechaRecaudo, fechaCobranza,  amparo_id, lineaNegocio_id, zona_id, Altura, participante_id, Concepto,segmento_id)
	SELECT 
		r.compania_id,
		r.ramoDetalle_id,
		r.productoDetalle_id,
		r.valorRecaudo,
		r.numeroNegocio,
		r.clave,
		r.modalidadpago_id,
		r.localidad_id,			
		r.numeroRecibo,
		r.fechaRecaudo,
		r.fechaCobranza, 
		r.amparo_id,
		r.lineaNegocio_id,
		r.zona_id,
		r.Altura,
		r.participante_id,
		r.Concepto,
		r.segmento_id
	FROM recaudo r
	WHERE r.fechaCobranza between @fechainiParam and @fechafinParam

	
	-- SOLO TOMAMOS LOS RECAUDOS DEL PARTICIPANTE QUE PERTENECE AL CANAL FRANQUICIAS CON EL FIN DE NO DUPLICAR LOS RECAUDOS
	-- CAMBIO SOLICITADO 21/08/2012
	INSERT INTO DetalleLiquidacionFranquicia(
	porcentajeParticipacion, 
	totalParticipacion, 
	liquidacionFranquicia_id, 
	localidad_id, 
	compania_id, 
	ramo_id, 
	producto_id, 
	valorRecaudo, 
	numeroNegocio, 
	nivelDirector,  
	claveParticipante, 
	modalidadPagoId,  
	numeroRecibo, 
	fechaRecaudo, 
	fechaContabl, 
	amparo_Id, 
	colquines, 
	lineaNegocio_id, 
	zona_id, 
	codigo_agrupador, 
	tipoVehiculo,
	liquidadoPor,
	ramo_id_agrupado,
	producto_id_agrupado,
	concepto,
	altura,
	segmento_id)
	SELECT 
		0,
		0,
		@idLiquidacionParam,
		p.localidad_id,
		r.compania_id,
		r.ramoDetalle_id,
		r.productoDetalle_id,
		r.valorRecaudo,
		r.numeroNegocio,
		'',
		r.clave,
		r.modalidadpago_id,
		r.numeroRecibo,
		r.fechaRecaudo,
		r.fechaCobranza, 
		r.amparo_id,
		0,
		r.lineaNegocio_id,
		r.zona_id,
		'' as codigo,
		0 as tipoVehiculoId,
		0,
		rd.ramo_id,
		pd.producto_id,
		CASE rd.ramo_id WHEN 9 
			THEN r.Concepto
			ELSE ''
		END as concepto,
		r.Altura,
		r.segmento_id			
	FROM #Recaudos r	
	INNER JOIN ramoDetalle rd ON r.ramoDetalle_id = rd.id
	INNER JOIN productoDetalle pd ON r.productoDetalle_id = pd.id
	INNER JOIN Participante p ON r.participante_id = p.id
	INNER JOIN localidad l ON l.id = p.localidad_id	
	WHERE l.tipo_localidad_id=2 and r.fechaCobranza between @fechainiParam and @fechafinParam and p.canal_id = 7

	-- INSERTAMOS LOS RECAUDOS DE LAS EXCEPCIONES QUE TENGAN EXCEPCION_RECAUDO EN TRUE
	-- ESTAS EXCEPCIONES SON EXCLUSIVAS PARA LOCALIDADES QUE NO SON DE TIPO FRANQUICIA Y QUE POR ENDE
	-- NO SE SELECCIONAN EN EL QUERY ANTERIOR PERO QUE SE DEBEN LIQUIDAR COMO FRANQUICIAS (EJEMPLO. ALIANZAS Y MASIVOS)
	
	-- Combinacion 1 CLAVE + NUMERO NEGOCIO + LOCALIDAD
	INSERT INTO DetalleLiquidacionFranquicia(
	porcentajeParticipacion, 
	totalParticipacion, 
	liquidacionFranquicia_id, 
	localidad_id, 
	compania_id, 
	ramo_id, 
	producto_id, 
	valorRecaudo, 
	numeroNegocio, 
	nivelDirector,  
	claveParticipante, 
	modalidadPagoId,  
	numeroRecibo, 
	fechaRecaudo, 
	fechaContabl, 
	amparo_Id, 
	colquines, 
	lineaNegocio_id, 
	zona_id, 
	codigo_agrupador, 
	tipoVehiculo,
	liquidadoPor,
	ramo_id_agrupado,
	producto_id_agrupado,
	concepto,
	altura,
	segmento_id)
	SELECT 
		0,
		0,
		@idLiquidacionParam,
		e.Localidad_id,
		r.compania_id,
		r.ramoDetalle_id,
		r.productoDetalle_id,
		r.valorRecaudo,
		r.numeroNegocio,
		'',
		r.clave,
		r.modalidadpago_id,
		r.numeroRecibo,
		r.fechaRecaudo,
		r.fechaCobranza, 
		r.amparo_id,
		0,
		r.lineaNegocio_id,
		r.zona_id,
		'' as codigo,
		0 as tipoVehiculoId,
		4, -- TIPO EXCEPCIONES ESPECIALES LOCALIDAD QUE NO ES FRANQUICIA
		rd.ramo_id,
		pd.producto_id,
		CASE rd.ramo_id WHEN 9 
			THEN r.Concepto
			ELSE ''
		END as concepto,
		r.Altura,
		r.segmento_id				
	FROM #Recaudos r	
	INNER JOIN ramoDetalle rd ON r.ramoDetalle_id = rd.id
	INNER JOIN productoDetalle pd ON r.productoDetalle_id = pd.id
	INNER JOIN Excepcion e ON r.clave = e.clave and r.numeroNegocio = e.negocio_id and r.localidad_id = e.localidad_de_id
	WHERE r.fechaCobranza between @fechainiParam and @fechafinParam and e.excepcion_recaudo = 1		

	-- Combinacion 2 CLAVE + LOCALIDAD
	INSERT INTO DetalleLiquidacionFranquicia(
	porcentajeParticipacion, 
	totalParticipacion, 
	liquidacionFranquicia_id, 
	localidad_id, 
	compania_id, 
	ramo_id, 
	producto_id, 
	valorRecaudo, 
	numeroNegocio, 
	nivelDirector,  
	claveParticipante, 
	modalidadPagoId,  
	numeroRecibo, 
	fechaRecaudo, 
	fechaContabl, 
	amparo_Id, 
	colquines, 
	lineaNegocio_id, 
	zona_id, 
	codigo_agrupador, 
	tipoVehiculo,
	liquidadoPor,
	ramo_id_agrupado,
	producto_id_agrupado,
	concepto,
	altura,
	segmento_id)
	SELECT 
		0,
		0,
		@idLiquidacionParam,
		e.Localidad_id,
		r.compania_id,
		r.ramoDetalle_id,
		r.productoDetalle_id,
		r.valorRecaudo,
		r.numeroNegocio,
		'',
		r.clave,
		r.modalidadpago_id,
		r.numeroRecibo,
		r.fechaRecaudo,
		r.fechaCobranza, 
		r.amparo_id,
		0,
		r.lineaNegocio_id,
		r.zona_id,
		'' as codigo,
		0 as tipoVehiculoId,
		4, -- TIPO EXCEPCIONES ESPECIALES LOCALIDAD QUE NO ES FRANQUICIA
		rd.ramo_id,
		pd.producto_id,
		CASE rd.ramo_id WHEN 9 
			THEN r.Concepto
			ELSE ''
		END as concepto,
		r.Altura,
		r.segmento_id	
	FROM #Recaudos r	
	INNER JOIN ramoDetalle rd ON r.ramoDetalle_id = rd.id
	INNER JOIN productoDetalle pd ON r.productoDetalle_id = pd.id
	INNER JOIN Excepcion e ON r.clave = e.clave and r.localidad_id = e.localidad_de_id
	WHERE r.fechaCobranza between @fechainiParam and @fechafinParam and e.negocio_id = '' and e.excepcion_recaudo = 1
	and CAST(cast(r.numeroNegocio as varchar) + cast(r.clave as varchar) + cast(e.Localidad_id as varchar) AS BIGINT) NOT IN (SELECT CAST(cast(dlf.numeroNegocio as varchar) + cast(dlf.claveParticipante as varchar) + cast(dlf.localidad_id as varchar) AS BIGINT) FROM DetalleLiquidacionFranquicia dlf WHERE dlf.liquidacionFranquicia_id = @idLiquidacionParam and dlf.liquidadoPor = 4)

	-- *********************************************************************************************************
	-- CREAMOS TABLA TEMPORAL CON LOS NEGOCIOS QUE INTERVIENEN EN LA LIQUIDACION
	-- *********************************************************************************************************
	--DROP TABLE #Negocios
	CREATE TABLE #Negocios(
		id bigint NOT NULL,
		numeroNegocio nvarchar(250) COLLATE Modern_Spanish_CI_AS NULL,
		codigoAgrupador nvarchar(250) NULL,
		tipoVehiculo_id int NULL,
		compania_id int NULL,
		ramoDetalle_id int NULL,
		productoDetalle_id int NULL,
		localidad_id int NULL,
		fechaExpedicion datetime NULL
	)	

    Create Index i1 ON #Negocios(id)
    Create Index i2 ON #Negocios(numeroNegocio)
    Create Index i3 ON #Negocios(tipoVehiculo_id)
    Create Index i4 ON #Negocios(compania_id)
    Create Index i5 ON #Negocios(ramoDetalle_id)
    Create Index i6 ON #Negocios(productoDetalle_id)
    Create Index i7 ON #Negocios(localidad_id)
    
    -- PARA LOS NEGOCIOS TAMBIEN CAMBIAMOS LA LOCALIDAD DE EXPEDICION POR LA DEL PARTICIPANTE TAL CUAL COMO SE HACE EN LOS RECAUDOS
    -- CUANDO SE PASAN A LA LIQUIDACION DE FRANQUICIAS
    INSERT INTO #Negocios(id, numeroNegocio,codigoAgrupador,tipoVehiculo_id,compania_id,ramoDetalle_id,productoDetalle_id,localidad_id,fechaExpedicion)
    SELECT n.id,dlf.numeroNegocio,n.codigoAgrupador,n.tipoVehiculo_id,n.compania_id,n.ramoDetalle_id,n.productoDetalle_id,p.localidad_id,n.fechaExpedicion
    FROM 
    ( 
		SELECT numeroNegocio 
		FROM
		DetalleLiquidacionFranquicia
		WHERE liquidacionFranquicia_id = @idLiquidacionParam
		GROUP BY numeroNegocio
	) as dlf
    INNER JOIN Negocio as n ON dlf.numeroNegocio = n.numeroNegocio
    INNER JOIN Participante as p ON n.clave =  p.clave		
    ORDER BY dlf.numeroNegocio

	-- *********************************************************************************************************
	-- CREAMOS TABLA TEMPORAL CON LOS NEGOCIOS AGRUPADOS POR FECHAS
	-- *********************************************************************************************************
	--DROP TABLE #NegociosFechas
	CREATE TABLE #NegociosFechas(
		maxFecha datetime NULL,
		maxId bigint NULL,
		numeroNegocio nvarchar(250) COLLATE Modern_Spanish_CI_AS,
		localidad_id int NULL,
		compania_id int NULL,
		ramoDetalle_id int NULL,
		productoDetalle_id int NULL
	)	
	
    Create Index i2 ON #NegociosFechas(maxFecha)
    Create Index i4 ON #NegociosFechas(maxId)
    Create Index i5 ON #NegociosFechas(numeroNegocio)
    Create Index i6 ON #NegociosFechas(localidad_id)

	INSERT INTO #NegociosFechas(maxFecha,maxId,numeroNegocio,compania_id, ramoDetalle_id, productoDetalle_id, localidad_id	)
	SELECT MAX(fechaExpedicion) as maxFecha, MAX(id) as maxId, numeroNegocio, compania_id, ramoDetalle_id, productoDetalle_id, localidad_id	
	FROM #Negocios
	GROUP BY numeroNegocio, compania_id, ramoDetalle_id, productoDetalle_id, localidad_id	

	-- *********************************************************************************************************
	-- CREAMOS TABLA TEMPORAL CON LOS NEGOCIOS CON SU TIPO DE VEHICULO
	-- *********************************************************************************************************
	--DROP TABLE #NegociosTipoVehiculo
	CREATE TABLE #NegociosTipoVehiculo(
		numeroNegocio nvarchar(250) COLLATE Modern_Spanish_CI_AS NULL,
		codigoAgrupador nvarchar(250) NULL,
		tipoVehiculo_id int NULL,
		tipoVehiculo nvarchar(250) NULL,
		compania_id int NULL,
		ramoDetalle_id int NULL,
		productoDetalle_id int NULL,
		localidad_id int NULL
	)	

    Create Index i2 ON #NegociosTipoVehiculo(numeroNegocio)
    Create Index i4 ON #NegociosTipoVehiculo(compania_id)
    Create Index i5 ON #NegociosTipoVehiculo(ramoDetalle_id)
    Create Index i6 ON #NegociosTipoVehiculo(productoDetalle_id)
    Create Index i7 ON #NegociosTipoVehiculo(localidad_id)
    
    INSERT INTO #NegociosTipoVehiculo(codigoAgrupador,tipoVehiculo_id,tipoVehiculo,numeroNegocio,compania_id,ramoDetalle_id,productoDetalle_id,localidad_id)
	SELECT n1.codigoAgrupador, n1.tipoVehiculo_id, tv.nombre as tipovehiculo, n1.numeroNegocio, n1.compania_id, n1.ramoDetalle_id, n1.productoDetalle_id,n1.localidad_id
	FROM 	
	#NegociosFechas AS sub1 
	INNER JOIN #Negocios n1 ON n1.numeroNegocio = sub1.numeroNegocio AND n1.fechaExpedicion = sub1.maxFecha AND n1.id = sub1.maxId AND n1.localidad_id = sub1.localidad_id
	INNER JOIN TipoVehiculo tv ON tv.id = n1.tipoVehiculo_id	
	GROUP BY n1.codigoAgrupador, n1.tipoVehiculo_id, tv.nombre, n1.numeroNegocio, n1.compania_id, n1.ramoDetalle_id,n1.productoDetalle_id,n1.localidad_id
    
	UPDATE DetalleLiquidacionFranquicia 
	SET codigo_agrupador = COALESCE(n.codigoAgrupador,''),tipoVehiculo = COALESCE(n.tipoVehiculo_id,0)
	FROM 
	DetalleLiquidacionFranquicia AS dlf
	LEFT JOIN #NegociosTipoVehiculo AS n ON n.numeroNegocio = dlf.numeroNegocio AND n.compania_id = dlf.compania_id AND n.ramoDetalle_id = dlf.ramo_id AND n.productoDetalle_id = dlf.producto_id AND n.localidad_id = dlf.localidad_id
	WHERE liquidacionFranquicia_id = @idLiquidacionParam
	
	--ACTUALIZAMOS LOS ACUMULADOS ANTERIORES POR SI HAY LIQUIDACIONES DE RANGOS
	DECLARE @idReliquidada int = (SELECT id_liquidacion_reliquidada FROM LiquidacionFranquicia WHERE id = @idLiquidacionParam)
	DECLARE @mes int = MONTH(@fechainiParam)
	DECLARE @anio int = YEAR(@fechainiParam)
	DECLARE @nombreCol varchar(20)
	DECLARE @Sentencia varchar(max)
	
	SET @nombreCol = 
	CASE 
		WHEN @mes = 1 THEN 'enero'
		WHEN @mes = 2 THEN 'febrero'
		WHEN @mes = 3 THEN 'marzo'
		WHEN @mes = 4 THEN 'abril'
		WHEN @mes = 5 THEN 'mayo'
		WHEN @mes = 6 THEN 'junio'
		WHEN @mes = 7 THEN 'julio'
		WHEN @mes = 8 THEN 'agosto'
		WHEN @mes = 9 THEN 'septiembre'
		WHEN @mes = 10 THEN 'octubre'
		WHEN @mes = 11 THEN 'noviembre'
		WHEN @mes = 12 THEN 'diciembre'		
	END	

	IF (@idReliquidada > 0 ) 
	BEGIN
		SET @Sentencia = 'UPDATE DetalleLiquiRangosFranq SET acumuladoTotal = ' + @nombreCol + 
						 ' WHERE anio = ' + CONVERT(VARCHAR(10),@anio)
	END
	ELSE
	BEGIN
		SET @Sentencia = 'UPDATE DetalleLiquiRangosFranq SET ' + @nombreCol + ' = acumuladoTotal ' + 
						 ' WHERE anio = ' + CONVERT(VARCHAR(10),@anio)	
	END
			 
	EXEC (@Sentencia)
	
	DROP TABLE #Negocios	
	DROP TABLE #NegociosTipoVehiculo
	DROP TABLE #NegociosFechas
	DROP TABLE #Recaudos
	
	INSERT INTO LiquidacionContratacionDebug(prueba1) VALUES (100)
	
	return 1	
END

