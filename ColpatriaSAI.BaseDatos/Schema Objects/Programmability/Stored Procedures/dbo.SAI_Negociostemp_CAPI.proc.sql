-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza y homologa la información de Negocios entregada por CAPI.--				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Negociostemp_CAPI]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 111)

	-- *********************************************************************************************************
	-- Validaciones de normalización de información de la tabla dbo.Negociostemp
	-- *********************************************************************************************************--
	UPDATE NegociostempCAPI
	SET clave = RTRIM(LTRIM(clave))

	UPDATE NegociostempCAPI
	SET formaPago_id = '0'
	WHERE formaPago_id = ''

	UPDATE NegociostempCAPI
	SET tipoEndoso_id = '0'

	-- VALORES NUMERICOS
	UPDATE NegociostempCAPI
	SET valorAhorro = '0'
	WHERE ISNUMERIC(valorAhorro) = 0

	UPDATE NegociostempCAPI
	SET valorAsegurado = '0'
	WHERE ISNUMERIC(valorAsegurado) = 0

	UPDATE NegociostempCAPI
	SET valorPrimaPensiones = '0'
	WHERE ISNUMERIC(valorPrimaPensiones) = 0

	UPDATE NegociostempCAPI
	SET valorPrimaTotal = '0'
	WHERE ISNUMERIC(valorPrimaTotal) = 0

	UPDATE NegociostempCAPI
	SET valorProteccion = '0'
	WHERE ISNUMERIC(valorProteccion) = 0

	UPDATE NegociostempCAPI
	SET cuotasPagadas = '0'
	WHERE ISNUMERIC(cuotasPagadas) = 0

	UPDATE NegociostempCAPI
	SET cuotasVencidas = '0'
	WHERE ISNUMERIC(cuotasVencidas) = 0

	--  FECHAS
	UPDATE NegociostempCAPI
	SET fechaEmisionMaximoEndoso = (
			CASE (fechaEmisionMaximoEndoso)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaEmisionMaximoEndoso)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE (fechaEmisionMaximoEndoso)
								WHEN '0/00/00'
									THEN @DefaultDate
								ELSE CASE 
										WHEN (fechaEmisionMaximoEndoso) IS NULL
											THEN @DefaultDate
										ELSE (fechaEmisionMaximoEndoso)
										END
								END
						END
				END
			)

	UPDATE NegociostempCAPI
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

	UPDATE NegociostempCAPI
	SET fechaRecaudoInicial = (
			CASE (fechaRecaudoInicial)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaRecaudoInicial)
						WHEN '0/00/00'
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
				END
			)

	UPDATE NegociostempCAPI
	SET fechaExpedicion = (
			CASE (fechaExpedicion)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaExpedicion)
						WHEN '0/00/00'
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
				END
			)

	UPDATE NegociostempCAPI
	SET fechaGrabacion = (
			CASE (fechaGrabacion)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaGrabacion)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE (fechaGrabacion)
								WHEN '0/00/00'
									THEN @DefaultDate
								ELSE CASE 
										WHEN (fechaGrabacion) IS NULL
											THEN @DefaultDate
										ELSE (fechaGrabacion)
										END
								END
						END
				END
			)

	UPDATE NegociostempCAPI
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

	UPDATE NegociostempCAPI
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

	--  Actualiza a '0' el Amparo que no existe en la tabla AmparoDetalle
	UPDATE NegociostempCAPI
	SET amparo_id = '0'
	FROM NegociostempCAPI AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM AmparoDetalle AS v
			WHERE RTRIM(LTRIM(s.amparo_id)) = RTRIM(LTRIM(v.codigoCore))
			)

	--  Actualiza a '0' el Grupo de Endoso que no exite en la tabla GrupoEndoso
	UPDATE NegociostempCAPI
	SET grupoEndoso_id = '0'
	FROM NegociostempCAPI AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM GrupoEndoso AS v
			WHERE CAST(s.grupoEndoso_id AS INT) = v.id
			)

	--  Actualiza a '0' la Forma de Pago que no existe en la tabla FormaPago
	UPDATE NegociostempCAPI
	SET formaPago_id = '0'
	FROM NegociostempCAPI AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM FormaPago AS v
			WHERE CAST(s.formaPago_id AS INT) = v.id
			)

	UPDATE NegociostempCAPI
	SET marcaVehiculo = '0'

	-- *********************************************************************************************************
	-- Homologación de datos Negociostemp
	-- *********************************************************************************************************--
	-- Actualización con el id del Cliente haciendo el join por el documento del Cliente
	UPDATE NegociostempCAPI
	SET cliente_id = cl.id
	FROM NegociostempCAPI AS nt
	INNER JOIN Cliente AS cl ON RTRIM(LTRIM(cl.cedula)) = RTRIM(LTRIM(nt.identificacionSuscriptor))
		AND CAST(nt.tipoDocumento_id AS INT) = cl.tipoDocumento_id

	-- Actualización con el id del Ramo relacionado a la compania configurada en la tabla Ramo
	UPDATE NegociostempCAPI
	SET ramo_id = rd.id
	FROM NegociostempCAPI AS nt
	INNER JOIN Compania c ON c.id = CAST(nt.compania_id AS INT)
	INNER JOIN RamoDetalle AS rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(nt.ramo_id))
	WHERE rd.compania_id = 3

	-- Actualización con el id del Amparo relacionado el AmparoDetalle que se envia en el archivo de negocios de CAPI
	UPDATE NegociostempCAPI
	SET amparo_id = a.id
	FROM NegociostempCAPI AS nt
	INNER JOIN AmparoDetalle ad ON RTRIM(LTRIM(ad.codigoCore)) = RTRIM(LTRIM(nt.amparo_id))
	INNER JOIN Amparo a ON a.id = ad.amparo_id

	--	Actualización con el id de la Cobertura relacionada al codigoCore enviado en el archivo de Negocios de CAPI
	UPDATE NegociostempCAPI
	SET cobertura_id = co.id
	FROM NegociostempCAPI AS nt
	INNER JOIN Cobertura co ON RTRIM(LTRIM(co.codigoCore)) = RTRIM(LTRIM(nt.cobertura_id))

	--  Actualización de la Modalidad de pago del Negocio	
	UPDATE NegociostempCAPI
	SET modalidadPago_id = 1
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '2'

	UPDATE NegociostempCAPI
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

	UPDATE NegociostempCAPI
	SET modalidadPago_id = 0
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '0'

	-- Actualización con el id del Producto relacionado al codigoCore del ProductoDetalle enviado en el archivo de negocios de CAPI
	UPDATE NegociostempCAPI
	SET productoCodigo = pd.id
	FROM NegociostempCAPI AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON RTRIM(LTRIM(pd.codigoCore)) = RTRIM(LTRIM(nt.productoCodigo))
		AND pd.ramoDetalle_id = rd.id
	WHERE rd.compania_id = 3

	-- Actualización con el id del Plan relacionado al codigoCore del plANDetalle enviado en el archivo de Negocios de BH
	UPDATE NegociostempCAPI
	SET plan_id = pld.id
	FROM NegociostempCAPI AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON pd.id = CAST(nt.productoCodigo AS INT)
		AND pd.ramoDetalle_id = rd.id
	INNER JOIN PlanDetalle pld ON RTRIM(LTRIM(pld.codigoCore)) = RTRIM(LTRIM(nt.plan_id))
		AND pld.productoDetalle_id = pd.id
	WHERE rd.compania_id = 3

	-- Actualización con el id de la localidad SAI respecto al codigo CAPI
	UPDATE NegociostempCAPI
	SET localidad_id = l.id
	FROM NegociostempCAPI AS nt
	INNER JOIN Localidad AS l ON l.[codigo CAPI] = CAST(nt.localidad_id AS INT)
END