-- =============================================
-- Author:		<Enrique Gonzalez Araujo>
-- Create date: <29/11/2011>
-- Description:	<Store procedure para la generacion de los reportes para sai
-- =============================================
CREATE PROCEDURE [dbo].[ReporteLiquidacionFranquicias]
	
	@Compania_id NVARCHAR(200) = NULL,
	@Localidad_id NVARCHAR(200) = NULL,
	@ID int 

	

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Insert statements for procedure here
-- Modificación QUERY - Juan Pablo Ruiz - 2011-12-05		

SELECT	LiquidacionFranquicia.id, LiquidacionFranquicia.fechaLiquidacion, LiquidacionFranquicia.periodoLiquidacionIni, 
LiquidacionFranquicia.periodoLiquidacionFin, dlf.porcentajeParticipacion, dlf.totalParticipacion, 
l.nombre AS localidad, dlf.localidad_id, dlf.compania_id, c.nombre AS compania, dlf.ramo_id, r.nombre AS ramo, 
p.nombre AS producto, p.producto_id, dlf.valorRecaudo, dlf.numeroNegocio, dlf.nivelDirector, 
dlf.claveParticipante, mp.nombre AS modalidadpago, dlf.modalidadPagoId, dlf.numeroRecibo, 
dlf.fechaRecaudo, dlf.fechaContabl, dlf.amparo_Id, dlf.colquines, dlf.lineaNegocio_id, z.nombre AS zona, 
dlf.zona_id, dlf.codigo_agrupador, TipoVehiculo.nombre as TipoVehiculo, Amparo.nombre AS Amparo, 
LTRIM(RTRIM(Participante.nombre)) + ' ' + LTRIM(RTRIM(Participante.apellidos)) as Participante,
dlf.concepto as Concepto, dlf.altura, 
CASE dlf.liquidadoPor 
	WHEN 1 THEN 'Excepciones' 
	WHEN 2 THEN 'Participacion' 
	WHEN 3 THEN 'Rangos' 
	WHEN 4 THEN 'Especiales' 
	ELSE 'Sin Liquidar'
END as liquidadoPor,
Coalesce(s.nombre, '') as Segmento		
FROM LiquidacionFranquicia 
INNER JOIN DetalleLiquidacionFranquicia AS dlf ON dlf.liquidacionFranquicia_id = LiquidacionFranquicia.id 
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
WHERE  dlf.compania_id IN (SELECT Item FROM   SPLIT(@Compania_id, ','))
AND dlf.Localidad_id IN (SELECT Item FROM   SPLIT(@Localidad_id, ','))
AND (LiquidacionFranquicia.id = @ID)
ORDER BY localidad_id

	    END