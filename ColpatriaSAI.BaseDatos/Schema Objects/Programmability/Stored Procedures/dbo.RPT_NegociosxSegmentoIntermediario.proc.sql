-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 17/09/2012
-- Description:	 Reporte Negocios por segmento participante
-- =============================================
CREATE PROCEDURE [dbo].[RPT_NegociosxSegmentoIntermediario]
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
		,z.nombre AS zonaNombre
		,l.nombre AS Localidad
		,jPadre.nombre AS Director
		,l1.nombre AS LocalidadDirector
		,RTRIM(LTRIM(n.clave)) AS Clave
		,LTRIM(RTRIM(pa.nombre)) + ' ' + LTRIM(RTRIM(pa.apellidos)) AS nombreParticipante
		,n.porcentajeParticipacion
		,ln.nombre AS LineaNegocio
		,s.nombre AS Segmento
		,r.nombre AS Ramo
		,p.nombre AS Producto
		,pd.nombre AS [Plan]
		,a.nombre AS Amparo
		,co.nombre AS Cobertura
		,mp.nombre AS ModalidadPago
		,pla.nombre AS plazoNombre
		,CAST(n.numeroNegocio AS BIGINT) AS numeroNegocio
		,n.estadoNegocio
		,n.valorAhorro
		,n.valorProteccion
		,n.valorPrimaPensiones
		,n.valorPrimaTotal
		,n.mesCierre
		,n.anioCierre
		,CAST(n.fechaExpedicion AS DATE) AS fechaExpedicion
		,CAST(n.fechaGrabacion AS DATE) AS fechaGrabacion
		,CAST(n.fechaCancelacion AS DATE) AS fechaCancelacion
		,n.identificacionSuscriptor AS cedulaCliente
		,n.nombreSuscriptor AS nombreCliente
		,ac.nombre AS ActividadEconomica
		,n.codigoAgrupador
		,ge.nombre AS grupoEndoso
		,te.nombre AS tipoEndoso
		,pa.segmento_id AS segmentoParticipante
	FROM temporalNegocio n
	INNER JOIN Compania c ON c.id = n.compania_id
	INNER JOIN LineaNegocio ln ON ln.id = n.lineaNegocio_id
	INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
	INNER JOIN Ramo r ON r.id = rd.ramo_id
	INNER JOIN ProductoDetalle pd ON pd.id = n.productoDetalle_id
	INNER JOIN Producto p ON p.id = pd.producto_id
	INNER JOIN Plazo pla ON pla.id = p.plazo_id
	LEFT JOIN Amparo a ON a.id = n.amparo_id
	LEFT JOIN Cobertura co ON co.id = n.cobertura_id
	LEFT JOIN Segmento s ON s.id = n.segmento_id
	LEFT JOIN ModalidadPago mp ON mp.id = n.modalidadPago_id
	LEFT JOIN ActividadEconomica ac ON ac.id = n.actividadEconomica_id
	LEFT JOIN Localidad l ON l.id = n.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	INNER JOIN Participante pa ON pa.id = n.participante_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = pa.id
	LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
	INNER JOIN Localidad l1 ON l1.id = jPadre.localidad_id
	LEFT JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id
	LEFT JOIN TipoEndoso te ON te.id = n.tipoEndoso_id
	WHERE n.anioCierre = @anio
		AND n.mesCierre BETWEEN @mesInicio
			AND @mesFin
		AND (
			@compania_id = 0
			OR n.compania_id = @compania_id
			)
		AND pa.segmento_id = @segmento_id
END