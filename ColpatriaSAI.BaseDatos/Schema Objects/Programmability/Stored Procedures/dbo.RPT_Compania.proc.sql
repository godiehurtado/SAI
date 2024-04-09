-- =============================================
-- Author:		<Enrique>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_Compania]
AS
	SET NOCOUNT ON;
SELECT     Compania.nombre AS Compania, Ramo.nombre AS RamoAgrupado, LTRIM(RTRIM(RamoDetalle.nombre)) + ' (' + RamoDetalle.codigoCore + ')' AS RamoDetalle, 
                      Producto.nombre AS ProductoAgrupado, ProductoDetalle.nombre + ' (' + ProductoDetalle.codigoCore + ')' AS ProductoDetalle, [Plan].nombre AS PlanAgrupado, 
                      PlanDetalle.nombre AS PlanDetalle
FROM         Compania LEFT JOIN
                      Ramo ON Ramo.compania_id = Compania.id LEFT OUTER JOIN
                      RamoDetalle ON RamoDetalle.ramo_id = Ramo.id AND RamoDetalle.compania_id = Compania.id LEFT JOIN
                      Producto ON Producto.ramo_id = Ramo.id LEFT OUTER JOIN
                      ProductoDetalle ON ProductoDetalle.producto_id = Producto.id AND ProductoDetalle.ramoDetalle_id = RamoDetalle.id LEFT JOIN
                      [Plan] ON [Plan].producto_id = Producto.id LEFT OUTER JOIN
                      PlanDetalle ON PlanDetalle.plan_id = [Plan].id AND PlanDetalle.productoDetalle_id = ProductoDetalle.id
WHERE     (Compania.id <> 0)
ORDER BY Compania, RamoAgrupado, ProductoAgrupado, PlanAgrupado
