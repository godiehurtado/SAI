CREATE VIEW dbo.PresupuestoEjecucionDetalle
AS
SELECT ROW_NUMBER() OVER (ORDER BY presupuesto_id) AS id, presupuesto_id, nodo_id, nombreParticipante, nombreNivel, Anio, 
meta_id, nombreMeta, nombreCanal,[1] AS Enero, [2] AS Febrero, [3] AS Marzo, [4] AS Abril, [5] AS Mayo, [6] AS Junio, [7] AS Julio, [8] AS Agosto, [9] AS Septiembre, [10] AS Octubre, 
[11] AS Noviembre, [12] AS Diciembre
FROM         
(
	SELECT     
		e.presupuesto_id, 
		JerarquiaDetalle.id AS nodo_id, 
		JerarquiaDetalle.nombre AS nombreParticipante, 
		JerarquiaDetalle.codigoNivel AS nombreNivel,                                               
        YEAR(ed.periodo) AS Anio, 
        Meta.id AS meta_id, 
        Meta.nombre AS nombreMeta, 
        ed.valor AS valor, 
        MONTH(ed.periodo) AS Mes,
        Canal.nombre as nombreCanal
    FROM
		Ejecucion AS e 
		INNER JOIN EjecucionDetalle AS ed ON e.id = ed.ejecucion_id 
		INNER JOIN JerarquiaDetalle ON ed.nodo_id = JerarquiaDetalle.id 
		INNER JOIN Meta ON ed.meta_id = Meta.id
		INNER JOIN Canal ON ed.canal_id = Canal.id
) AS tabla PIVOT (MAX(valor) FOR Mes IN ([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS Detalle
