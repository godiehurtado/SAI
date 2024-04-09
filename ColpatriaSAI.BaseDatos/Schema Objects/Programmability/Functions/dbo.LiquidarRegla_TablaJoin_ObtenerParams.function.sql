-- =============================================
-- Author:		Frank Payares
-- Create date: 30/11/2011
-- Description:	Obtiene la condición agrupada de una subregla
-- =============================================
CREATE FUNCTION [dbo].[LiquidarRegla_TablaJoin_ObtenerParams] (
	@NoCampos		int = 0,
	@Condiciones_id	varchar(255)
)
RETURNS nvarchar(MAX)
AS
BEGIN
	--DECLARE @Condiciones_id	varchar(255)='154,', @NoCampos INT=1
	DECLARE @TablaCond TABLE (id int, Item varchar(20))
	DECLARE @i int=1, @SqlCampos nvarchar(MAX)='', @SqlParams nvarchar(MAX)='', @Cond varchar(25)='', @Field nvarchar(20)='', @Conds varchar(MAX)=''
	
	INSERT INTO @TablaCond SELECT ROW_NUMBER()OVER(ORDER BY Item) AS id, Item FROM dbo.SplitCondiciones(@Condiciones_id, ',')
		
	WHILE @i <= @NoCampos BEGIN -- AÑADIR CAMPOS Y PARAMETROS DINAMICOS
		SET @SqlParams = @SqlParams + N'@cond'+ CAST(@i AS varchar) +' varchar(25) OUTPUT, '
		SET @i = @i+1
	END
	WHILE @i <= 10 BEGIN
		SET @SqlParams = @SqlParams + N'@cond'+ CAST(@i AS varchar) +' varchar(25) OUTPUT, '
		SET @i=@i+1
	END
	SET @SqlParams = @SqlParams + N'@Resultado varchar(25) OUTPUT'
	--SELECT @SqlParams
	
	RETURN @SqlParams
END