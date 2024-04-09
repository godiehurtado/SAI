-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza y homologa la información de Recaudos entregada por EMERMEDICA.
--				Se agrega la validación de homologación sobre BancoDetalle
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Recaudostemp_EMERMEDICA]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

	-- *********************************************************************************************************
	-- Validaciones de normalización de información de la tabla dbo.Recaudostemp
	-- *********************************************************************************************************--
	UPDATE recaudostempEMERMEDICA
	SET clave = RTRIM(LTRIM(clave))

	-- FECHAS
	UPDATE recaudostempEMERMEDICA
	SET fechaRecaudo = @DefaultDate
	WHERE fechaRecaudo IS NULL

	UPDATE recaudostempEMERMEDICA
	SET fechaCobranza = @DefaultDate
	WHERE fechaCobranza IS NULL

	UPDATE recaudostempEMERMEDICA
	SET fechaGrabacion = @DefaultDate
	WHERE fechaGrabacion IS NULL

	UPDATE recaudostempEMERMEDICA
	SET formapago_id = '0'
	WHERE formapago_id IS NULL
	
	UPDATE recaudostempEMERMEDICA
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

	UPDATE recaudostempEMERMEDICA
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

	UPDATE recaudostempEMERMEDICA
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
	--  Actualiza a '0' el amparo que no exsite en la tabla Amparo
	UPDATE recaudostempEMERMEDICA
	SET amparo_id = '0'
	FROM RecaudostempEMERMEDICA AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM AmparoDetalle AS v
			WHERE RTRIM(LTRIM(s.amparo_id)) = RTRIM(LTRIM(v.codigoCore))
			)

	--  Actualiza a '0' la Red de Recaudo que no existe en la tabla red
	UPDATE recaudostempEMERMEDICA
	SET red_id = '0'
	FROM RecaudostempEMERMEDICA AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM RedDetalle AS v
			WHERE RTRIM(LTRIM(s.red_id)) = RTRIM(LTRIM(v.codigoCore))
				AND CAST(s.compania_id AS INT) = v.compania_id
				AND v.compania_id = 5
			)

	-- Actualiza a '0' las redes que vienen con registros vacios.
	UPDATE recaudostempEMERMEDICA
	SET red_id = '0'
	WHERE red_id = ''

	--  Actualiza a '0' el Codigo del Banco que no exsite en la tabla Banco
	UPDATE recaudostempEMERMEDICA
	SET codigoBanco = '0'
	FROM RecaudostempEMERMEDICA AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM BancoDetalle AS v
			WHERE RTRIM(LTRIM(s.codigoBanco)) = RTRIM(LTRIM(v.codigoCore))
				AND CAST(s.compania_id AS INT) = v.compania_id
				AND v.compania_id = 5
			)

	-- Actualiza a '0' los bancos que vienen con registros vacios.
	UPDATE recaudostempEMERMEDICA
	SET codigoBanco = '0'
	WHERE codigoBanco = ''

	UPDATE recaudostempEMERMEDICA
	SET Altura = '0'
	WHERE Altura = ''

	UPDATE recaudostempEMERMEDICA
	SET porcentajeAhorro_Inversion = '0'
	WHERE porcentajeAhorro_Inversion = ''

	-- Actualización con el id del Ramo relacionado a la compania configurada en la tabla Ramo
	UPDATE recaudostempEMERMEDICA
	SET ramo_id = rd.id
	FROM RecaudostempEMERMEDICA AS rt
	INNER JOIN Compania c ON c.id = CAST(rt.compania_id AS INT)
	INNER JOIN RamoDetalle AS rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(rt.ramo_id))
	WHERE rd.compania_id = 5

	-- Actualización con el id del Amparo relacionado el AmparoDetalle que se envia en el archivo de Recaudos de EMERMEDICA
	UPDATE recaudostempEMERMEDICA
	SET amparo_id = a.id
	FROM RecaudostempEMERMEDICA AS rt
	INNER JOIN AmparoDetalle ad ON RTRIM(LTRIM(ad.codigoCore)) = RTRIM(LTRIM(rt.amparo_id))
	INNER JOIN Amparo a ON a.id = ad.amparo_id

	-- Actualización con el id de la Cobertura relacionada al codigoCore enviado en el archivo de Recaudos de EMERMEDICA
	UPDATE recaudostempEMERMEDICA
	SET cobertura_id = co.id
	FROM RecaudostempEMERMEDICA AS rt
	INNER JOIN Cobertura co ON RTRIM(LTRIM(co.codigoCore)) = RTRIM(LTRIM(rt.cobertura_id))

	--  Actualización de la Modalidad de pago del Recaudo	
	UPDATE recaudostempEMERMEDICA
	SET modalidadPago_id = 1
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '2'

	UPDATE recaudostempEMERMEDICA
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

	UPDATE recaudostempEMERMEDICA
	SET modalidadPago_id = 0
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '0'

	-- Actualización con el id del Producto relacionado al codigoCore del ProductoDetalle enviado en el archivo de recaudos de EMERMEDICA
	UPDATE recaudostempEMERMEDICA
	SET producto_id = pd.id
	FROM RecaudostempEMERMEDICA AS rt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(rt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON RTRIM(LTRIM(pd.codigoCore)) = RTRIM(LTRIM(rt.producto_id))
		AND pd.ramoDetalle_id = rd.id
	WHERE rd.compania_id = 5

	-- Actualización con el id del Plan relacionado al codigoCore del planDetalle enviado en el archivo de recaudos de EMERMEDICA
	UPDATE recaudostempEMERMEDICA
	SET plan_id = pld.id
	FROM RecaudostempEMERMEDICA AS rt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(rt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON pd.id = CAST(rt.producto_id AS INT)
		AND pd.ramoDetalle_id = rd.id
	INNER JOIN PlanDetalle pld ON RTRIM(LTRIM(pld.codigoCore)) = RTRIM(LTRIM(rt.plan_id))
		AND pld.productoDetalle_id = pd.id
	WHERE rd.compania_id = 5

	UPDATE recaudostempEMERMEDICA
	SET localidad_id = 0

	-- Actualización con el id del Banco Detalle respecto al codigoCore de EMERMEDICA
	UPDATE recaudostempEMERMEDICA
	SET codigoBanco = bd.id
	FROM RecaudostempEMERMEDICA AS rt
	INNER JOIN BancoDetalle AS bd ON RTRIM(LTRIM(bd.codigoCore)) = RTRIM(LTRIM(rt.codigoBanco))
		AND CAST(rt.compania_id AS INT) = bd.compania_id
	WHERE bd.compania_id = 5
		AND rt.codigoBanco <> ''

	-- Actualización con el id de la Red respecto al codigoCore de EMERMEDICA Y la Agrupacion de Redes x Compañía
	UPDATE recaudostempEMERMEDICA
	SET red_id = rd.id
	FROM RecaudostempEMERMEDICA AS rt
	INNER JOIN RedDetalle rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(rt.red_id))
		AND CAST(rt.compania_id AS INT) = rd.compania_id
	WHERE rd.compania_id = 5
		AND rt.red_id <> ''
END
