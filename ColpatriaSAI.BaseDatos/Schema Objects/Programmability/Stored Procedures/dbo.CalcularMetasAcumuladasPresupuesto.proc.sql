-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcularMetasAcumuladasPresupuesto]
	-- Add the parameters for the stored procedure here
	@presupuestoId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @presupuesto_id int = @presupuestoId

	UPDATE ProcesoLiquidacion SET estadoProceso_id = 9 WHERE tipo=4 AND liquidacion_id=@presupuesto_id

	-- BORRAMOS TABLAS NECESARIAS
	DELETE FROM dp FROM DetallePresupuesto as dp INNER JOIN Meta as m ON dp.meta_id = m.id WHERE dp.presupuesto_id = @presupuesto_id AND m.meta_id is not null

	INSERT INTO DetallePresupuesto(fechaIni, fechaFin, valor, meta_id, presupuesto_id, jerarquiaDetalle_id)
	SELECT 
		dp.fechaIni, dp.fechaFin, 
		(
			SELECT sum(valor) 
			FROM detallePresupuesto 
			WHERE fechaIni <= dp.fechaIni and meta_id = dp.meta_id and jerarquiaDetalle_id = dp.jerarquiaDetalle_id  AND presupuesto_id = @presupuesto_id
		) as acumuladoTotal,
		m.id, 
		dp.presupuesto_id,
		dp.jerarquiaDetalle_id
	FROM detallePresupuesto as dp
	INNER JOIN meta as m ON dp.meta_id = m.meta_id
	WHERE m.meta_id is not null and dp.presupuesto_id = @presupuesto_id
	ORDER BY dp.meta_id, dp.jerarquiaDetalle_id	
	
	RETURN 1
			
END
