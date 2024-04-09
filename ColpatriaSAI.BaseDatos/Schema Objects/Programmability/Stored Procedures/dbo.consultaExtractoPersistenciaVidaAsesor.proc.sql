-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 24/05/2012
-- Description:	Procedimiento almacenado para obtener el extracto de persistencia de vida de un asesor
-- =============================================
CREATE PROCEDURE [dbo].[consultaExtractoPersistenciaVidaAsesor]
(
	@clave NVARCHAR(250),
	@anio INT
)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ultimoMes AS INT = (SELECT MAX(mesCorte) FROM PersistenciadeVIDA WHERE añoAMedir = @anio)
	DECLARE @valorPersistenciaVIDA AS FLOAT = (
		SELECT CAST(pe.valor AS FLOAT) FROM PersistenciaEsperada pe INNER JOIN Concurso c ON c.id = pe.concurso_id WHERE YEAR(c.fecha_inicio) = @anio
		AND YEAR(c.fecha_fin) = @anio
		AND c.principal = 'true'
		AND pe.tipoPersistencia = 'true'
		AND c.tipoConcurso_id = 1
		)

	SELECT (
			CASE 
				WHEN @valorPersistenciaVIDA IS NULL
					THEN 0
				ELSE @valorPersistenciaVIDA
				END
			) AS minimo
		,(
			CASE @ultimoMes
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
			) AS mes
		,pv.persistenciaDefinitiva AS porcentaje
		,RTRIM(LTRIM(pv.tipoPersistencia)) AS tipoPersistencia
		,SUM(pv.colquinesDescontar) AS colquinesDescontar
	FROM PersistenciadeVIDA pv	
	INNER JOIN Participante p ON p.id = pv.participante_id
	WHERE pv.añoAMedir = @anio
		AND RTRIM(LTRIM(p.clave)) = @clave
		AND pv.mesCorte = @ultimoMes
	GROUP BY pv.fechaMedicionPersistencia
		,pv.persistenciaDefinitiva
		,pv.tipoPersistencia
END