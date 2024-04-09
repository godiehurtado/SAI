
-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 15/09/2011
-- Description:	Normaliza y homologa la información de comisiones entregada por GP
--				Adicionalmente segmenta las comisiones ya que este dato no lo entrega GP
--				Esta información se utiliza en el cálculo de las participaciones por director
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Comision]
AS
BEGIN
	-- *********************************************************************************************************
	-- HOMOLOGACIÓN Y NORMALIZACIÓN DE INFORMACIÓN
	-- *********************************************************************************************************	
	-- Se borra de la tabla de comisiones la información correspondiente al mismo mes y año de la extracción realizada
	DECLARE @anioVigente AS INT = (SELECT valor FROM ParametrosApp WHERE id = 3)
	DECLARE @mesActual AS NVARCHAR(10) = MONTH (GETDATE())
	DECLARE @mesAnterior AS NVARCHAR(10) = MONTH (DATEADD(MM, - 1, GETDATE()))
	DECLARE @cantidadRegistros AS INT = (SELECT COUNT(*) FROM Comisiontemp)

	IF (
			@mesActual > '1'
			AND YEAR(GETDATE()) = @anioVigente
			)
	BEGIN
		SET @mesAnterior = CAST(@anioVigente AS NVARCHAR(5)) + '-' + @mesAnterior + '-01'
		SET @mesActual = DATEADD(DD, - 1, DATEADD(MM, 2, CAST(@mesAnterior AS DATE)))
	END

	IF (
			@mesActual = '1'
			AND YEAR(GETDATE()) = @anioVigente
			)
	BEGIN
		SET @mesAnterior = CAST((CAST(@anioVigente AS INT) - 1) AS NVARCHAR(5)) + '-' + @mesAnterior + '-01'
		SET @mesActual = DATEADD(DD, - 1, DATEADD(MM, 2, CAST(@mesAnterior AS DATE)))
	END 

	IF (
			@mesActual = '1'
			AND (YEAR(GETDATE()) - 1) = @anioVigente
			)
	BEGIN
		SET @mesAnterior = CAST(@anioVigente AS NVARCHAR(5)) + '-' + @mesAnterior + '-01'
		SET @mesActual = DATEADD(DD, - 1, DATEADD(MM, 2, CAST(@mesAnterior AS DATE)))
	END

	IF (
			@mesActual > '1'
			AND (YEAR(GETDATE()) - 1) = @anioVigente
			)
	BEGIN
		SET @mesAnterior = CAST((CAST(@anioVigente AS INT) + 1) AS NVARCHAR(5)) + '-' + @mesAnterior + '-01'
		SET @mesActual = DATEADD(DD, - 1, DATEADD(MM, 2, CAST(@mesAnterior AS DATE)))
	END

	IF (@cantidadRegistros > 0)
	BEGIN
		DELETE
		FROM Comision
		WHERE CAST(CAST(año AS NVARCHAR(5)) + '-' + CAST(mes AS NVARCHAR(5)) + '-01' AS DATE) BETWEEN @mesAnterior
				AND @mesActual
	END

	-- Solo se deben dejar los registros con concepto de comisiones y los que tengan indicador de pago 'P'
	-- Definición: William Rojas (Comisiones)
	DELETE
	FROM Comisiontemp
	WHERE indicadorPago <> 'P'
		OR CAST(codigoConcepto AS INT) NOT IN (
			99
			,100
			,101
			,102
			,103
			,104
			,105
			,106
			,107
			,108
			,109
			,110
			,123
			,146
			,176
			)

	-- Los números de negocio con el caracter '-', se ajustan para poder convertirlos a BIGINT.
	UPDATE Comisiontemp
	SET numeroNegocio1 = REPLACE(numeroNegocio1, '-', '')
	WHERE numeroNegocio1 LIKE '%-%'

	-- Se convierten los datos a tipo numérico para luego realizar las homologaciones
	UPDATE Comisiontemp
	SET codigoEmpresa = CAST(codigoEmpresa AS BIGINT)
		,codigoEmpresaNovedad = CAST(codigoEmpresaNovedad AS BIGINT)
		,claveAsesor = RTRIM(LTRIM(claveAsesor))
		,numeroNegocio1 = CAST(numeroNegocio1 AS BIGINT)
		,mesTransaccion = CAST(mesTransaccion AS BIGINT)

	UPDATE Comisiontemp
	SET ramo1 = 0
	WHERE ISNUMERIC(ramo1) = 0

	UPDATE Comisiontemp
	SET ramo1 = CAST(ramo1 AS BIGINT)

	-- Homologación del tipo de identificación
	UPDATE Comisiontemp
	SET identificacionNegocio = 1
	WHERE identificacionNegocio IN (
			'N'
			,'T'
			)

	UPDATE Comisiontemp
	SET identificacionNegocio = 2
	WHERE identificacionNegocio IN (
			'C'
			,'R'
			)

	UPDATE Comisiontemp
	SET identificacionNegocio = 0
	WHERE identificacionNegocio = ''

	---  Cantidad de caracteres enviado desde GP para el campo valorConcepto = 15
	UPDATE Comisiontemp
	SET valorConcepto = STR(CAST('-' + CAST(valorConcepto AS NVARCHAR(15)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', valorConcepto) > 0

	UPDATE Comisiontemp
	SET valorConcepto = RTRIM(LTRIM(valorConcepto))

	UPDATE Comisiontemp
	SET valorConcepto = '0'
	WHERE valorConcepto = '-0.00'

	UPDATE Comisiontemp
	SET valorConcepto = CAST(valorConcepto AS BIGINT)
	WHERE CHARINDEX('-', valorConcepto) = 0

	--UPDATE Comisiontemp set valorConcepto = REPLACE(LTRIM(REPLACE(valorConcepto, '0', ' ')), ' ', '0')
	-- Se homologa el código de la empresa de acuerdo a la codificación que tiene internamente GP
	UPDATE Comisiontemp
	SET codigoEmpresa = CASE 
			WHEN codigoEmpresa = '11'
				THEN 5
			ELSE CASE 
					WHEN codigoEmpresa = '13'
						THEN 3
					ELSE CASE 
							WHEN codigoEmpresa = '14'
								THEN 2
							ELSE CASE 
									WHEN codigoEmpresa = '15'
										THEN 1
									ELSE CASE 
											WHEN codigoEmpresa = '16'
												THEN 4
											END
									END
							END
					END
			END

	UPDATE Comisiontemp
	SET codigoEmpresaNovedad = CASE 
			WHEN codigoEmpresaNovedad = '11'
				THEN 5
			ELSE CASE 
					WHEN codigoEmpresaNovedad = '13'
						THEN 3
					ELSE CASE 
							WHEN codigoEmpresaNovedad = '14'
								THEN 2
							ELSE CASE 
									WHEN codigoEmpresaNovedad = '15'
										THEN 1
									ELSE CASE 
											WHEN codigoEmpresaNovedad = '16'
												THEN 4
											END
									END
							END
					END
			END

	-- Se normaliza la información de localidad														
	UPDATE Comisiontemp
	SET localidadRecaudo = RTRIM(LTRIM(localidadRecaudo))

	-- VIDA y GENERALES son las únicas compañías que entregan el dato correcto de localidad, las demás se dejan en cero
	UPDATE Comisiontemp
	SET localidadRecaudo = REPLACE(LTRIM(REPLACE(localidadRecaudo, '0', ' ')), ' ', '0')
	WHERE codigoEmpresaNovedad IN (
			'1'
			,'2'
			)

	UPDATE Comisiontemp
	SET localidadRecaudo = '0'
	WHERE codigoEmpresaNovedad NOT IN (
			'1'
			,'2'
			)

	UPDATE Comisiontemp
	SET ramo2 = rd.ramo_id
	FROM Comisiontemp AS ct
	INNER JOIN Compania c ON c.id = cast(ct.codigoEmpresaNovedad AS INT)
	INNER JOIN RamoDetalle AS rd ON rd.codigoCore = ct.ramo1
	WHERE rd.compania_id = 1
		AND ct.codigoEmpresaNovedad = '1'

	UPDATE Comisiontemp
	SET ramo2 = rd.ramo_id
	FROM Comisiontemp AS ct
	INNER JOIN Compania c ON c.id = cast(ct.codigoEmpresaNovedad AS INT)
	INNER JOIN RamoDetalle AS rd ON rd.codigoCore = ct.ramo1
	WHERE rd.compania_id = 2
		AND ct.codigoEmpresaNovedad = '2'

	-- Actualizar el ramo para la compañía CAPITALIZACIÓN desde la tabla de negocio
	-- Se deben quitar los últimos 3 digitos ya que estos no los envia GP COMISIONES
	UPDATE Comisiontemp
	SET ramo2 = rd.ramo_id
	FROM Comisiontemp ct
	INNER JOIN Negocio n ON SUBSTRING(n.numeroNegocio, 0, LEN(n.numeroNegocio) - 2) = RTRIM(LTRIM(ct.numeroNegocio1))
	INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
	WHERE n.compania_id = 3
		AND ct.codigoEmpresaNovedad = '3'
		AND rd.compania_id = 3

	-- Para ARP pendiente por actualizar el ramo respectivo por el concepto (123).
	UPDATE Comisiontemp
	SET ramo2 = rd.ramo_id
	FROM Comisiontemp AS ct
	INNER JOIN Compania c ON c.id = CAST(ct.codigoEmpresaNovedad AS INT)
	INNER JOIN RamoDetalle AS rd ON rd.codigoCore = ct.ramo1
	WHERE rd.compania_id = 4
		AND ct.codigoEmpresaNovedad = '4'

	-- Para BH el ramo respectivo se obtiene por el concepto.		
	-- MPP (Código Core 2)
	DECLARE @ramoMpp AS INT = (
		SELECT rd.ramo_id FROM RamoDetalle rd WHERE rd.compania_id = 5
		AND rd.codigoCore = '2'
		)

	UPDATE Comisiontemp
	SET ramo2 = @ramoMpp
	FROM Comisiontemp AS ct
	WHERE ct.codigoEmpresaNovedad = '5'
		AND CAST(codigoConcepto AS INT) IN (
			104
			,146
			,123
			)

	-- HYC (Código Core 3)
	DECLARE @ramoHyc AS INT = (
		SELECT rd.ramo_id FROM RamoDetalle rd WHERE rd.compania_id = 5
		AND rd.codigoCore = '3'
		)

	UPDATE Comisiontemp
	SET ramo2 = @ramoHyc
	FROM Comisiontemp AS ct
	WHERE ct.codigoEmpresaNovedad = '5'
		AND CAST(codigoConcepto AS INT) = 100

	-- EMERMEDICA (Código Core 4)
	DECLARE @ramoEmermedica AS INT = (
		SELECT rd.ramo_id FROM RamoDetalle rd WHERE rd.compania_id = 5
		AND rd.codigoCore = '4'
		)

	UPDATE Comisiontemp
	SET ramo2 = @ramoEmermedica
	FROM Comisiontemp AS ct
	WHERE ct.codigoEmpresaNovedad = '5'
		AND CAST(codigoConcepto AS INT) = 99

	----	
	UPDATE Comisiontemp
	SET ramo2 = 0
	WHERE ISNUMERIC(ramo2) = 0

	-- Se actualiza el código de la localidad a partir de la tabla de Localidad. Solo para VIDA y GENERALES
	UPDATE Comisiontemp
	SET localidadRecaudo = l.id
	FROM Comisiontemp AS ct
	INNER JOIN Localidad AS l ON l.[codigo SISE] = ct.localidadRecaudo
	WHERE ct.codigoEmpresaNovedad IN (
			'1'
			,'2'
			)

	-- Las que no se pueden homologar se dejan en cero. (Se debe actualizar la tabla Localidad)
	UPDATE Comisiontemp
	SET localidadRecaudo = '0'
	FROM Comisiontemp AS ct
	WHERE ct.codigoEmpresaNovedad IN (
			'1'
			,'2'
			)
		AND NOT EXISTS (
			SELECT *
			FROM Localidad AS l
			WHERE l.[codigo SISE] = ct.localidadRecaudo
			)
END
