-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarFranquiciasRangos]
	-- Add the parameters for the stored procedure here
	--@id int,
	--@totalParticipacion float,
	--@porcentajeParticipacion float
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Este SP funciona correctamente pero es muy lento a la hora de ejecucion se optimizar con el update que esta mas adelante
	--UPDATE DetalleLiquidacionFranquicia SET totalParticipacion = @totalParticipacion, porcentajeParticipacion = @porcentajeParticipacion 
	--WHERE id = @id
	
	-- ACTUALIZAMOS LA LIQUIDACION POR RANGOS CON UNA TABLA TEMPORAL PARA OPTIMIZAR EL PROCESO 
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = dlft.totalParticipacion, porcentajeParticipacion = dlft.porcentajeParticipacion, liquidadoPor = 3
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN DetalleLiquidacionFranquiciaTemp AS dlft ON dlf.id = dlft.id
		
    --BORRAMOS LA TABLA TEMPORAL
    DELETE FROM DetalleLiquidacionFranquiciaTemp
    DELETE FROM LiquidacionFranquiciaProceso
    		
END
