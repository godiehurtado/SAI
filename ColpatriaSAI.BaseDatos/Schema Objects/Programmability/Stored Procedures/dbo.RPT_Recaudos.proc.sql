-- =============================================
-- Author:		<>
-- Create date: <Create Date,,>
-- Description:	<Description,,>

-- 27/06/2012: En los campos de 'identificacionSuscriptor', 'nombreSuscriptor' y 'actividadEconomica' se quito la comparación de planDetalle_id
-- =============================================
CREATE PROCEDURE [dbo].[RPT_Recaudos]
(
	@fechaInicio SMALLDATETIME,
	@fechaFin SMALLDATETIME,
	@compania_id INT,
	@ramo_id INT,
	@plazo_id INT,
	@producto_id INT,
	@clave NVARCHAR(500),
	@lineaNegocio_id INT,
	@amparo_id INT,
	@modalidadPago_id INT,
	@localidad_id INT,
	@numeroNegocio NVARCHAR(500)
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		c.nombre AS Compania
		, z.nombre AS Zona
		, l.nombre AS Localidad
		, jPadre.nombre AS Director
		, r.clave
		, LTRIM(RTRIM(pa.nombre)) + ' ' + LTRIM(RTRIM(pa.apellidos)) AS nombreParticipante
		, r.porcentajeParticipacion
		, ln.nombre AS LineaNegocio
		, s.nombre AS Segmento
		, ra.nombre AS Ramo
		, p.nombre AS Producto
		, pd.nombre AS [Plan]
		, a.nombre AS Amparo
		, co.nombre AS Cobertura
		, mp.nombre AS ModalidadPago
		, pla.nombre AS plazoNombre
		, CAST(r.numeroNegocio AS BIGINT) AS numeroNegocio
		, r.valorRecaudo
		, r.Colquines
		, r.mesCierre
		, r.anioCierre
		, CAST(r.fechaRecaudo AS DATE) AS fechaRecaudo
		, CAST(r.fechaGrabacion AS DATE) AS fechaGrabacion
		, CAST(r.fechaCobranza AS DATE) AS fechaCobranza
		, (SELECT TOP 1 n.identificacionSuscriptor FROM Negocio n WHERE n.numeroNegocio = r.numeroNegocio
			AND n.compania_id = r.compania_id
			AND n.ramoDetalle_id = r.ramoDetalle_id
			AND n.productoDetalle_id = r.productoDetalle_id
			AND n.localidad_id = r.localidad_id
			AND n.participante_id = r.participante_id) AS identificacionSuscriptor
		, (SELECT TOP 1 n.nombreSuscriptor FROM Negocio n WHERE n.numeroNegocio = r.numeroNegocio
			AND n.compania_id = r.compania_id
			AND n.ramoDetalle_id = r.ramoDetalle_id
			AND n.productoDetalle_id = r.productoDetalle_id
			AND n.localidad_id = r.localidad_id
			AND n.participante_id = r.participante_id) AS nombreSuscriptor
		, (SELECT TOP 1 ae.nombre
			FROM ActividadEconomica ae INNER JOIN Negocio n ON n.actividadEconomica_id = ae.id
			WHERE n.numeroNegocio = r.numeroNegocio
			AND n.compania_id = r.compania_id
			AND n.ramoDetalle_id = r.ramoDetalle_id
			AND n.productoDetalle_id = r.productoDetalle_id
			AND n.localidad_id = r.localidad_id
			AND n.participante_id = r.participante_id) AS actividadEconomica
	FROM Recaudo r
		INNER JOIN Compania c ON c.id = r.compania_id
		INNER JOIN LineaNegocio ln ON ln.id = r.lineaNegocio_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		INNER JOIN Ramo ra on ra.id = rd.ramo_id
		INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
		INNER JOIN Producto p ON p.id = pd.producto_id
		INNER JOIN Plazo pla ON pla.id = p.plazo_id
		INNER JOIN Amparo a ON a.id = r.amparo_id
		INNER JOIN Cobertura co ON co.id = r.cobertura_id
		LEFT JOIN ModalidadPago mp ON mp.id = r.modalidadpago_id
		INNER JOIN Participante pa ON pa.id = r.participante_id
		INNER JOIN Localidad l ON l.id = pa.localidad_id
		INNER JOIN Zona z ON z.id = l.zona_id
		LEFT JOIN Segmento s ON s.id = r.segmento_id
		LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = pa.id
		LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
	WHERE
		r.fechaRecaudo BETWEEN @fechaInicio AND @fechaFin
		AND r.compania_id = @compania_id
		AND (@ramo_id = 0 OR ra.id = @ramo_id)
		AND (@plazo_id = 0 OR p.plazo_id = @plazo_id)
		AND (@producto_id = 0 OR p.id = @producto_id)
		AND r.clave LIKE ISNULL(@clave, r.clave)
		AND r.numeroNegocio LIKE ISNULL(@numeroNegocio, r.numeroNegocio)
		AND (@lineaNegocio_id = 0 OR ln.id = @lineaNegocio_id)
		AND (@amparo_id = 0 OR a.id = @amparo_id)
		AND (@modalidadPago_id = 0 OR mp.id = @modalidadPago_id)
		AND (@localidad_id = 0 OR pa.localidad_id = @localidad_id)
END