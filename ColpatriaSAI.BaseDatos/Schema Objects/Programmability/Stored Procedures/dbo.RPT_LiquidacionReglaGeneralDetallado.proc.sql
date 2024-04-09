-- =============================================
-- Author:		<Andrés Bravo>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_LiquidacionReglaGeneralDetallado] 
	
	@idLiquidacion as int
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @idLiquidacionTemp as int
	SET @idLiquidacionTemp = @idLiquidacion
	
    SELECT   lr.id as idLiquidacion
    , lr.fecha_liquidacion
    , p.id as idParticipante
    , RTRIM(LTRIM(p.clave)) as clave
    , RTRIM(LTRIM(p.nombre)) as nombre
    , RTRIM(LTRIM(p.apellidos)) as apellidos
    , sr.id as idSubRegla
    , RTRIM(LTRIM(sr.descripcion)) as SubRegla
    ,(CASE dlr.resultado WHEN 0 THEN 'No' ELSE 'Si'	END) as Gano
    ,(CASE dlr.resultado WHEN 0 THEN '' ELSE Coalesce(sub1.resultado, '')	END) as resultadoPremio
    ,(CASE dlr.resultado WHEN 0 THEN '' ELSE Coalesce(sub1.descripcion, '')	END) as Premio/**/
    , Coalesce(c.id,'') as idCondicion
    , Coalesce(c.descripcion,'') as condicion
    , Coalesce(RTRIM(LTRIM(v.nombre)),'') as variable
    , (CASE WHEN  c.valor = '0' and c.seleccion = '0' then NULL
		else
	   CASE WHEN c.valor = '0' and c.fecha = convert(datetime, '1900-01-01 00:00:00.000', 21) then c.seleccion 
		else 
	   CASE WHEN c.seleccion = '0' and c.fecha = convert(datetime, '1900-01-01 00:00:00.000', 21)   then c.valor end end end)  as Esperado
    , STR(CAST(Coalesce((CASE dlsr.resultado 	WHEN '' THEN '0' ELSE dlsr.resultado END), '0') as float), 13, 2) as Resultado
    , RTRIM(LTRIM(cat.nombre)) as nombreCategoria
	, dlsr.id
	
	FROM LiquidacionRegla AS lr 
		INNER JOIN LiquidacionReglaxParticipante AS lrp ON lr.id = lrp.liquidacionRegla_id AND lrp.liquidacionRegla_id = @idLiquidacionTemp
		INNER JOIN DetalleLiquidacionRegla AS dlr ON lrp.id = dlr.liquidacionReglaxParticipante_id
		INNER JOIN SubRegla AS sr ON sr.id = dlr.subregla_id
		INNER JOIN Participante AS p ON p.id = lrp.participante_id
		INNER JOIN Categoria cat on cat.id = p.categoria_id
		LEFT JOIN DetalleLiquidacionSubRegla AS dlsr ON dlr.id = dlsr.detalleliquidacionregla_id 
		LEFT JOIN Condicion AS c ON dlsr.condicion_id = c.id
		LEFT JOIN Variable v ON v.id = c.variable_id
		LEFT JOIN PremioxSubregla ps ON ps.subregla_id = sr.id
		LEFT JOIN (
			SELECT lp.liquidacionreglaxparticipante_id, pre.descripcion, lp.resultado, lp.premio_id, lp.subregla_id, pre.variable_id
			FROM LiquidacionPremio AS lp 
				INNER JOIN Premio AS pre ON lp.premio_id = pre.id
				INNER JOIN DetalleLiquidacionRegla dlr ON dlr.subregla_id = lp.subregla_id AND dlr.liquidacionReglaxParticipante_id = lp.liquidacionReglaxParticipante_id
				INNER JOIN LiquidacionReglaxParticipante lxp ON lxp.id = dlr.liquidacionReglaxParticipante_id AND lxp.liquidacionRegla_id = @idLiquidacionTemp
		)
		AS sub1 ON lrp.id = sub1.liquidacionreglaxparticipante_id AND ps.premio_id = sub1.premio_id AND sub1.subregla_id = dlr.subregla_id /**/
	ORDER BY p.clave, idSubRegla, Gano DESC

END
/*
	FROM LiquidacionRegla AS lr
		INNER JOIN SubRegla AS sr ON lr.regla_id = sr.regla_id 
		INNER JOIN DetalleLiquidacionRegla AS dlr ON sr.id = dlr.subregla_id 
		INNER JOIN LiquidacionReglaxParticipante AS lrp ON lr.id = lrp.liquidacionRegla_id AND dlr.liquidacionReglaxParticipante_id = lrp.id
		INNER JOIN Participante AS p ON lrp.participante_id = p.id
		INNER JOIN Categoria cat on cat.id = p.categoria_id
*/