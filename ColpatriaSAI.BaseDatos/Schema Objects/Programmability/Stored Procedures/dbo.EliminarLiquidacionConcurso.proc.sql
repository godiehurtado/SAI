CREATE PROCEDURE [dbo].[EliminarLiquidacionConcurso]

	@liqregla AS INT

AS
BEGIN

--DECLARE @liqregla AS INT = 56

--select * from LiquidacionRegla
	--select * from LiquidacionReglaxParticipante
		--select * from DetallePagosRegla
			--select * from LiquidacionPremio
				--select * from DetalleLiquidacionRegla
					--select * from DetalleLiquidacionSubRegla

--  Por DetalleLiquidacionSubRegla
	DELETE dls
	FROM LiquidacionRegla AS lq
	INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lrxp.liquidacionRegla_id = lq.id
	INNER JOIN DetalleLiquidacionRegla AS dlr ON dlr.liquidacionReglaxParticipante_id = lrxp.id
	INNER JOIN DetalleLiquidacionSubRegla AS dls ON dls.detalleLiquidacionRegla_id = dlr.id 
	WHERE lq.id = @liqregla
	AND lq.estado = 1

--  Por DetalleLiquidacionRegla
	DELETE dlr
	FROM LiquidacionRegla AS lq
	INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lrxp.liquidacionRegla_id = lq.id
	INNER JOIN DetalleLiquidacionRegla AS dlr ON dlr.liquidacionReglaxParticipante_id = lrxp.id
	WHERE lq.id = @liqregla
	AND lq.estado = 1
	
--  Por LiquidacionPremio
	DELETE lp
	FROM LiquidacionRegla AS lq
	INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lrxp.liquidacionRegla_id = lq.id
	INNER JOIN LiquidacionPremio AS lp ON lp.liquidacionReglaxParticipante_id = lrxp.id
	WHERE lq.id = @liqregla
	AND lq.estado = 1

--  Por DetallePagosRegla
	DELETE dpr
	FROM LiquidacionRegla AS lq
	INNER JOIN DetallePagosRegla AS dpr ON dpr.liquidacionRegla_id = lq.id
	WHERE lq.id = @liqregla
	AND lq.estado = 1

--  Por LiquidacionReglaxParticipante
	DELETE lrxp
	FROM LiquidacionRegla AS lq
	INNER JOIN LiquidacionReglaxParticipante AS lrxp ON lrxp.liquidacionRegla_id = lq.id
	WHERE lq.id = @liqregla
	AND lq.estado = 1

--  Por LiquidacionRegla
	DELETE FROM LiquidacionRegla
	WHERE LiquidacionRegla.id = @liqregla
	AND LiquidacionRegla.estado = 1

END