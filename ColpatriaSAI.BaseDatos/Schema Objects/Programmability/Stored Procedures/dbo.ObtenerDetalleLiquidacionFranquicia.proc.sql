-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ObtenerDetalleLiquidacionFranquicia] 
	-- Add the parameters for the stored procedure here
	@idLiquidacion as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- OBTENEMOS TODO EL DETALLE DE LA LIQUIDACION PARA DETERMINAR SI SE PUEDEN LIQUIDAR POR RANGOS
	SELECT id, porcentajeParticipacion, totalParticipacion, liquidacionFranquicia_id, localidad_id, compania_id, ramo_id, producto_id, valorRecaudo, numeroNegocio, 
                      nivelDirector, claveParticipante, modalidadPagoId, numeroRecibo, fechaRecaudo, fechaContabl, amparo_Id, colquines, lineaNegocio_id, zona_id, codigo_agrupador, 
                      tipoVehiculo, liquidadoPor, ramo_id_agrupado, producto_id_agrupado
	FROM DetalleLiquidacionFranquicia
	WHERE liquidacionFranquicia_id = @idLiquidacion AND (liquidadoPor = 2 OR liquidadoPor = 0)
END
