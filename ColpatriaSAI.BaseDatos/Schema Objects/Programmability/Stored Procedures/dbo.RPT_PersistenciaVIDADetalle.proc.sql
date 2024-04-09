-- =============================================
-- Author:		Juan Fernando Rojas Moreno
-- Create date: 19/12/2012
-- Description:	Reporte detallado de base negocios utilizado para el calculo 
--				de la persistencia de VIDA.			
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PersistenciaVIDADetalle] (
	@clave NVARCHAR(500)
	,@canal_id INT
	,@lineaNegocio_id INT
	,@zona_id INT
	,@localidad_id INT
	,@numeroNegocio AS NVARCHAR(250)
	)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @claveTemp NVARCHAR(500) = @clave
		,@canal_idTemp INT = @canal_id
		,@lineaNegocio_idTemp INT = @lineaNegocio_id
		,@zona_idTemp INT = @zona_id
		,@localidad_idTemp INT = @localidad_id
		,@numeroNegocioTemp AS NVARCHAR(250) = @numeroNegocio

	SELECT pvd.Compania AS Compania
		,pvd.zonaNombre AS zonaNombre
		,pvd.Localidad AS Localidad
		,pvd.Director AS Director
		,pvd.Clave AS Clave
		,pvd.Canal AS Canal
		,pvd.nombreParticipante AS nombreParticipante
		,pvd.porcentajeParticipacion
		,pvd.LineaNegocio AS LineaNegocio
		,pvd.Segmento AS Segmento
		,pvd.Ramo AS Ramo
		,pvd.Producto AS Producto
		,pvd.[Plan] AS [Plan]
		,pvd.Amparo AS Amparo
		,pvd.Cobertura AS Cobertura
		,pvd.ModalidadPago AS ModalidadPago
		,pvd.plazoNombre AS plazoNombre
		,pvd.numeroNegocio AS numeroNegocio
		,pvd.estadoNegocio
		,pvd.valorAhorro
		,pvd.valorProteccion
		,pvd.valorPrimaPensiones
		,pvd.valorPrimaTotal
		,pvd.mesCierre
		,pvd.anioCierre
		,pvd.fechaExpedicion AS fechaExpedicion
		,pvd.fechaGrabacion AS fechaGrabacion
		,pvd.fechaCancelacion AS fechaCancelacion
		,pvd.cedulaCliente AS cedulaCliente
		,pvd.nombreCliente AS nombreCliente
		,pvd.ActividadEconomica AS ActividadEconomica
		,pvd.codigoAgrupador
		,pvd.grupoEndoso AS grupoEndoso
		,pvd.tipoEndoso AS tipoEndoso
		,(
			CASE 
				WHEN pvd.estadoReal = 'V'
					THEN 'Vigente'
				ELSE CASE 
						WHEN pvd.estadoReal = 'NV'
							THEN 'No Vigente'
						ELSE 'NA'
						END
				END
			) AS estadoReal
		,(
			CASE 
				WHEN pvd.claseEndoso = 1
					THEN 'Expedición'
				ELSE CASE 
						WHEN pvd.claseEndoso = 2
							THEN 'Cancelación'
						ELSE 'NA'
						END
				END
			) AS claseEndoso
	FROM PersistenciaVIDADetalle pvd
	WHERE pvd.clave LIKE ISNULL(@claveTemp, pvd.clave)
		AND (
			@canal_idTemp = 0
			OR pvd.Canal_id = @canal_idTemp
			)
		AND (
			@zona_idTemp = 0
			OR pvd.zona_id = @zona_idTemp
			)
		AND (
			@localidad_idTemp = 0
			OR pvd.localidad_id = @localidad_idTemp
			)
	ORDER BY pvd.anioCierre
		,pvd.mesCierre
END
