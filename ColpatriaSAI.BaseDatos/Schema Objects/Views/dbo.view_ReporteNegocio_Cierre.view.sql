CREATE VIEW [dbo].[view_ReporteNegocio_Cierre]
AS
SELECT c.id AS compania_id
	,c.nombre AS Compania
	,z.id AS zona_id
	,z.nombre AS zonaNombre
	,l.id AS localidad_id
	,l.nombre AS Localidad
	,jPadre.id AS jPadre_id
	,jPadre.nombre AS Director
	,pa.id AS participante_id
	,RTRIM(LTRIM(n.clave)) AS Clave
	,ca.id AS Canal_id
	,ca.nombre AS Canal
	,LTRIM(RTRIM(pa.nombre)) + ' ' + LTRIM(RTRIM(pa.apellidos)) AS nombreParticipante
	,n.porcentajeParticipacion
	,ln.id AS lineaNegocio_id
	,ln.nombre AS LineaNegocio
	,s.id AS segmento_id
	,s.nombre AS Segmento
	,r.id AS ramo_id
	,r.nombre AS Ramo
	,p.id AS producto_id
	,p.nombre AS Producto
	,pd.id AS plan_id
	,pd.nombre AS [Plan]
	,a.id AS amparo_id
	,a.nombre AS Amparo
	,co.nombre AS Cobertura
	,mp.id AS modalidadPago_id
	,mp.nombre AS ModalidadPago
	,pla.id AS plazo_id
	,pla.nombre AS plazoNombre
	,CAST(n.numeroNegocio AS BIGINT) AS numeroNegocio
	,n.estadoNegocio
	,n.valorAhorro
	,n.valorProteccion
	,n.valorPrimaPensiones
	,n.valorPrimaTotal
	,ge.estadoReal
	,n.mesCierre
	,n.anioCierre
	,CAST(n.fechaExpedicion AS DATE) AS fechaExpedicion
	,CAST(n.fechaGrabacion AS DATE) AS fechaGrabacion
	,CAST(n.fechaCancelacion AS DATE) AS fechaCancelacion
	,n.identificacionSuscriptor AS cedulaCliente
	,n.nombreSuscriptor AS nombreCliente
	,ac.id AS actividadEconomica_id
	,ac.nombre AS ActividadEconomica
	,n.codigoAgrupador
	,ge.id AS grupoEndoso_id
	,ge.nombre AS grupoEndoso
	,te.id AS tipoEndoso_id
	,te.nombre AS tipoEndoso
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
INNER JOIN Participante pa ON pa.id = n.participante_id
INNER JOIN Canal ca ON ca.id = pa.canal_id
INNER JOIN Localidad l ON l.id = pa.localidad_id
INNER JOIN Zona z ON z.id = l.zona_id
LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = pa.id
LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
LEFT JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id
LEFT JOIN TipoEndoso te ON te.id = n.tipoEndoso_id