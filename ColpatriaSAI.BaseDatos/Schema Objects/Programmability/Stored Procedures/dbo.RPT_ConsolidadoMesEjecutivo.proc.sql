-- =============================================
-- Author:		Andres Bravo
-- Create date: 23/02/2012
-- Description:	Consulta que sirve como origen de datos al reporte de Consolidado Mes Ejecutivo
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ConsolidadoMesEjecutivo]
(
	@anio INT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		jd.codigoNivel,
		c.nombre as compania,
		r.nombre as ramo,
		p.nombre as producto,
		n.nombre as nivel,
		cat.nombre as categoria,
		can.nombre as canal,
		mes,
		anio,
		personasACargo,
		personasACargoVenden,
		numeroNegocios,
		primaTotal,
		promedioPrimas,
		totalColquines,
		totalRecaudos,
		promedioNegocios,
		colquinesDescontarPV,
		RecaudosDescontarPV,
		ColquinesDescontarPC,
		RecaudosDescontarPC,
		ColquinesDescontarS,
		RecaudosDescontarS
	FROM ConsolidadoMesEjecutivo as cme
	INNER JOIN jerarquiaDetalle as jd ON cme.jerarquiaDetalle_id = jd.id
	INNER JOIN compania as c ON cme.compania_id = c.id
	INNER JOIN ramo as r ON cme.ramo_id = r.id
	INNER JOIN producto as p ON cme.producto_id = p.id
	INNER JOIN nivel as n ON cme.nivel_id = n.id
	INNER JOIN categoria as cat ON cme.categoria_id = cat.id
	INNER JOIN canal as can ON cme.canal_id = can.id
	WHERE
		cme.anio = @anio
	ORDER BY 
		jd.codigoNivel,
		c.nombre,
		r.nombre,
		p.nombre,
		n.nombre,
		cme.mes		
END