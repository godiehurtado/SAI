
-- =============================================
-- Author:		Frank Payares
-- Create date: 06/10/2011
-- Description:	Reune los campos a consultar con base en las condiciones de determinada subregla y prefiltra la liquidación creando tablas temporales
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_VerificarOrigenDatos]
	@subregla_id	int,
	@fechaInicio	datetime,
	@fechaFinal		datetime
AS
BEGIN
	--DECLARE @subregla_id int=3362, @fechaInicio datetime='2011-03-01', @fechaFinal datetime='2011-03-31'
	DECLARE @idSubregla int=@subregla_id, @fecha_inicio datetime=@fechaInicio, @fecha_final datetime=@fechaFinal, @condicion_id int=0, @tipoTabla int=0, @columnaMaestra varchar(50)='', 
		@crearTipoTabla1 int=0, @crearTipoTabla2 int=0, @crearTipoTabla3 int=0, @crearTipoTabla4 int=0, @var varchar(500)='', @filtrarAnioAnterior int=0
	DECLARE @tipoConcurso int = ( SELECT C.tipoConcurso_id FROM SubRegla SR JOIN Regla R ON R.id=SR.regla_id JOIN Concurso C ON C.id=R.concurso_id WHERE SR.id=@idSubregla )
	
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TiposTablas]') AND type in (N'U'))	DROP TABLE TiposTablas
	-- Se guarda en una tabla los diferentes tipo tabla dependiendo del tipo de concurso de la regla
	IF @tipoConcurso = 1  SELECT id INTO TiposTablas FROM (SELECT 1 id UNION SELECT 2 id) T1  ELSE  SELECT id INTO TiposTablas FROM (SELECT 3 id UNION SELECT 4 id) T1


	--**************************************************************************************************
	-- OBTENER LISTA DE CONDICIONES PARA LISTAR LOS CAMPOS
	--**************************************************************************************************	
	DECLARE @Condiciones CURSOR SET @Condiciones = CURSOR FAST_FORWARD FOR 
		SELECT DISTINCT condicion_id, C.columnaTablaMaestra, TTV.tipotabla_id
		FROM CondicionesVariables AS C INNER JOIN Variable V ON C.variable_id = V.id JOIN TipoTablaVariable TTV ON TTV.variable_id = V.id
		WHERE subregla_id = @idSubregla AND TTV.tipotabla_id IN (SELECT * FROM TiposTablas) AND V.esFiltro=0 ORDER BY condicion_id
		
	-- ****** CONSTRUIR QUERY CON CONDICIONES QUE CONTIENEN VARIABLES DE LIQUIDACIÓN LAS CUALES CONFORMARAN EL QUERY SELECT A CONSTRUIR
	OPEN @Condiciones FETCH NEXT FROM @Condiciones INTO @condicion_id, @columnaMaestra, @tipoTabla
	-- Recorre cada variable de liquidación de las condiciónes de la subregla simple actual
	WHILE @@FETCH_STATUS = 0 BEGIN
		
		IF @condicion_id <> 0 AND @columnaMaestra <> '' BEGIN
			IF @tipoTabla = 1  SET @crearTipoTabla1 = 1 -- Indica que se debe crear la tabla temporal prefiltrada de la tabla TablaMaestra
			IF @tipoTabla = 2  SET @crearTipoTabla2 = 1 -- Indica que se debe crear la tabla temporal prefiltrada de la tabla ConsolidadoMes
			IF @tipoTabla = 3  SET @crearTipoTabla3 = 1 -- Indica que se debe crear la tabla temporal prefiltrada de la tabla ConsolidadoMesEjecutivo
			IF @tipoTabla = 4  SET @crearTipoTabla4 = 1 -- Indica que se debe crear la tabla temporal prefiltrada de la vista PresupuestoEjecutadoxMeta
		END
		FETCH NEXT FROM @Condiciones INTO @condicion_id, @columnaMaestra, @tipoTabla
	END CLOSE @Condiciones DEALLOCATE @Condiciones
	-------
	
	-- CREA LAS TABLAS DE LIQUIDACIÓN CON INFORMACIÓN FILTRADA POR EL PERIODO A LIQUIDAR. SE CREAN LAS TABLAS DEPENDIENDO DE LAS VARIABLES DE LIQUIDACIÓN CONFIGURADAS
	DECLARE @regla_id int = (SELECT regla_id FROM SubRegla WHERE id=@idSubregla)

	SELECT @var=@var + cast(v.id as varchar(10)) +',' FROM CondicionesVariables c INNER JOIN Variable v ON v.id=c.variable_id INNER JOIN SubRegla sr ON sr.id=c.subregla_id
	WHERE sr.regla_id = @regla_id AND v.esFiltro=0 GROUP BY v.id
	IF CHARINDEX(N'13,', @var)<>0  SET @filtrarAnioAnterior=1
	
	EXEC dbo.LiquidarRegla_GenerarTablasFiltradas @regla_id, @crearTipoTabla1, @crearTipoTabla2, @crearTipoTabla3, @crearTipoTabla4, @fecha_inicio, @fecha_final, @filtrarAnioAnterior
	
END