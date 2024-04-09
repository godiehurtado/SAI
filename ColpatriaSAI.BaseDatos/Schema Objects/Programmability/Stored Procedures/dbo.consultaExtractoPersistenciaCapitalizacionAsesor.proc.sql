-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 24/05/2012
-- Description:	Procedimiento almacenado para obtener el extracto de persistencia de capi de un asesor
-- =============================================
CREATE PROCEDURE [dbo].[consultaExtractoPersistenciaCapitalizacionAsesor] (
	@clave NVARCHAR(250)
	,@anio INT
	)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ultimoPeriodo AS INT = (SELECT MAX(ultimoPeriodo) FROM PersistenciadeCAPIAcumulada WHERE anioCierreNegocio = @anio)
	DECLARE @valorPersistenciaCAPICortoPlazo AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = @anio
		AND YEAR(c.fecha_fin) = @anio
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'false'
		AND pe.plazo_id = 1
		AND c.tipoConcurso_id = 1
		)
	DECLARE @valorPersistenciaCAPILargoPlazo AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = @anio
		AND YEAR(c.fecha_fin) = @anio
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'false'
		AND pe.plazo_id = 2
		AND c.tipoConcurso_id = 1
		)

	SELECT (
			CASE 
				WHEN pc.plazo_id = 1
					THEN CASE 
							WHEN @valorPersistenciaCAPICortoPlazo IS NULL
								THEN 0
							ELSE @valorPersistenciaCAPICortoPlazo
							END
				ELSE CASE 
						WHEN pc.plazo_id = 2
							THEN CASE 
									WHEN @valorPersistenciaCAPILargoPlazo IS NULL
										THEN 0
									ELSE @valorPersistenciaCAPILargoPlazo
									END
						END
				END
			) AS minimo
		,(
			CASE pc.ultimoPeriodo
				WHEN 1
					THEN 'Enero'
				WHEN 2
					THEN 'Febrero'
				WHEN 3
					THEN 'Marzo'
				WHEN 4
					THEN 'Abril'
				WHEN 5
					THEN 'Mayo'
				WHEN 6
					THEN 'Junio'
				WHEN 7
					THEN 'Julio'
				WHEN 8
					THEN 'Agosto'
				WHEN 9
					THEN 'Septiembre'
				WHEN 10
					THEN 'Octubre'
				WHEN 11
					THEN 'Noviembre'
				ELSE 'Diciembre'
				END
			) AS mesAcumulada
			,(
			CASE pcp.periodo
				WHEN 1
					THEN 'Enero'
				WHEN 2
					THEN 'Febrero'
				WHEN 3
					THEN 'Marzo'
				WHEN 4
					THEN 'Abril'
				WHEN 5
					THEN 'Mayo'
				WHEN 6
					THEN 'Junio'
				WHEN 7
					THEN 'Julio'
				WHEN 8
					THEN 'Agosto'
				WHEN 9
					THEN 'Septiembre'
				WHEN 10
					THEN 'Octubre'
				WHEN 11
					THEN 'Noviembre'
				ELSE 'Diciembre'
				END
			) AS mesPeriodo
		,pc.persistenciaAcumulada AS acumulada
		,pcp.persistenciaPeriodo AS porcentajePeriodo
		,pl.nombre AS plazo
		,SUM(pc.colquinesDescontar) AS colquinesDescontar
	FROM PersistenciadeCAPIAcumulada pc
	INNER JOIN Plazo pl ON pl.id = pc.plazo_id
	LEFT JOIN PersistenciadeCAPIPeriodo pcp ON pcp.anioCierreNegocio = pc.anioCierreNegocio
		AND pcp.participante_id = pc.participante_id
		AND pcp.plazo_id = pc.plazo_id
	WHERE pc.clave = @clave
		AND pc.anioCierreNegocio = @anio
		AND pc.ultimoPeriodo = @ultimoPeriodo
		AND pcp.anioCierreNegocio = @anio
		AND pcp.periodo BETWEEN 1 AND @ultimoPeriodo
	GROUP BY pc.ultimoPeriodo
		,pl.nombre
		,pc.persistenciaAcumulada
		,pc.plazo_id
		,pcp.periodo
		,pcp.persistenciaPeriodo
END
