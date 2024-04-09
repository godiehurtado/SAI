
CREATE PROCEDURE [dbo].[SAI_SegmentacionComision]
AS
BEGIN
	-- *********************************************************************************************************
	-- SEGMENTACIÓN Y ACTUALIZACIÓN DE LÍNEA DE NEGOCIO
	-- *********************************************************************************************************		
	-- La información de comisiones viene sin segmentar y sin línea de negocio correcta. 
	-- Se utiliza la tabla de recaudo para definir estos dos campos.
	DECLARE @anioVigente AS INT = (SELECT valor FROM ParametrosApp WHERE id = 3)
	DECLARE @mesActual AS NVARCHAR(10) = MONTH (GETDATE())
	DECLARE @mesAnterior AS NVARCHAR(10) = MONTH (DATEADD(MM, - 1, GETDATE()))

	-- ************************************* 
	--   Actualización de Participante
	-- *************************************
	UPDATE Comisiontemp
	SET claveAsesor = LTRIM(RTRIM(claveAsesor))

	IF (
			@mesActual > '1'
			AND YEAR(GETDATE()) = @anioVigente
			)
	BEGIN
		SET @mesAnterior = CAST(@anioVigente AS NVARCHAR(5)) + '-' + @mesAnterior + '-01'
		SET @mesActual = DATEADD(DD, - 1, DATEADD(MM, 2, CAST(@mesAnterior AS DATE)))
	END

	IF (
			@mesActual = '1'
			AND YEAR(GETDATE()) = @anioVigente
			)
	BEGIN
		SET @mesAnterior = CAST((CAST(@anioVigente AS INT) - 1) AS NVARCHAR(5)) + '-' + @mesAnterior + '-01'
		SET @mesActual = DATEADD(DD, - 1, DATEADD(MM, 2, CAST(@mesAnterior AS DATE)))
	END

	IF (
			@mesActual = '1'
			AND (YEAR(GETDATE()) - 1) = @anioVigente
			)
	BEGIN
		SET @mesAnterior = CAST(@anioVigente AS NVARCHAR(5)) + '-' + @mesAnterior + '-01'
		SET @mesActual = DATEADD(DD, - 1, DATEADD(MM, 2, CAST(@mesAnterior AS DATE)))
	END

	IF (
			@mesActual > '1'
			AND (YEAR(GETDATE()) - 1) = @anioVigente
			)
	BEGIN
		SET @mesAnterior = CAST((CAST(@anioVigente AS INT) + 1) AS NVARCHAR(5)) + '-' + @mesAnterior + '-01'
		SET @mesActual = DATEADD(DD, - 1, DATEADD(MM, 2, CAST(@mesAnterior AS DATE)))
	END

	-- ************************************* 
	--   Inserta en la tabla de comisiones
	-- *************************************	
	INSERT INTO Comision (
		ramo_id
		,participante_id
		,lineaNegocio_id
		,localidad_id
		,concepto
		,companiaMovimiento_id
		,companiaAsesor_id
		,clave
		,año
		,mes
		,valorConcepto
		,indicadorPago
		,numeroNegocio
		)
	SELECT ct.ramo2
		,p.id AS participante_id
		,ct.identificacionNegocio
		,ct.localidadRecaudo
		,ct.codigoConcepto
		,ct.codigoEmpresaNovedad
		,ct.codigoEmpresa
		,ct.claveAsesor
		,ct.añoTransaccion
		,ct.mesTransaccion
		,ct.valorConcepto
		,ct.indicadorPago
		,RTRIM(LTRIM(ct.numeroNegocio1)) AS numeroNegocio
	FROM Comisiontemp ct
	INNER JOIN Participante p ON p.clave = ct.claveAsesor
	WHERE ISNUMERIC(ct.valorConcepto) = 1
		AND CAST(CAST(ct.añoTransaccion AS NVARCHAR(5)) + '-' + CAST(ct.mesTransaccion AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- ************************************* 
	--   Actualización de Línea de Negocio
	-- *************************************
	-- Para CAPI solamente se tiene en cuenta la combinación Negocio + Compañía
	UPDATE Comision
	SET lineaNegocio_id = r.lineaNegocio_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(SUBSTRING(r.numeroNegocio, 0, LEN(r.numeroNegocio) - 2) AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND r.mesCierre = c.mes
		AND r.anioCierre = c.año
	WHERE r.compania_id = 3
		AND c.companiaMovimiento_id = 3
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual
		AND CAST(CAST(r.anioCierre AS NVARCHAR(5)) + '-' + CAST(r.mesCierre AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para GENERALES se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad.
	UPDATE Comision
	SET lineaNegocio_id = r.lineaNegocio_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.numeroNegocio AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND r.localidad_id = c.localidad_id
		AND c.participante_id = r.participante_id
		AND r.mesCierre = c.mes
		AND r.anioCierre = c.año
	INNER JOIN RamoDetalle AS rd ON rd.id = r.ramoDetalle_id
		AND rd.ramo_id = c.ramo_id
	WHERE r.compania_id = 1
		AND c.companiaMovimiento_id = 1
		AND rd.ramo_id <> 9
		AND c.ramo_id <> 9
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual
		AND CAST(CAST(r.anioCierre AS NVARCHAR(5)) + '-' + CAST(r.mesCierre AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para GENERALES Ramo SOAT se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
	-- haciendo el cruce de datos por el Concepto del recaudo (# formulario)
	UPDATE Comision
	SET lineaNegocio_id = r.lineaNegocio_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.Concepto AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND r.localidad_id = c.localidad_id
		AND r.participante_id = c.participante_id
		AND r.mesCierre = c.mes
		AND r.anioCierre = c.año
	INNER JOIN RamoDetalle AS rd ON rd.id = r.ramoDetalle_id
		AND rd.ramo_id = c.ramo_id
	WHERE r.compania_id = 1
		AND c.companiaMovimiento_id = 1
		AND rd.ramo_id = 9
		AND c.ramo_id = 9
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual
		AND CAST(CAST(r.anioCierre AS NVARCHAR(5)) + '-' + CAST(r.mesCierre AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para VIDA se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
	UPDATE Comision
	SET lineaNegocio_id = r.lineaNegocio_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.numeroNegocio AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND r.localidad_id = c.localidad_id
		AND c.participante_id = r.participante_id
		AND r.mesCierre = c.mes
		AND r.anioCierre = c.año
	INNER JOIN RamoDetalle AS rd ON rd.id = r.ramoDetalle_id
		AND rd.ramo_id = c.ramo_id
	WHERE r.compania_id = 2
		AND c.companiaMovimiento_id = 2
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual
		AND CAST(CAST(r.anioCierre AS NVARCHAR(5)) + '-' + CAST(r.mesCierre AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para BH se tiene en cuenta la combinación Compañía + Negocio + Participante
	UPDATE Comision
	SET lineaNegocio_id = r.lineaNegocio_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.numeroNegocio AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND c.participante_id = r.participante_id
		AND r.mesCierre = c.mes
		AND r.anioCierre = c.año
	WHERE r.compania_id = 5
		AND c.companiaMovimiento_id = 5
		AND r.sistema = 'BH'
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual
		AND CAST(CAST(r.anioCierre AS NVARCHAR(5)) + '-' + CAST(r.mesCierre AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para EMERMEDICA se tiene en cuenta la combinación Compañía + Negocio + Participante
	UPDATE Comision
	SET lineaNegocio_id = r.lineaNegocio_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.numeroNegocio AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND c.participante_id = r.participante_id
		AND r.mesCierre = c.mes
		AND r.anioCierre = c.año
	WHERE r.compania_id = 5
		AND c.companiaMovimiento_id = 5
		AND r.sistema = 'EMERMEDICA'
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual
		AND CAST(CAST(r.anioCierre AS NVARCHAR(5)) + '-' + CAST(r.mesCierre AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- **********************************
	--   Actualización de Ramo para CAPI
	-- **********************************
	-- Para CAPI  si el ramo de la comision es 0 se actualiza el ramo de la comision
	-- con el ramo del recaudo (haciendo el cruce por numeroNegocio).
	UPDATE Comision
	SET ramo_id = rd.ramo_id
	FROM Comision c
	INNER JOIN Recaudo AS r ON CAST(SUBSTRING(r.numeroNegocio, 0, LEN(r.numeroNegocio) - 2) AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
	INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
	WHERE r.compania_id = 3
		AND c.ramo_id = 0
		AND c.companiaMovimiento_id = 3
		AND c.año = @anioVigente

	-- *****************************
	--   Actualización de Segmento
	-- *****************************
	-- Para CAPI solamente se tiene en cuenta la combinación Negocio + Compañía
	UPDATE Comision
	SET segmento_id = r.segmento_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(SUBSTRING(r.numeroNegocio, 0, LEN(r.numeroNegocio) - 2) AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
	WHERE r.compania_id = 3
		AND c.companiaMovimiento_id = 3
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para GENERALES se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad + Participante
	UPDATE Comision
	SET segmento_id = r.segmento_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.numeroNegocio AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND r.localidad_id = c.localidad_id
		AND c.participante_id = r.participante_id
	INNER JOIN RamoDetalle AS rd ON rd.id = r.ramoDetalle_id
		AND rd.ramo_id = c.ramo_id
	WHERE r.compania_id = 1
		AND c.companiaMovimiento_id = 1
		AND rd.ramo_id <> 9
		AND c.ramo_id <> 9
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para GENERALES Ramo SOAT se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
	-- haciendo el cruce de datos por el Concepto del recaudo (# formulario)
	UPDATE Comision
	SET segmento_id = r.segmento_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.Concepto AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND r.localidad_id = c.localidad_id
		AND r.participante_id = c.participante_id
	INNER JOIN RamoDetalle AS rd ON rd.id = r.ramoDetalle_id
		AND rd.ramo_id = c.ramo_id
	WHERE r.compania_id = 1
		AND c.companiaMovimiento_id = 1
		AND rd.ramo_id = 9
		AND c.ramo_id = 9
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para VIDA se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad + Participante
	UPDATE Comision
	SET segmento_id = r.segmento_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.numeroNegocio AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND r.localidad_id = c.localidad_id
		AND c.participante_id = r.participante_id
	INNER JOIN RamoDetalle AS rd ON rd.id = r.ramoDetalle_id
		AND rd.ramo_id = c.ramo_id
	WHERE r.compania_id = 2
		AND c.companiaMovimiento_id = 2
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para SALUD se tiene en cuenta la combinación Compañía + Negocio + Participante
	UPDATE Comision
	SET segmento_id = r.segmento_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.numeroNegocio AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND c.participante_id = r.participante_id
	WHERE r.compania_id = 5
		AND c.companiaMovimiento_id = 5
		AND r.sistema = 'BH'
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Para EMERMEDICA se tiene en cuenta la combinación Compañía + Negocio + Participante
	UPDATE Comision
	SET segmento_id = r.segmento_id
	FROM Comision AS c
	INNER JOIN Recaudo AS r ON CAST(r.numeroNegocio AS BIGINT) = CAST(c.numeroNegocio AS BIGINT)
		AND c.participante_id = r.participante_id
	WHERE r.compania_id = 5
		AND c.companiaMovimiento_id = 5
		AND r.sistema = 'EMERMEDICA'
		AND CAST(CAST(c.año AS NVARCHAR(5)) + '-' + CAST(c.mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
			AND @mesActual

	-- Actualización de los registros que no se segmentaron.
	UPDATE Comision
	SET segmento_id = 0
	WHERE segmento_id IS NULL
END
