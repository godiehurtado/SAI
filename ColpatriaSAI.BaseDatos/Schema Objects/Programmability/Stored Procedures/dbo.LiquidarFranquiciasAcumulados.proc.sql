-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarFranquiciasAcumulados]
	-- Add the parameters for the stored procedure here
	@liquidacionId int,
	@companiaId int,
	@ramoId int,
	@productoId int, 
	@numeroNegocio nvarchar(100),
	@acumuladoTotal float
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @anio as int = (SELECT YEAR(periodoLiquidacionIni) FROM LiquidacionFranquicia WHERE id = @liquidacionId)	

    -- ACTUALIZAMOS LA LIQUIDACION DE RANGOS AL ULTIMO VALOR ENVIADO TENIENDO EN CUENTA LA COMPANIA, RAMO, PRODUCTO Y NUMERO NEGOCIO 
	UPDATE DetalleLiquiRangosFranq SET acumuladoTotal = @acumuladoTotal WHERE compania_id = @companiaId AND ramo_id = @ramoId AND producto_id = @productoId AND numeroNegocio = @numeroNegocio and anio = @anio
END
