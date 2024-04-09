CREATE PROCEDURE [dbo].[RPT_LogErroresNegocio]
(
	@compania_id INT
)
AS
BEGIN
	SELECT
		nte.ErrorColumnName
		, nte.ErrorColumnCode
		, c.nombre AS companiaNombre
		, c.codigoCore AS companiaCore
		, r.nombre AS ramoNombre
		, r.codigoCore AS ramoCore
		, p.nombre AS productoNombre
		, p.codigoCore AS productoCore
		, ln.nombre AS lineaNegocioNombre
		, ln.codigoCore AS lineaNegocioCore
		, pl.nombre AS planNombre
		, pl.codigoCore AS planCore
		, nte.numeroNegocio
		, nte.fechaExpedicion
		, nte.estadoNegocio_id
		, nte.numeroSolicitud
		, nte.valorPrimaTotal
		, nte.identificacionSuscriptor
		, l.nombre AS nombreLocalidad
		, nte.clave
		, nte.porcentajeParticipacion
		, nte.grupoEndoso_id
		, nte.tipoVehiculo
		, nte.sistema
		, nte.amparo_id
		, nte.modalidadPago_id
		, nte.cobertura_id
		, nte.codigoAgrupador
		, nte.fechaGrabacion
		, nte.tipoEndoso_id
		, nte.valorAsegurado
		, nte.valorAhorro
		, nte.valorPrimaPensiones
		, nte.valorProteccion
	FROM NegociostempError nte
		INNER JOIN Compania c ON c.id = CAST(nte.compania_id AS INT)
		INNER JOIN RamoDetalle r ON r.id = CAST(nte.ramo_id AS INT)
		INNER JOIN ProductoDetalle p ON p.id = CAST(nte.producto_id AS INT)
		INNER JOIN LineaNegocio ln ON ln.id = CAST(nte.lineaNegocio_id AS INT)
		INNER JOIN PlanDetalle pl ON pl.id = CAST(nte.plan_id AS INT)
		INNER JOIN Localidad l ON l.id = nte.localidad_id
	WHERE
		c.id = @compania_id
END