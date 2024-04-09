-- =============================================
-- Author:		Frank Payares
-- Create date: 30/11/2011
-- Description:	Obtiene la condición agrupada de una subregla
-- =============================================
CREATE FUNCTION [dbo].[LiquidarRegla_TablaJoin_ObtenerCampos] (
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
		SET @Cond = (SELECT Item FROM @TablaCond WHERE id = @i)   SET @Field='condicion_'+ @Cond
		SET @SqlCampos = @SqlCampos + N'@cond'+ CAST(@i AS varchar) +'='+ 'condicion_'+ @Cond +', '
		SET @i = @i+1
	END
	WHILE @i <= 10 BEGIN
		SET @Field = 'cond'+ CAST(@i AS varchar)
		SET @Conds = @Conds +', @cond'+ CAST(@i AS varchar) +'='+ @Field
		SET @i=@i+1
	END
	SET @Conds = @Conds + N', @Resultado=Resultado'
	SET @SqlCampos = N' '+ left(@SqlCampos, len(@SqlCampos)-1) +' '+ @Conds
	--SELECT @SqlCampos
	
	RETURN @SqlCampos
END