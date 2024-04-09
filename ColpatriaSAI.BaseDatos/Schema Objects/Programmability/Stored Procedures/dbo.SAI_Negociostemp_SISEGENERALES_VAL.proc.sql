
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza las fechas y los valores ´numericos de SISE GENERALES--				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Negociostemp_SISEGENERALES_VAL]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

	-- *********************************************************************************************************
	-- Homologación de fechas
	-- *********************************************************************************************************--
	UPDATE NegociostempGENERALES
	SET fechaExpedicion = @DefaultDate
	WHERE (
			fechaExpedicion IS NULL
			OR fechaExpedicion = ''
			)

	UPDATE NegociostempGENERALES
	SET fechaCancelacion = @DefaultDate
	WHERE (
			fechaCancelacion IS NULL
			OR fechaCancelacion = ''
			)

	UPDATE NegociostempGENERALES
	SET fechaEmisionMaximoEndoso = @DefaultDate
	WHERE (
			fechaEmisionMaximoEndoso IS NULL
			OR fechaEmisionMaximoEndoso = ''
			)

	UPDATE NegociostempGENERALES
	SET fechaRecaudoInicial = @DefaultDate
	WHERE (
			fechaRecaudoInicial IS NULL
			OR fechaRecaudoInicial = ''
			)

	UPDATE NegociostempGENERALES
	SET fechaGrabacion = @DefaultDate
	WHERE (
			fechaGrabacion IS NULL
			OR fechaGrabacion = ''
			)

	UPDATE NegociostempGENERALES
	SET fechaExpedicion = CONVERT(DATETIME, fechaExpedicion, 103)

	UPDATE NegociostempGENERALES
	SET fechaCancelacion = CONVERT(DATETIME, fechaCancelacion, 103)

	UPDATE NegociostempGENERALES
	SET fechaEmisionMaximoEndoso = CONVERT(DATETIME, fechaEmisionMaximoEndoso, 103)

	UPDATE NegociostempGENERALES
	SET fechaRecaudoInicial = CONVERT(DATETIME, fechaRecaudoInicial, 103)

	UPDATE NegociostempGENERALES
	SET fechaGrabacion = CONVERT(DATETIME, fechaGrabacion, 103)

	-- *********************************************************************************************************
	-- Normalización llaves foráneas
	-- *********************************************************************************************************--
	UPDATE NegociostempGENERALES
	SET tipoDocumento_id = '0'
	WHERE tipoDocumento_id = ''

	UPDATE NegociostempGENERALES
	SET actividadEconomica_id = CAST(actividadEconomica_id AS INT)
	WHERE actividadEconomica_id IS NULL

	UPDATE NegociostempGENERALES
	SET zona_id = '0'
	WHERE zona_id IS NULL

	UPDATE NegociostempGENERALES
	SET grupoEndoso_id = CAST(grupoEndoso_id AS INT)
	WHERE grupoEndoso_id IS NULL

	UPDATE NegociostempGENERALES
	SET tipoEndoso_id = CAST(tipoEndoso_id AS INT)
	WHERE tipoEndoso_id IS NULL

	UPDATE NegociostempGENERALES
	SET marcaVehiculo = CAST(marcaVehiculo AS INT)
	WHERE marcaVehiculo IS NULL

	UPDATE NegociostempGENERALES
	SET tipoVehiculo = CAST(tipoVehiculo AS INT)
	WHERE tipoVehiculo IS NULL

	-- *********************************************************************************************************
	-- Normalización valores númericos.
	-- *********************************************************************************************************--
	UPDATE NegociostempGENERALES
	SET modeloVehiculo = CAST(modeloVehiculo AS INT)
	WHERE modeloVehiculo IS NULL

	UPDATE NegociostempGENERALES
	SET Usuarios = CAST(Usuarios AS INT)
	WHERE Usuarios IS NULL

	UPDATE NegociostempGENERALES
	SET codigoAgrupador = '0'
	WHERE codigoAgrupador IS NULL

	UPDATE NegociostempGENERALES
	SET numeroSolicitud = CAST(numeroSolicitud AS INT)
	WHERE numeroSolicitud IS NULL

	UPDATE NegociostempGENERALES
	SET valorAsegurado = STR(CAST(REPLACE(valorAsegurado, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempGENERALES
	SET cuotasPagadas = STR(CAST(REPLACE(cuotasPagadas, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempGENERALES
	SET cuotasVencidas = STR(CAST(REPLACE(cuotasVencidas, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempGENERALES
	SET valorProteccion = STR(CAST(REPLACE(valorProteccion, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempGENERALES
	SET valorAhorro = STR(CAST(REPLACE(valorAhorro, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempGENERALES
	SET valorPrimaPensiones = STR(CAST(REPLACE(valorPrimaPensiones, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempGENERALES
	SET valorPrimaTotal = STR(CAST(REPLACE(valorPrimaTotal, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempGENERALES
	SET valorAsegurado = RTRIM(LTRIM(valorAsegurado))
		,valorAhorro = RTRIM(LTRIM(valorAhorro))
		,valorPrimaPensiones = RTRIM(LTRIM(valorPrimaPensiones))
		,valorPrimaTotal = RTRIM(LTRIM(valorPrimaTotal))
		,valorProteccion = RTRIM(LTRIM(valorProteccion))
END