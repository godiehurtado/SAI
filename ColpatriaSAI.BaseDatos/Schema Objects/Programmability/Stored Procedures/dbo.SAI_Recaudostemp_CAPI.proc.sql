-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza y homologa la información de Recaudos entregada por CAPI.
--				Se agrega la validación de homologación sobre BancoDetalle
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Recaudostemp_CAPI]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)
	DECLARE @DefaultDate1 DATE

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)
	SET @DefaultDate1 = CONVERT(DATETIME, 0)

	-- *********************************************************************************************************
	-- Validaciones de normalización de información de la tabla dbo.Recaudostemp
	-- *********************************************************************************************************--
	UPDATE RecaudostempCAPI
	SET clave = RTRIM(LTRIM(clave))

	-- FECHAS
	UPDATE RecaudostempCAPI
	SET fechaRecaudo = @DefaultDate
	WHERE fechaRecaudo IS NULL

	UPDATE RecaudostempCAPI
	SET fechaCobranza = @DefaultDate
	WHERE fechaCobranza IS NULL

	UPDATE RecaudostempCAPI
	SET fechaGrabacion = @DefaultDate
	WHERE fechaGrabacion IS NULL

	UPDATE RecaudostempCAPI
	SET formapago_id = '0'
	WHERE formapago_id IS NULL

	UPDATE RecaudostempCAPI
	SET fechaRecaudo = (
			CASE (fechaRecaudo)
				WHEN ''
					THEN @DefaultDate1
				ELSE CASE (fechaRecaudo)
						WHEN '0'
							THEN @DefaultDate1
						ELSE CASE 
								WHEN (fechaRecaudo) IS NULL
									THEN @DefaultDate1
								ELSE (fechaRecaudo)
								END
						END
				END
			)

	UPDATE RecaudostempCAPI
	SET fechaGrabacion = (
			CASE (fechaGrabacion)
				WHEN ''
					THEN @DefaultDate1
				ELSE CASE 
						WHEN (fechaGrabacion) = '0/00/00'
							THEN @DefaultDate1
						ELSE CASE 
								WHEN (fechaGrabacion) IS NULL
									THEN @DefaultDate1
								ELSE (fechaGrabacion)
								END
						END
				END
			)

	UPDATE RecaudostempCAPI
	SET fechaCobranza = (
			CASE (fechaCobranza)
				WHEN ''
					THEN @DefaultDate1
				ELSE CASE (fechaCobranza)
						WHEN '0'
							THEN @DefaultDate1
						ELSE CASE 
								WHEN (fechaCobranza) IS NULL
									THEN @DefaultDate1
								ELSE (fechaCobranza)
								END
						END
				END
			)

	-- *********************************************************************************************************
	-- Homologación de datos Recaudostemp
	-- *********************************************************************************************************--
	--  Actualiza a '0' el amparo que no exsite en la tabla Amparo
	UPDATE RecaudostempCAPI
	SET amparo_id = '0'
	FROM RecaudostempCAPI AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM AmparoDetalle AS v
			WHERE RTRIM(LTRIM(s.amparo_id)) = RTRIM(LTRIM(v.codigoCore))
			)

	--  Actualiza a '0' la Red de Recaudo que no exsite en la tabla red
	UPDATE RecaudostempCAPI
	SET red_id = '0'
	FROM RecaudostempCAPI AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM RedDetalle AS v
			WHERE RTRIM(LTRIM(s.red_id)) = RTRIM(LTRIM(v.codigoCore))
				AND CAST(s.compania_id AS INT) = v.compania_id
				AND v.compania_id = 3
			)

	-- Actualiza a '0' las redes que vienen con registros vacios.
	UPDATE RecaudostempCAPI
	SET red_id = '0'
	WHERE red_id = ''

	--  Actualiza a '0' el Codigo del Banco que no exsite en la tabla Banco
	UPDATE RecaudostempCAPI
	SET codigoBanco = '0'
	FROM RecaudostempCAPI AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM BancoDetalle AS v
			WHERE RTRIM(LTRIM(s.codigoBanco)) = RTRIM(LTRIM(v.codigoCore))
				AND CAST(s.compania_id AS INT) = v.compania_id
				AND v.compania_id = 3
			)

	-- Actualiza a '0' los bancos que vienen con registros vacios.
	UPDATE RecaudostempCAPI
	SET codigoBanco = '0'
	WHERE codigoBanco = ''

	--  Actualiza a '0' la Forma de Pago que no exsite en la tabla formaPago
	UPDATE RecaudostempCAPI
	SET formaPago_id = '0'
	FROM RecaudostempCAPI AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM FormaPago AS v
			WHERE CAST(s.formaPago_id AS INT) = v.id
			)

	UPDATE RecaudostempCAPI
	SET Altura = '0'
	WHERE Altura = ''

	UPDATE RecaudostempCAPI
	SET porcentajeAhorro_Inversion = '0'
	WHERE porcentajeAhorro_Inversion = ''

	-- Actualización con el id del Ramo relacionado a la compania configurada en la tabla Ramo
	UPDATE RecaudostempCAPI
	SET ramo_id = rd.id
	FROM RecaudostempCAPI AS rt
	INNER JOIN Compania c ON c.id = CAST(rt.compania_id AS INT)
	INNER JOIN RamoDetalle AS rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(rt.ramo_id))
	WHERE rd.compania_id = 3

	-- Actualización con el id del Amparo relacionado el AmparoDetalle que se envia en el archivo de Recaudos de CAPI
	UPDATE RecaudostempCAPI
	SET amparo_id = a.id
	FROM RecaudostempCAPI AS rt
	INNER JOIN AmparoDetalle ad ON RTRIM(LTRIM(ad.codigoCore)) = RTRIM(LTRIM(rt.amparo_id))
	INNER JOIN Amparo a ON a.id = ad.amparo_id

	-- Actualización con el id de la Cobertura relacionada al codigoCore enviado en el archivo de Recaudos de CAPI
	UPDATE RecaudostempCAPI
	SET cobertura_id = co.id
	FROM RecaudostempCAPI AS rt
	INNER JOIN Cobertura co ON RTRIM(LTRIM(co.codigoCore)) = RTRIM(LTRIM(rt.cobertura_id))

	--  Actualización de la Modalidad de pago del Recaudo	
	UPDATE RecaudostempCAPI
	SET modalidadPago_id = 1
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '2'

	UPDATE RecaudostempCAPI
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

	UPDATE RecaudostempCAPI
	SET modalidadPago_id = 0
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '0'

	-- Actualización con el id del Producto relacionado al codigoCore del ProductoDetalle enviado en el archivo de recaudos de CAPI
	UPDATE RecaudostempCAPI
	SET producto_id = pd.id
	FROM RecaudostempCAPI AS rt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(rt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON RTRIM(LTRIM(pd.codigoCore)) = RTRIM(LTRIM(rt.producto_id))
		AND pd.ramoDetalle_id = rd.id
	WHERE rd.compania_id = 3

	-- Actualización con el id del Plan relacionado al codigoCore del planDetalle enviado en el archivo de recaudos de CAPI
	UPDATE RecaudostempCAPI
	SET plan_id = pld.id
	FROM RecaudostempCAPI AS rt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(rt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON pd.id = CAST(rt.producto_id AS INT)
		AND pd.ramoDetalle_id = rd.id
	INNER JOIN PlanDetalle pld ON RTRIM(LTRIM(pld.codigoCore)) = RTRIM(LTRIM(rt.plan_id))
		AND pld.productoDetalle_id = pd.id
	WHERE rd.compania_id = 3

	-- Actualización con el id de la localidad SAI respecto al codigo CAPI
	UPDATE RecaudostempCAPI
	SET localidad_id = l.id
	FROM RecaudostempCAPI AS rt
	INNER JOIN Localidad AS l ON l.[codigo CAPI] = CAST(rt.localidad_id AS INT)

	-- Actualización con el id del Banco Detalle respecto al codigoCore de CAPI
	UPDATE RecaudostempCAPI
	SET codigoBanco = bd.id
	FROM RecaudostempCAPI AS rt
	INNER JOIN BancoDetalle AS bd ON RTRIM(LTRIM(bd.codigoCore)) = RTRIM(LTRIM(rt.codigoBanco))
		AND CAST(rt.compania_id AS INT) = bd.compania_id
	WHERE bd.compania_id = 3
		AND rt.codigoBanco <> ''

	-- Actualización con el id de la Red respecto al codigoCore de CAPI Y la Agrupacion de Redes x Compañía
	UPDATE RecaudostempCAPI
	SET red_id = rd.id
	FROM RecaudostempCAPI AS rt
	INNER JOIN RedDetalle rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(rt.red_id))
		AND CAST(rt.compania_id AS INT) = rd.compania_id
	WHERE rd.compania_id = 3
		AND rt.red_id <> ''
END
