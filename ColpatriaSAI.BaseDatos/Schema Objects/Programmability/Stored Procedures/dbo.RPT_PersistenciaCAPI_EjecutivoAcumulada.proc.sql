
CREATE PROCEDURE [dbo].[RPT_PersistenciaCAPI_EjecutivoAcumulada] @localidad_id AS INT = 0
	,@zona_id AS INT = 0
	,@codigoNivel AS VARCHAR(100) = NULL
	,@plazo_id INT = 0
	,@canal_id INT = 0
	,@nivel_id INT = 0
	,@periodo INT = 0
	,@anio INT
AS
BEGIN
	SELECT z.nombre AS zona
		,l.nombre AS localidad
		,@periodo AS ultimoPeriodo
		,pl.nombre AS plazo
		,pc.persistenciaAcumulada
		,pc.anioCierreNegocio
		,pc.colquinesDescontar
		,pc.recaudosDescontar
		,jd.nombre AS ejecutivo
		,c.nombre AS canal
		,n.nombre AS nivel
	FROM PersistenciadeCAPIAcumulada pc
	INNER JOIN JerarquiaDetalle jd ON jd.id = pc.jerarquiaDetalle_id
	INNER JOIN Localidad l ON l.id = jd.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	INNER JOIN Plazo pl ON pl.id = pc.plazo_id
	INNER JOIN Canal c ON c.id = jd.canal_id
	INNER JOIN Nivel n ON n.id = jd.nivel_id
	WHERE (
			@localidad_id = 0
			OR l.id = @localidad_id
			)
		AND (
			@zona_id = 0
			OR z.id = @zona_id
			)
		AND (
			@codigoNivel IS NULL
			OR jd.codigoNivel = @codigoNivel
			)
		AND (
			@plazo_id = 0
			OR pl.id = @plazo_id
			)
		AND (
			@canal_id = 0
			OR c.id = @canal_id
			)
		AND (
			@nivel_id = 0
			OR n.id = @nivel_id
			)
		AND pc.ultimoPeriodo = @periodo
		AND pc.anioCierreNegocio = @anio
		AND pc.jerarquiaDetalle_id IS NOT NULL
END
