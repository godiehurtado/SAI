-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 16/04/2012
-- Description:	Procedimiento almacenado que da origen a los reportes de liquidación por franquicias usado en la ETL de generación de archivos en csv
-- =============================================
CREATE PROCEDURE [dbo].[ReporteLiquidacionFranquicias_etl]
(
	@liquidacionFranquicia_id INT,
	@localidad_id INT
)
AS
BEGIN
	SET NOCOUNT ON;		
	        
	SELECT
		lf.id
		, lf.fechaLiquidacion
		, lf.periodoLiquidacionIni
		, lf.periodoLiquidacionFin
		, dlf.porcentajeParticipacion
		, dlf.totalParticipacion
		, l.nombre AS localidad
		, dlf.localidad_id
		, dlf.compania_id
		, c.nombre AS compania
		, dlf.ramo_id
		, r.nombre AS ramo
		, p.nombre AS producto
		, p.producto_id
		, dlf.valorRecaudo
		, dlf.numeroNegocio
		, dlf.nivelDirector
		, dlf.claveParticipante
		, mp.nombre AS modalidadpago
		, dlf.modalidadPagoId
		, dlf.numeroRecibo
		, dlf.fechaRecaudo
		, dlf.fechaContabl
		, dlf.amparo_Id
		, dlf.colquines
		, dlf.lineaNegocio_id
		, z.nombre AS zona
		, dlf.zona_id
		, dlf.codigo_agrupador
		, TipoVehiculo.nombre AS TipoVehiculo
		, Amparo.nombre AS Amparo
		, LTRIM(RTRIM(Participante.nombre)) + ' ' + LTRIM(RTRIM(Participante.apellidos)) AS Participante
		, dlf.concepto AS Concepto
		, dlf.altura
		, CASE dlf.liquidadoPor 
			WHEN 1 THEN 'Excepciones' 
			WHEN 2 THEN 'Participacion' 
			WHEN 3 THEN 'Rangos' 
			WHEN 4 THEN 'Especiales' 
			ELSE 'Sin Liquidar'
		END as liquidadoPor,
		Coalesce(s.nombre, '') as Segmento		
	FROM LiquidacionFranquicia lf
		INNER JOIN DetalleLiquidacionFranquicia AS dlf ON dlf.liquidacionFranquicia_id = lf.id 
		INNER JOIN Compania AS c ON dlf.compania_id = c.id 
		INNER JOIN RamoDetalle AS r ON dlf.ramo_id = r.id 
		INNER JOIN ProductoDetalle AS p ON dlf.producto_id = p.id 
		LEFT JOIN Amparo ON dlf.amparo_Id = Amparo.id 
		LEFT JOIN Zona AS z ON dlf.zona_id = z.id 
		LEFT JOIN Localidad AS l ON dlf.localidad_id = l.id 
		LEFT JOIN ModalidadPago AS mp ON dlf.modalidadPagoId = mp.id
		LEFT JOIN Participante ON Participante.clave = dlf.claveParticipante
		LEFT JOIN TipoVehiculo ON TipoVehiculo.id = dlf.tipoVehiculo
		LEFT JOIN Segmento as s ON s.id = dlf.segmento_id
	WHERE
		lf.id = @liquidacionFranquicia_id
		AND dlf.Localidad_id = @localidad_id
	ORDER BY localidad_id
END