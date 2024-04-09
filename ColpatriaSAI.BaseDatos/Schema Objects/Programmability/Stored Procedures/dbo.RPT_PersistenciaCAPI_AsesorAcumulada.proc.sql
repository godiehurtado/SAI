
CREATE PROCEDURE [dbo].[RPT_PersistenciaCAPI_AsesorAcumulada] @localidad_id AS INT = 0
	,@zona_id AS INT = 0
	,@clave AS VARCHAR(100) = NULL
	,@plazo_id INT = 0
	,@canal_id INT = 0
	,@periodo INT = 0
	,@anio INT
AS
BEGIN
	SELECT z.nombre AS zona
		,l.nombre AS localidad
		,RTRIM(LTRIM(pc.clave)) AS clave
		,(RTRIM(LTRIM(p.nombre)) + ' ' + RTRIM(LTRIM(p.apellidos))) AS asesor
		,@periodo AS ultimoPeriodo
		,pl.nombre AS plazo
		,pc.persistenciaAcumulada
		,pc.anioCierreNegocio
		,pc.colquinesDescontar
		,jPadre.nombre AS director
		,c.nombre AS canal
	FROM PersistenciadeCAPIAcumulada pc
	INNER JOIN Participante p ON p.id = pc.participante_id
	INNER JOIN Localidad l ON l.id = p.localidad_id
	INNER JOIN Zona z ON z.id = p.zona_id
	INNER JOIN Plazo pl ON pl.id = pc.plazo_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
	LEFT JOIN JerarquiaDetalle jPadre ON jPadre.id = jd.padre_id
	INNER JOIN Canal c ON c.id = p.canal_id
	WHERE (
			@localidad_id = 0
			OR l.id = @localidad_id
			)
		AND (
			@zona_id = 0
			OR z.id = @zona_id
			)
		AND (
			@clave IS NULL
			OR pc.clave = @clave
			)
		AND (
			@plazo_id = 0
			OR pl.id = @plazo_id
			)
		AND (
			@canal_id = 0
			OR c.id = @canal_id
			)
		AND pc.ultimoPeriodo = @periodo
		AND pc.anioCierreNegocio = @anio
		AND pc.participante_id IS NOT NULL
END