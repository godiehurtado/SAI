-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarFranquiciasAcumuladosInsert]
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

    -- INSERTAMOS LA LIQUIDACION DE RANGOS AL ULTIMO VALOR ENVIADO TENIENDO EN CUENTA LA COMPANIA, RAMO, PRODUCTO Y NUMERO NEGOCIO
    -- lOS VALORES DE acumuladoAnterior VA EN 0
	INSERT INTO DetalleLiquiRangosFranq(compania_id,ramo_id,producto_id,numeroNegocio,acumuladoTotal,RangoActual,PorcentajeActual, acumuladoAnterior, anio)
	VALUES
	(@companiaId,@ramoId,@productoId,@numeroNegocio,@acumuladoTotal,0,0,0,@anio)
END
