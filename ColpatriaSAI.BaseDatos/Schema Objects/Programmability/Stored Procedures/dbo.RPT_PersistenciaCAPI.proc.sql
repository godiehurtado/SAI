
CREATE PROCEDURE [dbo].[RPT_PersistenciaCAPI] @clave AS NVARCHAR(100) = NULL
	,@plazo_id INT = 0
	,@canal_id INT = 0
	,@periodo INT = 0
	,@anio INT
	,@numeroNegocio AS NVARCHAR(100) = NULL
AS
BEGIN
	
	SELECT pc.mesCierre
		,RTRIM(LTRIM(pc.clave)) AS clave
		,(RTRIM(LTRIM(p.nombre)) + ' ' + RTRIM(LTRIM(p.apellidos))) AS asesor
		,pc.numeroNegocio
		,pl.nombre AS plazo
		,pc.valorPrimaTotal
		,pc.cuotasPagadas
		,pc.cuotasVencidas
		,pc.fechaUltimoRecaudo
		,pc.fechaCierre
		,pc.cumple
		,@anio AS anio
		,l.nombre AS localidad
		,z.nombre AS zona
		,pc.nombreSuscriptor
		,pla.nombre AS planDetalle
		,pc.comentarios
		,jPadre.nombre AS director
		,pc.identificacionSuscriptor
		,c.nombre AS canal
	FROM PersistenciadeCAPIDetalle pc
	INNER JOIN Participante p ON p.id = pc.participante_id
	INNER JOIN Plazo pl ON pl.id = pc.plazo_id
	INNER JOIN Localidad l ON l.id = pc.localidad_id
	INNER JOIN Zona z ON z.id = pc.zona_id
	INNER JOIN PlanDetalle pla ON pla.id = pc.planDetalle_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
	LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
	INNER JOIN Canal c ON c.id = p.canal_id
	WHERE (
			@clave IS NULL
			OR pc.clave = @clave
			)
		AND (
			@numeroNegocio IS NULL
			OR pc.numeroNegocio = @numeroNegocio
			)
		AND (
			@plazo_id = 0
			OR pl.id = @plazo_id
			)
		AND (
			@canal_id = 0
			OR c.id = @canal_id
			)
		AND pc.mesCierre = @periodo
		AND pc.anioCierreNegocio = @anio
		AND pc.participante_id IS NOT NULL
END
