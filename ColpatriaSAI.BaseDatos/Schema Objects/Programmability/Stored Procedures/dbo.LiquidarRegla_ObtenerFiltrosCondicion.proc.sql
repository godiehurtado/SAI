-- =============================================
-- Author:		Frank Payares
-- Create date: 06/10/2011
-- Description:	Ejecuta el query construido con la TablaMaestra basandose en las condiciones de determinada regla

-- 28/06/2012: (Linea 48)
-- 27/07/2012: (Lineas 133-135) Se obtienen los grupos de endosos para consultar información de nuevos negocios
-- 03/09/2012: (Lineas 91,124) Se corrige la manera de obtener valorRecaudo y cantidadSuscriptores, quitandole filtros de lineaNegocio_id y estadoNegocio o ValorRecaudo y los filtros de grupoEndoso a cantidadSuscriptores
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_ObtenerFiltrosCondicion]
	@regla_id		int,
	@subregla_id	int,
	@tipoTabla		int,
	@condicion		int,
	@fechaInicio	datetime,
	@fechaFinal		datetime,
	@añoEnCurso		int,
	@variable_id	int
AS
BEGIN
	--DECLARE @regla_id int=301, @subregla_id int=3363, @tipoTabla int=2, @condicion int=5634, @fechaInicio datetime='2012-01-01', @fechaFinal datetime='2012-04-30', @añoEnCurso int=2012, @variable_id int=172
		
	DECLARE @tipoDato varchar(100)='', @seleccion varchar(100)='', @fecha datetime='', @valor varchar(100)='', @columnaMaestra varchar(50)='', @expresion varchar(5)='', @Filtro varchar(8000)='', @FiltroFechasPpto int=0,
			@tipoConsulta int=0, @esFiltro int=0, @alias varchar(5)='', @tipoMedida int=0/*, @tipoMedWhere varchar(MAX)=''*/, @conteoFiltros int=0, @conteoFiltroCompania int=0, @gruposEndoso varchar(100)='',
			@FiltroNoNegocio varchar(100)='', @i int=1, @variable int=0, @FiltroFechas varchar(50)='', @FiltroFechasEjec int=0, @mesAcumulado varchar(30)='', @queryWhere varchar(MAX)='', @conceptosTM varchar(100)='',
			@FiltroLimra int=0, @FiltroCompania varchar(100)='', @incluirGrupoEndoso int=0, @registrosTablaMaestra int=0, @registrosConsolidado int=0, @conceptosCM varchar(100)='', @filtroNumNegocioEjec varchar(20)='',
			@filtroGruposEndoso varchar(50)=''
	DECLARE @Columnas TABLE (columna varchar(MAX), seleccion varchar(100))
	
	-- IDENTIFICAR DE DONDE OBTENER LA INFORMACIÓN A CONSULTAR
	SET @tipoConsulta = @tipoTabla
	--SET @alias = 'T.'--IF @tipoConsulta = 1 SET @alias = 'T.'  ELSE  IF @tipoConsulta = 2 SET @alias = 'C.'  ELSE  IF @tipoConsulta = 3 SET @alias = 'C.'  ELSE  SET @alias = 'P.'
	---
	
	--**************************************************************************************************
	-- CONSTRUIR WHERE A PARTIR DE LAS VARIABLES FILTRO QUE SEAN IGUAL, CON EL FORMATO 'campo IN (valo12,valor2...)'
	--**************************************************************************************************
	INSERT INTO @Columnas
	SELECT * FROM (
		SELECT columnaTablaMaestra, STUFF(
			(	SELECT ',' + CAST(T2.seleccion as varchar(20))
				FROM (
					SELECT C.columnaTablaMaestra, /*C.seleccion*/
						CASE C.seleccion
							WHEN '0' THEN
								CASE WHEN ISNUMERIC(C.valor)=0 THEN ''''+C.valor+'''' ELSE C.valor END
							ELSE C.seleccion 
							END seleccion
					FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id=V.id INNER JOIN SubRegla SR ON C.subregla_id=SR.id INNER JOIN TipoTablaVariable TTV ON TTV.variable_id=V.id
					WHERE SR.regla_id = @regla_id AND SR.id = @subregla_id AND TTV.tipotabla_id = @tipoTabla AND V.esFiltro=1
					GROUP BY C.columnaTablaMaestra, C.seleccion, C.valor
				) AS T2 
				WHERE T1.columnaTablaMaestra = T2.columnaTablaMaestra
				FOR XML PATH('')
			), 1, 1,'') as selecciones
		FROM (
			SELECT C.columnaTablaMaestra FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id=V.id INNER JOIN SubRegla SR ON C.subregla_id=SR.id INNER JOIN TipoTablaVariable TTV ON TTV.variable_id=V.id
			WHERE SR.regla_id = @regla_id AND SR.id = @subregla_id AND TTV.tipotabla_id = @tipoTabla AND V.esFiltro=1
			GROUP BY C.columnaTablaMaestra
			HAVING COUNT(C.columnaTablaMaestra) > 1
		) AS T1 ) AS T3
	WHERE selecciones <>'0'
	
	SELECT @Filtro = @Filtro + columna +' IN ('+ seleccion +') AND ' FROM @Columnas				--select @Filtro
	
	
	--**************************************************************************************************
	-- CONSTRUIR WHERE A PARTIR DE LAS VARIABLES FILTRO QUE SEAN DIFERENTES, INCLUYENDO LAS DE LIQUIDACIÓN
	--**************************************************************************************************
	DECLARE @Condiciones CURSOR SET @Condiciones = CURSOR LOCAL FAST_FORWARD FOR
		SELECT DISTINCT C.tipoDato, C.seleccion, fecha, valor, C.columnaTablaMaestra, expresion/*, V.tipoMedida_id*/, V.esFiltro, V.id, TTV.tipotabla_id
		FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id=V.id INNER JOIN SubRegla ON C.subregla_id=SubRegla.id INNER JOIN TipoTablaVariable TTV ON TTV.variable_id=V.id
		WHERE SubRegla.regla_id=@regla_id AND SubRegla.id=@subregla_id AND TTV.tipotabla_id=@tipoTabla AND C.columnaTablaMaestra NOT IN (SELECT columna FROM @Columnas) ORDER BY V.id
		
	OPEN @Condiciones
	FETCH NEXT FROM @Condiciones INTO @tipoDato, @seleccion, @fecha, @valor, @columnaMaestra, @expresion, @esFiltro, @variable, @tipoTabla
	
	-- Recorremos cada condición de la subregla actual
	WHILE @@FETCH_STATUS = 0 BEGIN
			
		-- Si la tabla de donde se obtendrán los datos es TablaMaestra
		IF @tipoTabla = 1 BEGIN
			SET @FiltroFechas = 'fechaRecaudo'
			-- Estas variables deben tener en cuenta los negocios vigentes en el primer año (numeroNegocio, cantidadSuscriptores, primaProteccion)
			IF @variable IN (5, 42, 9, 38)  SET @FiltroNoNegocio = 'lineaNegocio_id = 1 AND ' -- 
		END
		-- Si la tabla de donde se obtendrán los datos es ConsolidadoMes
		IF @tipoTabla = 2 BEGIN
			
			IF @variable = 171  SET @FiltroNoNegocio = 'lineaNegocio_id = 1 AND '
			-- Si la variable de la condición es 'LIMRA' o 'FASECOLDA', el query no debe filtrar por el campo 'año' para efectos del resultado
			IF @variable IN (30, 31)  SET @FiltroLimra = 1
			IF EXISTS(SELECT id FROM Variable WHERE id=@variable AND tipoMedida_id IS NOT NULL)  SET @FiltroCompania = 'compania_id=0 AND '
		END
		-- Si la tabla de donde se obtendrán los datos es ConsolidadoMesEjecutivo
		IF @tipoTabla = 3 BEGIN
			-- Si la variable de la condición es 'Valor Prima Total x Mes' (totalPrimas) se debe filtrar por el mes que se esta liquidando, si no, quiere decir que se debe liquidar el periodo seleccionado
			IF @variable = 150  SET @FiltroFechasEjec = 1  ELSE  SET @FiltroFechasEjec = 2
			IF @variable = 159  SET @filtroNumNegocioEjec = ' AND nivel_id=1'
		END
		
		-- Si la tabla de donde se obtendrán los datos es PresupuestoEjecutadoxMeta
		IF @tipoTabla = 4  SET @FiltroFechasPpto = 1
		
		-- Capturar las condiciones a filtrar, solo las variables tipo filtro
		IF @esFiltro = 1 BEGIN
			IF   @tipoDato='Seleccion' SET @valor = @seleccion
			ELSE IF @tipoDato='Fecha' SET @valor = right('00'+ CAST(CAST(MONTH(@fecha) AS varchar) AS varchar(2)), 2) +'/'+ right('00'+ CAST(CAST(DAY(@fecha) AS varchar) AS varchar(2)), 2) +'/'+ CAST(YEAR(@fecha) AS varchar)
			ELSE SET @valor = REPLACE(@valor, ',', '.') -- Prevenir que vanga un dato decimal con coma
			-- Aca se van concatenando los diferentes filtros
			SET @Filtro = @Filtro + @alias + @columnaMaestra +' '+ @expresion + ' '''+ @valor +''' AND '
			
			/*IF @variable <> 8
			ELSE BEGIN -- Si la variable es 8 (Estado de las pólizas) se filtra por los grupo de endosos que tengan estadoReal parametrizado
				IF @valor='1'  SET @valor='V'  ELSE  SET @valor='NV'
				SELECT @gruposEndoso = @gruposEndoso + CAST(id as varchar(10)) + ',' FROM GrupoEndoso WHERE estadoReal = @valor
				IF @gruposEndoso <> ''  SET @Filtro = 'grupoEndoso_id IN ('+ left(@gruposEndoso, LEN(@gruposEndoso)-1) +') AND '
				SET @gruposEndoso = ''
			END*/
		END
		FETCH NEXT FROM @Condiciones INTO @tipoDato, @seleccion, @fecha, @valor, @columnaMaestra, @expresion, @esFiltro, @variable, @tipoTabla
	END CLOSE @Condiciones DEALLOCATE @Condiciones
	
	
	-- Se debe agregar el filtro de grupos de endoso (Nuevos negocios) cuando se consulte cantidad de negocios, Número de asegurados (cantidadSuscriptores) o Valor protección (primaProteccion) y que la compañia, 
	-- ramo o producto (variable 67, 60, 55, respectivamente) que este parametrizado pertenezca a las compañias SEGUROS GENERALES o VIDA
	IF EXISTS( SELECT variable_id FROM CondicionesVariables WHERE subregla_id=@subregla_id AND variable_id IN (5,42,9) )
	BEGIN
		SET @Condiciones = CURSOR LOCAL FAST_FORWARD FOR
			SELECT C.variable_id, C.tipoDato, C.valor, C.seleccion FROM CondicionesVariables AS C INNER JOIN TipoTablaVariable TTV ON TTV.variable_id=C.variable_id 
			WHERE C.subregla_id=@subregla_id AND TTV.tipotabla_id=@tipoTabla AND C.variable_id IN (67, 60, 55)
			
		OPEN @Condiciones  FETCH NEXT FROM @Condiciones INTO @variable, @tipoDato, @valor, @seleccion
		WHILE @@FETCH_STATUS = 0 BEGIN
			IF @incluirGrupoEndoso = 0 BEGIN
			
				IF   @tipoDato='Seleccion' SET @valor = @seleccion  ELSE IF  @tipoDato='Numero' SET @valor = REPLACE(@valor, ',', '.')
			
				SELECT @gruposEndoso = @gruposEndoso + CAST(id as varchar(10)) + ',' FROM GrupoEndoso WHERE claseEndoso=1
				-- Se obtienen los grupos de endosos para consultar información de nuevos negocios
				SET @gruposEndoso = left(@gruposEndoso, LEN(@gruposEndoso)-1)
				
				IF @variable = 67 BEGIN
					IF EXISTS( SELECT id FROM Compania WHERE id IN (1,2) AND id=@valor )  SET @FiltroNoNegocio = @FiltroNoNegocio + 'grupoEndoso_id IN ('+@gruposEndoso+') AND '
					SET @incluirGrupoEndoso=1
				END
				ELSE IF @variable = 60 BEGIN
					IF EXISTS( SELECT id FROM Ramo WHERE compania_id IN (1,2) AND id=@valor )  SET @FiltroNoNegocio = @FiltroNoNegocio + 'grupoEndoso_id IN ('+@gruposEndoso+') AND '
					SET @incluirGrupoEndoso=1
				END
				ELSE IF @variable = 55 BEGIN
					IF EXISTS( SELECT p.id FROM Producto p JOIN Ramo r ON r.id=p.ramo_id WHERE compania_id IN (1,2) AND p.id=@valor )  SET @FiltroNoNegocio = @FiltroNoNegocio + 'grupoEndoso_id IN ('+@gruposEndoso+') AND '
					SET @incluirGrupoEndoso=1
				END
			END
			FETCH NEXT FROM @Condiciones INTO @variable, @tipoDato, @valor, @seleccion
		END CLOSE @Condiciones DEALLOCATE @Condiciones
	END
	
	
	-- Se suprime al final la cadena 'AND '
	IF right(@Filtro, 4) = 'AND '  SET @Filtro = LEFT(@Filtro, LEN(@Filtro)-4)			--select @FiltroFechas 	--select @Filtro
	
	/*IF @variable_id = 3 AND @conceptosTM ='' BEGIN
		-- Si la variable es 3 (Cantidad de Colquines) se obtienen la parametrización de conceptos de colquines a consultar
		SELECT @conceptosTM = @conceptosTM + CAST(cd.id as varchar(10)) + ',' FROM ReglaxConceptoDescuento rxd INNER JOIN ConceptoDescuento cd ON rxd.conceptoDescuento_id=cd.id wHERE rxd.regla_id = @regla_id
		IF @conceptosTM <> ''  SET @conceptosTM = left(@conceptosTM, LEN(@conceptosTM)-1)
	END
	IF @variable_id = 172 AND @conceptosCM ='' BEGIN
		-- Si la variable es 172 (Cantidad de Colquines Etapa PIONEROS) se obtienen la parametrización de conceptos de colquines a consultar
		SELECT @conceptosCM = @conceptosCM + CAST(cd.tipoMedida_id as varchar(10)) + ',' FROM ReglaxConceptoDescuento rxd INNER JOIN ConceptoDescuento cd ON rxd.conceptoDescuento_id=cd.id wHERE rxd.regla_id = @regla_id
		IF @conceptosCM <> ''  SET @conceptosCM = left(@conceptosCM, LEN(@conceptosCM)-1)
	END*/
			
	-- Esto solo aplica para las variables que tengan tipoMedida, es decir, para ConsolidadoMes
	SELECT @tipoMedida = ISNULL(tipoMedida_id,0) FROM Variable WHERE id=@variable_id
	
	IF @tipoMedida <> 0 BEGIN
	
		IF @variable_id IN ( SELECT id FROM Variable WHERE nombre LIKE '%cumpli%' OR nombre LIKE '%creci%' OR nombre like '%ejecu%' ) BEGIN
			SELECT @conteoFiltroCompania = COUNT(DISTINCT C.variable_id) FROM CondicionesVariables AS C INNER JOIN TipoTablaVariable TTV ON TTV.variable_id=C.variable_id 
			WHERE C.subregla_id=@subregla_id AND TTV.tipotabla_id=@tipoTabla AND C.variable_id IN (67, 60, 55, 39, 169)
			
			IF @conteoFiltroCompania > 0  SET @FiltroCompania='compania_id<>0 AND '  ELSE  SET @FiltroCompania='compania_id=0 AND '
		END ELSE BEGIN
			SET @FiltroCompania='compania_id<>0 AND '
		END
		IF @tipoMedida = 2  SET @FiltroCompania=''
	END
	
	-- Concatenar finalmente los filtros construidos con los filtros especiales
	IF @Filtro			<> ''	SET @queryWhere = @Filtro --+ @queryWhere
	IF @FiltroNoNegocio <> ''	SET @queryWhere = @FiltroNoNegocio + @queryWhere
	IF @FiltroCompania  <> ''	SET @queryWhere = @FiltroCompania + @queryWhere
	IF @filtroNumNegocioEjec <> ''	SET @queryWhere = @queryWhere + @filtroNumNegocioEjec
	
	-- Se agrega el sgte filtro a la variable 148 (Cumplimiento al Presupuesto) para evitar que realice ese calculo cuando el presupuesto es igual a 0
	IF @variable_id = 148  SET @queryWhere = 'presupuesto <> 0 AND '+ @queryWhere
	IF @variable_id = 3 BEGIN
		/*IF @conceptosTM <> ''
			SET @queryWhere = 'conceptoDescuento_id=0 OR (mesCierre='+ CAST(MONTH(@fechaFinal) AS varchar(2)) +' AND conceptoDescuento_id IN ('+ @conceptosTM +')) AND '+ @queryWhere
		ELSE*/
			SET @queryWhere = 'conceptoDescuento_id IN (0,6) AND '+ @queryWhere
	END
	--IF @conceptosCM		<> ''	SET @conceptosCM = ','+ @conceptosCM
	IF @tipoMedida <> 0 BEGIN
		IF @tipoMedida <> 2   SET @queryWhere = 'tipoMedida_id IN ('+ CAST(@tipoMedida as varchar(2)) + @conceptosCM +') AND '+ @queryWhere   ELSE   SET @queryWhere = 'tipoMedida_id IN (2,26) AND '+ @queryWhere
	END
	
	IF @FiltroFechas <> '' BEGIN
		-- Filtro de fechas para TablaMaestra
		SET @i = MONTH(@fechaInicio)   SET @mesAcumulado=''
		WHILE @i <= MONTH(@fechaFinal) BEGIN  SET @mesAcumulado = @mesAcumulado + CAST(@i AS varchar(2)) +','  SET @i=@i+1  END
		SET @queryWhere = 'anioCierre='+CAST(@añoEnCurso as varchar(4))+' AND mesCierre IN ('+ left(@mesAcumulado, LEN(@mesAcumulado)-1) +') AND ' + @queryWhere
		/*DECLARE @Fecha1 varchar(10) = right('00'+ CAST(CAST(MONTH(@fechaInicio) AS varchar) AS varchar(2)), 2) +'/'+ right('00'+ CAST(CAST(DAY(@fechaInicio) AS varchar) AS varchar(2)), 2) +'/'+ CAST(YEAR(@fechaInicio) AS varchar(4))		DECLARE @Fecha2 varchar(10) = right('00'+ CAST(CAST(MONTH(@fechaFinal) AS varchar) AS varchar(2)), 2) +'/'+ right('00'+ CAST(CAST(DAY(@fechaFinal) AS varchar) AS varchar(2)), 2) +'/'+ CAST(YEAR(@fechaFinal) AS varchar(4))		SET @queryWhere = '('+ @FiltroFechas + ' BETWEEN ''' + @Fecha1 + ''' AND ''' + @Fecha2 + ''') AND ' + @queryWhere*/
	END
	
	IF @FiltroFechasEjec = 1
		-- Filtro de fechas para ConsolidadoMesEjecutivo cuando el periodo sea un mes determinado
		SET @queryWhere = 'anio='+CAST(@añoEnCurso as varchar(4))+' AND mes = '+CAST(MONTH(@fechaInicio) AS varchar(4))+' AND ' + @queryWhere
	ELSE
	IF @FiltroFechasEjec = 2 OR @FiltroFechasPpto = 1 BEGIN
		-- Filtro de fechas para ConsolidadoMesEjecutivo y PresupuestoEjecutadoxMeta cuando sea dentro del periodo que se este liquidando
		SET @i = MONTH(@fechaInicio)   SET @mesAcumulado=''
		WHILE @i <= MONTH(@fechaFinal) BEGIN  SET @mesAcumulado = @mesAcumulado + CAST(@i AS varchar(2)) +','  SET @i=@i+1  END
		
		IF @FiltroFechasPpto = 1 BEGIN
			-- Pero si las variables tipo filtro de la subregla son 'Meta' y hacen referencia a metas agrupadas, se coloca el mes de la fecha final
			IF EXISTS( SELECT DISTINCT seleccion FROM CondicionesVariables c INNER JOIN Meta m ON c.seleccion=m.id WHERE variable_id=139 AND subregla_id=@subregla_id AND m.nombre LIKE '%ACUM%' ) BEGIN
				SET @mesAcumulado = CAST(MONTH(@fechaFinal) as varchar(2)) +','
			END
		END
		SET @queryWhere = 'anio='+CAST(@añoEnCurso as varchar(4))+' AND mes IN ('+ left(@mesAcumulado, LEN(@mesAcumulado)-1) +') AND ' + @queryWhere
	END
	
	SET @queryWhere = ' AND '+ @queryWhere + dbo.LiquidarRegla_ObtenerExcepciones(@regla_id, @tipoTabla)
	
	--IF @registrosTablaMaestra > 0 OR @registrosConsolidado > 0  SET @queryWhere = @queryWhere +' OR (compania_id = -1)'
	---
	
	IF		@tipoConsulta IN (1, 3, 4)
		SELECT @condicion, '', @queryWhere, '', @tipoConsulta
	ELSE IF @tipoConsulta = 2
		-- Cuando la consulta sea para ConsolidadoMes se le concatena al WHERE general el filtro adicional de año
		SELECT @condicion, '',
			CASE WHEN @FiltroLimra=0 THEN
				CASE WHEN @variable_id <> 13 THEN ' AND año='+ CAST(@añoEnCurso as varchar(4)) ELSE ' AND año='+ CAST(@añoEnCurso-1 as varchar(4)) END
			ELSE
				''
			END + @queryWhere,
			'', @tipoConsulta
END