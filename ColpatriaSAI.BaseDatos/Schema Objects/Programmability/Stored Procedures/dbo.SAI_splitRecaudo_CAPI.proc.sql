
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Procedimiento que permite separar en más de un reglón los porcentajes y claves con
--              negocios compartidos.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_splitRecaudo_CAPI]
AS
BEGIN
	DECLARE @cantidadRegistros AS INT = (SELECT COUNT(*) FROM RecaudostempCAPI)

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

		CREATE TABLE #RecaudostempsplitCAPI (
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
		INSERT INTO #RecaudostempsplitCAPI (
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
			,rte.altura
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
			,rte.anioCierre FROM RecaudostempErrorCAPI rte INNER JOIN Compania c ON c.id = rte.compania_id INNER JOIN RamoDetalle rd ON rd.id = rte.ramo_id INNER JOIN ProductoDetalle pd ON pd.id = rte.producto_id INNER JOIN Localidad l ON l.id = rte.localidad_id INNER JOIN LineaNegocio ln ON ln.id = rte.lineaNegocio_id WHERE c.id = rd.compania_id
			AND c.id = 3
			AND rte.clave <> ''
			AND rte.porcentajeParticipacion <> ''
			AND (
				CHARINDEX('-', rte.porcentajeParticipacion) > 0
				OR CHARINDEX('-', rte.clave) > 0
				)
			)

		CREATE TABLE #Recaudostemp1splitCAPI (
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
			,estadoCierre INT
			,mesCierre INT
			,anioCierre INT
			)

		-- *********************************************************************************************************
		-- SE LE ASIGNA UN VALOR A CADA UNA DE LAS VARIABLES YA CREADAS. 
		-- *********************************************************************************************************--
		DECLARE @total AS INT = (SELECT MAX(nte.id) FROM #RecaudostempsplitCAPI nte)
		DECLARE @inicio AS INT = (SELECT MIN(nte.id) FROM #RecaudostempsplitCAPI nte)

		WHILE (@inicio) <= @total
		BEGIN
			SELECT @pos = 0

			SELECT @pos1 = 0

			SELECT @compania_id = 3

			SELECT @clave = (
					SELECT clave
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @porcentajeParticipacion = (
					SELECT porcentajeParticipacion
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @numeroNegocio = (
					SELECT numeroNegocio
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @valorRecaudo = (
					SELECT valorRecaudo
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @numeroRecibo = (
					SELECT numeroRecibo
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @lineaNegocio_id = (
					SELECT lineaNegocio
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
						AND clave <> ''
						AND porcentajeParticipacion <> ''
					)

			SELECT @Altura = (
					SELECT altura
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @concepto = (
					SELECT concepto
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @porcentajeAhorroInversion = (
					SELECT porcentajeAhorro_Inversion
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @codigoOcupacion = (
					SELECT codigoOcupacion
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @ramo_id = (
					SELECT ramo
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @producto_id = (
					SELECT productoCodigo
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @amparo_id = (
					SELECT amparo
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @cobertura_id = (
					SELECT cobertura
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @modalidadPago_id = (
					SELECT modalidadPago
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @plan_id = (
					SELECT [plan]
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @red = (
					SELECT red_id
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @banco = (
					SELECT banco
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @formaPago = (
					SELECT formaPago
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @periodofacturado = (
					SELECT periodoFacturado
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaRecaudo = (
					SELECT fechaRecaudo
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaGrabacion = (
					SELECT fechaGrabacion
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @fechaCobranza = (
					SELECT fechaCobranza
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @localidad = (
					SELECT localidad
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @estadoCierre = (
					SELECT estadoCierre
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @mesCierre = (
					SELECT mesCierre
					FROM #RecaudostempsplitCAPI
					WHERE id = @inicio
					)

			SELECT @anioCierre = (
					SELECT anioCierre
					FROM #RecaudostempsplitCAPI
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
				INSERT INTO #Recaudostemp1splitCAPI (
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
					,'CAPI'
					,@codigoOcupacion
					,@red
					,@banco
					,@fechaRecaudo
					,@fechaGrabacion
					,@fechaCobranza
					,@localidad
					,@estadoCierre
					,@mesCierre
					,@anioCierre
					)

				SELECT @clave = RTRIM(SUBSTRING(@clave, @pos + 1, 2048))

				SELECT @porcentajeParticipacion = LTRIM(SUBSTRING(@porcentajeParticipacion, @pos1 + 1, 2048))
			END

			SET @inicio = @inicio + 1
		END

		-- Multiplicación de Valores x porcentajeParticipacion
		UPDATE #Recaudostemp1splitCAPI
		SET valorRecaudo = CAST((CAST(valorRecaudo AS FLOAT) * (CAST(porcentajeParticipacion AS FLOAT) / 100)) AS FLOAT)

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
			,estadoCierre
			,mesCierre
			,anioCierre
			) (
			SELECT clave
			,porcentajeParticipacion
			,numeroNegocio
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
			,fechaRecaudo
			,fechaCobranza
			,fechaGrabacion
			,GETDATE()
			,estadoCierre
			,mesCierre
			,anioCierre FROM #Recaudostemp1splitCAPI
			)

		DROP TABLE #RecaudostempsplitCAPI

		DROP TABLE #Recaudostemp1splitCAPI

		UPDATE Recaudo
		SET amparo_id = 0
		WHERE amparo_id IS NULL
			AND compania_id = 3

		UPDATE Recaudo
		SET cobertura_id = 0
		WHERE cobertura_id IS NULL
			AND compania_id = 3

		UPDATE Recaudo
		SET modalidadPago_id = 0
		WHERE modalidadPago_id IS NULL
			AND compania_id = 3

		UPDATE Recaudo
		SET participante_id = p.id
		FROM Recaudo r
		INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(r.clave))
		WHERE r.compania_id = 3
			AND sistema = 'CAPI'
			AND r.porcentajeParticipacion < 100
			AND r.participante_id IS NULL

		UPDATE Recaudo
		SET zona_id = l.zona_id
		FROM Recaudo r
		INNER JOIN Localidad l ON l.id = r.localidad_id
		WHERE r.compania_id = 3
			AND sistema = 'CAPI'
			AND r.porcentajeParticipacion < 100
			AND r.zona_id IS NULL
	END
END
