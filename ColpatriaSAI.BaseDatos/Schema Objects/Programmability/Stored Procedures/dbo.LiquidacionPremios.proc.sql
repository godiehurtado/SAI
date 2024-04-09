-- =============================================
-- Author:		Andres Bravo
-- Create date: 09/12/2011
-- Description:	Genera los premios a los participantes a través de la liquidación generada y su parametrización de premios de la regla especificada

-- 26/06/2012: (Linea 21) Se corrigió la manera de obtener el id de la liquidación anterior pero de la misma regla
-- =============================================
CREATE PROCEDURE [dbo].[LiquidacionPremios]
	-- Add the parameters for the stored procedure here
	@idLiquidacionRegla int
AS
BEGIN
	SET NOCOUNT ON;	--declare @idLiquidacionRegla int=59
	
	DECLARE @idLiquidacionAnterior int = (SELECT TOP 1 id FROM LiquidacionRegla WHERE id < @idLiquidacionRegla AND regla_id = (SELECT regla_id FROM LiquidacionRegla WHERE id = @idLiquidacionRegla) ORDER BY id DESC)
	
	-- INSERTAMOS LOS PREMIOS AL PARTICIPANTE TENIENDO EN CUENTA LAS SUBREGLAS AGRUPADAS QUE TENGAN PREMIOS ASOCIADOS Y QUE EL PREMIO TENGA UNA VARIABLE
	INSERT INTO LiquidacionPremio(liquidacionreglaxparticipante_id, premio_id, resultado, estado, subregla_id)
	SELECT DISTINCT T1.liquidacionReglaxParticipante_id, id, --T1.subregla_id, T2.participante_id,
		CASE WHEN tipoPremio_id = 3 THEN
			CASE expresion
				WHEN '*' THEN LTRIM(STR(valor * T2.resultado, 15, 3))
				WHEN '-' THEN LTRIM(STR(valor - T2.resultado, 15, 3))
				WHEN '+' THEN LTRIM(STR(valor + T2.resultado, 15, 3))
				WHEN '/' THEN LTRIM(STR(valor / T2.resultado, 15, 3))
				WHEN '=' THEN LTRIM(STR(valor, 15, 3))
			END
		ELSE CAST(descripcion AS varchar(50)) END,
		1, T1.subregla_id
	FROM (
			SELECT dlr.subregla_id, dlr.liquidacionReglaxParticipante_id, p.id, dlr.resultado, p.descripcion, p.tipoPremio_id, p.valor, o.expresion, p.variable_id
			FROM LiquidacionRegla AS lr 
				INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lr.id = lrxp.liquidacionRegla_id
				INNER JOIN DetalleLiquidacionRegla AS dlr ON lrxp.id = dlr.liquidacionReglaxParticipante_id
				INNER JOIN SubRegla AS sr ON sr.id = dlr.subregla_id
				INNER JOIN PremioxSubregla AS pxr ON sr.id = pxr.subregla_id
				INNER JOIN Premio AS p ON p.id = pxr.premio_id
				INNER JOIN TipoPremio AS tp ON p.tipoPremio_id = tp.id
				INNER JOIN Operador AS o ON p.operador_id = o.id
			WHERE lr.id = @idLiquidacionRegla AND sr.condicionAgrupada_id IS NOT NULL AND dlr.resultado = 1
		) AS T1
		INNER JOIN (
			SELECT dlr.liquidacionReglaxParticipante_id, C.variable_id, dlsr.resultado, lrxp.participante_id
			FROM LiquidacionRegla AS lr 
				INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lr.id = lrxp.liquidacionRegla_id
				INNER JOIN DetalleLiquidacionRegla AS dlr ON lrxp.id = dlr.liquidacionReglaxParticipante_id
				INNER JOIN DetalleLiquidacionSubRegla AS dlsr ON dlr.id = dlsr.detalleliquidacionRegla_id
				INNER JOIN Condicion AS c ON dlsr.condicion_id = c.id
			WHERE lr.id = @idLiquidacionRegla AND dlr.resultado = 1
		) AS T2
		ON T2.variable_id = T1.variable_id AND T2.liquidacionReglaxParticipante_id = T1.liquidacionReglaxParticipante_id
	WHERE T1.variable_id <> 0
	----------------
	
	
	
	-- INSERTAMOS LOS PREMIOS AL PARTICIPANTE TENIENDO EN CUENTA LAS SUBREGLAS AGRUPADAS QUE TENGAN PREMIOS ASOCIADOS Y QUE EL PREMIO NO TENGA VARIABLE
	INSERT INTO LiquidacionPremio(liquidacionreglaxparticipante_id, premio_id, resultado, estado, subregla_id)
	SELECT dlr.liquidacionReglaxParticipante_id, p.id, CASE WHEN p.tipoPremio_id = 3 THEN CAST(p.valor AS varchar(50))  ELSE  CAST(p.descripcion AS varchar(50))  END, 1, sr.id
	FROM LiquidacionRegla AS lr 
		INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lr.id = lrxp.liquidacionRegla_id
		INNER JOIN DetalleLiquidacionRegla AS dlr ON lrxp.id = dlr.liquidacionReglaxParticipante_id
		INNER JOIN SubRegla AS sr ON sr.id = dlr.subregla_id
		INNER JOIN PremioxSubregla AS pxr ON sr.id = pxr.subregla_id
		INNER JOIN Premio AS p ON p.id = pxr.premio_id
	WHERE lr.id = @idLiquidacionRegla AND sr.condicionAgrupada_id IS NOT NULL AND dlr.resultado = 1 AND p.variable_id = 0
	----------------
		
	
	
	--INSERTAMOS LOS PREMIOS AL PARTICIPANTE A TRAVÉS DE SUBREGLAS SIMPLES CUANDO EL PREMIO TIENE UNA VARIABLE
	INSERT INTO LiquidacionPremio(liquidacionreglaxparticipante_id, premio_id, resultado, estado, subregla_id)
	SELECT dlr.liquidacionReglaxParticipante_id, p.id, --dlr.subregla_id, dlsr.resultado, o.expresion, p.valor, 
		CASE WHEN p.tipoPremio_id = 3 THEN
			CASE o.expresion
				WHEN '*' THEN LTRIM(STR(p.valor * dlsr.resultado, 15, 3))
				WHEN '-' THEN LTRIM(STR(p.valor - dlsr.resultado, 15, 3))
				WHEN '+' THEN LTRIM(STR(p.valor + dlsr.resultado, 15, 3))
				WHEN '/' THEN LTRIM(STR(p.valor / dlsr.resultado, 15, 3))
				WHEN '=' THEN LTRIM(STR(p.valor, 15, 3))
			END
		ELSE CAST(p.descripcion AS varchar(50)) END,/**/
		1, dlr.subregla_id
	FROM LiquidacionRegla AS lr 
		INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lr.id = lrxp.liquidacionRegla_id
		INNER JOIN DetalleLiquidacionRegla AS dlr ON lrxp.id = dlr.liquidacionReglaxParticipante_id
		INNER JOIN DetalleLiquidacionSubRegla AS dlsr ON dlr.id = dlsr.detalleliquidacionRegla_id
		INNER JOIN Condicion AS c ON dlsr.condicion_id = c.id
		INNER JOIN PremioxSubRegla AS pxs ON dlr.subregla_id = pxs.subregla_id
		INNER JOIN Premio AS p ON pxs.premio_id = p.id
		INNER JOIN TipoPremio AS tp ON p.tipoPremio_id = tp.id
		INNER JOIN Operador AS o ON p.operador_id = o.id
		INNER JOIN Variable AS v ON p.variable_id = v.id/**/
	WHERE lr.id = @idLiquidacionRegla AND dlr.resultado = 1 AND p.variable_id = c.variable_id AND p.variable_id <> 0
	----------------
	
	
	
	-- INSERTAMOS LOS PREMIOS AL PARTICIPANTE A TRAVÉS DE SUBREGLAS SIMPLES CUANDO EL PREMIO NO TENGA UNA VARIABLE, SOLO SE TOMA EL VALOR SIN HACER NINGUN CASE
	INSERT INTO LiquidacionPremio(liquidacionreglaxparticipante_id, premio_id, resultado, estado, subregla_id)
	SELECT dlr.liquidacionReglaxParticipante_id, p.id, CASE WHEN p.tipoPremio_id = 3 THEN  CAST(p.valor AS varchar(50))  ELSE  CAST(p.descripcion AS varchar(50))  END, 1, dlr.subregla_id
	FROM LiquidacionRegla AS lr 
		INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lr.id = lrxp.liquidacionRegla_id
		INNER JOIN DetalleLiquidacionRegla AS dlr ON lrxp.id = dlr.liquidacionReglaxParticipante_id
		INNER JOIN DetalleLiquidacionSubRegla AS dlsr ON dlr.id = dlsr.detalleliquidacionRegla_id
		INNER JOIN PremioxSubRegla AS pxs ON dlr.subregla_id = pxs.subregla_id
		INNER JOIN Premio AS p ON pxs.premio_id = p.id
	WHERE lr.id = @idLiquidacionRegla AND dlr.resultado = 1 AND p.variable_id = 0
	----------------



	--INSERTAMOS TEMPORALMENTE LOS PREMIOS DE REGULARIDAD QUE SE VAN ACTUALIZAR TENIENDO EN CUENTA LOS PREMIOS DE REGULARIDAD
	--ACTUAL Y LOS PREMIOS DE REGULARIDAD DE LA LIQUIDACION ANTERIOR
	INSERT INTO LiquidacionPremioRegularidadTemp
	SELECT sub1.idLiquidacionPremio, sub1.premio_id, sub1.subregla_id, sub1.participante_id, sub2.resultadoPremio
	FROM (
			SELECT lp.id as idLiquidacionPremio, p.id as premio_id, ISNULL(lrxp.participante_id, lrxp.jerarquiaDetalle_id) as participante_id, dlr.subregla_id
			FROM LiquidacionRegla AS lr 
				INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lr.id = lrxp.liquidacionRegla_id
				INNER JOIN DetalleLiquidacionRegla AS dlr ON lrxp.id = dlr.liquidacionReglaxParticipante_id
				INNER JOIN LiquidacionPremio AS lp ON lrxp.id = lp.liquidacionReglaxParticipante_id AND lp.subregla_id = dlr.subregla_id
				INNER JOIN Premio AS p ON lp.premio_id = p.id
			WHERE lr.id = @idLiquidacionRegla AND dlr.resultado = 1 AND p.regularidad = 1
		) AS sub1
		INNER JOIN (	
			SELECT p.id as premio_id, dlr.subregla_id, ISNULL(lrxp.participante_id, lrxp.jerarquiaDetalle_id) as participante_id, CAST(LTRIM(STR(lp.resultado, 15, 3)) as float) as resultadoPremio
			FROM LiquidacionRegla AS lr 
				INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lr.id = lrxp.liquidacionRegla_id
				INNER JOIN DetalleLiquidacionRegla AS dlr ON lrxp.id = dlr.liquidacionReglaxParticipante_id
				LEFT JOIN LiquidacionPremio AS lp ON lrxp.id = lp.liquidacionReglaxParticipante_id AND lp.subregla_id = dlr.subregla_id
				INNER JOIN Premio AS p ON lp.premio_id = p.id
			WHERE lr.id = @idLiquidacionAnterior AND dlr.resultado = 1 AND p.regularidad = 1 AND lr.estado = 2
		) AS sub2
		ON sub1.premio_id = sub2.premio_id AND sub1.subregla_id = sub2.subregla_id	AND sub1.participante_id = sub2.participante_id	

	
	--ACTUALIZAMOS LOS PREMIOS DE LA LIQUIDACION ACTUAL CON LOS PREMIOS DE LA LIQUIDACION ANTERIOR Y QUE SEAN DE REGULARIDAD
	UPDATE LiquidacionPremio 
		SET resultado = (CASE WHEN p.tipoPremio_id = 3 THEN LTRIM(STR(CAST(LTRIM(STR(resultado, 15, 3)) as float) + resultadoPremio, 15, 3)) ELSE resultadoPremio END)
	FROM LiquidacionPremio as lp
		JOIN LiquidacionPremioRegularidadTemp lpr ON lp.id = lpr.idLiquidacionPremio	
		JOIN Premio p ON p.id = lp.premio_id
	
	--BORRAMOS LOS PREMIOS DE REGULARIDAD TEMP
	DELETE FROM LiquidacionPremioRegularidadTemp
	
	RETURN 1
END
