-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_Pagos]
	-- Add the parameters for the stored procedure here
	@idLiquidacionRegla int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- INSERTAMOS LOS PREMIOS DE COLQUINES
	INSERT INTO LiquidacionMoneda(moneda_id, compania_id, cantidad, participante_id, concepto, fechaLiquidacion, tipo)
	SELECT  
		m.id as moneda_id,
		part.compania_id, 
		lp.resultado, 
		lrxp.participante_id, 
		p.descripcion, 
		lr.fecha_liquidacion,
		3
	FROM LiquidacionRegla as lr
		INNER JOIN LiquidacionReglaxParticipante as lrxp ON lr.id = lrxp.liquidacionregla_id
		INNER JOIN LiquidacionPremio as lp ON lrxp.id = lp.liquidacionreglaxparticipante_id
		INNER JOIN Premio as p ON lp.premio_id = p.id
		INNER JOIN UnidadMedida as um ON p.unidadmedida_id = um.id
		INNER JOIN Participante as part ON lrxp.participante_id = part.id
		INNER JOIN Moneda as m ON part.segmento_id = m.segmento_id
	WHERE lrxp.liquidacionRegla_id = @idLiquidacionRegla AND um.tipounidadmedida_id = 1

	-- INSERTAMOS LOS PREMIOS DE DINERO
	INSERT INTO DetallePagosRegla(liquidacionRegla_id, compania_id, clave, tipoDocumento_id, documento, totalParticipacion, 
	descripcion, fechaLiquidacion, estado)
	SELECT 
		@idLiquidacionRegla,
		part.compania_id,
		part.clave,
		part.tipoDocumento_id,
		part.documento,
		lp.resultado,
		p.descripcion as descripcion,
		lr.fecha_liquidacion,
		1
	FROM LiquidacionRegla as lr
		INNER JOIN LiquidacionReglaxParticipante as lrxp ON lr.id = lrxp.liquidacionregla_id
		INNER JOIN LiquidacionPremio as lp ON lrxp.id = lp.liquidacionreglaxparticipante_id
		INNER JOIN Premio as p ON lp.premio_id = p.id
		INNER JOIN UnidadMedida as um ON p.unidadmedida_id = um.id
		INNER JOIN Participante as part ON lrxp.participante_id = part.id		
	WHERE lrxp.liquidacionRegla_id = @idLiquidacionRegla AND um.tipounidadmedida_id = 2


END
