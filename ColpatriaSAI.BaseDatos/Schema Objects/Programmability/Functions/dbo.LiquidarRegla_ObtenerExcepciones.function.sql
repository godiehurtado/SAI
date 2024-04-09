-- =============================================
-- Author:		Frank Payares
-- Create date: 30/11/2011
-- Description:	Obtiene la condición agrupada de una subregla
-- =============================================
CREATE FUNCTION [dbo].[LiquidarRegla_ObtenerExcepciones] (
	@regla_id int,
	@subregla_id int,
	@tipoTabla int
)
RETURNS varchar(MAX)
AS
BEGIN --DECLARE @regla_id int=76, @subregla_id int=96, @añoEnCurso int=2012, @tipoTabla int=1
	DECLARE @Columnas TABLE (columna varchar(MAX), seleccion varchar(100))
	DECLARE @tipoDato varchar(100)='', @seleccion varchar(100)='', @fecha datetime='', @valor varchar(100)='', @columnaMaestra varchar(50)='', @expresion varchar(5)='', @Filtro varchar(8000)='', @variable_id int=0,
		@tipoConsulta int=0, @esFiltro int=0, @alias varchar(5)='', @condicion int=0, @tipoMedida int=0, @tipoMedWhere varchar(MAX)='', @FiltroNoNegocio varchar(30)='', @queryWhere varchar(MAX)=''
	
	-- IDENTIFICAR DE DONDE OBTENER LA INFORMACIÓN A CONSULTAR
	SET @tipoConsulta = dbo.LiquidarRegla_TipoConsulta('', @subregla_id)--
	IF @tipoConsulta = 1 SET @alias = 'T.'  ELSE  IF @tipoConsulta = 2 SET @alias = 'C.'  ELSE  IF @tipoConsulta = 3 SET @alias = 'C.'  ELSE  SET @alias = 'P.'
	---
	
	-- CONSTRUIR WHERE CON COLUMNAS COMUNES
	INSERT INTO @Columnas
	SELECT * FROM (
		SELECT columnaTablaMaestra, STUFF(
			(	SELECT ',' + CAST(T2.seleccion as varchar(10))
				FROM (
					SELECT C.columnaTablaMaestra, C.seleccion FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id = V.id INNER JOIN SubRegla SR ON C.subregla_id = SR.id
						INNER JOIN TipoTablaVariable TTV ON V.id = TTV.variable_id
					WHERE SR.regla_id = @regla_id AND SR.tipoSubregla = 3 AND V.esFiltro = 1 AND TTV.tipotabla_id = @tipoTabla
					GROUP BY C.columnaTablaMaestra, C.seleccion
				) AS T2 
				WHERE T1.columnaTablaMaestra = T2.columnaTablaMaestra
				FOR XML PATH('')
			), 1, 1,'') as selecciones
		FROM (
			SELECT C.columnaTablaMaestra FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id = V.id INNER JOIN SubRegla SR ON C.subregla_id = SR.id
				INNER JOIN TipoTablaVariable TTV ON V.id = TTV.variable_id
			WHERE SR.regla_id = @regla_id AND SR.tipoSubregla = 3 AND V.esFiltro = 1 AND TTV.tipotabla_id = @tipoTabla
			GROUP BY C.columnaTablaMaestra
			HAVING COUNT(C.columnaTablaMaestra) > 1
		) AS T1 ) AS T3
	WHERE selecciones <>'0'

	SELECT @Filtro = @Filtro + columna +' IN ('+ seleccion +') AND ' FROM @Columnas					--print @Filtro
	---
	
	-- CONSTRUIR WHERE CON COLUMNAS ÚNICAS
	DECLARE @Condiciones CURSOR SET @Condiciones = CURSOR LOCAL FAST_FORWARD FOR
		SELECT DISTINCT C.tipoDato, C.seleccion, fecha, valor, C.columnaTablaMaestra, expresion, V.id, V.tipoMedida_id, V.esFiltro
		FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id = V.id INNER JOIN SubRegla SR ON C.subregla_id = SR.id INNER JOIN TipoTablaVariable TTV ON V.id = TTV.variable_id
		WHERE SR.regla_id=@regla_id AND SR.tipoSubregla = 3 AND V.esFiltro = 1 AND TTV.tipotabla_id = @tipoTabla AND C.columnaTablaMaestra NOT IN (SELECT columna FROM @Columnas) ORDER BY V.id
		
	OPEN @Condiciones
	FETCH NEXT FROM @Condiciones INTO @tipoDato, @seleccion, @fecha, @valor, @columnaMaestra, @expresion, @variable_id, @tipoMedida, @esFiltro
	WHILE @@FETCH_STATUS = 0 BEGIN -- RECORRE CADA CONDICION DE LA SUBREGLA QUE SON FILTROS
		IF   @tipoDato='Seleccion' SET @valor = @seleccion
		ELSE IF @tipoDato='Fecha' SET @valor = right('00'+ CAST(CAST(MONTH(@fecha) AS varchar) AS varchar(2)), 2) +'/'+ right('00'+ CAST(CAST(DAY(@fecha) AS varchar) AS varchar(2)), 2) +'/'+ CAST(YEAR(@fecha) AS varchar)
		ELSE SET @valor = REPLACE(@valor, ',', '.')
		
		SET @Filtro = @Filtro + @alias + @columnaMaestra +' '+ @expresion + ' '''+ @valor +''' AND '
		
		FETCH NEXT FROM @Condiciones INTO @tipoDato, @seleccion, @fecha, @valor, @columnaMaestra, @expresion, @variable_id, @tipoMedida, @esFiltro
	END CLOSE @Condiciones DEALLOCATE @Condiciones
	IF right(@Filtro, 4) = 'AND '  SET @queryWhere = ' AND NOT ('+ LEFT(@Filtro, LEN(@Filtro)-4) +')'
	
	--SELECT @queryWhere
	RETURN @queryWhere
END