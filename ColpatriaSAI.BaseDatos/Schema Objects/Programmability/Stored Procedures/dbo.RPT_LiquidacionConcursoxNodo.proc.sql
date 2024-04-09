CREATE PROCEDURE [dbo].[RPT_LiquidacionConcursoxNodo] 
	
	@idLiquidacion as int,
	@codNivel as nvarchar (2048) = ''
AS
BEGIN

	SET NOCOUNT ON;

	-- DECLARE @idLiquidacion as int = 157, @codNivel as nvarchar (2048) = 'GTESBC'
	
    SELECT  lr.id as idLiquidacion
    , lr.fecha_liquidacion
    , p.id as idParticipante
    , RTRIM(LTRIM(jd.codigoNivel)) as codNivel
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
	
	FROM
	Participante p
	INNER JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
	INNER JOIN LiquidacionReglaxParticipante lrp ON jd.id = lrp.jerarquiaDetalle_id
	INNER JOIN LiquidacionRegla lr ON lrp.liquidacionRegla_id = lr.id
	INNER JOIN SubRegla sr ON lr.regla_id = sr.regla_id
	INNER JOIN DetalleLiquidacionRegla dlr ON sr.id = dlr.subregla_id
	LEFT JOIN LiquidacionPremio lqp ON lqp.liquidacionReglaxParticipante_id = lrp.id	
	INNER JOIN DetalleLiquidacionSubRegla AS dlsr ON dlr.id = dlsr.detalleliquidacionregla_id 
	INNER JOIN Condicion AS c ON dlsr.condicion_id = c.id
	INNER JOIN Variable v ON v.id = c.variable_id
	INNER JOIN Regla r ON r.id = sr.regla_id
	INNER JOIN Concurso con ON con.id = r.concurso_id
	LEFT JOIN LiquidacionPremio lp ON lrp.id = lp.liquidacionReglaxParticipante_id
	LEFT JOIN Premio AS pre ON lp.premio_id = pre.id	
	WHERE lr.id = @idLiquidacion
	AND jd.nivel_id > 1
	AND dlr.liquidacionReglaxParticipante_id = lrp.id
	AND c.subregla_id = sr.id
	AND jd.codigoNivel = @codNivel
	ORDER BY jd.codigoNivel
	, SubRegla
	, Gano

END

