-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 18/05/2012
-- Description:	Reporte detallado de negocios de un asesor por fecha de cierre
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ReporteNegocio_Cierre] (
	@anio INT
	,@mesInicio INT
	,@mesFin INT
	,@compania_id INT
	,@ramo_id INT
	,@plazo_id INT
	,@producto_id INT
	,@clave NVARCHAR(500)
	,@canal_id INT
	,@lineaNegocio_id INT
	,@amparo_id INT
	,@modalidadPago_id INT
	,@zona_id INT
	,@localidad_id INT
	,@numeroNegocio AS NVARCHAR(250)
	)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @anioTemp INT = @anio
		,@mesInicioTemp INT = @mesInicio
		,@mesFinTemp INT = @mesFin
		,@compania_idTemp INT = @compania_id
		,@ramo_idTemp INT = @ramo_id
		,@plazo_idTemp INT = @plazo_id
		,@producto_idTemp INT = @producto_id
		,@claveTemp NVARCHAR(500) = @clave
		,@canal_idTemp INT = @canal_id
		,@lineaNegocio_idTemp INT = @lineaNegocio_id
		,@amparo_idTemp INT = @amparo_id
		,@modalidadPago_idTemp INT = @modalidadPago_id
		,@zona_idTemp INT = @zona_id
		,@localidad_idTemp INT = @localidad_id
		,@numeroNegocioTemp AS NVARCHAR(250) = @numeroNegocio

	SELECT vr.Compania AS Compania
		,vr.zonaNombre AS zonaNombre
		,vr.Localidad AS Localidad
		,vr.Director AS Director
		,vr.Clave AS Clave
		,vr.Canal AS Canal
		,vr.nombreParticipante AS nombreParticipante
		,vr.porcentajeParticipacion
		,vr.LineaNegocio AS LineaNegocio
		,vr.Segmento AS Segmento
		,vr.Ramo AS Ramo
		,vr.Producto AS Producto
		,vr.[Plan] AS [Plan]
		,vr.Amparo AS Amparo
		,vr.Cobertura AS Cobertura
		,vr.ModalidadPago AS ModalidadPago
		,vr.plazoNombre AS plazoNombre
		,vr.numeroNegocio AS numeroNegocio
		,vr.estadoNegocio
		,vr.valorAhorro
		,vr.valorProteccion
		,vr.valorPrimaPensiones
		,vr.valorPrimaTotal
		,vr.estadoReal
		,vr.mesCierre
		,vr.anioCierre
		,vr.fechaExpedicion AS fechaExpedicion
		,vr.fechaGrabacion AS fechaGrabacion
		,vr.fechaCancelacion AS fechaCancelacion
		,vr.cedulaCliente AS cedulaCliente
		,vr.nombreCliente AS nombreCliente
		,vr.ActividadEconomica AS ActividadEconomica
		,vr.codigoAgrupador
		,vr.grupoEndoso AS grupoEndoso
		,vr.tipoEndoso AS tipoEndoso
	FROM view_ReporteNegocio_Cierre vr
	WHERE vr.anioCierre = @anioTemp
		AND vr.mesCierre BETWEEN @mesInicioTemp
			AND @mesFinTemp
		AND vr.compania_id = @compania_idTemp
		AND (
			@ramo_idTemp = 0
			OR vr.ramo_id = @ramo_idTemp
			)
		AND (
			@plazo_idTemp = 0
			OR vr.plazo_id = @plazo_idTemp
			)
		AND (
			@producto_idTemp = 0
			OR vr.producto_id = @producto_idTemp
			)
		AND vr.clave LIKE ISNULL(@claveTemp, vr.clave)
		AND (
			@canal_idTemp = 0
			OR vr.Canal_id = @canal_idTemp
			)
		AND vr.numeroNegocio LIKE ISNULL(@numeroNegocioTemp, vr.numeroNegocio)
		AND (
			@lineaNegocio_idTemp = 0
			OR vr.lineaNegocio_id = @lineaNegocio_idTemp
			)
		AND (
			@amparo_idTemp = 0
			OR vr.amparo_id = @amparo_idTemp
			)
		AND (
			@modalidadPago_idTemp = 0
			OR vr.modalidadPago_id = @modalidadPago_idTemp
			)
		AND (
			@zona_idTemp = 0
			OR vr.zona_id = @zona_idTemp
			)
		AND (
			@localidad_idTemp = 0
			OR vr.localidad_id = @localidad_idTemp
			)
	ORDER BY vr.clave
END