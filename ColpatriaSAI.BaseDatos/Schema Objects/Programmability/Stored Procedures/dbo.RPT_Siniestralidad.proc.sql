
CREATE PROCEDURE [dbo].[RPT_Siniestralidad] @mesCorte AS INT
	,@anioCorte AS INT
	,@canal_id AS INT = 0
AS
BEGIN
	DECLARE @mes AS INT = @mesCorte
		,@anio AS INT = @anioCorte

	SELECT RTRIM(LTRIM(s.clave)) AS clave
		,RTRIM(LTRIM(p.nombre)) + ' ' + RTRIM(LTRIM(p.apellidos)) AS nombre
		,(s.primasEmitidas + s.reservaTecnica) AS primasDevengadas
		,s.siniestrosIncurridos
		,s.indSiniestralidad
		,ROUND(s.primasEmitidas, 3) AS primasEmitidas
		,ROUND(s.reservaTecnica, 3) AS reservaTecnica
		,jPadre.nombre AS director
		,l.nombre AS localidad
		,z.nombre AS zona
		,c.nombre AS canal
		,MONTH(s.fechaCorte) AS periodo
	FROM Siniestralidad s
	INNER JOIN Participante p ON p.id = s.participante_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
	LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
	INNER JOIN Localidad l ON l.id = p.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	INNER JOIN Canal c ON c.id = p.canal_id
	WHERE MONTH(s.fechaCorte) = @mes
		AND YEAR(s.fechaCorte) = @anio
		AND s.participante_id IS NOT NULL
		AND (
			@canal_id = 0
			OR c.id = @canal_id
			)
	ORDER BY s.clave
END