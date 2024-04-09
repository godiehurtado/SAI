-- =============================================
-- Author:		<Andrés Bravo>
-- Create date: <Create Date,,>
-- Description:	<Description,,> 3394949 2910
-- =============================================
CREATE PROCEDURE [dbo].[RPT_LiquidacionReglaGeneral] 
	
	@idLiquidacion as int
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @idLiquidacionTemp as int
	SET @idLiquidacionTemp =  @idLiquidacion
	
    SELECT   lr.id as idLiquidacion
    , lr.fecha_liquidacion
    , p.id as idParticipante
    , RTRIM(LTRIM(p.clave)) as clave
    , RTRIM(LTRIM(p.nombre)) as nombre
    , RTRIM(LTRIM(p.apellidos)) as apellidos
    , sr.id as idSubRegla
    , RTRIM(LTRIM(sr.descripcion)) as SubRegla
    ,(CASE dlr.resultado WHEN 0 THEN 'No' ELSE 'Si'	END) as Gano
    , (CASE dlr.resultado WHEN 0 THEN '' ELSE Coalesce(lp.resultado, '') END)   as resultadoPremio
    , (CASE dlr.resultado WHEN 0 THEN '' ELSE Coalesce(pre.descripcion, '')	END)  as Premio
    , RTRIM(LTRIM(cat.nombre)) as nombreCategoria
	
	FROM LiquidacionRegla AS lr 
		INNER JOIN LiquidacionReglaxParticipante AS lrp ON lr.id = lrp.liquidacionRegla_id AND lrp.liquidacionRegla_id = @idLiquidacionTemp
		INNER JOIN DetalleLiquidacionRegla AS dlr ON lrp.id = dlr.liquidacionReglaxParticipante_id
		INNER JOIN SubRegla AS sr ON sr.id = dlr.subregla_id
		INNER JOIN Participante AS p ON p.id = lrp.participante_id
		INNER JOIN Categoria cat on cat.id = p.categoria_id
		LEFT JOIN PremioxSubregla ps ON ps.subregla_id = sr.id
		LEFT JOIN Premio AS pre ON ps.premio_id = pre.id
		LEFT JOIN LiquidacionPremio AS lp ON lp.premio_id = pre.id AND lrp.id = lp.liquidacionreglaxparticipante_id AND lp.subregla_id = sr.id
	ORDER BY p.clave, idSubRegla, Gano DESC
	/*
	LiquidacionRegla
	INNER JOIN SubRegla AS sr ON lr.regla_id = sr.regla_id 
	INNER JOIN DetalleLiquidacionRegla AS dlr ON sr.id = dlr.subregla_id 
	INNER JOIN LiquidacionReglaxParticipante AS lrp ON lr.id = lrp.liquidacionRegla_id AND dlr.liquidacionReglaxParticipante_id = lrp.id
	INNER JOIN Participante AS p ON lrp.participante_id = p.id
	INNER JOIN Categoria cat on cat.id = p.categoria_id
	LEFT JOIN PremioxSubregla ps ON ps.subregla_id = sr.id 
	LEFT JOIN LiquidacionPremio AS lp ON lrp.id = lp.liquidacionreglaxparticipante_id AND ps.premio_id = lp.premio_id AND lp.subregla_id = sr.id
	LEFT JOIN Premio AS pre ON lp.premio_id = pre.id
	WHERE lr.id = 130
	ORDER BY p.clave, idSubRegla, Gano DESC*/

END

