-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 17/09/2012
-- Description:	Reporte Recaudos por segmento participante
-- =============================================
CREATE PROCEDURE [dbo].[RPT_RecaudosxSegmentoIntermediario]
(
	@compania_id INT,
	@anio INT,
	@mesInicio INT,
	@mesFin INT,
	@segmento_id INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT c.nombre AS Compania
		,z.nombre AS Zona
		,l.nombre AS Localidad
		,jPadre.nombre AS Director
		,l1.nombre AS LocalidadDirector
		,r.clave
		,LTRIM(RTRIM(pa.nombre)) + ' ' + LTRIM(RTRIM(pa.apellidos)) AS nombreParticipante
		,r.porcentajeParticipacion
		,ln.nombre AS LineaNegocio
		,s.nombre AS Segmento
		,ra.nombre AS Ramo
		,p.nombre AS Producto
		,pd.nombre AS [Plan]
		,a.nombre AS Amparo
		,co.nombre AS Cobertura
		,mp.nombre AS ModalidadPago
		,pla.nombre AS plazoNombre
		,CAST(r.numeroNegocio AS BIGINT) AS numeroNegocio
		,r.valorRecaudo
		,r.Colquines
		,r.mesCierre
		,r.anioCierre
		,CAST(r.fechaRecaudo AS DATE) AS fechaRecaudo
		,CAST(r.fechaGrabacion AS DATE) AS fechaGrabacion
		,CAST(r.fechaCobranza AS DATE) AS fechaCobranza
		,(
			SELECT TOP 1 n.identificacionSuscriptor
			FROM Negocio n
			WHERE n.numeroNegocio = r.numeroNegocio
				AND n.compania_id = r.compania_id
				AND n.ramoDetalle_id = r.ramoDetalle_id
				AND n.productoDetalle_id = r.productoDetalle_id
				AND n.localidad_id = r.localidad_id
				AND n.participante_id = r.participante_id
			) AS identificacionSuscriptor
		,(
			SELECT TOP 1 n.nombreSuscriptor
			FROM Negocio n
			WHERE n.numeroNegocio = r.numeroNegocio
				AND n.compania_id = r.compania_id
				AND n.ramoDetalle_id = r.ramoDetalle_id
				AND n.productoDetalle_id = r.productoDetalle_id
				AND n.localidad_id = r.localidad_id
				AND n.participante_id = r.participante_id
			) AS nombreSuscriptor
		,(
			SELECT TOP 1 ae.nombre
			FROM ActividadEconomica ae
			INNER JOIN Negocio n ON n.actividadEconomica_id = ae.id
			WHERE n.numeroNegocio = r.numeroNegocio
				AND n.compania_id = r.compania_id
				AND n.ramoDetalle_id = r.ramoDetalle_id
				AND n.productoDetalle_id = r.productoDetalle_id
				AND n.localidad_id = r.localidad_id
				AND n.participante_id = r.participante_id
			) AS actividadEconomica
	FROM Recaudo r
	INNER JOIN Compania c ON c.id = r.compania_id
	INNER JOIN LineaNegocio ln ON ln.id = r.lineaNegocio_id
	INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
	INNER JOIN Ramo ra ON ra.id = rd.ramo_id
	INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
	INNER JOIN Producto p ON p.id = pd.producto_id
	INNER JOIN Plazo pla ON pla.id = p.plazo_id
	INNER JOIN Amparo a ON a.id = r.amparo_id
	INNER JOIN Cobertura co ON co.id = r.cobertura_id
	LEFT JOIN ModalidadPago mp ON mp.id = r.modalidadpago_id
	INNER JOIN Zona z ON z.id = r.zona_id
	INNER JOIN Localidad l ON l.id = r.localidad_id
	INNER JOIN Participante pa ON pa.clave = r.clave
	LEFT JOIN Segmento s ON s.id = r.segmento_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = pa.id
	LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
	INNER JOIN Localidad l1 ON l1.id = jPadre.localidad_id
	WHERE r.anioCierre = @anio
		AND r.mesCierre BETWEEN @mesInicio
			AND @mesFin
		AND (
			@compania_id = 0
			OR r.compania_id = @compania_id
			)
		AND pa.segmento_id = @segmento_id
END