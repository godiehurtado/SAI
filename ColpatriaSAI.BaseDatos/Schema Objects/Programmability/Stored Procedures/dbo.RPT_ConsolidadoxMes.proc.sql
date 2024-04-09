CREATE PROCEDURE [dbo].[RPT_ConsolidadoxMes]
(
	@año INT,
	@compania_id INT,
	@ramo_id INT,
	@producto_id INT,
	@lineaNegocio_id INT,
	@zona_id INT,
	@plazo_id INT,
	@amparo_id INT,
	@localidad_id INT = 0,
	@clave NVARCHAR(100),
	@canal_id INT = 0
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE 	@compania_idTemp INT	= @compania_id,
				@ramo_idTemp INT		= @ramo_id,
				@plazo_idTemp INT		= @plazo_id,
				@producto_idTemp INT	= @producto_id,
				@claveTemp NVARCHAR(500)= @clave,
				@canal_idTemp INT		= @canal_id,
				@lineaNegocio_idTemp INT= @lineaNegocio_id,
				@amparo_idTemp INT		= @amparo_id,
				@zona_idTemp INT		= @zona_id,
				@localidad_idTemp INT	= @localidad_id
	
	SELECT
		cm.clave
		,ca.nombre AS canal
		, tm.nombre AS tipoMedida
		, cm.año AS anio
		, c.nombre AS compania
		, ln.nombre AS lineaNegocio
		, r.nombre AS ramo
		, p.nombre AS producto
		, z.nombre AS zona
		, l.nombre AS localidad
		, a.nombre AS amparo
		, pz.nombre AS plazo
		, cm.Enero
		, cm.Febrero
		, cm.Marzo
		, cm.Abril
		, cm.Mayo
		, cm.Junio
		, cm.Julio
		, cm.Agosto
		, cm.Septiembre
		, cm.Octubre
		, cm.Noviembre
		, cm.Diciembre
	FROM ConsolidadoMes cm
		INNER JOIN Participante pa ON pa.id = cm.participante_id
		INNER JOIN Canal ca ON ca.id = pa.canal_id
		INNER JOIN TipoMedida tm ON tm.id = cm.tipoMedida_id
		INNER JOIN Compania c ON c.id = cm.compania_id
		INNER JOIN LineaNegocio ln ON ln.id = cm.lineaNegocio_id
		INNER JOIN Ramo r ON r.id = cm.ramo_id
		INNER JOIN Producto p ON p.id = cm.producto_id
		INNER JOIN Zona z ON z.id = cm.zona_id
		INNER JOIN Localidad l ON l.id = cm.localidad_id
		INNER JOIN Amparo a ON a.id = cm.amparo_id
		INNER JOIN Plazo pz ON pz.id = cm.plazo_id
	WHERE
		cm.año = @año
		AND (@compania_idTemp = 0 OR cm.compania_id = @compania_idTemp)
		AND (@ramo_idTemp = 0 OR cm.ramo_id = @ramo_idTemp)
		AND (@plazo_idTemp = 0 OR cm.plazo_id = @plazo_idTemp)
		AND (@producto_idTemp = 0 OR cm.producto_id = @producto_idTemp)
		AND cm.clave LIKE ISNULL(@claveTemp, cm.clave)
		AND (@canal_idTemp = 0 OR pa.canal_id = @canal_idTemp)
		AND (@lineaNegocio_idTemp = 0 OR cm.lineaNegocio_id = @lineaNegocio_idTemp)
		AND (@amparo_idTemp = 0 OR cm.amparo_id = @amparo_idTemp)
		AND (@zona_idTemp = 0 OR cm.zona_id = @zona_idTemp)
		AND (@localidad_idTemp = 0 OR cm.localidad_id = @localidad_idTemp)
END