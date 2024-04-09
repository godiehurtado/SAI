-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ObtenerRangosLiquidacionFranquicia]
	-- Add the parameters for the stored procedure here
	@idLiquidacion as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- TRAEMOS LOS RANGOS DE PORCENTAJES PARA LOS DETALLES DE LA LIQUIDACION
	SELECT dpf.id, dpf.compania_id, 
	dpf.ramo_id, 
	dpf.producto_id, 
	dpf.porcentaje, 
	dpf.rangoinferior, 
	dpf.rangosuperior, 
	dpf.plan_id, 
	dpf.lineaNegocio_id, 
	dpf.tipoVehiculo_id, 
	dpf.amparo_id, 
	dpf.part_franquicia_id 
	FROM 
	(
		SELECT min(fechaContabl) as minFechaContab, max(fechaContabl) as maxFechaContab, compania_id, ramo_id_agrupado, producto_id_agrupado
		FROM DetalleLiquidacionFranquicia as dlfTemp
		WHERE 
			dlfTemp.liquidacionFranquicia_id = @idLiquidacion AND 
			(dlfTemp.liquidadoPor = 2 OR dlfTemp.liquidadoPor = 0)
		GROUP BY compania_id, ramo_id_agrupado, producto_id_agrupado				
	) as dlf
	INNER JOIN DetallePartFranquicia as dpf ON dlf.compania_id = dpf.compania_id AND dlf.ramo_id_agrupado = dpf.ramo_id AND dlf.producto_id_agrupado = dpf.producto_id
	INNER JOIN ParticipacionFranquicia as pf ON dpf.part_franquicia_id = pf.id
	WHERE 
	dpf.rangoinferior is not null AND 
	dpf.rangosuperior is not null
	group by dpf.id, dpf.compania_id, 
	dpf.ramo_id, 
	dpf.producto_id, 
	dpf.porcentaje, 
	dpf.rangoinferior, 
	dpf.rangosuperior, 
	dpf.plan_id, 
	dpf.lineaNegocio_id, 
	dpf.tipoVehiculo_id, 
	dpf.amparo_id, 
	dpf.part_franquicia_id 

END
