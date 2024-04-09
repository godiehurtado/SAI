CREATE PROCEDURE [dbo].[RPT_LogErroresRecaudo]
(
	@compania_id INT
)
AS
BEGIN
	SELECT
		rte.ErrorColumnName
		, rte.ErrorColumnCode
		, c.nombre AS companiaNombre
		, c.codigoCore AS companiaCore
		, rd.nombre AS ramoNombre
		, rd.codigoCore AS ramoCore
		, p.nombre AS productoNombre
		, p.codigoCore AS productoCore
		, ln.nombre AS lineaNegocioNombre
		, ln.codigoCore AS lineaNegocioCore
		, pl.nombre AS planNombre
		, pl.codigoCore AS planCore
		, rte.numeroNegocio
		, rte.fechaRecaudo
		, rte.valorRecaudo
		, rte.numeroRecibo
		, l.nombre AS nombreLocalidad
		, rte.clave
		, rte.porcentajeParticipacion
		, rte.sistema
		, rte.amparo_id
		, rte.modalidadPago_id
		, rte.cobertura_id
		, rte.fechaGrabacion
		, rte.fechaCobranza
		, rte.localidad_id
		, rte.red_id
	FROM RecaudostempError rte
		LEFT JOIN Compania c ON c.id = CAST(rte.compania_id AS INT)
		LEFT JOIN RamoDetalle rd ON rd.id = CAST(rte.ramo_id AS INT)
		LEFT JOIN ProductoDetalle p ON p.id = CAST(rte.producto_id AS INT)
		LEFT JOIN LineaNegocio ln ON ln.id = CAST(rte.lineaNegocio_id AS INT)
		LEFT JOIN PlanDetalle pl ON pl.id = CAST(rte.plan_id AS INT)
		LEFT JOIN Localidad l ON l.id = rte.localidad_id
	WHERE
		c.id = @compania_id
END