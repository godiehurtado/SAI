-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Procedimiento que permite separar en más de un reglón los porcentajes y claves con
--              negocios compartidos.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_splitNegocio_CAPI]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)
	DECLARE @cantidadRegistros AS INT = (SELECT COUNT(*) FROM NegociostempErrorCAPI)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 111)

	IF (@cantidadRegistros > 0)
	BEGIN
		-- *********************************************************************************************************
		-- DECLARACIÓN DE VARIABLES
		-- *********************************************************************************************************--
		DECLARE @pos INT
			,@pos1 INT
			,@curruntLocation CHAR(20)
			,@curruntLocation1 CHAR(20)
			,@clave NVARCHAR(2048)
			,@porcentajeParticipacion NVARCHAR(2048)
			,@numeroNegocio NVARCHAR(2048)
			,@compania_id NVARCHAR(2048)
			,@lineaNegocio_id NVARCHAR(2048)
			,@ramo_id NVARCHAR(2048)
			,@amparo_id NVARCHAR(2048)
			,@cobertura_id NVARCHAR(2048)
			,@modalidadPago_id NVARCHAR(2048)
			,@producto_id NVARCHAR(2048)
			,@plan_id NVARCHAR(2048)
			,@cliente_id NVARCHAR(2048)
			,@estado NVARCHAR(2048)
			,@numeroSolicitud NVARCHAR(2048)
			,@cuotasVencidas NVARCHAR(2048)
			,@cuotasPagadas NVARCHAR(2048)
			,@valorAsegurado NVARCHAR(2048)
			,@valorProteccion NVARCHAR(2048)
			,@valorAhorro NVARCHAR(2048)
			,@valorprimaPensiones NVARCHAR(2048)
			,@valorPrimaTotal NVARCHAR(2048)
			,@identificacionSuscriptor NVARCHAR(2048)
			,@actividadEconomica NVARCHAR(2048)
			,@generoSuscriptor NVARCHAR(2048)
			,@grupoEndoso NVARCHAR(2048)
			,@tipoEndoso NVARCHAR(2048)
			,@marcaVehiculo NVARCHAR(2048)
			,@tipoVehiculo NVARCHAR(2048)
			,@modeloVehiculo NVARCHAR(2048)
			,@usuarios NVARCHAR(2048)
			,@localidad NVARCHAR(2048)
			,@fechaCancelacion NVARCHAR(2048)
			,@fechaRecaudoInicial NVARCHAR(2048)
			,@fechaGrabacion NVARCHAR(2048)
			,@fechaExpedicion NVARCHAR(2048)
			,@fechaEmisionMaximoEndoso NVARCHAR(2048)
			,@formaPago NVARCHAR(2048)
			,@codigoAgrupador NVARCHAR(2048)
			,@nombreSuscriptor NVARCHAR(2048)
			,@estadoCierre INT
			,@mesCierre INT
			,@anioCierre INT
			,@fechaInicioVigencia NVARCHAR(2048)
			,@cuotasTotales NVARCHAR(2048)
			,@fechaFinVigencia NVARCHAR(2048)
			,@codigoEmision NVARCHAR(2048)
			,@recompra NVARCHAR(2048)
			,@numeroRecompra NVARCHAR(2048)

		CREATE TABLE #NegociostempsplitCAPI (
			id INT IDENTITY(0, 1) NOT NULL
			,clave NVARCHAR(100)
			,porcentajeParticipacion NVARCHAR(100)
			,numeroNegocio NVARCHAR(100)
			,compania NVARCHAR(100)
			,lineaNegocio NVARCHAR(100)
			,ramo NVARCHAR(100)
			,amparo NVARCHAR(100)
			,cobertura NVARCHAR(100)
			,modalidadPago NVARCHAR(100)
			,productoCodigo NVARCHAR(100)
			,[plan] NVARCHAR(100)
			,formaPago NVARCHAR(2048)
			,estadoNegocio NVARCHAR(2048)
			,numeroSolicitud NVARCHAR(2048)
			,cuotasVencidas NVARCHAR(2048)
			,cuotasPagadas NVARCHAR(2048)
			,valorAsegurado NVARCHAR(2048)
			,valorProteccion NVARCHAR(2048)
			,valorAhorro NVARCHAR(2048)
			,valorPrimaPensiones NVARCHAR(2048)
			,valorPrimaTotal NVARCHAR(2048)
			,identificacionSuscriptor NVARCHAR(2048)
			,actividadEconomica NVARCHAR(2048)
			,generoSuscriptor NVARCHAR(2048)
			,grupoEndoso NVARCHAR(2048)
			,tipoEndoso NVARCHAR(2048)
			,marcaVehiculo NVARCHAR(2048)
			,tipoVehiculo NVARCHAR(2048)
			,modeloVehiculo NVARCHAR(2048)
			,sistema NVARCHAR(2048)
			,usuarios NVARCHAR(2048)
			,localidad NVARCHAR(2048)
			,fechaCancelacion NVARCHAR(2048)
			,fechaExpedicion NVARCHAR(2048)
			,fechaEmisionMaximoEndoso NVARCHAR(2048)
			,fechaRecaudoInicial NVARCHAR(2048)
			,codigoAgrupador NVARCHAR(2048)
			,cliente NVARCHAR(2048)
			,fechaGrabacion NVARCHAR(2048)
			,nombreSuscriptor NVARCHAR(2048)
			,estadoCierre INT
			,mesCierre INT
			,anioCierre INT
			,fechaInicioVigencia NVARCHAR(2048)
			,cuotasTotales NVARCHAR(2048)
			,fechaFinVigencia NVARCHAR(2048)
			,codigoEmision NVARCHAR(2048)
			,recompra NVARCHAR(2048)
			,numeroRecompra NVARCHAR(2048)
			)

		-- *********************************************************************************************************
		--  Tabla donde se insertan los registros con split (el campo contiene '-') y que contiene datos Core válidos. 
		-- *********************************************************************************************************--
		INSERT INTO #NegociostempsplitCAPI (
			clave
			,porcentajeParticipacion
			,numeroNegocio
			,compania
			,lineaNegocio
			,ramo
			,amparo
			,cobertura
			,modalidadPago
			,productoCodigo
			,[plan]
			,formaPago
			,estadoNegocio
			,numeroSolicitud
			,cuotasVencidas
			,cuotasPagadas
			,valorAsegurado
			,valorProteccion
			,valorAhorro
			,valorPrimaPensiones
			,valorPrimaTotal
			,identificacionSuscriptor
			,actividadEconomica
			,generoSuscriptor
			,grupoEndoso
			,tipoEndoso
			,marcaVehiculo
			,tipoVehiculo
			,modeloVehiculo
			,sistema
			,usuarios
			,localidad
			,fechaCancelacion
			,fechaExpedicion
			,fechaEmisionMaximoEndoso
			,fechaRecaudoInicial
			,codigoAgrupador
			,cliente
			,fechaGrabacion
			,nombreSuscriptor
			,estadoCierre
			,mesCierre
			,anioCierre
			,fechaInicioVigencia
			,cuotasTotales
			,fechaFinVigencia
			,codigoEmision
			,recompra
			,numeroRecompra
			) (
			SELECT RTRIM(LTRIM(nte.clave))
			,nte.porcentajeParticipacion
			,RTRIM(LTRIM(nte.numeroNegocio))
			,nte.compania_id
			,nte.lineaNegocio_id
			,nte.ramo_id
			,nte.amparo_id
			,nte.cobertura_id
			,nte.modalidadPago_id
			,nte.producto_id
			,nte.plan_id
			,nte.formaPago_id
			,nte.estadoNegocio_id
			,nte.numeroSolicitud
			,nte.cuotasVencidas
			,nte.cuotasPagadas
			,nte.valorAsegurado
			,nte.valorProteccion
			,nte.valorAhorro
			,nte.valorPrimaPensiones
			,nte.valorPrimaTotal
			,nte.identificacionSuscriptor
			,nte.actividadEconomica_id
			,nte.generoSuscriptor
			,nte.grupoEndoso_id
			,nte.tipoEndoso_id
			,nte.marcaVehiculo
			,nte.tipoVehiculo
			,nte.modeloVehiculo
			,nte.sistema
			,nte.Usuarios
			,nte.localidad_id
			,nte.fechaCancelacion
			,nte.fechaExpedicion
			,nte.fechaEmisionMaximoEndoso
			,nte.fechaRecaudoInicial
			,nte.codigoAgrupador
			,nte.cliente_id
			,nte.fechaGrabacion
			,nte.nombreSuscriptor
			,nte.estadoCierre
			,nte.mesCierre
			,nte.anioCierre
			,nte.fechaInicioVigencia
			,nte.cuotasTotales
			,nte.fechaFinVigencia
			,nte.codigoEmision
			,nte.recompra
			,nte.numeroRecompra FROM NegociostempErrorCAPI nte INNER JOIN Compania c ON c.id = nte.compania_id INNER JOIN RamoDetalle rd ON rd.id = nte.ramo_id INNER JOIN ProductoDetalle pd ON pd.id = nte.producto_id INNER JOIN Localidad l ON l.id = nte.localidad_id INNER JOIN LineaNegocio ln ON ln.id = nte.lineaNegocio_id WHERE c.id = rd.compania_id
			AND c.id = 3
			AND nte.clave <> ''
			AND nte.porcentajeParticipacion <> ''
			AND (
				CHARINDEX('-', nte.porcentajeParticipacion) > 0
				OR CHARINDEX('-', nte.clave) > 0
				)
			)

		CREATE TABLE #Negociostemp1splitCAPI (
			clave NVARCHAR(100)
			,porcentajeParticipacion NVARCHAR(100)
			,numeroNegocio NVARCHAR(100)
			,compania NVARCHAR(100)
			,lineaNegocio NVARCHAR(100)
			,ramo NVARCHAR(100)
			,amparo NVARCHAR(100)
			,cobertura NVARCHAR(100)
			,modalidadPago NVARCHAR(100)
			,productoCodigo NVARCHAR(100)
			,[plan] NVARCHAR(100)
			,formaPago NVARCHAR(2048)
			,estadoNegocio NVARCHAR(2048)
			,numeroSolicitud NVARCHAR(2048)
			,cuotasVencidas NVARCHAR(2048)
			,cuotasPagadas NVARCHAR(2048)
			,valorAsegurado NVARCHAR(2048)
			,valorProteccion NVARCHAR(2048)
			,valorAhorro NVARCHAR(2048)
			,valorPrimaPensiones NVARCHAR(2048)
			,valorPrimaTotal NVARCHAR(2048)
			,identificacionSuscriptor NVARCHAR(2048)
			,actividadEconomica NVARCHAR(2048)
			,generoSuscriptor NVARCHAR(2048)
			,grupoEndoso NVARCHAR(2048)
			,tipoEndoso NVARCHAR(2048)
			,marcaVehiculo NVARCHAR(2048)
			,tipoVehiculo NVARCHAR(2048)
			,modeloVehiculo NVARCHAR(2048)
			,sistema NVARCHAR(2048)
			,usuarios NVARCHAR(2048)
			,localidad NVARCHAR(2048)
			,fechaCancelacion NVARCHAR(2048)
			,fechaExpedicion NVARCHAR(2048)
			,fechaEmisionMaximoEndoso NVARCHAR(2048)
			,fechaRecaudoInicial NVARCHAR(2048)
			,cliente NVARCHAR(2048)
			,fechaGrabacion NVARCHAR(2048)
			,zona_id NVARCHAR(2048)
			,participante_id NVARCHAR(2048)
			,nombreSuscriptor NVARCHAR(2048)
			,codigoAgrupador NVARCHAR(2048)
			,estadoCierre INT
			,mesCierre INT
			,anioCierre INT
			,fechaInicioVigencia NVARCHAR(2048)
			,cuotasTotales NVARCHAR(2048)
			,fechaFinVigencia NVARCHAR(2048)
			,codigoEmision NVARCHAR(2048)
			,recompra NVARCHAR(2048)
			,numeroRecompra NVARCHAR(2048)
			)

		-- *********************************************************************************************************
		-- SE LE ASIGNA UN VALOR A CADA UNA DE LAS VARIABLES YA CREADAS. 
		-- *********************************************************************************************************-
		DECLARE @total INT = (SELECT MAX(nte.id) FROM #NegociostempsplitCAPI nte)
		DECLARE @inicio INT = (SELECT MIN(nte.id) FROM #NegociostempsplitCAPI nte)

		WHILE (@inicio) <= @total
		BEGIN
			SELECT @pos = 0

			SELECT @pos1 = 0

			SELECT @clave = (
					SELECT clave
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @porcentajeParticipacion = (
					SELECT porcentajeParticipacion
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @numeroNegocio = (
					SELECT numeroNegocio
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @compania_id = 3

			SELECT @lineaNegocio_id = (
					SELECT lineaNegocio
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @ramo_id = (
					SELECT ramo
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @amparo_id = (
					SELECT amparo
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @cobertura_id = (
					SELECT cobertura
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @modalidadPago_id = (
					SELECT modalidadPago
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @producto_id = (
					SELECT productoCodigo
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @plan_id = (
					SELECT [plan]
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @estado = (
					SELECT estadoNegocio
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @numeroSolicitud = (
					SELECT numeroSolicitud
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @cuotasVencidas = (
					SELECT cuotasVencidas
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @cuotasPagadas = (
					SELECT cuotasPagadas
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @valorAsegurado = (
					SELECT valorAsegurado
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @valorProteccion = (
					SELECT valorProteccion
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @valorAhorro = (
					SELECT valorAhorro
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @valorprimaPensiones = (
					SELECT valorPrimaPensiones
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @valorPrimaTotal = (
					SELECT valorPrimaTotal
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @identificacionSuscriptor = (
					SELECT identificacionSuscriptor
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @actividadEconomica = (
					SELECT actividadEconomica
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @generoSuscriptor = (
					SELECT generoSuscriptor
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @grupoEndoso = (
					SELECT grupoEndoso
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @tipoEndoso = (
					SELECT TipoEndoso
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @marcaVehiculo = (
					SELECT marcaVehiculo
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @tipoVehiculo = (
					SELECT tipoVehiculo
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @modeloVehiculo = (
					SELECT modeloVehiculo
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @usuarios = (
					SELECT Usuarios
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaCancelacion = (
					SELECT fechaCancelacion
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaRecaudoInicial = (
					SELECT fechaRecaudoInicial
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaEmisionMaximoEndoso = (
					SELECT fechaEmisionMaximoEndoso
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaExpedicion = (
					SELECT fechaExpedicion
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaGrabacion = (
					SELECT fechaGrabacion
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @localidad = (
					SELECT localidad
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @formaPago = (
					SELECT formaPago
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @codigoAgrupador = (
					SELECT codigoAgrupador
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @cliente_id = (
					SELECT cliente
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @nombreSuscriptor = (
					SELECT nombreSuscriptor
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @estadoCierre = (
					SELECT estadoCierre
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @mesCierre = (
					SELECT mesCierre
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @anioCierre = (
					SELECT anioCierre
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaInicioVigencia = (
					SELECT fechaInicioVigencia
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @cuotasTotales = (
					SELECT cuotasTotales
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaFinVigencia = (
					SELECT fechaFinVigencia
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @codigoEmision = (
					SELECT codigoEmision
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @recompra = (
					SELECT recompra
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @numeroRecompra = (
					SELECT numeroRecompra
					FROM #NegociostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @clave = @clave + '-'

			SELECT @porcentajeParticipacion = @porcentajeParticipacion + '-'

			WHILE CHARINDEX('-', @clave) > 0
				OR CHARINDEX('-', @porcentajeParticipacion) > 0
			BEGIN
				SELECT @pos = CHARINDEX('-', @clave)

				SELECT @pos1 = CHARINDEX('-', @porcentajeParticipacion)

				SELECT @curruntLocation = RTRIM(SUBSTRING(@clave, 1, @pos - 1))

				SELECT @curruntLocation1 = RTRIM(SUBSTRING(@porcentajeParticipacion, 1, @pos1 - 1))

				-- *********************************************************************************************************
				-- SE INSERTAN LOS VALORES YA SEPARADOS EN EL CICLO DEL SPLIT.
				-- *********************************************************************************************************--
				INSERT INTO #Negociostemp1splitCAPI (
					clave
					,porcentajeParticipacion
					,numeroNegocio
					,compania
					,lineaNegocio
					,ramo
					,amparo
					,cobertura
					,modalidadPago
					,productoCodigo
					,[plan]
					,formaPago
					,estadoNegocio
					,numeroSolicitud
					,cuotasVencidas
					,cuotasPagadas
					,valorAsegurado
					,valorProteccion
					,valorAhorro
					,valorPrimaPensiones
					,valorPrimaTotal
					,identificacionSuscriptor
					,actividadEconomica
					,generoSuscriptor
					,grupoEndoso
					,tipoEndoso
					,marcaVehiculo
					,tipoVehiculo
					,modeloVehiculo
					,sistema
					,usuarios
					,localidad
					,fechaCancelacion
					,fechaExpedicion
					,fechaEmisionMaximoEndoso
					,fechaRecaudoInicial
					,codigoAgrupador
					,cliente
					,fechaGrabacion
					,nombreSuscriptor
					,estadoCierre
					,mesCierre
					,anioCierre
					,fechaInicioVigencia
					,cuotasTotales
					,fechaFinVigencia
					,codigoEmision
					,recompra
					,numeroRecompra
					)
				VALUES (
					@curruntLocation
					,@curruntLocation1
					,@numeroNegocio
					,@compania_id
					,@lineaNegocio_id
					,@ramo_id
					,@amparo_id
					,@cobertura_id
					,@modalidadPago_id
					,@producto_id
					,@plan_id
					,@formaPago
					,@estado
					,@numeroSolicitud
					,@cuotasVencidas
					,@cuotasPagadas
					,@valorAsegurado
					,@valorProteccion
					,@valorAhorro
					,@valorprimaPensiones
					,@valorPrimaTotal
					,@identificacionSuscriptor
					,@actividadEconomica
					,@generoSuscriptor
					,@grupoEndoso
					,@tipoEndoso
					,@marcaVehiculo
					,@tipoVehiculo
					,@modeloVehiculo
					,'CAPI'
					,@usuarios
					,@localidad
					,@fechaCancelacion
					,@fechaExpedicion
					,@fechaEmisionMaximoEndoso
					,@fechaRecaudoInicial
					,@codigoAgrupador
					,@cliente_id
					,@fechaGrabacion
					,@nombreSuscriptor
					,@estadoCierre
					,@mesCierre
					,@anioCierre
					,@fechaInicioVigencia
					,@cuotasTotales
					,@fechaFinVigencia
					,@codigoEmision
					,@recompra
					,@numeroRecompra
					)

				SELECT @clave = RTRIM(SUBSTRING(@clave, @pos + 1, 2048))

				SELECT @porcentajeParticipacion = LTRIM(SUBSTRING(@porcentajeParticipacion, @pos1 + 1, 2048))
			END

			SET @inicio = @inicio + 1
		END

		-- *********************************************************************************************************
		-- HOMOLOGACIÓN DE CAMPOS EN DONDE SE ENCUENTRA EL RESULTADO DEL SPLIT.
		-- *********************************************************************************************************--	
		--  Actualización x participante_id de la clave
		UPDATE #Negociostemp1splitCAPI
		SET participante_id = p.id
		FROM #Negociostemp1splitCAPI ntsc
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(ntsc.clave)) COLLATE Modern_Spanish_CI_AS

		--  Actualización x Zona de la Localidad
		UPDATE #Negociostemp1splitCAPI
		SET zona_id = l.zona_id
		FROM #Negociostemp1splitCAPI nts
		INNER JOIN Localidad l ON l.id = nts.localidad

		--  Normalización de fechas.
		UPDATE #Negociostemp1splitCAPI
		SET fechaCancelacion = @DefaultDate
		WHERE fechaCancelacion = ''
			OR fechaCancelacion = '0/00/00'
			OR fechaCancelacion IS NULL

		UPDATE #Negociostemp1splitCAPI
		SET fechaEmisionMaximoEndoso = @DefaultDate
		WHERE fechaEmisionMaximoEndoso = ''
			OR fechaEmisionMaximoEndoso = '0/00/00'
			OR fechaEmisionMaximoEndoso IS NULL

		UPDATE #Negociostemp1splitCAPI
		SET fechaRecaudoInicial = @DefaultDate
		WHERE fechaRecaudoInicial = ''
			OR fechaRecaudoInicial = '0/00/00'
			OR fechaRecaudoInicial IS NULL

		UPDATE #Negociostemp1splitCAPI
		SET fechaExpedicion = @DefaultDate
		WHERE fechaExpedicion = ''
			OR fechaExpedicion = '0/00/00'
			OR fechaExpedicion IS NULL

		UPDATE #Negociostemp1splitCAPI
		SET fechaGrabacion = @DefaultDate
		WHERE fechaGrabacion = ''
			OR fechaGrabacion = '0/00/00'
			OR fechaGrabacion IS NULL

		UPDATE #Negociostemp1splitCAPI
		SET fechaInicioVigencia = @DefaultDate
		WHERE fechaInicioVigencia = ''
			OR fechaInicioVigencia = '0/00/00'
			OR fechaInicioVigencia IS NULL

		UPDATE #Negociostemp1splitCAPI
		SET fechaFinVigencia = @DefaultDate
		WHERE fechaFinVigencia = ''
			OR fechaFinVigencia = '0/00/00'
			OR fechaFinVigencia IS NULL

		-- Multiplicación de Valores x porcentajeParticipacion
		UPDATE #Negociostemp1splitCAPI
		SET valorAhorro = STR(CAST((CAST(REPLACE(valorAhorro, ',', '.') AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		UPDATE #Negociostemp1splitCAPI
		SET valorPrimaPensiones = STR(CAST((CAST(REPLACE(valorPrimaPensiones, ',', '.') AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		UPDATE #Negociostemp1splitCAPI
		SET valorPrimaTotal = STR(CAST((CAST(REPLACE(valorPrimaTotal, ',', '.') AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		UPDATE #Negociostemp1splitCAPI
		SET valorProteccion = STR(CAST((CAST(REPLACE(valorProteccion, ',', '.') AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		UPDATE #Negociostemp1splitCAPI
		SET valorAsegurado = STR(CAST(REPLACE(valorAsegurado, ',', '.') AS FLOAT), 13, 2)

		-- *********************************************************************************************************
		--  Inserción de los valores con Split con numeroNegocio que no existan actualmente en dbo.Negocio	
		-- *********************************************************************************************************--	
		INSERT INTO Negocio (
			clave
			,porcentajeParticipacion
			,numeroNegocio
			,estadoNegocio
			,identificacionSuscriptor
			,tipoEndoso_id
			,grupoEndoso_id
			,valorAsegurado
			,numeroSolicitud
			,cuotasPagadas
			,cuotasVencidas
			,generoSuscriptor
			,sistema
			,valorProteccion
			,valorAhorro
			,valorPrimaPensiones
			,valorPrimaTotal
			,marcaVehiculo_id
			,tipoVehiculo_id
			,modeloVehiculo
			,compania_id
			,fechaCancelacion
			,fechaEmisionMaximoEndoso
			,fechaExpedicion
			,fechaRecaudoInicial
			,productoDetalle_id
			,localidad_id
			,lineaNegocio_id
			,ramoDetalle_id
			,amparo_id
			,cobertura_id
			,modalidadPago_id
			,planDetalle_id
			,formaPago_id
			,codigoAgrupador
			,cliente_id
			,fechaGrabacion
			,fechaCarga
			,participante_id
			,zona_id
			,nombreSuscriptor
			,estadoCierre
			,mesCierre
			,anioCierre
			,fechaInicioVigencia
			,fechaFinVigencia
			,cuotasTotales
			,codigoEmision
			,recompra
			,numeroRecompra
			)
		SELECT RTRIM(LTRIM(nsc.clave))
			,nsc.porcentajeParticipacion
			,RTRIM(LTRIM(nsc.numeroNegocio))
			,nsc.estadoNegocio
			,RTRIM(LTRIM(nsc.identificacionSuscriptor))
			,nsc.tipoEndoso
			,nsc.grupoEndoso
			,RTRIM(LTRIM(nsc.valorAsegurado))
			,nsc.numeroSolicitud
			,RTRIM(LTRIM(nsc.cuotasPagadas))
			,RTRIM(LTRIM(nsc.cuotasVencidas))
			,nsc.generoSuscriptor
			,nsc.sistema
			,RTRIM(LTRIM(nsc.valorProteccion))
			,RTRIM(LTRIM(nsc.valorAhorro))
			,RTRIM(LTRIM(nsc.valorPrimaPensiones))
			,RTRIM(LTRIM(nsc.valorPrimaTotal))
			,nsc.marcaVehiculo
			,nsc.tipoVehiculo
			,nsc.modeloVehiculo
			,nsc.compania
			,nsc.fechaCancelacion
			,nsc.fechaEmisionMaximoEndoso
			,nsc.fechaExpedicion
			,nsc.fechaRecaudoInicial
			,nsc.productoCodigo
			,nsc.localidad
			,nsc.lineaNegocio
			,nsc.ramo
			,nsc.amparo
			,nsc.cobertura
			,nsc.modalidadPago
			,nsc.[plan]
			,nsc.formaPago
			,nsc.codigoAgrupador
			,nsc.cliente
			,nsc.fechaGrabacion
			,GETDATE()
			,nsc.participante_id
			,nsc.zona_id
			,nsc.nombreSuscriptor
			,nsc.estadoCierre
			,nsc.mesCierre
			,nsc.anioCierre
			,nsc.fechaInicioVigencia
			,nsc.fechaFinVigencia
			,nsc.cuotasTotales
			,nsc.codigoEmision
			,nsc.recompra
			,nsc.numeroRecompra
		FROM #Negociostemp1splitCAPI nsc

		DROP TABLE #NegociostempsplitCAPI

		DROP TABLE #Negociostemp1splitCAPI

		UPDATE Negocio
		SET amparo_id = 0
		WHERE amparo_id IS NULL
			AND compania_id = 3
			AND sistema = 'CAPI'

		UPDATE Negocio
		SET cobertura_id = 0
		WHERE cobertura_id IS NULL
			AND compania_id = 3
			AND sistema = 'CAPI'

		UPDATE Negocio
		SET actividadEconomica_id = 0
		WHERE actividadEconomica_id IS NULL
			AND compania_id = 3
			AND sistema = 'CAPI'

		UPDATE Negocio
		SET modalidadPago_id = 0
		WHERE modalidadPago_id IS NULL
			AND compania_id = 3
			AND sistema = 'CAPI'

		UPDATE Negocio
		SET tipoVehiculo_id = 0
		WHERE tipoVehiculo_id IS NULL
			AND compania_id = 3
			AND sistema = 'CAPI'

		UPDATE Negocio
		SET participante_id = p.id
		FROM Negocio n
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(n.clave))
		WHERE n.compania_id = 3
			AND sistema = 'CAPI'
			AND n.porcentajeParticipacion < 100
			AND n.participante_id IS NULL

		UPDATE Negocio
		SET zona_id = l.zona_id
		FROM Negocio n
		INNER JOIN Localidad l ON l.id = n.localidad_id
		WHERE n.compania_id = 3
			AND sistema = 'CAPI'
			AND n.porcentajeParticipacion < 100
			AND n.zona_id IS NULL
	END
END