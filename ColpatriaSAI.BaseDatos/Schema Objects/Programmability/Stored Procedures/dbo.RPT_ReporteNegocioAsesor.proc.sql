
-- =============================================
-- Author:		<Juan Pablo Ruiz>
-- Create date: <14/02/2012>
-- Description:	Reporte detallado de negocios de un asesor
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ReporteNegocioAsesor] (
	@fechaInicio SMALLDATETIME
	,@fechaFin SMALLDATETIME
	,@compania_id INT
	,@ramo_id INT
	,@plazo_id INT
	,@producto_id INT
	,@clave NVARCHAR(500)
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

	DECLARE @fechaInicioTemp SMALLDATETIME = @fechaInicio
		,@fechaFinTemp SMALLDATETIME = @fechaFin
		,@compania_idTemp INT = @compania_id
		,@ramo_idTemp INT = @ramo_id
		,@plazo_idTemp INT = @plazo_id
		,@producto_idTemp INT = @producto_id
		,@claveTemp NVARCHAR(500) = @clave
		,@lineaNegocio_idTemp INT = @lineaNegocio_id
		,@amparo_idTemp INT = @amparo_id
		,@modalidadPago_idTemp INT = @modalidadPago_id
		,@zona_idTemp INT = @zona_id
		,@localidad_idTemp INT = @localidad_id
		,@numeroNegocioTemp AS NVARCHAR(250) = @numeroNegocio

	SELECT vn.Compania AS Compania
		,vn.zonaNombre AS zonaNombre
		,vn.Localidad AS Localidad
		,vn.Director AS Director
		,vn.clave AS Clave
		,vn.nombreParticipante AS nombreParticipante
		,vn.porcentajeParticipacion
		,vn.LineaNegocio AS LineaNegocio
		,vn.Segmento AS Segmento
		,vn.Ramo AS Ramo
		,vn.Producto AS Producto
		,vn.[Plan] AS [Plan]
		,vn.Amparo AS Amparo
		,vn.Cobertura AS Cobertura
		,vn.ModalidadPago AS ModalidadPago
		,vn.plazoNombre AS plazoNombre
		,vn.numeroNegocio AS numeroNegocio
		,vn.estadoNegocio
		,vn.valorAhorro
		,vn.valorProteccion
		,vn.valorPrimaPensiones
		,vn.valorPrimaTotal
		,vn.mesCierre
		,vn.anioCierre
		,vn.fechaExpedicion AS fechaExpedicion
		,vn.fechaGrabacion AS fechaGrabacion
		,vn.fechaCancelacion AS fechaCancelacion
		,vn.cedulaCliente AS cedulaCliente
		,vn.nombreCliente AS nombreCliente
		,vn.ActividadEconomica AS ActividadEconomica
		,vn.codigoAgrupador
		,vn.grupoEndoso AS grupoEndoso
		,vn.tipoEndoso AS tipoEndoso
	FROM view_ReporteNegocioAsesor vn
	WHERE vn.fechaExpedicion BETWEEN @fechaInicioTemp
			AND @fechaFinTemp
		AND vn.compania_id = @compania_idTemp
		AND (
			@ramo_idTemp = 0
			OR vn.ramo_id = @ramo_idTemp
			)
		AND (
			@plazo_idTemp = 0
			OR vn.plazo_id = @plazo_idTemp
			)
		AND (
			@producto_idTemp = 0
			OR vn.producto_id = @producto_idTemp
			)
		AND vn.clave LIKE ISNULL(@claveTemp, vn.clave)
		AND vn.numeroNegocio LIKE ISNULL(@numeroNegocioTemp, vn.numeroNegocio)
		AND (
			@lineaNegocio_idTemp = 0
			OR vn.lineaNegocio_id = @lineaNegocio_idTemp
			)
		AND (
			@amparo_idTemp = 0
			OR vn.amparo_id = @amparo_idTemp
			)
		AND (
			@modalidadPago_idTemp = 0
			OR vn.modalidadPago_id = @modalidadPago_idTemp
			)
		AND (
			@zona_idTemp = 0
			OR vn.zona_id = @zona_idTemp
			)
		AND (
			@localidad_idTemp = 0
			OR vn.localidad_id = @localidad_idTemp
			)
END