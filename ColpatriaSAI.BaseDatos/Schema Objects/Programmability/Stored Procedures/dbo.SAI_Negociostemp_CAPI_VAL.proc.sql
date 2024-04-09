
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Inserción en dbo.Negocio y dbo.NegociostempErrorCAPI los negocios de CAPI que aún o existen en SAI x número de negocio--				
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Negociostemp_CAPI_VAL]
AS
BEGIN
	DECLARE @anioVigente AS INT = (
		SELECT anioCierre FROM PeriodoCierre WHERE compania_id = 3
		AND estado = 1
		)
	DECLARE @mesCierre AS INT = (
		SELECT mesCierre FROM PeriodoCierre WHERE compania_id = 3
		AND estado = 1
		)

	--  Valores que no existen por numero de negocio en la tabla dbo.Negocio
	SELECT nt.compania_id
		,nt.lineaNegocio_id
		,CAST(nt.ramo_id AS INT) AS ramo_id
		,CAST(nt.productoCodigo AS INT) AS producto_id
		,CAST(nt.plan_id AS INT) AS plan_id
		,CAST(nt.amparo_id AS INT) AS amparo_id
		,CAST(nt.cobertura_id AS INT) AS cobertura_id
		,CAST(nt.modalidadPago_id AS INT) AS modalidadPago_id
		,nt.formaPago_id
		,RTRIM(LTRIM(nt.numeroNegocio)) AS numeroNegocio
		,nt.numeroSolicitud
		,nt.codigoAgrupador
		,MIN(nt.fechaExpedicion) AS fechaExpedicion
		,nt.fechaGrabacion
		,nt.fechaRecaudoInicial
		,nt.fechaEmisionMaximoEndoso
		,nt.fechaCancelacion
		,CAST(REPLACE(nt.valorAsegurado, ',', '.') AS FLOAT) AS valorAsegurado
		,CAST(REPLACE(nt.valorProteccion, ',', '.') AS FLOAT) AS valorProteccion
		,CAST(REPLACE(nt.valorAhorro, ',', '.') AS FLOAT) AS valorAhorro
		,CAST(REPLACE(nt.valorPrimaPensiones, ',', '.') AS FLOAT) AS valorPrimaPensiones
		,CAST(REPLACE(nt.valorPrimaTotal, ',', '.') AS FLOAT) AS valorPrimaTotal
		,nt.estado
		,nt.zona_id
		,CAST(nt.localidad_id AS INT) AS localidad_id
		,RTRIM(LTRIM(nt.clave)) AS clave
		,nt.participante_id
		,nt.porcentajeParticipacion
		,CAST(nt.tipoEndoso_id AS INT) AS tipoEndoso
		,CAST(nt.grupoEndoso_id AS INT) AS grupoEndoso
		,CAST(nt.cuotasPagadas AS INT) AS cuotasPagadas
		,CAST(nt.cuotasVencidas AS INT) AS cuotasVencidas
		,CAST(nt.cliente_id AS INT) AS cliente_id
		,nt.identificacionSuscriptor
		,CAST(nt.usuarios AS INT) AS usuarios
		,CAST(nt.marcaVehiculo AS INT) AS marcaVehiculo
		,CAST(nt.tipoVehiculo AS INT) AS tipoVehiculo
		,GETDATE() AS fechaCarga
		,nt.nombreSuscriptor
		,nt.generoSuscriptor
		,nt.modeloVehiculo
		,nt.sistema
		,2 AS estadoCierre
		,@mesCierre AS mesCierre
		,@anioVigente AS anioCierre
	INTO #NegociosCAPI
	FROM NegociostempCAPI AS nt
	WHERE NOT EXISTS (
			SELECT *
			FROM Negocio AS n
			WHERE RTRIM(LTRIM(n.numeroNegocio)) = RTRIM(LTRIM(nt.numeroNegocio))
				AND n.clave = nt.clave
				AND n.lineaNegocio_id = nt.lineaNegocio_id
				AND n.compania_id = 3
				AND n.sistema = 'CAPI'
			)
	GROUP BY compania_id
		,lineaNegocio_id
		,ramo_id
		,productoCodigo
		,plan_id
		,amparo_id
		,cobertura_id
		,modalidadPago_id
		,formaPago_id
		,numeroNegocio
		,numeroSolicitud
		,codigoAgrupador
		,fechaGrabacion
		,fechaRecaudoInicial
		,fechaEmisionMaximoEndoso
		,fechaCancelacion
		,valorAsegurado
		,valorProteccion
		,valorAhorro
		,valorPrimaPensiones
		,valorPrimaTotal
		,estado
		,zona_id
		,localidad_id
		,clave
		,participante_id
		,porcentajeParticipacion
		,tipoEndoso_id
		,grupoEndoso_id
		,cuotasPagadas
		,cuotasVencidas
		,cliente_id
		,identificacionSuscriptor
		,actividadEconomica_id
		,Usuarios
		,marcaVehiculo
		,tipoVehiculo
		,nombreSuscriptor
		,generoSuscriptor
		,modeloVehiculo
		,sistema

	--  Valores que se deben insertar en NegociostempErrorCAPI y aún no existen en dbo.Negocio
	SELECT nt.compania_id
		,nt.lineaNegocio_id
		,CAST(nt.ramo_id AS INT) AS ramo_id
		,CAST(nt.producto_id AS INT) AS producto_id
		,CAST(nt.plan_id AS INT) AS plan_id
		,CAST(nt.amparo_id AS INT) AS amparo_id
		,CAST(nt.cobertura_id AS INT) AS cobertura_id
		,CAST(nt.modalidadPago_id AS INT) AS modalidadPago_id
		,nt.formaPago_id
		,RTRIM(LTRIM(nt.numeroNegocio)) AS numeroNegocio
		,nt.numeroSolicitud
		,nt.codigoAgrupador
		,nt.fechaExpedicion
		,nt.fechaGrabacion
		,nt.fechaRecaudoInicial
		,nt.fechaEmisionMaximoEndoso
		,nt.fechaCancelacion
		,CAST(REPLACE(nt.valorAsegurado, ',', '.') AS FLOAT) AS valorAsegurado
		,CAST(REPLACE(nt.valorProteccion, ',', '.') AS FLOAT) AS valorProteccion
		,CAST(REPLACE(nt.valorAhorro, ',', '.') AS FLOAT) AS valorAhorro
		,CAST(REPLACE(nt.valorPrimaPensiones, ',', '.') AS FLOAT) AS valorPrimaPensiones
		,CAST(REPLACE(nt.valorPrimaTotal, ',', '.') AS FLOAT) AS valorPrimaTotal
		,nt.estado
		,nt.zona_id
		,CAST(nt.localidad_id AS INT) AS localidad_id
		,RTRIM(LTRIM(nt.clave)) AS clave
		,nt.participante_id
		,nt.porcentajeParticipacion
		,CAST(nt.tipoEndoso AS INT) AS tipoEndoso
		,CAST(nt.grupoEndoso AS INT) AS grupoEndoso
		,CAST(nt.cuotasPagadas AS INT) AS cuotasPagadas
		,CAST(nt.cuotasVencidas AS INT) AS cuotasVencidas
		,CAST(nt.cliente_id AS INT) AS cliente_id
		,nt.identificacionSuscriptor
		,CAST(nt.usuarios AS INT) AS usuarios
		,CAST(nt.marcaVehiculo AS INT) AS marcaVehiculo
		,CAST(nt.tipoVehiculo AS INT) AS tipoVehiculo
		,GETDATE() AS fechaCarga
		,nt.nombreSuscriptor
		,nt.generoSuscriptor
		,nt.modeloVehiculo
		,nt.sistema
		,2 AS estadoCierre
		,@mesCierre AS mesCierre
		,@anioVigente AS anioCierre
	INTO #NegocioSplitCAPI
	FROM #NegociosCAPI AS nt
	WHERE (
			CHARINDEX('-', nt.clave) > 0
			OR CHARINDEX('-', nt.porcentajeParticipacion) > 0
			)

	--  Borrar de la tabla inicial, los registros que se les debe hacer Split.
	DELETE
	FROM #NegociosCAPI
	WHERE (
			CHARINDEX('-', clave) > 0
			OR CHARINDEX('-', porcentajeParticipacion) > 0
			)

	--  Insertar en dbo.Negocio (con mínima fecha de Expedición del negocio)
	INSERT INTO Negocio (
		productoDetalle_id
		,localidad_id
		,cliente_id
		,numeroNegocio
		,fechaExpedicion
		,tipoEndoso_id
		,grupoEndoso_id
		,valorAsegurado
		,lineaNegocio_id
		,compania_id
		,ramoDetalle_id
		,amparo_id
		,cobertura_id
		,modalidadPago_id
		,planDetalle_id
		,zona_id
		,participante_id
		,clave
		,fechaGrabacion
		,fechaRecaudoInicial
		,numeroSolicitud
		,cuotasPagadas
		,cuotasVencidas
		,identificacionSuscriptor
		,nombreSuscriptor
		,generoSuscriptor
		,marcaVehiculo_id
		,tipoVehiculo_id
		,modeloVehiculo
		,sistema
		,porcentajeParticipacion
		,formaPago_id
		,valorProteccion
		,valorAhorro
		,valorPrimaPensiones
		,valorPrimaTotal
		,estadoNegocio
		,codigoAgrupador
		,fechaEmisionMaximoEndoso
		,fechaCancelacion
		,Usuarios
		,fechaCarga
		,estadoCierre
		,mesCierre
		,anioCierre
		)
	SELECT nc.producto_id
		,nc.localidad_id
		,nc.cliente_id
		,RTRIM(LTRIM(nc.numeroNegocio))
		,nc.fechaExpedicion
		,nc.tipoEndoso
		,nc.grupoEndoso
		,nc.valorAsegurado
		,nc.lineaNegocio_id
		,nc.compania_id
		,nc.ramo_id
		,nc.amparo_id
		,nc.cobertura_id
		,nc.modalidadPago_id
		,nc.plan_id
		,nc.zona_id
		,nc.participante_id
		,RTRIM(LTRIM(nc.clave))
		,nc.fechaGrabacion
		,nc.fechaRecaudoInicial
		,nc.numeroSolicitud
		,nc.cuotasPagadas
		,nc.cuotasVencidas
		,nc.identificacionSuscriptor
		,nc.nombreSuscriptor
		,nc.generoSuscriptor
		,nc.marcaVehiculo
		,nc.tipoVehiculo
		,nc.modeloVehiculo
		,nc.sistema
		,nc.porcentajeParticipacion
		,nc.formaPago_id
		,nc.valorProteccion
		,nc.valorAhorro
		,nc.valorPrimaPensiones
		,nc.valorPrimaTotal
		,nc.estado
		,nc.codigoAgrupador
		,nc.fechaEmisionMaximoEndoso
		,nc.fechaCancelacion
		,nc.Usuarios
		,nc.fechaCarga
		,nc.estadoCierre
		,nc.mesCierre
		,nc.anioCierre
	FROM #NegociosCAPI nc

	--  Insertar en dbo.NegociostempError (con minima fecha de expedición del negocio)
	INSERT INTO NegociostempErrorCAPI (
		compania_id
		,lineaNegocio_id
		,ramo_id
		,amparo_id
		,cobertura_id
		,modalidadPago_id
		,producto_id
		,plan_id
		,numeroNegocio
		,fechaExpedicion
		,fechaCancelacion
		,fechaEmisionMaximoEndoso
		,fechaRecaudoInicial
		,formaPago_id
		,estadoNegocio_id
		,numeroSolicitud
		,cuotasVencidas
		,cuotasPagadas
		,valorAsegurado
		,valorProteccion
		,valorAhorro
		,valorPrimaPensiones
		,valorPrimaTotal
		,identificacionSuscriptor
		,nombreSuscriptor
		,generoSuscriptor
		,zona_id
		,localidad_id
		,clave
		,porcentajeParticipacion
		,grupoEndoso_id
		,tipoEndoso_id
		,codigoAgrupador
		,marcaVehiculo
		,tipoVehiculo
		,modeloVehiculo
		,sistema
		,Usuarios
		,cliente_id
		,fechaGrabacion
		,estadoCierre
		,mesCierre
		,anioCierre
		)
	SELECT nsc.compania_id
		,nsc.lineaNegocio_id
		,nsc.ramo_id
		,nsc.amparo_id
		,nsc.cobertura_id
		,nsc.modalidadPago_id
		,nsc.producto_id
		,nsc.plan_id
		,RTRIM(LTRIM(nsc.numeroNegocio))
		,nsc.fechaExpedicion
		,nsc.fechaCancelacion
		,nsc.fechaEmisionMaximoEndoso
		,nsc.fechaRecaudoInicial
		,nsc.formaPago_id
		,nsc.estado
		,nsc.numeroSolicitud
		,nsc.cuotasVencidas
		,nsc.cuotasPagadas
		,nsc.valorAsegurado
		,nsc.valorProteccion
		,nsc.valorAhorro
		,nsc.valorPrimaPensiones
		,nsc.valorPrimaTotal
		,nsc.identificacionSuscriptor
		,nsc.nombreSuscriptor
		,nsc.generoSuscriptor
		,nsc.zona_id
		,nsc.localidad_id
		,RTRIM(LTRIM(nsc.clave))
		,nsc.porcentajeParticipacion
		,nsc.grupoEndoso
		,nsc.tipoEndoso
		,nsc.codigoAgrupador
		,nsc.marcaVehiculo
		,nsc.tipoVehiculo
		,nsc.modeloVehiculo
		,nsc.sistema
		,nsc.usuarios
		,nsc.cliente_id
		,nsc.fechaGrabacion
		,nsc.estadoCierre
		,nsc.mesCierre
		,nsc.anioCierre
	FROM #NegocioSplitCAPI nsc

	DROP TABLE #NegociosCAPI

	DROP TABLE #NegocioSplitCAPI
END