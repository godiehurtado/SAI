-- =============================================
-- Author:		<Andrés Bravo>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_LiquidacionReglaGeneralEjecutivo] 
	
	@idLiquidacion as int
AS
BEGIN

	SET NOCOUNT ON;

	-- DECLARE @idLiquidacion as int = 157
	
    SELECT   lr.id as idLiquidacion
    , lr.fecha_liquidacion
    , p.id as idParticipante
    , RTRIM(LTRIM(p.nombre)) as nombre
    , RTRIM(LTRIM(p.apellidos)) as apellidos
    , jd.codigoNivel
    , sr.id as idSubRegla
    , RTRIM(LTRIM(sr.descripcion)) as SubRegla
    ,(CASE dlr.resultado WHEN 0 THEN 'No' ELSE 'Si'	END) as Gano
    , (CASE dlr.resultado WHEN 0 THEN '' ELSE Coalesce(lp.resultado, '') END)   as resultadoPremio
    , (CASE dlr.resultado WHEN 0 THEN '' ELSE Coalesce(pre.descripcion, '')	END)  as Premio
    , RTRIM(LTRIM(cat.nombre)) as nombreCategoria
	
	FROM         
	LiquidacionRegla AS lr
	INNER JOIN SubRegla AS sr ON lr.regla_id = sr.regla_id 
	INNER JOIN DetalleLiquidacionRegla AS dlr ON sr.id = dlr.subregla_id 
	INNER JOIN LiquidacionReglaxParticipante AS lrp ON lr.id = lrp.liquidacionRegla_id AND dlr.liquidacionReglaxParticipante_id = lrp.id
	INNER JOIN JerarquiaDetalle AS jd ON lrp.jerarquiaDetalle_id = jd.id
	INNER JOIN Participante AS p ON jd.participante_id = p.id
	INNER JOIN Categoria cat on cat.id = p.categoria_id
	LEFT JOIN PremioxSubregla ps ON ps.subregla_id = sr.id 
	LEFT JOIN LiquidacionPremio AS lp ON lrp.id = lp.liquidacionreglaxparticipante_id AND ps.premio_id = lp.premio_id
	LEFT JOIN Premio AS pre ON lp.premio_id = pre.id
	WHERE lr.id = @idLiquidacion
	ORDER BY jd.codigoNivel, idSubRegla, Gano DESC

END

