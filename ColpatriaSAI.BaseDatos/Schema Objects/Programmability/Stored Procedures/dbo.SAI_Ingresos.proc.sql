
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Homologación e inserción de la información de Ingresos enviado GP.
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Ingresos]
AS
BEGIN
	DECLARE @anioenCurso AS INT = YEAR (GETDATE())
	DECLARE @mesActual AS NVARCHAR(10) = MONTH (GETDATE())
	DECLARE @mesAnterior AS NVARCHAR(10) = MONTH (DATEADD(MM, - 1, GETDATE()))
	DECLARE @cantidadRegistros AS INT = (SELECT COUNT(*) FROM Ingresostemp)
	DECLARE @DefaultDate DATE

	SET @DefaultDate = CONVERT(DATETIME, 0)
	SET @anioenCurso = (
			CASE 
				WHEN @mesAnterior = 12
					THEN (@anioenCurso - 1)
				ELSE @anioenCurso
				END
			)

	-- *********************************************************************************************************
	-- HOMOLOGACIÓN DE CAMPOS
	-- *********************************************************************************************************--	
	UPDATE Ingresostemp
	SET DocumentoParticipante = CAST(DocumentoParticipante AS BIGINT)

	UPDATE Ingresostemp
	SET ClaveParticipante = RTRIM(LTRIM(ClaveParticipante))

	UPDATE Ingresostemp
	SET tipoParticipante = '0'
	WHERE ISNUMERIC(tipoParticipante) = 0

	UPDATE Ingresostemp
	SET tipoParticipante = '0'
	FROM Ingresostemp it
	WHERE NOT EXISTS (
			SELECT *
			FROM TipoParticipante AS tp
			WHERE tp.id = CAST(it.tipoParticipante AS INT)
			)

	UPDATE Ingresostemp
	SET tipoParticipante = CAST(tipoParticipante AS BIGINT)

	UPDATE Ingresostemp
	SET fechaIngreso = CAST((SUBSTRING(fechaIngreso, 1, 4) + '-') AS NVARCHAR(50)) + CAST((SUBSTRING(fechaIngreso, 5, 2)) + '-' AS NVARCHAR(50)) + CAST((SUBSTRING(fechaIngreso, 7, 2)) AS NVARCHAR(50))

	UPDATE Ingresostemp
	SET fechaIngreso = @DefaultDate
	WHERE ISDATE(fechaIngreso) = 0

	UPDATE Ingresostemp
	SET fechaRetiro = CAST((SUBSTRING(fechaRetiro, 1, 4) + '-') AS NVARCHAR(50)) + CAST((SUBSTRING(fechaRetiro, 5, 2)) + '-' AS NVARCHAR(50)) + CAST((SUBSTRING(fechaRetiro, 7, 2)) AS NVARCHAR(50))

	UPDATE Ingresostemp
	SET fechaRetiro = @DefaultDate
	WHERE ISDATE(fechaRetiro) = 0

	UPDATE Ingresostemp
	SET Periodo = REPLACE(Periodo, '|', '')

	UPDATE Ingresostemp
	SET Periodo = REPLACE(Periodo, '/', '')

	UPDATE Ingresostemp
	SET Periodo = CAST((SUBSTRING(Periodo, 1, 4) + '-') AS NVARCHAR(50)) + CAST((SUBSTRING(Periodo, 5, 2)) + '-' AS NVARCHAR(50)) + '01'

	UPDATE Ingresostemp
	SET Periodo = @DefaultDate
	WHERE ISDATE(Periodo) = 0

	UPDATE Ingresostemp
	SET estado = CASE 
			WHEN estado = 'I'
				THEN 1
			ELSE CASE 
					WHEN estado = 'A'
						THEN 2
					ELSE CASE 
							WHEN estado = 'E'
								THEN 3
							ELSE CASE 
									WHEN estado = 'F'
										THEN 4
									ELSE CASE 
											WHEN estado = 'R'
												THEN 5
											ELSE CASE 
													WHEN estado = 'T'
														THEN 6
													ELSE 0
													END
											END
									END
							END
					END
			END

	--  Cantidad de caracteres enviado desde GP para el campo valorComisiones = 11
	UPDATE Ingresostemp
	SET valorComisiones = STR(CAST('-' + CAST(valorComisiones AS NVARCHAR(11)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', valorComisiones) > 0

	UPDATE Ingresostemp
	SET valorComisiones = RTRIM(LTRIM(valorComisiones))

	UPDATE Ingresostemp
	SET valorComisiones = CAST(valorComisiones AS BIGINT)
	WHERE CHARINDEX('-', valorComisiones) = 0

	UPDATE Ingresostemp
	SET valorComisiones = '0'
	WHERE valorComisiones = '-0.00'

	--  Cantidad de caracteres enviado desde GP para el campo comisionesCAPÍ = 9
	UPDATE Ingresostemp
	SET comisionesCAPI = STR(CAST('-' + CAST(comisionesCAPI AS NVARCHAR(9)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', comisionesCAPI) > 0

	UPDATE Ingresostemp
	SET comisionesCAPI = RTRIM(LTRIM(comisionesCAPI))

	UPDATE Ingresostemp
	SET comisionesCAPI = CAST(comisionesCAPI AS BIGINT)
	WHERE CHARINDEX('-', comisionesCAPI) = 0

	UPDATE Ingresostemp
	SET comisionesCAPI = '0'
	WHERE comisionesCAPI = '-0.00'

	--  Cantidad de caracteres enviado desde GP para el campo comisionesVIDA = 9
	UPDATE Ingresostemp
	SET comisionesVIDA = STR(CAST('-' + CAST(comisionesVIDA AS NVARCHAR(9)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', comisionesVIDA) > 0

	UPDATE Ingresostemp
	SET comisionesVIDA = RTRIM(LTRIM(comisionesVIDA))

	UPDATE Ingresostemp
	SET comisionesVIDA = CAST(comisionesVIDA AS BIGINT)
	WHERE CHARINDEX('-', comisionesVIDA) = 0

	UPDATE Ingresostemp
	SET comisionesVIDA = '0'
	WHERE comisionesVIDA = '-0.00'

	--  Cantidad de caracteres enviado desde GP para el campo comisionesGENERALES = 9
	UPDATE Ingresostemp
	SET comisionesGENERALES = STR(CAST('-' + CAST(comisionesGENERALES AS NVARCHAR(9)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', comisionesGENERALES) > 0

	UPDATE Ingresostemp
	SET comisionesGENERALES = RTRIM(LTRIM(comisionesGENERALES))

	UPDATE Ingresostemp
	SET comisionesGENERALES = CAST(comisionesGENERALES AS BIGINT)
	WHERE CHARINDEX('-', comisionesGENERALES) = 0

	UPDATE Ingresostemp
	SET comisionesGENERALES = '0'
	WHERE comisionesGENERALES = '-0.00'

	--  Cantidad de caracteres enviado desde GP para el campo comisionesORV = 9
	UPDATE Ingresostemp
	SET comisionesORV = STR(CAST('-' + CAST(comisionesORV AS NVARCHAR(9)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', comisionesORV) > 0

	UPDATE Ingresostemp
	SET comisionesORV = RTRIM(LTRIM(comisionesORV))

	UPDATE Ingresostemp
	SET comisionesORV = CAST(comisionesORV AS BIGINT)
	WHERE CHARINDEX('-', comisionesORV) = 0

	UPDATE Ingresostemp
	SET comisionesORV = '0'
	WHERE comisionesORV = '-0.00'

	--  Cantidad de caracteres enviado desde GP para el campo comisionesORG = 9
	UPDATE Ingresostemp
	SET comisionesORG = STR(CAST('-' + CAST(comisionesORG AS NVARCHAR(9)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', comisionesORG) > 0

	UPDATE Ingresostemp
	SET comisionesORG = RTRIM(LTRIM(comisionesORG))

	UPDATE Ingresostemp
	SET comisionesORG = CAST(comisionesORG AS BIGINT)
	WHERE CHARINDEX('-', comisionesORG) = 0

	UPDATE Ingresostemp
	SET comisionesORG = '0'
	WHERE comisionesORG = '-0.00'

	--  Cantidad de caracteres enviado desde GP para el campo comisionesSALUD = 9
	UPDATE Ingresostemp
	SET comisionesSALUD = STR(CAST('-' + CAST(comisionesSALUD AS NVARCHAR(9)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', comisionesSALUD) > 0

	UPDATE Ingresostemp
	SET comisionesSALUD = RTRIM(LTRIM(comisionesSALUD))

	UPDATE Ingresostemp
	SET comisionesSALUD = CAST(comisionesSALUD AS BIGINT)
	WHERE CHARINDEX('-', comisionesSALUD) = 0

	UPDATE Ingresostemp
	SET comisionesSALUD = '0'
	WHERE comisionesSALUD = '-0.00'

	--  Cantidad de caracteres enviado desde GP para el campo comisionesSOAT = 9
	UPDATE Ingresostemp
	SET comisionesSOAT = STR(CAST('-' + CAST(comisionesSOAT AS NVARCHAR(9)) AS FLOAT), 13, 2)
	WHERE CHARINDEX('-', comisionesSOAT) > 0

	UPDATE Ingresostemp
	SET comisionesSOAT = RTRIM(LTRIM(comisionesSOAT))

	UPDATE Ingresostemp
	SET comisionesSOAT = CAST(comisionesSOAT AS BIGINT)
	WHERE CHARINDEX('-', comisionesSOAT) = 0

	UPDATE Ingresostemp
	SET comisionesSOAT = '0'
	WHERE comisionesSOAT = '-0.00'

	--  Actualizacion a INT del valor de la localidad (SISE)
	UPDATE Ingresostemp
	SET nombreLocalidad = CAST(nombreLocalidad AS INT)

	IF (@cantidadRegistros > 0)
	BEGIN
		DELETE
		FROM Ingreso
		WHERE MONTH(Periodo) = @mesAnterior
			AND YEAR(Periodo) = @anioenCurso
	END

	-- *********************************************************************************************************
	-- SE INSERTA EN LA TABLA INGRESO AGRUPANDO X CLAVE
	-- *********************************************************************************************************--	
	INSERT INTO Ingreso (
		participante_id
		,estadoParticipante_id
		,fechaIngreso
		,fechaRetiro
		,ComisionesCAPI
		,ComisionesVIDA
		,ComisionesGENERALES
		,ComisionesORV
		,ComisionesORG
		,ComisionesSALUD
		,ComisionesSOAT
		,TotalComisiones
		,Periodo
		)
	SELECT p.id AS participante_id
		,it.estado
		,it.fechaIngreso
		,it.fechaRetiro
		,SUM(CAST(it.comisionesCAPI AS FLOAT)) AS comisionesCAPI
		,SUM(CAST(it.comisionesVIDA AS FLOAT)) AS comisionesVIDA
		,SUM(CAST(it.comisionesGENERALES AS FLOAT)) AS comisionesGENERALES
		,SUM(CAST(it.comisionesORV AS FLOAT)) AS comisionesORV
		,SUM(CAST(it.comisionesORG AS FLOAT)) AS comisionesORG
		,SUM(CAST(it.comisionesSALUD AS FLOAT)) AS comisionesSALUD
		,SUM(CAST(it.comisionesSOAT AS FLOAT)) AS comisionesSOAT
		,SUM(CAST(it.valorComisiones AS FLOAT)) AS valorComisiones
		,it.Periodo
	FROM Ingresostemp it
	INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(it.ClaveParticipante))
	WHERE YEAR(Periodo) = @anioenCurso
		AND MONTH(Periodo) = @mesAnterior
	GROUP BY it.ClaveParticipante
		,it.Periodo
		,it.estado
		,it.fechaIngreso
		,it.fechaRetiro
		,p.id
END
