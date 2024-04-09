CREATE PROCEDURE [dbo].[RPT_ColquinesxRecaudo]
(
	@compania_id INT,
	@ramo_id INT,
	@producto_id INT,
	@lineaNegocio_id INT,
	@amparo_id INT,
	@modalidadPago_id INT,
	@zona_id INT,
	@localidad_id INT,
	@anioCIerre AS INT
)
AS
BEGIN

	SET NOCOUNT ON;	
	
	DECLARE 	
				@compania_idTemp INT			= @compania_id,
				@ramo_idTemp INT				= @ramo_id,
				@producto_idTemp INT			= @producto_id,
				@lineaNegocio_idTemp INT		= @lineaNegocio_id,
				@amparo_idTemp INT				= @amparo_id,
				@modalidadPago_idTemp INT		= @modalidadPago_id,
				@zona_idTemp INT				= @zona_id,
				@localidad_idTemp INT			= @localidad_id,
				@anioCIerreTemp INT			= @anioCIerre

		SELECT c.nombre AS companiaNombre
		, z.nombre AS zonaNombre
		, l.nombre AS localidadNombre
		, ln.nombre AS lineaNegocioNombre
		, s.nombre AS segmentoNombre
		, p.clave
		, RTRIM(LTRIM((p.nombre + ' ' + p.apellidos))) AS Participante
		, rm.nombre AS ramoNombre
		, pr.nombre AS productoNombre
		, pl.nombre AS planNombre
		, a.nombre AS amparoNombre
		, mp.nombre AS modalidadPagoNombre
		, r.numeroNegocio
		, r.fechaRecaudo
		, RedDetalle.nombre AS redNombre
		, r.valorRecaudo
		, lm.cantidad AS cantidadColquines
		, lm.factor AS factorLiquidacion
		FROM LiquidacionMoneda lm
		INNER JOIN Recaudo r ON r.id = lm.recaudo_id
		INNER JOIN Compania c ON c.id = lm.compania_id
		INNER JOIN Participante p ON p.id = lm.participante_id
		INNER JOIN Zona z ON z.id = r.zona_id
		INNER JOIN Localidad l ON l.id = r.localidad_id
		INNER JOIN LineaNegocio ln ON ln.id = r.lineaNegocio_id
		INNER JOIN Segmento s ON s.id = r.segmento_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
		INNER JOIN PlanDetalle pld ON pld.id = r.planDetalle_id
		INNER JOIN ModalidadPago mp ON mp.id = r.modalidadpago_id
		INNER JOIN Amparo a ON a.id = r.amparo_id
		LEFT JOIN Ramo rm ON rm.id = rd.ramo_id
		LEFT JOIN Producto pr ON pr.id = pd.producto_id
		LEFT JOIN [Plan] pl on pl.id = pld.plan_id
		LEFT JOIN RedDetalle ON RedDetalle.id = r.redDetalle_id
		WHERE lm.tipo = 1
		AND r.compania_id = @compania_idTemp
		AND (@anioCIerreTemp IS NULL OR r.anioCierre = @anioCIerreTemp)		
		AND rm.id = @ramo_idTemp		
		AND (@producto_idTemp = 0 OR pr.id = @producto_idTemp)
		AND ln.id = @lineaNegocio_idTemp
		AND (@amparo_idTemp = 0 OR a.id = @amparo_idTemp)
		AND (@modalidadPago_idTemp = 0 OR mp.id = @modalidadPago_idTemp)
		AND (@zona_idTemp = 0 OR r.zona_id = @zona_idTemp)	
		AND (@localidad_idTemp = 0 OR r.localidad_id = @localidad_idTemp)	
	ORDER BY r.clave	
END