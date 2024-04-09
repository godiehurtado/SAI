
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Homologación y carga de información de intermediarios. Se actualizan los que ya existen y se cargan los
--              que no existen por clave en la tabla participante.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_HomologacionParticipantesGP]
AS
BEGIN
	-- *********************************************************************************************************
	-- INICIO LOG ERRORES.
	-- *********************************************************************************************************--
	DECLARE @cantidadInicial AS INT = (SELECT COUNT(*) FROM Participante)
	DECLARE @DefaultDate VARCHAR(10)

	SET @DefaultDate = CONVERT(VARCHAR, CONVERT(DATETIME, 0), 103)

	-- *********************************************************************************************************
	-- Normalización de la tabla Temporal Participantestemp
	-- *********************************************************************************************************--
	UPDATE Participantetemp
	SET telefono = direccion
	WHERE RTRIM(LTRIM(canal)) = 'CALLE45ASUR N 64B38'

	UPDATE Participantetemp
	SET direccion = canal
	WHERE RTRIM(LTRIM(canal)) = 'CALLE45ASUR N 64B38'

	UPDATE Participantetemp
	SET canal = categoria
	WHERE RTRIM(LTRIM(canal)) = 'CALLE45ASUR N 64B38'

	UPDATE Participantetemp
	SET categoria = ''
	WHERE RTRIM(LTRIM(direccion)) = 'CALLE45ASUR N 64B38'

	UPDATE Participantetemp
	SET CompaniaCodigo = CAST(CompaniaCodigo AS INT)

	UPDATE Participantetemp
	SET CompaniaCodigo = 5
	WHERE CompaniaCodigo = 11

	UPDATE Participantetemp
	SET CompaniaCodigo = 1
	WHERE CompaniaCodigo = 13

	UPDATE Participantetemp
	SET CompaniaCodigo = 2
	WHERE CompaniaCodigo = 14

	UPDATE Participantetemp
	SET CompaniaCodigo = 3
	WHERE CompaniaCodigo = 15

	UPDATE Participantetemp
	SET CompaniaCodigo = 4
	WHERE CompaniaCodigo = 16

	UPDATE Participantetemp
	SET CompaniaCodigo = 5
	WHERE CompaniaCodigo = 17

	UPDATE Participantetemp
	SET clave = RTRIM(LTRIM(clave))

	UPDATE Participantetemp
	SET numeroDocumento = CAST(numeroDocumento AS BIGINT)

	UPDATE Participantetemp
	SET segmento = CAST(segmento AS INT)

	UPDATE Participantetemp
	SET estado = '1'
	WHERE RTRIM(LTRIM(estado)) = 'I'

	UPDATE Participantetemp
	SET estado = '2'
	WHERE RTRIM(LTRIM(estado)) = 'A'

	UPDATE Participantetemp
	SET estado = '3'
	WHERE RTRIM(LTRIM(estado)) = 'E'

	UPDATE Participantetemp
	SET estado = '4'
	WHERE RTRIM(LTRIM(estado)) = 'F'

	UPDATE Participantetemp
	SET estado = '5'
	WHERE RTRIM(LTRIM(estado)) = 'R'

	UPDATE Participantetemp
	SET estado = '6'
	WHERE RTRIM(LTRIM(estado)) = 'T'

	UPDATE Participantetemp
	SET estado = '7'
	WHERE RTRIM(LTRIM(estado)) = 'D'

	UPDATE Participantetemp
	SET estado = '8'
	WHERE RTRIM(LTRIM(estado)) = 'S'

	UPDATE Participantetemp
	SET estado = CAST(estado AS INT)

	UPDATE Participantetemp
	SET fechaIngreso = @DefaultDate
	WHERE fechaIngreso = ''
		OR fechaIngreso = '00/00/0000'

	UPDATE Participantetemp
	SET fechaRetiro = @DefaultDate
	WHERE fechaRetiro = ''
		OR fechaRetiro = '00/00/0000'

	UPDATE Participantetemp
	SET fechaNacimiento = @DefaultDate
	WHERE fechaNacimiento = ''
		OR fechaNacimiento = '00/00/0000'

	UPDATE Participantetemp
	SET ingresosMinimos = 0
	WHERE CHARINDEX('/', Participantetemp.ingresosMinimos) > 0

	UPDATE Participantetemp
	SET ingresosMinimos = CAST(ingresosMinimos AS INT)

	UPDATE Participantetemp
	SET LocalidadCodigo = CAST(LocalidadCodigo AS INT)

	UPDATE Participantetemp
	SET canal = CAST(canal AS INT)

	UPDATE Participantetemp
	SET tipoDocumento = '1'
	WHERE RTRIM(LTRIM(tipoDocumento)) = 'C'

	UPDATE Participantetemp
	SET tipoDocumento = '2'
	WHERE RTRIM(LTRIM(tipoDocumento)) = 'E'

	UPDATE Participantetemp
	SET tipoDocumento = '3'
	WHERE RTRIM(LTRIM(tipoDocumento)) = 'N'

	UPDATE Participantetemp
	SET tipoDocumento = '4'
	WHERE RTRIM(LTRIM(tipoDocumento)) = 'T'

	-- Actualización con el id de la localidad SAI respecto al codigo de SISE
	UPDATE Participantetemp
	SET LocalidadCodigo = l.id
	FROM Participantetemp AS pt
	INNER JOIN Localidad AS l ON l.[codigo SISE] = CAST(pt.LocalidadCodigo AS INT)

	-- Actualiza en '0' los valores de la localiad que no existen en Localidad.[codigo SISE]
	UPDATE Participantetemp
	SET LocalidadCodigo = '0'
	FROM Participantetemp AS pt
	WHERE NOT EXISTS (
			SELECT *
			FROM Localidad AS l
			WHERE pt.LocalidadCodigo = l.id
			)

	-- Actualización con el id del Canal del Participante (Intermediario)
	UPDATE Participantetemp
	SET canal = c.id
	FROM Participantetemp AS pt
	INNER JOIN CanalDetalle AS cd ON cd.codigoCore = pt.canal
	INNER JOIN Canal c ON c.id = cd.canal_id

	-- Actualización con el id del Segmento del Participante (Intermediario)
	UPDATE Participantetemp
	SET segmento = s.id
	FROM Participantetemp AS pt
	INNER JOIN Segmento AS s ON s.id = pt.segmento

	-- Actualización con el id del Estado del Participante (Intermediario)
	UPDATE Participantetemp
	SET estado = ep.id
	FROM Participantetemp AS pt
	INNER JOIN EstadoParticipante AS ep ON ep.id = pt.estado

	-- Actualización con el id del TipoDocumento del Participante (Intermediario)
	UPDATE Participantetemp
	SET tipoDocumento = td.id
	FROM Participantetemp AS pt
	INNER JOIN TipoDocumento AS td ON td.id = pt.tipoDocumento

	--  Inserta en la tabla Categoria el registro Categoria de la tabla Participantetemp que no exista en la tabla Categoria
	INSERT INTO Categoria (
		nombre
		,nivel_id
		,principal
		,tipoCategoria
		)
	SELECT DISTINCT Categoria
		,0
		,0
		,1
	FROM Participantetemp pt
	WHERE NOT EXISTS (
			SELECT *
			FROM Categoria c
			WHERE RTRIM(LTRIM(pt.categoria)) = RTRIM(LTRIM(c.nombre))
			)

	-- Actualización con el id de la Categoria del Participante (Intermediario)
	UPDATE Participantetemp
	SET categoria = cat.id
	FROM Participantetemp AS pt
	INNER JOIN Categoria AS cat ON RTRIM(LTRIM(cat.nombre)) = RTRIM(LTRIM(pt.categoria))

	-- *********************************************************************************************************
	--  TipoParticipante sube '0' mientras se valida si esto se va a enviar en el archivo.
	--  Inserta en la tabla Participante de la tabla Participantetemp que no exista en la tabla Participante.
	-- *********************************************************************************************************--
	INSERT INTO Participante (
		clave
		,codProductor
		,nombre
		,apellidos
		,documento
		,email
		,estadoParticipante_id
		,fechaIngreso
		,fechaRetiro
		,fechaNacimiento
		,nivel_id
		,compania_id
		,zona_id
		,localidad_id
		,canal_id
		,categoria_id
		,ingresosMinimos
		,tipoParticipante_id
		,tipoDocumento_id
		,telefono
		,direccion
		,segmento_id
		,GP
		)
	SELECT DISTINCT RTRIM(LTRIM(pt.clave)) AS CLAVE
		,pt.codigoProductor
		,RTRIM(LTRIM(pt.nombre)) AS nombre
		,RTRIM(LTRIM(pt.apellidos)) AS apellidos
		,RTRIM(LTRIM(pt.numeroDocumento)) AS numeroDocumento
		,RTRIM(LTRIM(pt.email)) AS email
		,pt.estado
		,CONVERT(DATETIME, pt.fechaIngreso, 103) AS fechaIngreso
		,CONVERT(DATETIME, pt.fechaRetiro, 103) AS fechaRetiro
		,CONVERT(DATETIME, pt.fechaNacimiento, 103) AS fechaNacimiento
		,1 AS nivel_id --> Concepto de Colpatria
		,pt.CompaniaCodigo
		,(
			SELECT l.zona_id
			FROM Localidad l
			WHERE l.id = pt.LocalidadCodigo
			) AS zona_id
		,pt.LocalidadCodigo
		,pt.canal
		,pt.categoria
		,pt.ingresosMinimos
		,0 AS tipoparticipante_id
		,pt.tipoDocumento
		,RTRIM(LTRIM(pt.telefono)) AS telefono
		,RTRIM(LTRIM(pt.direccion)) AS direccion
		,pt.segmento
		,'true' AS GP
	FROM Participantetemp pt
	WHERE NOT EXISTS (
			SELECT *
			FROM Participante p
			WHERE RTRIM(LTRIM(pt.clave)) = RTRIM(LTRIM(p.clave))
				AND p.GP = 1
			)
		AND RTRIM(LTRIM(pt.clave)) NOT IN (
			''
			,'0'
			)

	-- *********************************************************************************************************
	--  Actualiza la información de los registros ya existentes en la tabla Participante.
	-- *********************************************************************************************************--
	UPDATE Participante
	SET nombre = RTRIM(LTRIM(pt.nombre))
		,codProductor = RTRIM(LTRIM(pt.codigoProductor))
		,apellidos = RTRIM(LTRIM(pt.apellidos))
		,documento = RTRIM(LTRIM(pt.numeroDocumento))
		,email = RTRIM(LTRIM(pt.email))
		,estadoParticipante_id = pt.estado
		,fechaIngreso = CONVERT(DATETIME, pt.fechaIngreso, 103)
		,FechaRetiro = CONVERT(DATETIME, pt.fechaRetiro, 103)
		,fechaNacimiento = CONVERT(DATETIME, pt.fechaNacimiento, 103)
		,compania_id = pt.CompaniaCodigo
		,localidad_id = pt.LocalidadCodigo
		,canal_id = pt.canal
		,categoria_id = pt.categoria
		,IngresosMinimos = pt.ingresosMinimos
		,tipoDocumento_id = pt.tipoDocumento
		,telefono = RTRIM(LTRIM(pt.telefono))
		,direccion = RTRIM(LTRIM(pt.direccion))
		,segmento_id = pt.segmento
	FROM Participante p
	INNER JOIN Participantetemp pt ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(pt.clave))
	WHERE p.GP = 1
		AND RTRIM(LTRIM(pt.clave)) NOT IN (
			''
			,'0'
			)

	--  Log Errores
	DECLARE @cantidadFinal AS INT = (SELECT COUNT(*) FROM Participante)
	DECLARE @delta AS INT = @cantidadFinal - @cantidadInicial
	DECLARE @idActualizacion AS INT = (
		SELECT MAX(id) FROM LogIntegracion WHERE proceso = 'Carga a la tabla dbo.participante'
		AND estado = 1
		)

	UPDATE LogIntegracion
	SET fechaFin = GETDATE()
		,estado = 2
		,cantidad = @delta
	WHERE id = @idActualizacion
END
