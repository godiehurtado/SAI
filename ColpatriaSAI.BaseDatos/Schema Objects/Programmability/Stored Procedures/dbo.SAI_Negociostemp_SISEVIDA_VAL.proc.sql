
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Normaliza las fechas y los valores ´numericos de SISE VIDA--				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Negociostemp_SISEVIDA_VAL]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

	-- *********************************************************************************************************
	-- Homologación de fechas
	-- *********************************************************************************************************--
	UPDATE NegociostempVIDA
	SET fechaExpedicion = @DefaultDate
	WHERE fechaExpedicion IS NULL

	UPDATE NegociostempVIDA
	SET fechaCancelacion = @DefaultDate
	WHERE fechaCancelacion IS NULL

	UPDATE NegociostempVIDA
	SET fechaEmisionMaximoEndoso = @DefaultDate
	WHERE fechaEmisionMaximoEndoso IS NULL

	UPDATE NegociostempVIDA
	SET fechaRecaudoInicial = @DefaultDate
	WHERE fechaRecaudoInicial IS NULL

	UPDATE NegociostempVIDA
	SET fechaGrabacion = @DefaultDate
	WHERE fechaGrabacion IS NULL

	UPDATE NegociostempVIDA
	SET fechaExpedicion = CONVERT(DATETIME, fechaExpedicion, 103)

	UPDATE NegociostempVIDA
	SET fechaCancelacion = CONVERT(DATETIME, fechaCancelacion, 103)

	UPDATE NegociostempVIDA
	SET fechaEmisionMaximoEndoso = CONVERT(DATETIME, fechaEmisionMaximoEndoso, 103)

	UPDATE NegociostempVIDA
	SET fechaRecaudoInicial = CONVERT(DATETIME, fechaRecaudoInicial, 103)

	UPDATE NegociostempVIDA
	SET fechaGrabacion = CONVERT(DATETIME, fechaGrabacion, 103)

	-- *********************************************************************************************************
	-- Normalización llaves foráneas
	-- *********************************************************************************************************--
	UPDATE NegociostempVIDA
	SET tipoDocumento_id = '0'
	WHERE tipoDocumento_id = ''

	UPDATE NegociostempVIDA
	SET actividadEconomica_id = CAST(actividadEconomica_id AS INT)
	WHERE actividadEconomica_id IS NULL

	UPDATE NegociostempVIDA
	SET zona_id = '0'
	WHERE zona_id IS NULL

	UPDATE NegociostempVIDA
	SET grupoEndoso_id = CAST(grupoEndoso_id AS INT)
	WHERE grupoEndoso_id IS NULL

	UPDATE NegociostempVIDA
	SET tipoEndoso_id = CAST(tipoEndoso_id AS INT)
	WHERE tipoEndoso_id IS NULL

	UPDATE NegociostempVIDA
	SET marcaVehiculo = CAST(marcaVehiculo AS INT)
	WHERE marcaVehiculo IS NULL

	UPDATE NegociostempVIDA
	SET tipoVehiculo = CAST(tipoVehiculo AS INT)
	WHERE tipoVehiculo IS NULL

	-- *********************************************************************************************************
	-- Normalización valores númericos.
	-- *********************************************************************************************************--
	UPDATE NegociostempVIDA
	SET modeloVehiculo = CAST(modeloVehiculo AS INT)
	WHERE modeloVehiculo IS NULL

	UPDATE NegociostempVIDA
	SET Usuarios = CAST(Usuarios AS INT)
	WHERE Usuarios IS NULL

	UPDATE NegociostempVIDA
	SET codigoAgrupador = '0'
	WHERE codigoAgrupador IS NULL

	UPDATE NegociostempVIDA
	SET numeroSolicitud = CAST(numeroSolicitud AS INT)
	WHERE numeroSolicitud IS NULL

	UPDATE NegociostempVIDA
	SET valorAsegurado = STR(CAST(REPLACE(valorAsegurado, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempVIDA
	SET cuotasPagadas = STR(CAST(REPLACE(cuotasPagadas, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempVIDA
	SET cuotasVencidas = STR(CAST(REPLACE(cuotasVencidas, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempVIDA
	SET valorProteccion = STR(CAST(REPLACE(valorProteccion, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempVIDA
	SET valorAhorro = STR(CAST(REPLACE(valorAhorro, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempVIDA
	SET valorPrimaPensiones = STR(CAST(REPLACE(valorPrimaPensiones, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempVIDA
	SET valorPrimaTotal = STR(CAST(REPLACE(valorPrimaTotal, ',', '.') AS FLOAT), 20, 10)

	UPDATE NegociostempVIDA
	SET valorAsegurado = RTRIM(LTRIM(valorAsegurado))
		,valorAhorro = RTRIM(LTRIM(valorAhorro))
		,valorPrimaPensiones = RTRIM(LTRIM(valorPrimaPensiones))
		,valorPrimaTotal = RTRIM(LTRIM(valorPrimaTotal))
		,valorProteccion = RTRIM(LTRIM(valorProteccion))
END