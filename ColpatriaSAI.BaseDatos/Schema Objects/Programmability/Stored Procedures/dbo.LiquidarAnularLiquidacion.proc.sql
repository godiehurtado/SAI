-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarAnularLiquidacion]
	-- Add the parameters for the stored procedure here
	@liquidacionId int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @anio as int = (SELECT YEAR(periodoLiquidacionIni) FROM LiquidacionFranquicia WHERE id = @liquidacionId)
	DECLARE @mes int = (SELECT MONTH(periodoLiquidacionIni) FROM LiquidacionFranquicia WHERE id = @liquidacionId)

	DECLARE @nombreCol varchar(20)
	DECLARE @Sentencia varchar(max)
	
	SET @nombreCol = 
	CASE 
		WHEN @mes = 1 THEN 'enero'
		WHEN @mes = 2 THEN 'febrero'
		WHEN @mes = 3 THEN 'marzo'
		WHEN @mes = 4 THEN 'abril'
		WHEN @mes = 5 THEN 'mayo'
		WHEN @mes = 6 THEN 'junio'
		WHEN @mes = 7 THEN 'julio'
		WHEN @mes = 8 THEN 'agosto'
		WHEN @mes = 9 THEN 'septiembre'
		WHEN @mes = 10 THEN 'octubre'
		WHEN @mes = 11 THEN 'noviembre'
		WHEN @mes = 12 THEN 'diciembre'		
	END	

	SET @Sentencia = 'UPDATE DetalleLiquiRangosFranq SET acumuladoTotal = ' + @nombreCol +  
					 ' WHERE anio = ' + CONVERT(VARCHAR(10),@anio)
		 
	EXEC (@Sentencia)	
	
END
