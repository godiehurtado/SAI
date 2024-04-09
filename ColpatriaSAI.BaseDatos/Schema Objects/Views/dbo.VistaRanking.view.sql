CREATE VIEW dbo.VistaRanking
AS
SELECT 
	sub1.*,
	ROW_NUMBER() OVER (PARTITION BY sub1.categoria, sub1.anio, sub1.mes ORDER BY sub1.totalEvaluado DESC) as posicionRanking
FROM	
(
	SELECT 	 
		jd.id as jerarquiaDetalle_id,
		jd.nombre as jerarquia,
		COALESCE(c.nombre,'Sin Categoria') as categoria, 
		p.nombre + ' ' + p.apellidos as participante,
		l.nombre as localidad,
		YEAR(lc.fechaIni) as anio,
		MONTH(lc.fechaFin) as mes,		
		lcfp.notaDefinitiva as totalEvaluado
	FROM liquidacioncontratacion as lc
	INNER JOIN Liquicontratfactorparticipante as lcfp ON lc.id = lcfp.liqui_contrat_id
	INNER JOIN jerarquiaDetalle as jd ON lcfp.jerarquiaDetalle_id = jd.id
	INNER JOIN participante as p ON jd.participante_id = p.id
	INNER JOIN localidad as l ON jd.localidad_id = l.id
	LEFT JOIN categoria as c ON p.categoria_id = c.id
    WHERE lc.estado = 1	  
) as sub1	
