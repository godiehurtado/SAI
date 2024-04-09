-- =============================================
-- Author:		Frank Payares
-- Create date: 30/11/2011
-- Description:	Obtiene la condición agrupada de una subregla
-- =============================================
CREATE FUNCTION [dbo].[LiquidarRegla_TipoConsulta] (
	@select varchar(MAX),
	@subregla_id int
)
RETURNS int
AS
BEGIN --DECLARE @subregla_id int=90
	DECLARE @tipoConsulta int=0, @tipo int, @total1 int=0, @total2 int=0, @total3 int=0, @total4 int=0
	DECLARE @TipoTablas table (tipo int, total int)
	
	INSERT INTO @TipoTablas
	SELECT tipotabla_id, COUNT(tipotabla_id)
	FROM (	SELECT TTV.tipotabla_id FROM CondicionesVariables C JOIN TipoTablaVariable TTV ON TTV.variable_id=C.variable_id JOIN Variable V ON V.id=C.variable_id
			WHERE subregla_id=@subregla_id AND V.esFiltro=0 --GROUP BY C.columnaTablaMaestra, tipoTabla
		) AS t1
	GROUP BY tipotabla_id
	
	SELECT @total1=(CASE WHEN total IS NULL THEN 0 ELSE total END) FROM @TipoTablas WHERE tipo=1
	SELECT @total2=(CASE WHEN total IS NULL THEN 0 ELSE total END) FROM @TipoTablas WHERE tipo=2
	SELECT @total3=(CASE WHEN total IS NULL THEN 0 ELSE total END) FROM @TipoTablas WHERE tipo=3
	SELECT @total4=(CASE WHEN total IS NULL THEN 0 ELSE total END) FROM @TipoTablas WHERE tipo=4

	IF		@total1 > @total2 AND @total1 > @total3 AND @total1 > @total4	SET @tipoConsulta = 1
	ELSE IF @total2 > @total1 AND @total2 > @total3 AND @total2 > @total4	SET @tipoConsulta = 2
	ELSE IF @total3 > @total1 AND @total3 > @total2 AND @total3 > @total4	SET @tipoConsulta = 3
	ELSE IF @total4 > @total1 AND @total4 > @total2 AND @total4 > @total3	SET @tipoConsulta = 4
	
	--SELECT @tipoConsulta
	RETURN @tipoConsulta
	
	/*SET @total1 = (SELECT total FROM @TipoTablas WHERE tipo=1)
	SET @total2 = (SELECT total FROM @TipoTablas WHERE tipo=2)
	SET @total3 = (SELECT total FROM @TipoTablas WHERE tipo=3)
	SET @total4 = (SELECT total FROM @TipoTablas WHERE tipo=4)
	
	IF		@total1 IS NOT NULL AND @total2 IS NULL AND @total3 IS NULL AND @total4 IS NULL		SET @tipoConsulta = 1
	ELSE IF @total1 IS NULL AND @total2 IS NOT NULL AND @total3 IS NULL AND @total4 IS NULL		SET @tipoConsulta = 2
	ELSE IF @total1 IS NULL AND @total2 IS NULL AND @total3 IS NOT NULL AND @total4 IS NULL		SET @tipoConsulta = 3
	ELSE IF @total1 IS NULL AND @total2 IS NULL AND @total3 IS NULL AND @total4 IS NOT NULL		SET @tipoConsulta = 4*/
