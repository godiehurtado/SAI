CREATE VIEW view_NegocioConsolidado
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
	,'Todos' AS Amparo
	,'Todas' AS Cobertura
	,mp.id AS modalidadPago_id
	,mp.nombre AS ModalidadPago
	,pla.id AS plazo_id
	,pla.nombre AS plazoNombre
	,CAST(n.numeroNegocio AS BIGINT) AS numeroNegocio
	,n.estadoNegocio
	,SUM(n.valorAhorro) AS valorAhorro
	,SUM(n.valorProteccion) AS valorProteccion
	,SUM(n.valorPrimaPensiones) AS valorPrimaPensiones
	,SUM(n.valorPrimaTotal) AS valorPrimaTotal
	,n.mesCierre
	,n.anioCierre
	,CAST(MAX(n.fechaExpedicion) AS DATE) AS fechaExpedicion
	,CAST(MAX(n.fechaGrabacion) AS DATE) AS fechaGrabacion
	,CAST(MAX(n.fechaCancelacion) AS DATE) AS fechaCancelacion
	,n.identificacionSuscriptor AS cedulaCliente
	,n.nombreSuscriptor AS nombreCliente
	,ac.id AS actividadEconomica_id
	,ac.nombre AS ActividadEconomica
	,n.codigoAgrupador
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
INNER JOIN Localidad l ON l.id = pa.localidad_id
INNER JOIN Zona z ON z.id = l.zona_id
LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = pa.id
LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
GROUP BY YEAR(n.fechaExpedicion)
	,MONTH(n.fechaExpedicion)
	,c.id
	,c.nombre
	,r.id
	,r.nombre
	,p.id
	,p.nombre
	,n.numeroNegocio
	,l.id
	,l.nombre
	,n.clave
	,pd.id
	,pd.nombre
	,ln.id
	,ln.nombre
	,n.identificacionSuscriptor
	,n.nombreSuscriptor
	,s.id
	,s.nombre
	,mp.id
	,mp.nombre
	,n.porcentajeParticipacion
	,ac.id
	,ac.nombre
	,n.estadoNegocio
	,n.codigoAgrupador
	,jPadre.id
	,jPadre.nombre
	,pa.id
	,pa.nombre
	,pa.apellidos
	,z.id
	,z.nombre
	,pla.id
	,pla.nombre
	,n.mesCierre
	,n.anioCierre