CREATE PROCEDURE [dbo].[RPT_SiniestralidadAcumuladaEjecutivo] @mesCorte AS INT
	,@anioCorte AS INT
	,@canal_id AS INT = 0
	,@nivel_id AS INT = 0
AS
BEGIN
	DECLARE @mes AS INT = @mesCorte
		,@anio AS INT = @anioCorte

	SELECT LTRIM(RTRIM(jd.codigoNivel)) AS codigoNivel
		,LTRIM(RTRIM(jd.nombre)) AS nombreEjecutivo
		,c.nombre AS compania
		,r.nombre AS ramo
		,(s.primasEmitidas + s.reservaTecnica) AS primasDevengadas
		,s.siniestrosIncurridos
		,s.indSiniestralidad
		,s.ultimoMes
		,s.anio
		,ROUND(s.colquinesDescontar, 3) AS colquinesDescontar		
		,ROUND(s.recaudosDescontar, 3) AS recaudosDescontar
		,l.nombre AS localidad
		,z.nombre AS zona
		,ca.nombre AS canal
		,n.nombre AS nivel
	FROM SiniestralidadAcumulada s
	INNER JOIN JerarquiaDetalle jd ON jd.id = s.jerarquiaDetalle_id
	INNER JOIN Compania c ON c.id = s.compania_id
	INNER JOIN RamoDetalle rd ON rd.id = s.ramoDetalle_id
	INNER JOIN Ramo r ON r.id = rd.ramo_id
	INNER JOIN Localidad l ON l.id = jd.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	INNER JOIN Canal ca ON ca.id = jd.canal_id
	INNER JOIN Nivel n ON n.id = jd.nivel_id
	WHERE s.ultimoMes = @mes
		AND s.anio = @anio
		AND s.colquinesDescontar < 0
		AND (
			@canal_id = 0
			OR ca.id = @canal_id
			)
		AND (
			@nivel_id = 0
			OR n.id = @nivel_id
			)
		AND s.jerarquiaDetalle_id IS NOT NULL
	ORDER BY jd.codigoNivel ASC
END