-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 13/12/2011
-- Description:	Genera el query a ejecutar teniendo en cuanta la parametrización a través de una subregla simple

-- 20/06/2012: Se cambio el nombre de la tabla a guardar información de la liquidación de 'PresupuestoEjecutadoxMetaTemp' a 'PresupuestoEjecutado_TEMP'
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_ResultadosLiquidacionSimple]
	@Participantes	varchar(max),
	@añoEnCurso		int,
	@subregla_id	int,
	@fechaInicio	datetime,
	@fechaFinal		datetime
AS
BEGIN /*
	--DECLARE @TimeStart datetime2(7)=GETDATE() SET NOCOUNT ON
	declare @Ppantes varchar(max)='' select @Ppantes=@Ppantes + cast(item as varchar(10)) + ',' from frank --participante_id
	DECLARE @Participantes varchar(max)= @Ppantes --select @Ppantes
	DECLARE @añoEnCurso int=2012, @subregla_id int=2422, @fechaInicio datetime='2012-01-01', @fechaFinal datetime='2012-12-30'
	*/
	DECLARE @select varchar(max)='', @where varchar(max)='', @groupby varchar(max)='', @SqlCampos varchar(MAX)='', @cuerpo varchar(MAX)='', @campo varchar(300)='', @paginado int=1000, @total int=0, @selectPpal varchar(max)='', 
		@id int=0, @campoTotal varchar(1000)='', @campoResultado varchar(200)='0 AS resultado', @totalPpantes int=0, @i int=1, @tipoConsulta int=0, @subSelect1 varchar(1000)='', @subSelect2 varchar(1000)='', @campoPpante varchar(20)='',
		@QueryFinal1 nvarchar(MAX)='', @QueryFinal2 nvarchar(max)='', @queryParte1 nvarchar(max)='', @queryParte2 nvarchar(max)='', @variable int=0, @condicion_id int=0, @tipoDato varchar(100)='', @agregacion bit='', 
		@simbolo varchar(10)='', @seleccion varchar(100)='', @fecha datetime='', @tipoTabla int=0, @valor varchar(100)='', @columnaMaestra varchar(50)='', @expresion varchar(5)='', @columnaSelect varchar(500)='', @resultado varchar(max)=''
	DECLARE @tipoConcurso int = ( SELECT c.tipoConcurso_id FROM Concurso c INNER JOIN Regla r ON c.id=r.concurso_id INNER JOIN SubRegla sr ON r.id=sr.regla_id WHERE sr.id=@subregla_id )
	DEClARE @regla_id int = (SELECT regla_id FROM SubRegla WHERE id=@subregla_id)
	DECLARE @tabla table (id int IDENTITY(1,1), item varchar(MAX))
	DECLARE @tablaPpantes table (id int IDENTITY(1,1), item int)
	DECLARE @tablaFiltros table (id int IDENTITY(1,1), condicion_id int, cSelect varchar(1000), cWhere varchar(1000), cGroupBy varchar(1000), tipoConsulta int)
	
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TiposTablas]') AND type in (N'U'))	DROP TABLE TiposTablas
	-- Se guarda en una tabla los diferentes tipo tabla dependiendo del tipo de concurso de la regla
	IF @tipoConcurso = 1 BEGIN
		SELECT id INTO TiposTablas FROM (SELECT 1 id UNION SELECT 2 id) T1		SET @campoPpante = 'participante_id'
	END ELSE BEGIN
		SELECT id INTO TiposTablas FROM (SELECT 3 id UNION SELECT 4 id) T1		SET @campoPpante = 'jerarquiaDetalle_id'
	END
	
	
	--**************************************************************************************************
	-- OBTENER FILTROS DE LAS VARIABLES DE LIQUIDACIÓN DE CADA CONDICION
	--**************************************************************************************************
	-- Se guarda en una lista las variables de liquidación
	DECLARE @Condicones CURSOR SET @Condicones = CURSOR SCROLL FOR
		SELECT DISTINCT condicion_id, C.tipoDato, C.agregacion, simboloSQL, seleccion, fecha, valor, C.columnaTablaMaestra, expresion, V.id, TTV.tipotabla_id
		FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id = V.id JOIN TipoTablaVariable TTV ON TTV.variable_id = V.id
		WHERE subregla_id = @subregla_id AND TTV.tipotabla_id IN (SELECT * FROM TiposTablas) AND V.esFiltro=0 ORDER BY condicion_id
		
	-- Al recorrer las variables de liquidación, se van obteniendo los filtros correspondientes para cada una
	OPEN @Condicones FETCH NEXT FROM @Condicones INTO @condicion_id, @tipoDato, @agregacion, @simbolo, @seleccion, @fecha, @valor, @columnaMaestra, @expresion, @variable, @tipoTabla
	WHILE @@FETCH_STATUS = 0 BEGIN
		IF		@tipoDato='Seleccion' SET @valor = @seleccion
		ELSE IF @tipoDato='Fecha' SET @valor = right('00'+ CAST(CAST(MONTH(@fecha) AS varchar) AS varchar(2)), 2) +'/'+ right('00'+ CAST(CAST(DAY(@fecha) AS varchar) AS varchar(2)), 2) +'/'+ CAST(YEAR(@fecha) AS varchar)
		ELSE	SET @valor = REPLACE(@valor, ',', '.') -- Prevenir que vanga un dato decimal con coma
		IF CHARINDEX(N'.', @valor)=0  SET @valor = ''''+ @valor +''''
		
		IF @agregacion = 1 BEGIN
			IF		@variable = 5	SET @columnaSelect = ltrim(rtrim(@simbolo)) +'(DISTINCT '+ @columnaMaestra +')'
			ELSE IF @variable = 54	SET @columnaSelect = 'CASE WHEN MAX(CAST(personasACargo as float))>0 THEN ROUND(('+ ltrim(rtrim(@simbolo)) +'(CAST('+ @columnaMaestra +' as float))*100) / MAX(CAST(personasACargo as float)),3) ELSE MAX(CAST(personasACargoVenden as float)) END'
			ELSE					SET @columnaSelect = ltrim(rtrim(@simbolo)) +'('+ @columnaMaestra +')'
			--SET @Having = @columnaSelect +' '+ @expresion +' '+ @valor  SET @SQL = @SQL + @Having +' AND '			SET @Having = @Having +' AND '
		END
		ELSE BEGIN
			IF @variable = 149 BEGIN
				SET @columnaSelect = 'dbo.getRankingNodo('''+ @fechaInicio +''', '''+ @fechaFinal +''', jerarquiaDetalle_id) AND '
			END ELSE BEGIN
				SET @columnaSelect = @columnaMaestra
				SET @Where = @columnaSelect +' '+ @expresion +' '+ @valor   --SET @SQL = @SQL + @Where +' AND '
				SET @Where = @Where +' AND '
				-- Si la variable de liquidación es Primas x millón, no va con sentencia groupby ya que el campo a utilizar va con una función personalizada y no puede ir en el groupby
				IF @variable NOT IN (162, 170, 148)  SET @groupby = @columnaMaestra
				ELSE IF @variable = 148  SET @columnaSelect = 'CASE WHEN ISNULL(SUM(presupuesto),0) <> 0 THEN ROUND(((ISNULL(SUM(ejecutado),0)*100)/ISNULL(SUM(presupuesto),0)),2) WHEN ISNULL(SUM(presupuesto),0) < 0 AND ISNULL(SUM(ejecutado),0) >= 0 THEN ROUND((1-(ISNULL(SUM(ejecutado),0)/ISNULL(SUM(presupuesto),0))) * 100,2) WHEN ISNULL(SUM(presupuesto),0) < 0 AND ISNULL(SUM(ejecutado),0) < 0 THEN ROUND((1-(ISNULL(SUM(ejecutado),0)/ISNULL(SUM(presupuesto),0))+1) * 100,2) WHEN ISNULL(SUM(presupuesto),0) = 0 THEN 0 END'
			END
		END
		SET @Select = @columnaSelect +' AS condicion_'+ CAST(@condicion_id AS varchar(20))-- + ', '

		-- Inserta en esta lista los filtros de cada variable de liquidación de la subregla simple contenida en '@subregla_id'
		INSERT INTO @tablaFiltros  EXEC dbo.LiquidarRegla_ObtenerFiltrosCondicion @regla_id, @subregla_id, @tipoTabla, @condicion_id, @fechaInicio, @fechaFinal, @añoEnCurso, @variable
		UPDATE @tablaFiltros SET cSelect=@columnaSelect, cGroupBy=(CASE WHEN @groupby<>'' THEN ', '+ @groupby ELSE '' END) WHERE condicion_id=@condicion_id
		SET @resultado = @resultado + 'SUM(total_'+ CAST(@condicion_id as varchar(10)) +') '+ @expresion +' '+ @valor +' AND '
		
		SET @Select=''  SET @groupby=''
		FETCH NEXT FROM @Condicones INTO @condicion_id, @tipoDato, @agregacion, @simbolo, @seleccion, @fecha, @valor, @columnaMaestra, @expresion, @variable, @tipoTabla
	END
	
	IF @resultado <> ''  SET @resultado = 'CASE WHEN '+ left(@resultado, LEN(@resultado)-4) +' THEN 1 ELSE 0 END AS resultado'
	SET @total = (SELECT COUNT(id) FROM @tablaFiltros)  SET @select=''
	-- Se suprime de los filtros la cadena 'AND ' para evitar errores en la ejecución del query
	UPDATE @tablaFiltros SET cWhere = (CASE WHEN right(cWhere,4)='AND ' THEN LEFT(cWhere,LEN(cWhere)-4) ELSE cWhere END)
	
	
	--**************************************************************************************************
	-- CONSTRUIR LOS QUERIES A PARTIR DE LOS FILTROS OBTENIDOS Y UNIRLOS MEDIANTE 'UNION ALL'
	--**************************************************************************************************
	SET @Condicones = CURSOR SCROLL FOR	 SELECT id, condicion_id, cSelect, cWhere, cGroupBy, tipoConsulta FROM @tablaFiltros
	OPEN @Condicones FETCH NEXT FROM @Condicones INTO @id, @condicion_id, @Select, @where, @groupby, @tipoConsulta
	
	-- Se recorren las condiciones para construir el query general
	WHILE @@FETCH_STATUS = 0 BEGIN
		-- Se define un nombre que va a ser el alias del campo a consultar el cual esta conformado por el id de la condición de la variable de liquidación
		SET @campoTotal = 'total_'+ CAST(@condicion_id as varchar(10))
		
		-- Se concatena el alias definiendole el tipo float. La cadena de la variable '@SqlCampos' se utilizará para crear la tabla 'ResultadosLiquidacionSimple' donde se guardara la info consultada
		SET @SqlCampos = @SqlCampos + @campoTotal +' float, '
		
		-- Se guarda en '@campoTotal' una cadena que constituye la variable de liquidación mas su alias y que será un campo de la tabla 'ResultadosLiquidacionSimple'
		SET @campoTotal = @Select +' AS '+ @campoTotal +', ' --SET @campoTotal = LTRIM(RTRIM(REPLACE((SELECT TOP 1 Item FROM dbo.SplitCondiciones((SELECT item FROM @tablaSelects WHERE id=@id), ' AS ')),'.',','))) +' AS '+ @campoTotal +', '
		
		-- Se definen los campos adicionales diferentes a '@campoTotal' de acuerdo al múmero de condiciones de la subregla
		SELECT @subSelect1 = @subSelect1 + '0 AS total_'+ CAST(condicion_id as varchar(10)) +', ' FROM @tablaFiltros WHERE condicion_id <> @condicion_id AND id < @id
		SELECT @subSelect2 = @subSelect2 + '0 AS total_'+ CAST(condicion_id as varchar(10)) +', ' FROM @tablaFiltros WHERE condicion_id <> @condicion_id AND id > @id
				
		-- En este paso se forma el query individual de la condición actual.
		IF		@tipoConsulta = 1
			SET @cuerpo =	char(9)+ 'SELECT T.participante_id, '+ @subSelect1 + @campoTotal + @subSelect2 + @campoResultado +char(13)+ 
							char(9)+ 'FROM TablaMaestra_TEMP T  INNER JOIN  tablaPpantes P ON T.'+@campoPpante+'=P.item'+char(13)+char(9)+ 'WHERE 1=1'+ @where +char(13)+
							char(9)+ 'GROUP BY T.participante_id'+ @groupby +(CASE @i WHEN @total THEN '' ELSE char(13)+char(13)+char(9)+'UNION ALL'+char(13)+char(13) END)
		ELSE IF @tipoConsulta = 2
			SET @cuerpo =	char(9)+ 'SELECT T.participante_id, '+ @subSelect1 + @campoTotal + @subSelect2 + @campoResultado +char(13)+ 
							char(9)+ 'FROM ConsolidadoMes_TEMP T  INNER JOIN  tablaPpantes P ON T.'+@campoPpante+'=P.item'+char(13)+char(9)+ 'WHERE 1=1'+ @where +char(13)+
							char(9)+ 'GROUP BY T.participante_id'+ @groupby +(CASE @i WHEN @total THEN '' ELSE char(13)+char(13)+char(9)+'UNION ALL'+char(13)+char(13) END)
		ELSE IF @tipoConsulta = 3
			SET @cuerpo =	char(9)+ 'SELECT T.jerarquiaDetalle_id AS participante_id, '+ @subSelect1 + @campoTotal + @subSelect2 + @campoResultado +char(13)+ 
							char(9)+ 'FROM ConsolidadoMesEjecutivo_TEMP T  INNER JOIN  tablaPpantes P ON T.'+@campoPpante+'=P.item'+char(13)+char(9)+ 'WHERE 1=1'+ @where +char(13)+
							char(9)+ 'GROUP BY T.jerarquiaDetalle_id'+ @groupby +(CASE @i WHEN @total THEN '' ELSE char(13)+char(13)+char(9)+'UNION ALL'+char(13)+char(13) END)
		ELSE IF @tipoConsulta = 4
			SET @cuerpo =	char(9)+ 'SELECT T.jerarquiaDetalle_id AS participante_id, '+ @subSelect1 + @campoTotal + @subSelect2 + @campoResultado +char(13)+ 
							char(9)+ 'FROM PresupuestoEjecutado_TEMP T  INNER JOIN  tablaPpantes P ON T.'+@campoPpante+'=P.item'+char(13)+char(9)+ 'WHERE 1=1'+ @where +char(13)+
							char(9)+ 'GROUP BY T.jerarquiaDetalle_id'+ @groupby +(CASE @i WHEN @total THEN '' ELSE char(13)+char(13)+char(9)+'UNION ALL'+char(13)+char(13) END)
		
		-- Se van concatenando los queries individuales
		SET @QueryFinal1 = @QueryFinal1 + @cuerpo		SET @tipoConsulta=0  SET @i = @i+1	SET @subSelect1=''	 SET @subSelect2=''
		FETCH NEXT FROM @Condicones INTO @id, @condicion_id, @Select, @where, @groupby, @tipoConsulta
	END
	
	-- Construimos los campos generales del query en base a las condiciones formando así el query general de la subregla actual
	SELECT @selectPpal = @selectPpal + 'SUM(total_'+ CAST(condicion_id as varchar(10)) +') AS total_'+ CAST(condicion_id as varchar(10))+', ' FROM @tablaFiltros WHERE condicion_id IS NOT NULL
	SET @QueryFinal1 = char(13)+char(13)+'INSERT INTO ResultadosLiquidacionSimple'+char(13)+char(13)+
					'SELECT participante_id, ' + @selectPpal + @resultado +char(13)+'FROM (' +char(13)+ @QueryFinal1 +char(13)+ ')' +char(13)+ 'AS T1 GROUP BY participante_id'		print @QueryFinal1
	----------
	
	
	--**************************************************************************************************
	-- EJECUTAR EL QUERY GENERAL CONSTRUIDO Y ALMACENAR LOS DATOS EN LA TABLA 'ResultadosLiquidacionSimple'
	--**************************************************************************************************
	-- Sa almacenan los participantes en una lista y se obtiene el total de ellos
	INSERT INTO @tablaPpantes SELECT Item FROM dbo.SplitCondiciones(@Participantes, ',')
	SET @totalPpantes = (SELECT COUNT(id) FROM @tablaPpantes)   SET @i=1   SET @Participantes=''
	
	-- Se crea la tabla 'ResultadosLiquidacionSimple' donde se almacenarán los resultados del query general construido. Si existe, se elimina antes
	SET @SqlCampos = @SqlCampos + 'resultado int'
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ResultadosLiquidacionSimple]') AND type in (N'U')) DROP TABLE ResultadosLiquidacionSimple
	EXEC ('CREATE TABLE ResultadosLiquidacionSimple (participante_id int, '+ @SqlCampos +')')
	
	-- Se crea la tabla 'tablaPpantes' para guardar los participantes
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tablaPpantes]') AND type in (N'U')) DROP TABLE tablaPpantes
	CREATE TABLE tablaPpantes (item int)		--INSERT INTO tablaPpantes  SELECT item FROM @tablaPpantes
	
	-- EJECUTAR EL QUERY POR GRUPOS DE PARTICIPANTES E INSERTARLOS EN LA TABLA ResultadosLiquidacionSimple PARA GENERAR LOS RESULTADOS DE LA LIQUIDACION
	SET ANSI_WARNINGS OFF
	-- En este ciclo se ejecuta el query general de acuerdo a la cantidad de participantes. El query se ejecuta por cada cantidad del valor de '@paginado'.
	-- Esto se realiza para evitar que, cuando la consulta sea demasiado grande, el query colapse
	WHILE @i <= @totalPpantes BEGIN
		INSERT INTO tablaPpantes  SELECT item FROM @tablaPpantes WHERE id BETWEEN @i AND (@i + @paginado)-1				--select * from tablaPpantes
		SET NOCOUNT OFF;
		EXEC sp_executesql @QueryFinal1						--print @QueryFinal1
		SET @i = (@i + @paginado)   SET @Participantes=''   SET NOCOUNT ON;   DELETE FROM tablaPpantes
	END
	PRINT ''
	SET ANSI_WARNINGS ON
	SET NOCOUNT ON
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tablaPpantes]') AND type in (N'U')) DROP TABLE tablaPpantes
	---
	--SELECT * FROM ResultadosLiquidacionSimple where participante_id=9490 order by participante_id   --DROP TABLE ResultadosLiquidacionSimple
	--print 'TIEMPO TRANSCURRIDO: ' + CAST((convert(float, DateDiff(ss, @TimeStart, GETDATE()))/60) as nvarchar(24)) + ' minutos'
END