END
/*
	--DECLARE @select varchar(MAX)='COUNT(DISTINCT numeroNegocio) AS condicion_370, '''' AS Cond2, '''' AS Cond3, '''' AS Cond4, '''' AS Cond5, '''' AS Cond6, '''' AS Cond7, '''' AS Cond8, '''' AS Cond9, '''' AS Cond10, CASE WHEN COUNT(DISTINCT numeroNegocio) >= ''1'' THEN 1 ELSE 0 END AS Resultado'
	DECLARE @id int, @item varchar(100), @tipoConsulta int=0, @conteoMaestra int=0, @conteoConsolidado int=0, @conteoConsolEjec int=0, @hayMaestra int=0, @hayConsolidado int=0, @hayConsolEjec int=0, @conteo int=0
	DECLARE @tabla table (id int IDENTITY(1,1), item varchar(100))
	DECLARE @TablaCond table (id int IDENTITY(1,1), item varchar(100))
	
	INSERT INTO @tabla SELECT Item FROM dbo.SplitCondiciones(@select, ',')
	
	DECLARE @Cond1 varchar(100) = (SELECT TOP 1 Item FROM dbo.SplitCondiciones((SELECT item FROM @tabla WHERE id = 1), ' AS '))
	DECLARE @Cond2 varchar(100) = (SELECT TOP 1 Item FROM dbo.SplitCondiciones((SELECT item FROM @tabla WHERE id = 2), ' AS '))
		
	INSERT INTO @TablaCond VALUES (RTRIM(LTRIM(@Cond1))),(RTRIM(LTRIM(@Cond2)))
	
	SET @conteo = (SELECT COUNT(id) FROM @TablaCond WHERE item <> '''''')
	
	DECLARE @Campos CURSOR SET @Campos = CURSOR FAST_FORWARD FOR  SELECT * FROM @TablaCond WHERE item <> ''''''
	OPEN @Campos  FETCH NEXT FROM @Campos INTO @id, @item
	WHILE @@FETCH_STATUS = 0 BEGIN
		IF EXISTS( SELECT simboloSQL FROM OperacionAgregacion WHERE simboloSQL IN ( SELECT TOP 1 (SELECT TOP 1 item FROM dbo.SplitCondiciones(item, '(')) FROM @TablaCond ) )
			SET @item = ( SELECT LEFT(Item, LEN(Item)-1) FROM dbo.SplitCondiciones(@item, '(') WHERE id = 2 )
			
		IF EXISTS( SELECT V.columnaTablaMaestra FROM Variable V WHERE V.esFiltro = 0 AND V.columnaTablaMaestra = @item AND V.tipoTabla = 1 ) BEGIN
			SET @conteoMaestra = @conteoMaestra + 1
			SET @hayMaestra = 1
		END
		IF EXISTS( SELECT V.columnaTablaMaestra FROM Variable V WHERE V.esFiltro = 0 AND V.columnaTablaMaestra = @item AND V.tipoTabla = 2 ) BEGIN
			SET @conteoConsolidado = @conteoConsolidado + 1
			SET @hayConsolidado = 1
		END
		IF EXISTS( SELECT V.columnaTablaMaestra FROM Variable V WHERE V.esFiltro = 0 AND V.columnaTablaMaestra = @item AND V.tipoTabla = 3 ) BEGIN
			SET @conteoConsolEjec = @conteoConsolEjec + 1
			SET @hayConsolEjec = 1
		END
		FETCH NEXT FROM @Campos INTO @id, @item
	END CLOSE @Campos DEALLOCATE @Campos
	
	IF @conteoMaestra = @conteo BEGIN -- SI LA(S) CONDICION(ES) TIENEN QUE VER CON TABLA MAESTRA
		SET @tipoConsulta = 1  --print 'frank'
	END
	ELSE IF @conteoConsolidado = @conteo BEGIN -- SI LA(S) CONDICION(ES) TIENEN QUE VER CON TABLA CONSOLIDADOS
		SET @tipoConsulta = 2  --print 'estaban'
	END
	ELSE IF @hayConsolEjec = @conteo BEGIN -- SI LA(S) CONDICION(ES) TIENEN QUE VER CON TABLA CONSOLIDADOS EJECUTIVOS
		SET @tipoConsulta = 3  --print 'estaban'
	END
	ELSE IF @hayMaestra = @hayConsolidado AND @hayMaestra > 0 BEGIN -- SI ALGUNA CONDICION TIENE QUE VER CON TABLA MAESTRA O CON CONSOLIDADOS
		SET @tipoConsulta = 5  --print 'rios'
	END
	ELSE BEGIN
		SET @tipoConsulta = 1
	END*/
	--SELECT @tipoConsulta-- SELECT @conteo, @conteoMaestra, @hayMaestra, @conteoConsolidado, @hayConsolidado, @tipoConsulta --