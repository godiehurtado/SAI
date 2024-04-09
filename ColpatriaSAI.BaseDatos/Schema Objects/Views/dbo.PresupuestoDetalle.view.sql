CREATE VIEW dbo.PresupuestoDetalle
AS
SELECT     /*ISNULL(presupuesto_id, 0) AS id,*/ ROW_NUMBER() OVER (ORDER BY presupuesto_id) AS id, presupuesto_id, nodo_id, nombreParticipante, nombreNivel, Anio, meta_id, 
nombreMeta, [1] AS Enero, [2] AS Febrero, [3] AS Marzo, [4] AS Abril, [5] AS Mayo, [6] AS Junio, [7] AS Julio, [8] AS Agosto, [9] AS Septiembre, [10] AS Octubre, [11] AS Noviembre, 
[12] AS Diciembre
FROM         (SELECT     DetallePresupuesto.presupuesto_id, JerarquiaDetalle.id AS nodo_id, JerarquiaDetalle.nombre AS nombreParticipante, 
                                              JerarquiaDetalle.codigoNivel AS nombreNivel, YEAR(DetallePresupuesto.fechaIni) AS Anio, Meta.id as meta_id, Meta.nombre AS nombreMeta, DetallePresupuesto.valor, 
                                              MONTH(DetallePresupuesto.fechaIni) AS Mes
                       FROM          dbo.DetallePresupuesto INNER JOIN
                                              dbo.JerarquiaDetalle ON DetallePresupuesto.jerarquiaDetalle_id = JerarquiaDetalle.id INNER JOIN
                                              dbo.Meta ON DetallePresupuesto.meta_id = Meta.id) AS tabla PIVOT (MAX(valor) FOR Mes IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS Detalle
