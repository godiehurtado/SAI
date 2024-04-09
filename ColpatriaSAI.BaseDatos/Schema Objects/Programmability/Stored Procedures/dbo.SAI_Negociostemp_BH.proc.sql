-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza y homologa la información de Negocios entregada por BH.--				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Negociostemp_BH]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

	-- *********************************************************************************************************
	-- Validaciones de normalización de información de la tabla dbo.Negociostemp
	-- *********************************************************************************************************--
	UPDATE NegociostempBH
	SET clave = RTRIM(LTRIM(clave))

	UPDATE NegociostempBH
	SET formaPago_id = '0'
	WHERE formaPago_id = ''

	-- VALORES NUMERICOS
	UPDATE NegociostempBH
	SET valorAhorro = '0'
	WHERE ISNUMERIC(valorAhorro) = 0

	UPDATE NegociostempBH
	SET valorAsegurado = '0'
	WHERE ISNUMERIC(valorAsegurado) = 0

	UPDATE NegociostempBH
	SET valorPrimaPensiones = '0'
	WHERE ISNUMERIC(valorPrimaPensiones) = 0

	UPDATE NegociostempBH
	SET valorPrimaTotal = '0'
	WHERE ISNUMERIC(valorPrimaTotal) = 0

	UPDATE NegociostempBH
	SET valorProteccion = '0'
	WHERE ISNUMERIC(valorProteccion) = 0

	UPDATE NegociostempBH
	SET cuotasPagadas = '0'
	WHERE ISNUMERIC(cuotasPagadas) = 0

	UPDATE NegociostempBH
	SET cuotasVencidas = '0'
	WHERE ISNUMERIC(cuotasVencidas) = 0

	UPDATE NegociostempBH
	SET tipoVehiculo = '0'

	UPDATE NegociostempBH
	SET marcaVehiculo = '0'

	-- FECHAS
	UPDATE NegociostempBH
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

	UPDATE NegociostempBH
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

	UPDATE NegociostempBH
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

	UPDATE NegociostempBH
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

	UPDATE NegociostempBH
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
			
	UPDATE NegociostempBH
	SET fechaInicioVigencia = (
			CASE (fechaInicioVigencia)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaInicioVigencia)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaInicioVigencia) IS NULL
									THEN @DefaultDate
								ELSE (fechaInicioVigencia)
								END
						END
				END
			)
			
	UPDATE NegociostempBH
	SET fechaFinVigencia = (
			CASE (fechaFinVigencia)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaFinVigencia)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaFinVigencia) IS NULL
									THEN @DefaultDate
								ELSE (fechaFinVigencia)
								END
						END
				END
			)
	
	UPDATE NegociostempBH
	SET fechaEfecto = (
			CASE (fechaEfecto)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaEfecto)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaEfecto) IS NULL
									THEN @DefaultDate
								ELSE (fechaEfecto)
								END
						END
				END
			)

	-- *********************************************************************************************************
	-- Homologación de datos Negociostemp
	-- *********************************************************************************************************--
	--  Actualiza a '0' el Amparo que no exsite en la tabla AmparoDetalle
	UPDATE NegociostempBH
	SET amparo_id = '0'
	FROM NegociostempBH AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM AmparoDetalle AS v
			WHERE RTRIM(LTRIM(s.amparo_id)) = RTRIM(LTRIM(v.codigoCore))
			)

	--  Actualiza a '0' el Grupo de Endoso que no exsite en la tabla GrupoEndoso
	UPDATE NegociostempBH
	SET grupoEndoso_id = '0'
	FROM NegociostempBH AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM GrupoEndoso AS v
			WHERE CAST(s.grupoEndoso_id AS INT) = v.id
			)

	--  Actualiza a '0' la Forma de Pago que no exsite en la tabla FormaPago
	UPDATE NegociostempBH
	SET formaPago_id = '0'
	FROM NegociostempBH AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM FormaPago AS v
			WHERE CAST(s.formaPago_id AS INT) = v.id
			)

	-- Actualización con el id del Cliente haciendo el join por el documento del Cliente
	UPDATE NegociostempBH
	SET cliente_id = cl.id
	FROM NegociostempBH AS nt
	INNER JOIN Cliente AS cl ON RTRIM(LTRIM(cl.cedula)) = RTRIM(LTRIM(nt.identificacionSuscriptor))
		AND CAST(nt.tipoDocumento_id AS INT) = cl.tipoDocumento_id

	-- Actualización con el id del TipoEndoso relacionado a la compania configurada en la tabla TipoEndoso
	UPDATE NegociostempBH
	SET tipoEndoso_id = te.id
	FROM NegociostempBH AS nt
	INNER JOIN Compania c ON c.id = CAST(nt.compania_id AS INT)
	INNER JOIN TipoEndoso AS te ON te.compania_id = c.id
		AND CAST(te.codigoCore AS INT) = CAST(nt.tipoEndoso_id AS INT)

	-- Actualización con el id del Ramo relacionado a la compania configurada en la tabla Ramo
	UPDATE NegociostempBH
	SET ramo_id = rd.id
	FROM NegociostempBH AS nt
	INNER JOIN RamoDetalle AS rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(nt.ramo_id))
	WHERE rd.compania_id = 5

	-- Actualización con el id del Amparo relacionado el AmparoDetalle que se envia en el archivo de negocios de BH
	UPDATE NegociostempBH
	SET amparo_id = a.id
	FROM NegociostempBH AS nt
	INNER JOIN AmparoDetalle ad ON CAST(ad.codigoCore AS INT) = CAST(nt.amparo_id AS INT)
	INNER JOIN Amparo a ON a.id = ad.amparo_id

	-- Actualización con el id de la Cobertura relacionada al codigoCore enviado en el archivo de Negocios de BH
	UPDATE NegociostempBH
	SET cobertura_id = co.id
	FROM NegociostempBH AS nt
	INNER JOIN Cobertura co ON RTRIM(LTRIM(co.codigoCore)) = RTRIM(LTRIM(nt.cobertura_id))

	--  Actualización de la Modalidad de pago del Negocio	
	UPDATE NegociostempBH
	SET modalidadPago_id = 1
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '2'

	UPDATE NegociostempBH
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

	UPDATE NegociostempBH
	SET modalidadPago_id = 0
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '0'

	-- Actualización con el id del Producto relacionado al codigoCore del ProductoDetalle enviado en el archivo de negocios de BH
	UPDATE NegociostempBH
	SET productoCodigo = pd.id
	FROM NegociostempBH AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON RTRIM(LTRIM(pd.codigoCore)) = RTRIM(LTRIM(nt.productoCodigo))
		AND pd.ramoDetalle_id = rd.id
	WHERE rd.compania_id = 5

	-- Actualización con el id del Plan relacionado al codigoCore del planDetalle enviado en el archivo de Negocios de BH
	UPDATE NegociostempBH
	SET plan_id = pld.id
	FROM NegociostempBH AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON pd.id = CAST(nt.productoCodigo AS INT)
		AND pd.ramoDetalle_id = rd.id
	INNER JOIN PlanDetalle pld ON RTRIM(LTRIM(pld.codigoCore)) = RTRIM(LTRIM(nt.plan_id))
		AND pld.productoDetalle_id = pd.id
	WHERE rd.compania_id = 5

	-- Actualización con el id de la localidad SAI respecto al codigo BH
	UPDATE NegociostempBH
	SET localidad_id = l.id
	FROM NegociostempBH AS nt
	INNER JOIN Localidad AS l ON CAST(l.[codigo BH] AS INT) = CAST(nt.localidad_id AS INT)
END