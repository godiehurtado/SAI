
CREATE PROCEDURE [dbo].[RPT_SiniestralidadAcumulada] @mesCorte AS INT
	,@anioCorte AS INT
	,@canal_id AS INT = 0
AS
BEGIN
	DECLARE @mes AS INT = @mesCorte
		,@anio AS INT = @anioCorte

	SELECT s.clave
		,RTRIM(LTRIM(p.nombre)) + ' ' + RTRIM(LTRIM(p.apellidos)) AS nombre
		,c.nombre AS compania
		,r.nombre AS ramo
		,(s.primasEmitidas + s.reservaTecnica) AS primasDevengadas
		,s.siniestrosIncurridos
		,s.indSiniestralidad
		,s.ultimoMes
		,s.anio
		,ROUND(s.colquinesDescontar, 3) AS colquinesDescontar
		,jPadre.nombre AS director
		,l.nombre AS localidad
		,z.nombre AS zona
		,ca.nombre AS canal
	FROM SiniestralidadAcumulada s
	INNER JOIN Participante p ON p.id = s.participante_id
	INNER JOIN Compania c ON c.id = s.compania_id
	INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
	INNER JOIN Ramo r ON r.id = rd.ramo_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
	LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
	INNER JOIN Localidad l ON l.id = p.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	INNER JOIN Canal ca ON ca.id = p.canal_id
	WHERE s.ultimoMes = @mes
		AND s.anio = @anio
		AND s.colquinesDescontar < 0
		AND (
			@canal_id = 0
			OR ca.id = @canal_id
			)
		AND s.participante_id IS NOT NULL
END