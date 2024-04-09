-- =============================================
-- Author:		Frank Payares
-- Create date: 15/09/2011
-- Description:	Eliminar liquidacion
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarContratacion_Eliminar]
	@idLiquidacion int
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @idLiqui int = @idLiquidacion
	
	DELETE FROM LiquiContratFactorParticipante WHERE liqui_contrat_id = @idLiqui
	DELETE FROM DetalleLiquiContratPpacionPpante WHERE liqui_contrat_id = @idLiqui
	DELETE FROM LiquiContratMeta WHERE liqui_contrat_id = @idLiqui
	DELETE FROM LiquiContratPpacionPpante WHERE liqui_contrat_id = @idLiqui
	DELETE FROM LiquidacionContratacion WHERE id = @idLiqui
	DELETE FROM procesoliquidacion WHERE liquidacion_id = @idLiqui AND tipo = 2
	
	return 1	
END