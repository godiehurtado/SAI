
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Procedimiento que permite separar en más de un reglón los porcentajes y claves con
--              negocios compartidos.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_splitRecaudo_SISEGENERALES]
AS
BEGIN
	DECLARE @cantidadRegistros AS INT = (SELECT COUNT(*) FROM RecaudostempGENERALES)

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
			,@producto_id NVARCHAR(2048)
			,@amparo_id NVARCHAR(2048)
			,@cobertura_id NVARCHAR(2048)
			,@modalidadPago_id NVARCHAR(2048)
			,@plan_id NVARCHAR(2048)
			,@numeroRecibo NVARCHAR(2048)
			,@valorRecaudo NVARCHAR(2048)
			,@altura NVARCHAR(2048)
			,@concepto NVARCHAR(2048)
			,@porcentajeAhorroInversion NVARCHAR(2048)
			,@codigoOcupacion NVARCHAR(2048)
			,@red NVARCHAR(2048)
			,@banco NVARCHAR(2048)
			,@zona NVARCHAR(2048)
			,@localidad NVARCHAR(2048)
			,@participante NVARCHAR(2048)
			,@formaPago NVARCHAR(2048)
			,@periodofacturado NVARCHAR(2048)
			,@fechaRecaudo NVARCHAR(2048)
			,@fechaGrabacion NVARCHAR(2048)
			,@fechaCobranza NVARCHAR(2048)
			,@estadoCierre INT
			,@mesCierre INT
			,@anioCierre INT

		CREATE TABLE #RecaudostempsplitSISEGENERALES (
			id INT IDENTITY(0, 1) NOT NULL
			,clave NVARCHAR(2048)
			,porcentajeParticipacion NVARCHAR(2048)
			,numeroNegocio NVARCHAR(2048)
			,compania NVARCHAR(2048)
			,lineaNegocio NVARCHAR(2048)
			,ramo NVARCHAR(2048)
			,amparo NVARCHAR(2048)
			,cobertura NVARCHAR(2048)
			,modalidadPago NVARCHAR(2048)
			,productoCodigo NVARCHAR(2048)
			,[plan] NVARCHAR(2048)
			,zona NVARCHAR(2048)
			,localidad NVARCHAR(2048)
			,formaPago NVARCHAR(2048)
			,numeroRecibo NVARCHAR(2048)
			,valorRecaudo NVARCHAR(2048)
			,periodoFacturado NVARCHAR(2048)
			,Altura NVARCHAR(2048)
			,concepto NVARCHAR(2048)
			,porcentajeAhorro_Inversion NVARCHAR(2048)
			,sistema NVARCHAR(2048)
			,codigoOcupacion NVARCHAR(2048)
			,red_id NVARCHAR(2048)
			,banco NVARCHAR(2048)
			,fechaRecaudo NVARCHAR(2048)
			,fechaCobranza NVARCHAR(2048)
			,fechaGrabacion NVARCHAR(2048)
			,estadoCierre INT
			,mesCierre INT
			,anioCierre INT
			)

		-- *********************************************************************************************************
		--  Tabla donde se insertan los registros con split (el campo contiene '-') y que contiene datos Core válidos. 
		-- *********************************************************************************************************--
		INSERT INTO #RecaudostempsplitSISEGENERALES (
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
			,zona
			,localidad
			,formaPago
			,numeroRecibo
			,valorRecaudo
			,periodoFacturado
			,Altura
			,concepto
			,porcentajeAhorro_Inversion
			,sistema
			,codigoOcupacion
			,red_id
			,banco
			,fechaRecaudo
			,fechaCobranza
			,fechaGrabacion
			,estadoCierre
			,mesCierre
			,anioCierre
			) (
			SELECT rte.clave
			,rte.porcentajeParticipacion
			,rte.numeroNegocio
			,rte.compania_id
			,rte.lineaNegocio_id
			,rte.ramo_id
			,rte.amparo_id
			,rte.cobertura_id
			,rte.modalidadPago_id
			,rte.producto_id
			,rte.plan_id
			,rte.zona_id
			,rte.localidad_id
			,rte.formaPago_id
			,rte.numeroRecibo
			,rte.valorRecaudo
			,rte.periodoFacturado
			,rte.Altura
			,rte.concepto
			,rte.porcentajeAhorroInversion
			,rte.sistema
			,rte.codigoOcupacion
			,rte.red_id
			,rte.codigoBanco
			,rte.fechaRecaudo
			,rte.fechaCobranza
			,rte.fechaGrabacion
			,rte.estadoCierre
			,rte.mesCierre
			,rte.anioCierre FROM RecaudostempErrorGENERALES rte INNER JOIN Compania c ON c.id = rte.compania_id INNER JOIN RamoDetalle rd ON rd.id = rte.ramo_id INNER JOIN ProductoDetalle pd ON pd.id = rte.producto_id INNER JOIN Localidad l ON l.id = rte.localidad_id INNER JOIN LineaNegocio ln ON ln.id = rte.lineaNegocio_id WHERE c.id = rd.compania_id
			AND c.id = 1
			AND rte.clave <> ''
			AND rte.porcentajeParticipacion <> ''
			AND (
				CHARINDEX('-', rte.porcentajeParticipacion) > 0
				OR CHARINDEX('-', rte.clave) > 0
				)
			)

		CREATE TABLE #Recaudostemp1splitSISEGENERALES (
			clave NVARCHAR(2048)
			,porcentajeParticipacion NVARCHAR(2048)
			,numeroNegocio NVARCHAR(2048)
			,compania NVARCHAR(2048)
			,lineaNegocio NVARCHAR(2048)
			,ramo NVARCHAR(2048)
			,amparo NVARCHAR(2048)
			,cobertura NVARCHAR(2048)
			,modalidadPago NVARCHAR(2048)
			,productoCodigo NVARCHAR(2048)
			,[plan] NVARCHAR(2048)
			,zona NVARCHAR(2048)
			,localidad NVARCHAR(2048)
			,formaPago NVARCHAR(2048)
			,numeroRecibo NVARCHAR(2048)
			,valorRecaudo NVARCHAR(2048)
			,periodoFacturado NVARCHAR(2048)
			,Altura NVARCHAR(2048)
			,concepto NVARCHAR(2048)
			,porcentajeAhorro_Inversion NVARCHAR(2048)
			,sistema NVARCHAR(2048)
			,codigoOcupacion NVARCHAR(2048)
			,red_id NVARCHAR(2048)
			,banco NVARCHAR(2048)
			,fechaRecaudo NVARCHAR(2048)
			,fechaCobranza NVARCHAR(2048)
			,fechaGrabacion NVARCHAR(2048)
			,participante INT
			,estadoCierre INT
			,mesCierre INT
			,anioCierre INT
			)

		-- *********************************************************************************************************
		-- SE LE ASIGNA UN VALOR A CADA UNA DE LAS VARIABLES YA CREADAS. 
		-- *********************************************************************************************************--
		DECLARE @total INT = (SELECT MAX(rte.id) FROM #RecaudostempsplitSISEGENERALES rte)
		DECLARE @inicio INT = (SELECT MIN(rte.id) FROM #RecaudostempsplitSISEGENERALES rte)

		WHILE (@inicio) <= @total
		BEGIN
			SELECT @pos = 0

			SELECT @pos1 = 0

			SELECT @compania_id = 1

			SELECT @clave = (
					SELECT clave
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @porcentajeParticipacion = (
					SELECT porcentajeParticipacion
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @numeroNegocio = (
					SELECT numeroNegocio
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @valorRecaudo = (
					SELECT valorRecaudo
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @numeroRecibo = (
					SELECT numeroRecibo
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @lineaNegocio_id = (
					SELECT lineaNegocio
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @Altura = (
					SELECT altura
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @concepto = (
					SELECT concepto
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @porcentajeAhorroInversion = (
					SELECT porcentajeAhorro_Inversion
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @codigoOcupacion = (
					SELECT codigoOcupacion
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @ramo_id = (
					SELECT ramo
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @producto_id = (
					SELECT productoCodigo
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @amparo_id = (
					SELECT amparo
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @cobertura_id = (
					SELECT cobertura
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @modalidadPago_id = (
					SELECT modalidadPago
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @plan_id = (
					SELECT [plan]
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @red = (
					SELECT red_id
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @banco = (
					SELECT banco
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @formaPago = (
					SELECT formaPago
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @periodofacturado = (
					SELECT periodoFacturado
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @fechaRecaudo = (
					SELECT fechaRecaudo
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @fechaGrabacion = (
					SELECT fechaGrabacion
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @fechaCobranza = (
					SELECT fechaCobranza
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @localidad = (
					SELECT localidad
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @zona = (
					SELECT zona
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @estadoCierre = (
					SELECT estadoCierre
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @mesCierre = (
					SELECT mesCierre
					FROM #RecaudostempsplitSISEGENERALES
					WHERE id = @inicio
					)

			SELECT @anioCierre = (
					SELECT anioCierre
					FROM #RecaudostempsplitSISEGENERALES
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
				INSERT INTO #Recaudostemp1splitSISEGENERALES (
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
					,numeroRecibo
					,valorRecaudo
					,periodoFacturado
					,Altura
					,concepto
					,porcentajeAhorro_Inversion
					,sistema
					,codigoOcupacion
					,red_id
					,banco
					,fechaRecaudo
					,fechaGrabacion
					,fechaCobranza
					,localidad
					,zona
					,estadoCierre
					,mesCierre
					,anioCierre
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
					,@numeroRecibo
					,@valorRecaudo
					,@periodofacturado
					,@altura
					,@concepto
					,@porcentajeAhorroInversion
					,'SISE GENERALES'
					,@codigoOcupacion
					,@red
					,@banco
					,@fechaRecaudo
					,@fechaGrabacion
					,@fechaCobranza
					,@localidad
					,@zona
					,@estadoCierre
					,@mesCierre
					,@anioCierre
					)

				SELECT @clave = RTRIM(SUBSTRING(@clave, @pos + 1, 2048))

				SELECT @porcentajeParticipacion = LTRIM(SUBSTRING(@porcentajeParticipacion, @pos1 + 1, 2048))
			END

			SET @inicio = @inicio + 1
		END

		UPDATE #Recaudostemp1splitSISEGENERALES
		SET participante = p.id
		FROM #Recaudostemp1splitSISEGENERALES rtss
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(rtss.clave)) COLLATE Modern_Spanish_CI_AS

		UPDATE #Recaudostemp1splitSISEGENERALES
		SET fechaRecaudo = CONVERT(DATETIME, fechaRecaudo, 103)
		WHERE ISDATE(fechaRecaudo) = 0

		UPDATE #Recaudostemp1splitSISEGENERALES
		SET fechaCobranza = CONVERT(DATETIME, fechaCobranza, 103)
		WHERE ISDATE(fechaCobranza) = 0

		UPDATE #Recaudostemp1splitSISEGENERALES
		SET fechaGrabacion = CONVERT(DATETIME, fechaGrabacion, 103)
		WHERE ISDATE(fechaGrabacion) = 0

		UPDATE #Recaudostemp1splitSISEGENERALES
		SET zona = l.zona_id
		FROM #Recaudostemp1splitSISEGENERALES rtss
		INNER JOIN Localidad l ON l.id = rtss.localidad

		-- Multiplicación de Valores x porcentajeParticipacion
		UPDATE #Recaudostemp1splitSISEGENERALES
		SET valorRecaudo = STR(CAST((CAST(valorRecaudo AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT), 13, 2)

		--  Inserción de los valores con Split en la tabla de Recaudo
		INSERT INTO Recaudo (
			clave
			,porcentajeParticipacion
			,numeroNegocio
			,compania_id
			,lineaNegocio_id
			,ramoDetalle_id
			,amparo_id
			,cobertura_id
			,modalidadpago_id
			,planDetalle_id
			,formaPago_id
			,numeroRecibo
			,valorRecaudo
			,Altura
			,Concepto
			,porcentajeAhorro_Inversion
			,sistema
			,codigoOcupacion
			,redDetalle_id
			,bancoDetalle_id
			,periodoFacturado
			,localidad_id
			,productoDetalle_id
			,fechaRecaudo
			,fechaCobranza
			,fechaGrabacion
			,fechaCarga
			,participante_id
			,estadoCierre
			,mesCierre
			,anioCierre
			) (
			SELECT RTRIM(LTRIM(clave)) AS clave
			,porcentajeParticipacion
			,RTRIM(LTRIM(numeroNegocio)) AS numeroNegocio
			,compania
			,lineaNegocio
			,ramo
			,amparo
			,cobertura
			,modalidadPago
			,[plan]
			,formaPago
			,numeroRecibo
			,valorRecaudo
			,Altura
			,concepto
			,porcentajeAhorro_Inversion
			,sistema
			,codigoOcupacion
			,red_id
			,banco
			,periodoFacturado
			,localidad
			,productoCodigo
			,CAST(fechaRecaudo AS DATE) AS fechaRecaudo
			,CAST(fechaCobranza AS DATE) AS fechaCobranza
			,CAST(fechaGrabacion AS DATE) AS fechaGrabacion
			,(GETDATE()) AS fechaCarga
			,participante
			,estadoCierre
			,mesCierre
			,anioCierre FROM #Recaudostemp1splitSISEGENERALES
			)

		DROP TABLE #RecaudostempsplitSISEGENERALES

		DROP TABLE #Recaudostemp1splitSISEGENERALES

		UPDATE Recaudo
		SET amparo_id = 0
		WHERE amparo_id IS NULL
			AND compania_id = 1
			AND sistema = 'SISE GENERALES'

		UPDATE Recaudo
		SET cobertura_id = 0
		WHERE cobertura_id IS NULL
			AND compania_id = 1
			AND sistema = 'SISE GENERALES'

		UPDATE Recaudo
		SET modalidadPago_id = 0
		WHERE modalidadPago_id IS NULL
			AND compania_id = 1
			AND sistema = 'SISE GENERALES'

		UPDATE Recaudo
		SET participante_id = p.id
		FROM Recaudo r
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(r.clave))
		WHERE r.compania_id = 1
			AND sistema = 'SISE GENERALES'
			AND r.porcentajeParticipacion < 100
			AND r.participante_id IS NULL

		UPDATE Recaudo
		SET zona_id = l.zona_id
		FROM Recaudo r
		INNER JOIN Localidad l ON l.id = r.localidad_id
		WHERE r.compania_id = 1
			AND sistema = 'SISE GENERALES'
			AND r.porcentajeParticipacion < 100
			AND r.zona_id IS NULL
	END
END
