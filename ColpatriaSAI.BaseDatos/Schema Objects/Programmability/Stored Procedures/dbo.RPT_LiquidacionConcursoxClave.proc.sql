CREATE PROCEDURE [dbo].[RPT_LiquidacionConcursoxClave] 
	
	@idLiquidacion as int,
	@Clave as nvarchar (2048) = ''
AS
BEGIN

	SET NOCOUNT ON;

	-- DECLARE @idLiquidacion as int = 20
	
    SELECT   lr.id as idLiquidacion
    , lr.fecha_liquidacion
    , p.id as idParticipante
    , RTRIM(LTRIM(p.clave)) as clave
    , RTRIM(LTRIM(p.nombre)) as nombre
    , RTRIM(LTRIM(p.apellidos)) as apellidos
    , sr.id as idSubRegla
    , RTRIM(LTRIM(sr.descripcion)) as SubRegla
    ,(CASE dlr.resultado WHEN 0 THEN 'No' ELSE 'Si'	END) as Gano
    , Coalesce(lp.resultado, '')  as resultadoPremio
    , Coalesce(pre.descripcion, '') as Premio
    , c.id as idCondicion
    , RTRIM(LTRIM(v.nombre)) as variable
    , (CASE WHEN  c.valor = '0' and c.seleccion = '0' then NULL
		else
	   CASE WHEN c.valor = '0' and c.fecha = convert(datetime, '1900-01-01 00:00:00.000', 21) then c.seleccion 
		else 
	   CASE WHEN c.seleccion = '0' and c.fecha = convert(datetime, '1900-01-01 00:00:00.000', 21)   then c.valor end end end)  as Esperado
    , STR(CAST(Coalesce((CASE dlsr.resultado 	WHEN '' THEN '0' ELSE dlsr.resultado END), '0') as float), 13, 2) as Resultado
    , RTRIM(LTRIM(cat.nombre)) as nombreCategoria
	
	FROM         
	LiquidacionRegla AS lr
	INNER JOIN SubRegla AS sr ON lr.regla_id = sr.regla_id 
	INNER JOIN DetalleLiquidacionRegla AS dlr ON sr.id = dlr.subregla_id 
	INNER JOIN LiquidacionReglaxParticipante AS lrp ON lr.id = lrp.liquidacionRegla_id AND dlr.liquidacionReglaxParticipante_id = lrp.id
	LEFT JOIN LiquidacionPremio lqp ON lqp.liquidacionReglaxParticipante_id = lrp.id
	INNER JOIN Participante AS p ON lrp.participante_id = p.id
	INNER JOIN Categoria cat on cat.id = p.categoria_id
	INNER JOIN DetalleLiquidacionSubRegla AS dlsr ON dlr.id = dlsr.detalleliquidacionregla_id 
	INNER JOIN Condicion AS c ON dlsr.condicion_id = c.id
	INNER JOIN Variable v ON v.id = c.variable_id
	LEFT JOIN LiquidacionPremio AS lp ON lrp.id = lp.liquidacionreglaxparticipante_id
	LEFT JOIN Premio AS pre ON lp.premio_id = pre.id
	WHERE lr.id = @idLiquidacion
	AND c.subregla_id = sr.id
	AND p.clave = @clave
	ORDER BY p.clave
	, SubRegla
	, Gano

END

