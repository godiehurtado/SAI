-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza y homologa la información de Negocios entregada por SISE GENERALES.--				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Negociostemp_SISEGENERALES]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

	-- *********************************************************************************************************
	-- Validaciones de normalización de información de la tabla dbo.Negociostemp
	-- *********************************************************************************************************--
	UPDATE NegociostempGENERALES
	SET clave = RTRIM(LTRIM(clave))

	UPDATE NegociostempGENERALES
	SET formaPago_id = '0'
	WHERE formaPago_id = ''

	-- VALORES NUMERICOS
	UPDATE NegociostempGENERALES
	SET valorAhorro = '0'
	WHERE ISNUMERIC(valorAhorro) = 0

	UPDATE NegociostempGENERALES
	SET valorAsegurado = '0'
	WHERE ISNUMERIC(valorAsegurado) = 0

	UPDATE NegociostempGENERALES
	SET valorPrimaPensiones = '0'
	WHERE ISNUMERIC(valorPrimaPensiones) = 0

	UPDATE NegociostempGENERALES
	SET valorPrimaTotal = '0'
	WHERE ISNUMERIC(valorPrimaTotal) = 0

	UPDATE NegociostempGENERALES
	SET valorProteccion = '0'
	WHERE ISNUMERIC(valorProteccion) = 0

	UPDATE NegociostempGENERALES
	SET cuotasPagadas = '0'
	WHERE ISNUMERIC(cuotasPagadas) = 0

	UPDATE NegociostempGENERALES
	SET cuotasVencidas = '0'
	WHERE ISNUMERIC(cuotasVencidas) = 0
	
	UPDATE NegociostempGENERALES
	SET consecutivoEndosoCore = (
		CASE ISNUMERIC(consecutivoEndosoCore) WHEN 1
			THEN CAST(consecutivoEndosoCore AS INT)
		ELSE 0
		END
	)

	--  Actualiza a '0' el Amparo que no exsite en la tabla AmparoDetalle
	UPDATE NegociostempGENERALES
	SET amparo_id = '0'
	FROM NegociostempGENERALES AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM AmparoDetalle AS v
			WHERE RTRIM(LTRIM(s.amparo_id)) = RTRIM(LTRIM(v.codigoCore))
			)

	--  Actualiza a '0' el Grupo de Endoso que no exsite en la tabla GrupoEndoso
	UPDATE NegociostempGENERALES
	SET grupoEndoso_id = '0'
	FROM NegociostempGENERALES AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM GrupoEndoso AS v
			WHERE CAST(s.grupoEndoso_id AS INT) = v.id
			)

	--  Actualiza a '0' la Forma de Pago que no exsite en la tabla FormaPago
	UPDATE NegociostempGENERALES
	SET formaPago_id = '0'
	FROM NegociostempGENERALES AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM FormaPago AS v
			WHERE CAST(s.formaPago_id AS INT) = v.id
			)

	UPDATE NegociostempGENERALES
	SET tipoVehiculo = CAST(tipoVehiculo AS INT)

	UPDATE NegociostempGENERALES
	SET marcaVehiculo = CAST(marcaVehiculo AS INT)

	--  Actualiza a '0' la Marca del Vehiculo que no existe en la tabla marcaVehiculo
	UPDATE NegociostempGENERALES
	SET marcaVehiculo = '0'
	FROM NegociostempGENERALES AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM marcaVehiculo AS v
			WHERE CAST(s.marcaVehiculo AS INT) = v.id
			)

	--  FECHAS
	UPDATE NegociostempGENERALES
	SET fechaEmisionMaximoEndoso = (
			CASE (fechaEmisionMaximoEndoso)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaEmisionMaximoEndoso)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaEmisionMaximoEndoso) IS NULL
									THEN @DefaultDate
								ELSE (fechaEmisionMaximoEndoso)
								END
						END
				END
			)

	UPDATE NegociostempGENERALES
	SET fechaCancelacion = (
			CASE (fechaCancelacion)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE 
						WHEN (fechaCancelacion) = '0/00/00'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaCancelacion) IS NULL
									THEN @DefaultDate
								ELSE (fechaCancelacion)
								END
						END
				END
			)

	UPDATE NegociostempGENERALES
	SET fechaRecaudoInicial = (
			CASE (fechaRecaudoInicial)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaRecaudoInicial)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaRecaudoInicial) IS NULL
									THEN @DefaultDate
								ELSE (fechaRecaudoInicial)
								END
						END
				END
			)

	UPDATE NegociostempGENERALES
	SET fechaExpedicion = (
			CASE (fechaExpedicion)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaExpedicion)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaExpedicion) IS NULL
									THEN @DefaultDate
								ELSE (fechaExpedicion)
								END
						END
				END
			)

	UPDATE NegociostempGENERALES
	SET fechaGrabacion = (
			CASE (fechaGrabacion)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaGrabacion)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaGrabacion) IS NULL
									THEN @DefaultDate
								ELSE (fechaGrabacion)
								END
						END
				END
			)
	
	UPDATE NegociostempGENERALES
	SET fechaInicioVigencia = (
			CASE (fechaInicioVigencia)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaInicioVigencia)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE (fechaInicioVigencia)
								WHEN '0/00/00'
									THEN @DefaultDate
								ELSE CASE 
										WHEN (fechaInicioVigencia) IS NULL
											THEN @DefaultDate
										ELSE (fechaInicioVigencia)
										END
								END
						END
				END
			)
	
	UPDATE NegociostempGENERALES
	SET fechaFinVigencia = (
			CASE (fechaFinVigencia)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaFinVigencia)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE (fechaFinVigencia)
								WHEN '0/00/00'
									THEN @DefaultDate
								ELSE CASE 
										WHEN (fechaFinVigencia) IS NULL
											THEN @DefaultDate
										ELSE (fechaFinVigencia)
										END
								END
						END
				END
			)

	-- *********************************************************************************************************
	-- Homologación de datos Negociostemp
	-- *********************************************************************************************************--
	--  Actualización con el id del Cliente haciendo el join por el documento del Cliente
	UPDATE NegociostempGENERALES
	SET cliente_id = cl.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN Cliente AS cl ON RTRIM(LTRIM(cl.cedula)) = RTRIM(LTRIM(nt.identificacionSuscriptor))
		AND CAST(nt.tipoDocumento_id AS INT) = cl.tipoDocumento_id

	--  Actualización con el id del TipoEndoso relacionado a la compania configurada en la tabla TipoEndoso
	UPDATE NegociostempGENERALES
	SET tipoEndoso_id = te.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN Compania c ON c.id = CAST(nt.compania_id AS INT)
	INNER JOIN TipoEndoso AS te ON te.compania_id = c.id
		AND CAST(te.codigoCore AS INT) = CAST(nt.tipoEndoso_id AS INT)

	-- Actualización con el id del Ramo relacionado a la compania configurada en la tabla Ramo
	UPDATE NegociostempGENERALES
	SET ramo_id = rd.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN Compania c ON c.id = CAST(nt.compania_id AS INT)
	INNER JOIN RamoDetalle AS rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(nt.ramo_id))
	WHERE rd.compania_id = 1

	--  Actualiza a '0' el Tipo de Vehiculo que no exsite en la tabla tipoVehiculo
	UPDATE NegociostempGENERALES
	SET tipoVehiculo = '0'
	FROM NegociostempGENERALES AS s
	INNER JOIN RamoDetalle rd ON rd.id = CAST(s.ramo_id AS INT)
	WHERE NOT EXISTS (
			SELECT *
			FROM TipoVehiculo AS v
			WHERE RTRIM(LTRIM(s.tipoVehiculo)) = RTRIM(LTRIM(v.codigoCore))
				AND v.ramo_id = (
					SELECT rd1.ramo_id
					FROM RamoDetalle rd1
					WHERE CAST(s.ramo_id AS INT) = rd1.id
					)
			)

	--  Actualización con el id del Amparo relacionado el AmparoDetalle que se envia en el archivo de negocios de GENERALES
	UPDATE NegociostempGENERALES
	SET amparo_id = a.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN AmparoDetalle ad ON RTRIM(LTRIM(ad.codigoCore)) = RTRIM(LTRIM(nt.amparo_id))
	INNER JOIN Amparo a ON a.id = ad.amparo_id

	--  Actualización con el id de la Cobertura relacionada al codigoCore enviado en el archivo de Negocios de GENERALES
	UPDATE NegociostempGENERALES
	SET cobertura_id = co.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN Cobertura co ON RTRIM(LTRIM(co.codigoCore)) = RTRIM(LTRIM(nt.cobertura_id))

	--  Actualización de la Modalidad de pago del Negocio	
	UPDATE NegociostempGENERALES
	SET modalidadPago_id = 1
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '2'

	UPDATE NegociostempGENERALES
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

	UPDATE NegociostempGENERALES
	SET modalidadPago_id = 0
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '0'

	--  Actualización con el id del tipoVehiculo relacionada al codigoCore enviado en el archivo de Negocios de GENERALES
	UPDATE NegociostempGENERALES
	SET tipoVehiculo = tv.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN TipoVehiculo tv ON CAST(tv.codigoCore AS INT) = CAST(nt.tipoVehiculo AS INT)
		AND rd.ramo_id = tv.ramo_id

	--  Actualización con el id del Producto relacionado al codigoCore del ProductoDetalle enviado en el archivo de negocios de GENERALES
	UPDATE NegociostempGENERALES
	SET productoCodigo = pd.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON RTRIM(LTRIM(pd.codigoCore)) = RTRIM(LTRIM(nt.productoCodigo))
		AND pd.ramoDetalle_id = rd.id
	WHERE rd.compania_id = 1

	--  Actualización con el id del Plan relacionado al codigoCore del planDetalle enviado en el archivo de Negocios de GENERALES
	UPDATE NegociostempGENERALES
	SET plan_id = pld.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON pd.id = CAST(nt.productoCodigo AS INT)
		AND pd.ramoDetalle_id = rd.id
	INNER JOIN PlanDetalle pld ON RTRIM(LTRIM(pld.codigoCore)) = RTRIM(LTRIM(nt.plan_id))
		AND pld.productoDetalle_id = pd.id
	WHERE rd.compania_id = 1

	--  Actualización con el id de la localidad SAI respecto al codigo GENERALES
	UPDATE NegociostempGENERALES
	SET localidad_id = l.id
	FROM NegociostempGENERALES AS nt
	INNER JOIN Localidad AS l ON CAST(l.[codigo SISE] AS INT) = CAST(nt.localidad_id AS INT)
END