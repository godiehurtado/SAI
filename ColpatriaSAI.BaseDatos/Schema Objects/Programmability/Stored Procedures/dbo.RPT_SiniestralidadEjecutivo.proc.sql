CREATE PROCEDURE [dbo].[RPT_SiniestralidadEjecutivo] @mesCorte AS INT
	,@anioCorte AS INT
	,@canal_id AS INT = 0
	,@nivel_id AS INT = 0
AS
BEGIN
	DECLARE @mes AS INT = @mesCorte
		,@anio AS INT = @anioCorte

	SELECT RTRIM(LTRIM(jd.nombre)) AS nombre
		,RTRIM(LTRIM(jd.codigoNivel)) AS codigoNivel
		,(s.primasEmitidas + s.reservaTecnica) AS primasDevengadas
		,s.siniestrosIncurridos
		,s.indSiniestralidad
		,ROUND(s.primasEmitidas, 3) AS primasEmitidas
		,ROUND(s.reservaTecnica, 3) AS reservaTecnica
		,l.nombre AS localidad
		,z.nombre AS zona
		,c.nombre AS canal
		,n.nombre AS nivel
		,MONTH(s.fechaCorte) AS periodo
	FROM Siniestralidad s
	INNER JOIN JerarquiaDetalle jd ON jd.id = s.jerarquiaDetalle_id
	INNER JOIN Localidad l ON l.id = jd.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	INNER JOIN Canal c ON c.id = jd.canal_id
	INNER JOIN Nivel n ON n.id = jd.nivel_id
	WHERE MONTH(s.fechaCorte) = @mes
		AND YEAR(s.fechaCorte) = @anio
		AND s.jerarquiaDetalle_id IS NOT NULL
		AND (
			@canal_id = 0
			OR c.id = @canal_id
			)
		AND (
			@nivel_id = 0
			OR n.id = @nivel_id
			)
	ORDER BY jd.codigoNivel
END
