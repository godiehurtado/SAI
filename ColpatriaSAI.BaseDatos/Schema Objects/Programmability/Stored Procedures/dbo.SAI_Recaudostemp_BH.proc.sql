-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza y homologa la información de Recaudos entregada por BH.
--				Se agrega la validación de homologación sobre BancoDetalle
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Recaudostemp_BH]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

	-- *********************************************************************************************************
	-- Validaciones de normalización de información de la tabla dbo.Recaudostemp
	-- *********************************************************************************************************--
	UPDATE recaudostempBH
	SET clave = RTRIM(LTRIM(clave))

	-- FECHAS
	UPDATE recaudostempBH
	SET fechaRecaudo = @DefaultDate
	WHERE fechaRecaudo IS NULL

	UPDATE recaudostempBH
	SET fechaCobranza = @DefaultDate
	WHERE fechaCobranza IS NULL

	UPDATE recaudostempBH
	SET fechaGrabacion = @DefaultDate
	WHERE fechaGrabacion IS NULL

	UPDATE recaudostempBH
	SET formapago_id = '0'
	WHERE formapago_id IS NULL

	UPDATE recaudostempBH
	SET fechaRecaudo = (
			CASE (fechaRecaudo)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaRecaudo)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaRecaudo) IS NULL
									THEN @DefaultDate
								ELSE (fechaRecaudo)
								END
						END
				END
			)

	UPDATE recaudostempBH
	SET fechaGrabacion = (
			CASE (fechaGrabacion)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE 
						WHEN (fechaGrabacion) = '0/00/00'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaGrabacion) IS NULL
									THEN @DefaultDate
								ELSE (fechaGrabacion)
								END
						END
				END
			)

	UPDATE recaudostempBH
	SET fechaCobranza = (
			CASE (fechaCobranza)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaCobranza)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaCobranza) IS NULL
									THEN @DefaultDate
								ELSE (fechaCobranza)
								END
						END
				END
			)

	-- *********************************************************************************************************
	-- Homologación de datos Recaudostemp
	-- *********************************************************************************************************--
	--  Actualiza a '0' la Red de Recaudo que no exsite en la tabla red
	UPDATE recaudostempBH
	SET red_id = '0'
	FROM RecaudostempBH AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM RedDetalle AS v
			WHERE RTRIM(LTRIM(s.red_id)) = RTRIM(LTRIM(v.codigoCore))
				AND CAST(s.compania_id AS INT) = v.compania_id
				AND v.compania_id = 5
			)

	-- Actualiza a '0' las redes que vienen con registros vacios.
	UPDATE recaudostempBH
	SET red_id = '0'
	WHERE red_id = ''

	--  Actualiza a '0' el Codigo del Banco que no existe en la tabla BancoDetalle
	UPDATE recaudostempBH
	SET codigoBanco = '0'
	FROM RecaudostempBH AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM BancoDetalle AS v
			WHERE RTRIM(LTRIM(s.codigoBanco)) = RTRIM(LTRIM(v.codigoCore))
				AND CAST(s.compania_id AS INT) = v.compania_id
				AND v.compania_id = 5
			)

	-- Actualiza a '0' los bancos que vienen con registros vacios.
	UPDATE recaudostempBH
	SET codigoBanco = '0'
	WHERE codigoBanco = ''

	--  Actualiza a '0' el Amparo que no existe en la tabla Amparo
	UPDATE recaudostempBH
	SET amparo_id = '0'
	FROM RecaudostempBH AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM AmparoDetalle AS v
			WHERE RTRIM(LTRIM(s.amparo_id)) = RTRIM(LTRIM(v.codigoCore))
			)

	--  Actualiza a '0' la Forma de Pago que no exsite en la tabla formaPago
	UPDATE recaudostempBH
	SET formaPago_id = '0'
	FROM RecaudostempBH AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM FormaPago AS v
			WHERE CAST(s.formaPago_id AS INT) = v.id
			)

	UPDATE recaudostempBH
	SET Altura = '0'
	WHERE Altura = ''

	UPDATE recaudostempBH
	SET porcentajeAhorro_Inversion = '0'
	WHERE porcentajeAhorro_Inversion = ''

	-- Actualización con el id del Ramo relacionado a la compania configurada en la tabla Ramo
	UPDATE recaudostempBH
	SET ramo_id = rd.id
	FROM RecaudostempBH AS rt
	INNER JOIN Compania c ON c.id = CAST(rt.compania_id AS INT)
	INNER JOIN RamoDetalle AS rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(rt.ramo_id))
	WHERE rd.compania_id = 5

	-- Actualización con el id del Amparo relacionado el AmparoDetalle que se envia en el archivo de Recaudos de BH
	UPDATE recaudostempBH
	SET amparo_id = a.id
	FROM RecaudostempBH AS rt
	INNER JOIN AmparoDetalle ad ON RTRIM(LTRIM(ad.codigoCore)) = RTRIM(LTRIM(rt.amparo_id))
	INNER JOIN Amparo a ON a.id = ad.amparo_id

	-- Actualización con el id de la Cobertura relacionada al codigoCore enviado en el archivo de Recaudos de BH
	UPDATE recaudostempBH
	SET cobertura_id = co.id
	FROM RecaudostempBH AS rt
	INNER JOIN Cobertura co ON RTRIM(LTRIM(co.codigoCore)) = RTRIM(LTRIM(rt.cobertura_id))

	--  Actualización de la Modalidad de pago del Recaudo	
	UPDATE recaudostempBH
	SET modalidadPago_id = 1
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '2'

	UPDATE recaudostempBH
	SET modalidadPago_id = 2
	WHERE RTRIM(LTRIM(modalidadPago_id)) IN (
			'3'
			,'4'
			,'5'
			,'6'
			,'7'
			,'8'
			,'9'
			,'10'
			,'11'
			,'12'
			,'13'
			,'14'
			,'15'
			,'16'
			,'17'
			,'18'
			,'19'
			,'20'
			,'99'
			)

	UPDATE recaudostempBH
	SET modalidadPago_id = 0
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '0'

	-- Actualización con el id del Producto relacionado al codigoCore del ProductoDetalle enviado en el archivo de recaudos de BH
	UPDATE recaudostempBH
	SET producto_id = pd.id
	FROM RecaudostempBH AS rt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(rt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON RTRIM(LTRIM(pd.codigoCore)) = RTRIM(LTRIM(rt.producto_id))
		AND pd.ramoDetalle_id = rd.id
	WHERE rd.compania_id = 5

	-- Actualización con el id del Plan relacionado al codigoCore del plANDetalle enviado en el archivo de recaudos de BH
	UPDATE recaudostempBH
	SET plan_id = pld.id
	FROM RecaudostempBH AS rt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(rt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON pd.id = CAST(rt.producto_id AS INT)
		AND pd.ramoDetalle_id = rd.id
	INNER JOIN PlANDetalle pld ON RTRIM(LTRIM(pld.codigoCore)) = RTRIM(LTRIM(rt.plan_id))
		AND pld.productoDetalle_id = pd.id
	WHERE rd.compania_id = 5

	-- Actualización con el id de la localidad SAI respecto al codigo BH
	UPDATE recaudostempBH
	SET localidad_id = l.id
	FROM RecaudostempBH AS rt
	INNER JOIN Localidad AS l ON CAST(l.[codigo BH] AS INT) = CAST(rt.localidad_id AS INT)

	-- Actualización con el id del Banco Detalle respecto al codigoCore de BH
	UPDATE recaudostempBH
	SET codigoBanco = bd.id
	FROM RecaudostempBH AS rt
	INNER JOIN BancoDetalle AS bd ON RTRIM(LTRIM(bd.codigoCore)) = RTRIM(LTRIM(rt.codigoBanco))
		AND CAST(rt.compania_id AS INT) = bd.compania_id
	WHERE bd.compania_id = 5
		AND rt.codigoBanco <> ''

	-- Actualización con el id de la Red respecto al codigoCore de BH Y la Agrupacion de Redes x Compañía
	UPDATE recaudostempBH
	SET red_id = rd.id
	FROM RecaudostempBH AS rt
	INNER JOIN RedDetalle rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(rt.red_id))
		AND CAST(rt.compania_id AS INT) = rd.compania_id
	WHERE rd.compania_id = 5
		AND rt.red_id <> ''
		/*	-- Las reversiones de recaudos vienen identificados con el código 11 en el campo “estado” de la tabla recaudos , estos se deben multiplicar por (-1)
	UPDATE recaudostempBH
	SET valorRecaudo = (valorRecaudo * (- 1))
	WHERE estado = '11'*/ -- Esto ya no se utliza por que la extracción ya trae los valores Negativos.
END
