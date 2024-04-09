-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 20/03/2012
-- Description:	Procesa la liquidación a través de los resultados obtenidos
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_LiquidarSimples]
	@fechaInicio	datetime,
	@fechaFinal		datetime,
	@Participantes	varchar(MAX)
AS
BEGIN /*
	declare @ppante varchar(max)=''  select @ppante=@ppante + cast(participante_id as varchar(10)) + ',' from frank
	DECLARE @Participantes varchar(max)= @ppante, @fechaInicio datetime='2011-01-01', @fechaFinal datetime='2011-03-31'
	*/
	DECLARE @Fecha_Inicio datetime=@fechaInicio, @Fecha_Final datetime=@fechaFinal, @añoEnCurso int = (SELECT valor FROM ParametrosApp WHERE id=3), @params nvarchar(MAX)='',
		@SubRegla1 int=0, @SubRegla2 int=0, @detLiqRegla_id int=0, @subregla_id int=0, @participante int=0, @campo nvarchar(MAX)='', @Resultado varchar(25)='', @SQL nvarchar(MAX)='', @i int=1, @Cond float='', @condicion int=0,
		@cond1 float=0, @cond2 float=0, @cond3 float=0, @cond4 float=0, @cond5 float=0, @cond6 float=0, @cond7 float=0, @cond8 float=0, @cond9 float=0, @cond10 float=0, @Ppantes varchar(MAX)=@Participantes
	DECLARE @TablaCondiciones CURSOR
	DECLARE @TablaCond TABLE (id int, Item varchar(20))
	DECLARE @otraTabla TablaQueries
	DECLARE @DetLiquiRegla CURSOR   SET @DetLiquiRegla = CURSOR LOCAL FAST_FORWARD FOR   SELECT id, subregla_id, ppante_id FROM DetalleLiquiRegla
	
	--**************************************************************************************************
	-- RECORREMOS LAS SUBREGLAS SIMPLES POR PARTICIPANTES PARA OBTENER LA LIQUIDACIÓN DE CADA FUNCIONARIO
	--**************************************************************************************************
	OPEN @DetLiquiRegla FETCH NEXT FROM @DetLiquiRegla INTO @detLiqRegla_id, @subregla_id, @participante
	WHILE @@FETCH_STATUS = 0 BEGIN
		SET @SubRegla1 = @subregla_id
		
		-- Como en la tabla 'DetalleLiquiRegla' se encuentran los participantes por cada subregla simple, la linea de ejecución entra en la sgte condición
		-- cada vez que hay una subregla simple diferente, para así obtener la liquidación de los participantes a través de la(s) consultas de dicha subregla
		IF @SubRegla1 <> @SubRegla2 BEGIN
			SET @params=''	SET @campo=''
			-- Se obtiene la info a través de la(s) variable(es) de liquidación y filtros adicionales
			EXEC dbo.LiquidarRegla_ResultadosLiquidacionSimple @Ppantes, @añoEnCurso, @subregla_id, @Fecha_Inicio, @Fecha_Final
			
			-- Se almacenan las condiones en una lista para construir la sentencia select de la consulta dinámica que se debe ejecutar para obtener la info sobre la tabla generada en el paso anterior
			DELETE FROM @TablaCond		INSERT INTO @TablaCond  SELECT ROW_NUMBER() OVER (ORDER BY c.id) AS id, c.id FROM Condicion c INNER JOIN Variable v ON c.variable_id=v.id WHERE c.subregla_id=@subregla_id AND v.esFiltro=0 ORDER BY c.id
			SET @TablaCondiciones = CURSOR SCROLL FOR  SELECT * FROM @TablaCond
			/*
			UPDATE DetalleLiquiRegla  SET resultado = (CASE WHEN r.resultado IS NULL THEN 0 ELSE r.resultado END)			FROM ResultadosLiquidacionSimple r  RIGHT JOIN  DetalleLiquiRegla dlr ON r.participante_id=dlr.ppante_id			WHERE dlr.subregla_id=@subregla_id ORDER BY dlr.subregla_id, dlr.ppante_id
				*/
			-- Recorre cada condición para construir la sentencia select
			OPEN @TablaCondiciones FETCH NEXT FROM @TablaCondiciones INTO @i, @condicion
			WHILE @@FETCH_STATUS = 0 BEGIN
				SET @campo = @campo + N'@cond'+CAST(@i as varchar(10))+'=total_'+CAST(@condicion as varchar(10))+', '
				/*SET @campo = CAST(@condicion as varchar(10))
				
				EXEC ('SELECT dlr.id, '+@campo+', CASE WHEN r.total_'+@campo+' IS NULL THEN 0 ELSE r.total_'+@campo+' END						FROM ResultadosLiquidacionSimple r  RIGHT JOIN  DetalleLiquiRegla dlr ON r.participante_id=dlr.ppante_id						WHERE dlr.subregla_id='+CAST(@subregla_id as varchar(10))+' ORDER BY dlr.subregla_id, dlr.ppante_id')
				*/
				FETCH NEXT FROM @TablaCondiciones INTO @i, @condicion
			END
		END 
		SET @SQL	= N'SELECT '+ @campo +'@Resultado=resultado FROM ResultadosLiquidacionSimple WHERE participante_id='+ CAST(@participante as varchar(10))  --print @params print @SQL
		SET @params = N'@cond1 float OUTPUT, @cond2 float OUTPUT, @cond3 float OUTPUT, @cond4 float OUTPUT, @cond5 float OUTPUT, @cond6 float OUTPUT, @cond7 float OUTPUT, @cond8 float OUTPUT, @cond9 float OUTPUT, @cond10 float OUTPUT, @Resultado varchar(25) OUTPUT'
		
		-- En este punto se ejecuta el query generado para consultar la info de la tabla generada 'ResultadosLiquidacionSimple'
		EXEC sp_executeSQL @SQL, @params, @cond1=@cond1 OUTPUT, @cond2=@cond2 OUTPUT, @cond3=@cond3 OUTPUT, @cond4=@cond4 OUTPUT, @cond5=@cond5 OUTPUT, @cond6=@cond6 OUTPUT, @cond7=@cond7 OUTPUT, @cond8=@cond8 OUTPUT, @cond9=@cond9 OUTPUT, @cond10=@cond10 OUTPUT, @Resultado=@Resultado OUTPUT --print cast(@detLiqRegla_id as varchar(10)) +'  '+ cast(@subregla_id as varchar(10)) +'  '+ cast(@participante as varchar(20)) +'  '+ cast(@cond1 as varchar(20)) /*+' '+ cast(@cond2 as varchar(20)) +' '+ cast(@cond3 as varchar(20)) +' '+ cast(@cond4 as varchar(20)) +' '+ cast(@cond5 as varchar(20)) +' '+ cast(@cond6 as varchar(20)) +' '+ cast(@cond7 as varchar(20)) +' '+ cast(@cond8 as varchar(20)) +' '+ cast(@cond9 as varchar(20)) +' '+ cast(@cond10 as varchar(20))*/ +'  '+ cast(@Resultado as varchar(20))
		
		-- Se guarda el resultado de la evaluación de la(s) condicion(es) por participante y subregla actual
		UPDATE DetalleLiquiRegla SET resultado=(CASE WHEN @Resultado IS NULL THEN 0 ELSE @Resultado END) WHERE id = @detLiqRegla_id AND subregla_id = @subregla_id
		
		-- Se guarda el valor obtenido de cada condición o variable de liquidación por participante y subregla actual.
		-- Se utiliza la variable '@TablaCond' para saber cuales son los id's y los valores de las condiciones obtenidos e insertarlos en la tabla
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=1)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond1)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=2)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond2)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=3)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond3)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=4)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond4)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=5)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond5)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=6)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond6)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=7)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond7)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=8)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond8)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=9)  IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond9)
		SET @Cond=(SELECT Item FROM @TablaCond WHERE id=10) IF @Cond<>'' INSERT INTO DetalleLiquiSubRegla VALUES (@detLiqRegla_id, @Cond, @cond10)
		/**/
		SET @SubRegla2 = @subregla_id		SET @SQL='' SET @cond1=0 SET @cond2=0 SET @cond3=0 SET @cond4=0 SET @cond5=0 SET @cond6=0 SET @cond7=0 SET @cond8=0 SET @cond9=0 SET @cond10=0 SET @Resultado=0
		FETCH NEXT FROM @DetLiquiRegla INTO @detLiqRegla_id, @subregla_id, @participante
	END CLOSE @DetLiquiRegla DEALLOCATE @DetLiquiRegla
END