-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza y homologa la información de Negocios entregada por EMERMEDICA.--				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Negociostemp_EMERMEDICA]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

	-- *********************************************************************************************************
	-- Validaciones de normalización de información de la tabla dbo.Negociostemp
	-- *********************************************************************************************************--
	UPDATE NegociostempEMERMEDICA
	SET clave = RTRIM(LTRIM(clave))

	UPDATE NegociostempEMERMEDICA
	SET formaPago_id = '0'
	WHERE formaPago_id = ''

	-- VALORES NUMERICOS
	UPDATE NegociostempEMERMEDICA
	SET valorAhorro = '0'
	WHERE ISNUMERIC(valorAhorro) = 0

	UPDATE NegociostempEMERMEDICA
	SET valorAsegurado = '0'
	WHERE ISNUMERIC(valorAsegurado) = 0

	UPDATE NegociostempEMERMEDICA
	SET valorPrimaPensiones = '0'
	WHERE ISNUMERIC(valorPrimaPensiones) = 0

	UPDATE NegociostempEMERMEDICA
	SET valorPrimaTotal = '0'
	WHERE ISNUMERIC(valorPrimaTotal) = 0

	UPDATE NegociostempEMERMEDICA
	SET valorProteccion = '0'
	WHERE ISNUMERIC(valorProteccion) = 0

	UPDATE NegociostempEMERMEDICA
	SET cuotasPagadas = '0'
	WHERE ISNUMERIC(cuotasPagadas) = 0

	UPDATE NegociostempEMERMEDICA
	SET cuotasVencidas = '0'
	WHERE ISNUMERIC(cuotasVencidas) = 0

	UPDATE NegociostempEMERMEDICA
	SET tipoNovedad = '0'
	WHERE ISNUMERIC(tipoNovedad) = 0

	--  Actualiza a '0' el Amparo que no existe en la tabla AmparoDetalle
	UPDATE NegociostempEMERMEDICA
	SET amparo_id = '0'
	FROM NegociostempEMERMEDICA AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM AmparoDetalle AS v
			WHERE RTRIM(LTRIM(s.amparo_id)) = RTRIM(LTRIM(v.codigoCore))
			)

	--  Actualiza a '0' el Grupo de Endoso que no existe en la tabla GrupoEndoso
	UPDATE NegociostempEMERMEDICA
	SET grupoEndoso_id = '0'
	FROM NegociostempEMERMEDICA AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM GrupoEndoso AS v
			WHERE CAST(s.grupoEndoso_id AS INT) = v.id
			)

	--  Actualiza a '0' la Forma de Pago que no existe en la tabla FormaPago
	UPDATE NegociostempEMERMEDICA
	SET formaPago_id = '0'
	FROM NegociostempEMERMEDICA AS s
	WHERE NOT EXISTS (
			SELECT *
			FROM FormaPago AS v
			WHERE CAST(s.formaPago_id AS INT) = v.id
			)

	UPDATE NegociostempEMERMEDICA
	SET tipoVehiculo = '0'
		,marcaVehiculo = '0'

	--  FECHAS
	UPDATE NegociostempEMERMEDICA
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

	UPDATE NegociostempEMERMEDICA
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

	UPDATE NegociostempEMERMEDICA
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

	UPDATE NegociostempEMERMEDICA
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

	UPDATE NegociostempEMERMEDICA
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
			
	UPDATE NegociostempEMERMEDICA
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
			
	UPDATE NegociostempEMERMEDICA
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
			
	UPDATE NegociostempEMERMEDICA
	SET fechaContrato = (
			CASE (fechaContrato)
				WHEN ''
					THEN @DefaultDate
				ELSE CASE (fechaContrato)
						WHEN '0'
							THEN @DefaultDate
						ELSE CASE 
								WHEN (fechaContrato) IS NULL
									THEN @DefaultDate
								ELSE (fechaContrato)
								END
						END
				END
			)

	-- *********************************************************************************************************
	-- Homologación de datos Negociostemp
	-- *********************************************************************************************************--
	-- Actualización con el id del Cliente haciendo el join por el documento del Cliente
	UPDATE NegociostempEMERMEDICA
	SET cliente_id = cl.id
	FROM NegociostempEMERMEDICA AS nt
	INNER JOIN Cliente AS cl ON RTRIM(LTRIM(cl.cedula)) = RTRIM(LTRIM(nt.identificacionSuscriptor))
		AND CAST(nt.tipoDocumento_id AS INT) = cl.tipoDocumento_id

	-- Actualización con el id del TipoEndoso relacionado a la compania configurada en la tabla TipoEndoso
	UPDATE NegociostempEMERMEDICA
	SET tipoEndoso_id = te.id
	FROM NegociostempEMERMEDICA AS nt
	INNER JOIN Compania c ON c.id = CAST(nt.compania_id AS INT)
	INNER JOIN TipoEndoso AS te ON te.compania_id = c.id
		AND CAST(te.codigoCore AS INT) = CAST(nt.tipoEndoso_id AS INT)

	-- Actualización con el id del Ramo relacionado a la compania configurada en la tabla Ramo
	UPDATE NegociostempEMERMEDICA
	SET ramo_id = rd.id
	FROM NegociostempEMERMEDICA AS nt
	INNER JOIN Compania c ON c.id = CAST(nt.compania_id AS INT)
	INNER JOIN RamoDetalle AS rd ON RTRIM(LTRIM(rd.codigoCore)) = RTRIM(LTRIM(nt.ramo_id))
	WHERE rd.compania_id = 5

	-- Actualización con el id del Amparo relacionado el AmparoDetalle que se envia en el archivo de negocios de EMERMEDICA
	UPDATE NegociostempEMERMEDICA
	SET amparo_id = a.id
	FROM NegociostempEMERMEDICA AS nt
	INNER JOIN AmparoDetalle ad ON RTRIM(LTRIM(ad.codigoCore)) = RTRIM(LTRIM(nt.amparo_id))
	INNER JOIN Amparo a ON a.id = ad.amparo_id

	--	Actualización con el id de la Cobertura relacionada al codigoCore enviado en el archivo de Negocios de EMERMEDICA
	UPDATE NegociostempEMERMEDICA
	SET cobertura_id = co.id
	FROM NegociostempEMERMEDICA AS nt
	INNER JOIN Cobertura co ON RTRIM(LTRIM(co.codigoCore)) = RTRIM(LTRIM(nt.cobertura_id))

	--  Actualización de la Modalidad de pago del Negocio	
	UPDATE NegociostempEMERMEDICA
	SET modalidadPago_id = 1
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '2'

	UPDATE NegociostempEMERMEDICA
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

	UPDATE NegociostempEMERMEDICA
	SET modalidadPago_id = 0
	WHERE RTRIM(LTRIM(modalidadPago_id)) = '0'

	-- Actualización con el id del Producto relacionado al codigoCore del ProductoDetalle enviado en el archivo de negocios de EMERMEDICA
	UPDATE NegociostempEMERMEDICA
	SET productoCodigo = pd.id
	FROM NegociostempEMERMEDICA AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON RTRIM(LTRIM(pd.codigoCore)) = RTRIM(LTRIM(nt.productoCodigo))
		AND pd.ramoDetalle_id = rd.id
	WHERE rd.compania_id = 5

	-- Actualización con el id del Plan relacionado al codigoCore del plANDetalle enviado en el archivo de Negocios de EMERMEDICA
	UPDATE NegociostempEMERMEDICA
	SET plan_id = pld.id
	FROM NegociostempEMERMEDICA AS nt
	INNER JOIN RamoDetalle rd ON rd.id = CAST(nt.ramo_id AS INT)
	INNER JOIN ProductoDetalle pd ON pd.id = CAST(nt.productoCodigo AS INT)
		AND pd.ramoDetalle_id = rd.id
	INNER JOIN PlanDetalle pld ON RTRIM(LTRIM(pld.codigoCore)) = RTRIM(LTRIM(nt.plan_id))
		AND pld.productoDetalle_id = pd.id
	WHERE rd.compania_id = 5

	UPDATE NegociostempEMERMEDICA
	SET localidad_id = 0
END