-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Procedimiento que permite separar en más de un reglón los porcentajes y claves con
--              negocios compartidos.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_splitNegocio_BH]
AS
BEGIN
	DECLARE @DefaultDate VARCHAR(10)
	DECLARE @cantidadRegistros AS INT = (SELECT COUNT(*) FROM NegociostempErrorBH)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

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
			,@nombreSuscriptor NVARCHAR(2048)
			,@codigoAgrupador NVARCHAR(2048)
			,@estadoCierre INT
			,@mesCierre INT
			,@anioCierre INT
			,@fechaInicioVigencia NVARCHAR(2048)
			,@fechaFinVigencia NVARCHAR(2048)
			,@fechaEfecto NVARCHAR(2048)

		CREATE TABLE #NegociostempsplitBH (
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
			,cliente NVARCHAR(2048)
			,fechaGrabacion NVARCHAR(2048)
			,zona_id NVARCHAR(2048)
			,nombreSuscriptor NVARCHAR(2048)
			,codigoAgrupador NVARCHAR(2048)
			,estadoCierre INT
			,mesCierre INT
			,anioCierre INT
			,fechaInicioVigencia NVARCHAR(2048)
			,fechaFinVigencia NVARCHAR(2048)
			,fechaEfecto NVARCHAR(2048)
			)

		-- *********************************************************************************************************
		--  Tabla donde se insertan los registros con split (el campo contiene '-') y que contiene datos Core válidos. 
		-- *********************************************************************************************************--
		INSERT INTO #NegociostempsplitBH (
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
			,cliente
			,fechaGrabacion
			,zona_id
			,nombreSuscriptor
			,codigoAgrupador
			,estadoCierre
			,mesCierre
			,anioCierre
			,fechaInicioVigencia
			,fechaFinVigencia
			,fechaEfecto
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
			,nte.cliente_id
			,nte.fechaGrabacion
			,nte.zona_id
			,nte.nombreSuscriptor
			,nte.codigoAgrupador
			,nte.estadoCierre
			,nte.mesCierre
			,nte.anioCierre
			,nte.fechaInicioVigencia
			,nte.fechaFinVigencia
			,nte.fechaEfecto
			FROM NegociostempErrorBH nte INNER JOIN Compania c ON c.id = nte.compania_id INNER JOIN RamoDetalle rd ON rd.id = nte.ramo_id INNER JOIN ProductoDetalle pd ON pd.id = nte.producto_id INNER JOIN Localidad l ON l.id = nte.localidad_id INNER JOIN LineaNegocio ln ON ln.id = nte.lineaNegocio_id WHERE c.id = rd.compania_id
			AND c.id = 5
			AND nte.clave <> ''
			AND nte.porcentajeParticipacion <> ''
			AND (
				CHARINDEX('-', nte.porcentajeParticipacion) > 0
				OR CHARINDEX('-', nte.clave) > 0
				)
			)

		CREATE TABLE #Negociostemp1splitBH (
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
			,fechaFinVigencia NVARCHAR(2048)
			,fechaEfecto NVARCHAR(2048)
			)

		-- *********************************************************************************************************
		-- SE LE ASIGNA UN VALOR A CADA UNA DE LAS VARIABLES YA CREADAS. 
		-- *********************************************************************************************************--
		DECLARE @total AS INT = (SELECT MAX(nte.id) FROM #NegociostempsplitBH nte)
		DECLARE @inicio AS INT = (SELECT MIN(nte.id) FROM #NegociostempsplitBH nte)

		WHILE (@inicio) <= @total
		BEGIN
			SELECT @pos = 0

			SELECT @pos1 = 0

			SELECT @clave = (
					SELECT clave
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @porcentajeParticipacion = (
					SELECT porcentajeParticipacion
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @numeroNegocio = (
					SELECT numeroNegocio
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @compania_id = 5

			SELECT @lineaNegocio_id = (
					SELECT lineaNegocio
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @ramo_id = (
					SELECT ramo
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @amparo_id = (
					SELECT amparo
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @cobertura_id = (
					SELECT cobertura
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @modalidadPago_id = (
					SELECT modalidadPago
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @producto_id = (
					SELECT productoCodigo
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @plan_id = (
					SELECT [plan]
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @estado = (
					SELECT estadoNegocio
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @numeroSolicitud = (
					SELECT numeroSolicitud
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @cuotasVencidas = (
					SELECT cuotasVencidas
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @cuotasPagadas = (
					SELECT cuotasPagadas
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @valorAsegurado = (
					SELECT valorAsegurado
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @valorProteccion = (
					SELECT valorProteccion
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @valorAhorro = (
					SELECT valorAhorro
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @valorprimaPensiones = (
					SELECT valorPrimaPensiones
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @valorPrimaTotal = (
					SELECT valorPrimaTotal
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @identificacionSuscriptor = (
					SELECT identificacionSuscriptor
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @actividadEconomica = (
					SELECT actividadEconomica
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @generoSuscriptor = (
					SELECT generoSuscriptor
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @grupoEndoso = (
					SELECT grupoEndoso
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @tipoEndoso = (
					SELECT tipoEndoso
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @marcaVehiculo = (
					SELECT marcaVehiculo
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @tipoVehiculo = (
					SELECT tipoVehiculo
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @modeloVehiculo = (
					SELECT modeloVehiculo
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @usuarios = (
					SELECT Usuarios
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @fechaCancelacion = (
					SELECT fechaCancelacion
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @fechaRecaudoInicial = (
					SELECT fechaRecaudoInicial
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @fechaEmisionMaximoEndoso = (
					SELECT fechaEmisionMaximoEndoso
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @fechaExpedicion = (
					SELECT fechaExpedicion
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @fechaGrabacion = (
					SELECT fechaGrabacion
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @localidad = (
					SELECT localidad
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @formaPago = (
					SELECT formaPago
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @cliente_id = (
					SELECT cliente
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @nombreSuscriptor = (
					SELECT nombreSuscriptor
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @codigoAgrupador = (
					SELECT codigoAgrupador
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @estadoCierre = (
					SELECT estadoCierre
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @mesCierre = (
					SELECT mesCierre
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @anioCierre = (
					SELECT anioCierre
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @fechaInicioVigencia = (
					SELECT fechaInicioVigencia
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @fechaFinVigencia = (
					SELECT fechaFinVigencia
					FROM #NegociostempsplitBH
					WHERE id = @inicio
					)

			SELECT @fechaEfecto = (
					SELECT fechaEfecto
					FROM #NegociostempsplitBH
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
				INSERT INTO #Negociostemp1splitBH (
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
					,cliente
					,fechaGrabacion
					,nombreSuscriptor
					,codigoAgrupador
					,estadoCierre
					,mesCierre
					,anioCierre
					,fechaInicioVigencia
					,fechaFinVigencia
					,fechaEfecto
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
					,'BH'
					,@usuarios
					,@localidad
					,@fechaCancelacion
					,@fechaExpedicion
					,@fechaEmisionMaximoEndoso
					,@fechaRecaudoInicial
					,@cliente_id
					,@fechaGrabacion
					,@nombreSuscriptor
					,@codigoAgrupador
					,@estadoCierre
					,@mesCierre
					,@anioCierre
					,@fechaInicioVigencia
					,@fechaFinVigencia
					,@fechaEfecto
					)

				SELECT @clave = RTRIM(SUBSTRING(@clave, @pos + 1, 2048))

				SELECT @porcentajeParticipacion = LTRIM(SUBSTRING(@porcentajeParticipacion, @pos1 + 1, 2048))
			END

			SET @inicio = @inicio + 1
		END

		-- *********************************************************************************************************
		-- HOMOLOGACIÓN DE CAMPOS EN DONDE SE ENCUENTRA EL RESULTADO DEL SPLIT.
		-- *********************************************************************************************************--		
		--  Normalizacion Fechas tabla Temporal con los Split de BH.
		--  Actualización de los registros x Zona y participante
		UPDATE #Negociostemp1splitBH
		SET fechaCancelacion = @DefaultDate
		WHERE fechaCancelacion = ''
			OR fechaCancelacion = '0/00/00'
			OR fechaCancelacion IS NULL

		UPDATE #Negociostemp1splitBH
		SET fechaEmisionMaximoEndoso = @DefaultDate
		WHERE fechaEmisionMaximoEndoso = ''
			OR fechaEmisionMaximoEndoso = '0/00/00'
			OR fechaEmisionMaximoEndoso IS NULL

		UPDATE #Negociostemp1splitBH
		SET fechaRecaudoInicial = @DefaultDate
		WHERE fechaRecaudoInicial = ''
			OR fechaRecaudoInicial = '0/00/00'
			OR fechaRecaudoInicial IS NULL

		UPDATE #Negociostemp1splitBH
		SET fechaExpedicion = @DefaultDate
		WHERE fechaExpedicion = ''
			OR fechaExpedicion = '0/00/00'
			OR fechaExpedicion IS NULL

		UPDATE #Negociostemp1splitBH
		SET fechaGrabacion = @DefaultDate
		WHERE fechaGrabacion = ''
			OR fechaGrabacion = '0/00/00'
			OR fechaGrabacion IS NULL

		UPDATE #Negociostemp1splitBH
		SET fechaInicioVigencia = @DefaultDate
		WHERE fechaInicioVigencia = ''
			OR fechaInicioVigencia = '0/00/00'
			OR fechaInicioVigencia IS NULL

		UPDATE #Negociostemp1splitBH
		SET fechaFinVigencia = @DefaultDate
		WHERE fechaFinVigencia = ''
			OR fechaFinVigencia = '0/00/00'
			OR fechaFinVigencia IS NULL

		UPDATE #Negociostemp1splitBH
		SET fechaEfecto = @DefaultDate
		WHERE fechaEfecto = ''
			OR fechaEfecto = '0/00/00'
			OR fechaEfecto IS NULL

		UPDATE #Negociostemp1splitBH
		SET zona_id = l.zona_id
		FROM #Negociostemp1splitBH nts
		INNER JOIN Localidad l ON l.id = nts.localidad

		UPDATE #Negociostemp1splitBH
		SET participante_id = p.id
		FROM #Negociostemp1splitBH nts
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(nts.clave)) COLLATE Modern_Spanish_CI_AS

		-- Multiplicación de Valores x porcentajeParticipacion
		UPDATE #Negociostemp1splitBH
		SET valorAhorro = STR(CAST((CAST(valorAhorro AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		UPDATE #Negociostemp1splitBH
		SET valorPrimaPensiones = STR(CAST((CAST(valorPrimaPensiones AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		UPDATE #Negociostemp1splitBH
		SET valorPrimaTotal = STR(CAST((CAST(valorPrimaTotal AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		UPDATE #Negociostemp1splitBH
		SET valorProteccion = STR(CAST((CAST(valorProteccion AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		--  Inserción de los valores con Split en la tabla de Negocio
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
			,cliente_id
			,fechaGrabacion
			,fechaCarga
			,zona_id
			,participante_id
			,nombreSuscriptor
			,codigoAgrupador
			,Usuarios
			,estadoCierre
			,mesCierre
			,anioCierre
			,fechaInicioVigencia
			,fechaFinVigencia
			,fechaEfecto
			) (
			SELECT RTRIM(LTRIM(clave))
			,porcentajeParticipacion
			,RTRIM(LTRIM(numeroNegocio))
			,estadoNegocio
			,identificacionSuscriptor
			,tipoEndoso
			,grupoEndoso
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
			,marcaVehiculo
			,tipoVehiculo
			,modeloVehiculo
			,compania
			,fechaCancelacion
			,fechaEmisionMaximoEndoso
			,fechaExpedicion
			,fechaRecaudoInicial
			,productoCodigo
			,localidad
			,lineaNegocio
			,ramo
			,amparo
			,cobertura
			,modalidadPago
			,[plan]
			,formaPago
			,cliente
			,fechaGrabacion
			,GETDATE()
			,zona_id
			,participante_id
			,RTRIM(LTRIM(nombreSuscriptor))
			,codigoAgrupador
			,usuarios
			,estadoCierre
			,mesCierre
			,anioCierre
			,fechaInicioVigencia
			,fechaFinVigencia
			,fechaEfecto
			FROM #Negociostemp1splitBH
			)

		DROP TABLE #NegociostempsplitBH

		DROP TABLE #Negociostemp1splitBH

		UPDATE Negocio
		SET amparo_id = 0
		WHERE amparo_id IS NULL
			AND compania_id = 5
			AND sistema = 'BH'

		UPDATE Negocio
		SET cobertura_id = 0
		WHERE cobertura_id IS NULL
			AND compania_id = 5
			AND sistema = 'BH'

		UPDATE Negocio
		SET actividadEconomica_id = 0
		WHERE actividadEconomica_id IS NULL
			AND compania_id = 5
			AND sistema = 'BH'

		UPDATE Negocio
		SET modalidadPago_id = 0
		WHERE modalidadPago_id IS NULL
			AND compania_id = 5
			AND sistema = 'BH'

		UPDATE Negocio
		SET tipoVehiculo_id = 0
		WHERE tipoVehiculo_id IS NULL
			AND compania_id = 5
			AND sistema = 'BH'

		UPDATE Negocio
		SET participante_id = p.id
		FROM Negocio n
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(n.clave))
		WHERE n.compania_id = 5
			AND sistema = 'BH'
			AND n.porcentajeParticipacion < 100
			AND n.participante_id IS NULL

		UPDATE Negocio
		SET zona_id = l.zona_id
		FROM Negocio n
		INNER JOIN Localidad l ON l.id = n.localidad_id
		WHERE n.compania_id = 5
			AND sistema = 'BH'
			AND n.porcentajeParticipacion < 100
			AND n.zona_id IS NULL
	END
END