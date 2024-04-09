-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 21/03/2012
-- Description:	Crea tablas temporales filtradas con la info necesaria para la liquidación

-- 20/06/2012: (Linea 88) Se añadió código para reconstruir los indices de la tabla 'LiquiContratFactorParticipante' para optimizar la vista 'VistaRanking' y 
--				cambio de nombre de la tabla 'PresupuestoEjecutadoxMetaTemp' a 'PresupuestoEjecutado_TEMP'
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_GenerarTablasFiltradas]
	@reglaId				int,
	@crearTipoTabla1		int,
	@crearTipoTabla2		int,
	@crearTipoTabla3		int,
	@crearTipoTabla4		int,
	@fechaInicio			datetime,
	@fechaFinal				datetime,
	@filtrarAnioAnterior	int
AS
BEGIN
	-- declare @crearTipoTabla1 int=1, @crearTipoTabla2 int=0, @crearTipoTabla3 int=0, @crearTipoTabla4 int=0, @fechaInicio datetime='2011-01-01', @fechaFinal datetime='2011-12-31', @FiltroFecha varchar(50)='', @filtrarAnioAnterior int=0
	DECLARE @regla_id int=@reglaId, @crear1 int=@crearTipoTabla1, @crear2 int=@crearTipoTabla2, @crear3 int=@crearTipoTabla3, @crear4 int=@crearTipoTabla4, @fecha_inicio datetime=@fechaInicio, @fecha_final datetime=@fechaFinal,
		@permitirAnioAnterior int=@filtrarAnioAnterior, @i int=0, @whereDinamico varchar(500)='', @whereTM varchar(500)='', @mesAcumulado varchar(30)='', @query varchar(500)=''
		
	SET @i = MONTH(@fecha_inicio)
	WHILE @i <= MONTH(@fecha_final) BEGIN  SET @mesAcumulado = @mesAcumulado + CAST(@i AS varchar(2)) +','  SET @i=@i+1  END
	SET @whereDinamico = 'anio = '+CAST(YEAR(@fecha_inicio) AS varchar(4))+' AND mes IN ('+ left(@mesAcumulado, LEN(@mesAcumulado)-1) +')'
	
	SET ANSI_WARNINGS OFF
	
	IF @crear1 = 1 AND NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TablaMaestra_TEMP]') AND type in (N'U'))
	BEGIN
		SET @i = MONTH(@fecha_inicio)   SET @mesAcumulado=''
		WHILE @i <= MONTH(@fecha_final) BEGIN  SET @mesAcumulado = @mesAcumulado + CAST(@i AS varchar(2)) +','  SET @i=@i+1  END
		SET @whereTM = 'anioCierre = '+CAST(YEAR(@fecha_inicio) AS varchar(4))+' AND mesCierre IN ('+ left(@mesAcumulado, LEN(@mesAcumulado)-1) +')'  --print 'SELECT * INTO TablaMaestra_TEMP FROM TablaMaestra WHERE ('+ @Filtro +' BETWEEN '''+ @Fecha1 +''' AND '''+ @Fecha2 +''')'
		SET @query = 'SELECT * INTO TablaMaestra_TEMP FROM TablaMaestra WHERE '+ @whereTM /**/
		EXEC (@query)
		
		ALTER TABLE TablaMaestra_TEMP ADD actual float
		ALTER TABLE TablaMaestra_TEMP ADD descuento float
		ALTER TABLE TablaMaestra_TEMP ADD colquinesFinales float

		CREATE NONCLUSTERED INDEX [IX_participante_id] ON [dbo].[TablaMaestra_TEMP] ( participante_id ASC ) WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		CREATE NONCLUSTERED INDEX [IX_fechaExpedicionNegocio] ON [dbo].[TablaMaestra_TEMP] ( fechaExpedicionNegocio ASC ) WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		CREATE NONCLUSTERED INDEX [IX_producto_id] ON [dbo].[TablaMaestra_TEMP] ( producto_id ASC ) WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		
		print @query
		print 'Tabla TablaMaestra_TEMP creada' print ''
	END
	
	
	IF @crear2 = 1 AND NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsolidadoMes_TEMP]') AND type in (N'U'))
	BEGIN
		IF @permitirAnioAnterior = 0
			SET @query = 'SELECT * INTO ConsolidadoMes_TEMP FROM ConsolidadoMes WHERE año = '+ CAST(YEAR(@fecha_inicio) as varchar(4))
		ELSE
			SET @query = 'SELECT * INTO ConsolidadoMes_TEMP FROM ConsolidadoMes WHERE año BETWEEN '+ CAST((YEAR(@fecha_inicio)-1) as varchar(4)) +' AND '+ CAST(YEAR(@fecha_inicio) as varchar(4))
		
		EXEC (@query)
		
		ALTER TABLE ConsolidadoMes_TEMP ADD actual float
		ALTER TABLE ConsolidadoMes_TEMP ADD descuento float
		ALTER TABLE ConsolidadoMes_TEMP ADD colquinesFinales float

		CREATE NONCLUSTERED INDEX [IX_participante_id] ON [dbo].[ConsolidadoMes_TEMP] ( participante_id ASC ) WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		CREATE NONCLUSTERED INDEX [IX_producto_id] ON [dbo].[ConsolidadoMes_TEMP] ( producto_id ASC ) WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		
		print @query
		print 'Tabla ConsolidadoMes_TEMP creada' print ''
	END
	

	EXEC dbo.LiquidarRegla_IncluirResultadosPremios @regla_id
	
	
	IF @crear3 = 1 AND NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsolidadoMesEjecutivo_TEMP]') AND type in (N'U'))
	BEGIN
		SET @query = 'SELECT * INTO ConsolidadoMesEjecutivo_TEMP FROM ConsolidadoMesEjecutivo WHERE '+ @whereDinamico
		EXEC (@query)
		
		CREATE NONCLUSTERED INDEX [IX_jerarquiaDetalle_id] ON [dbo].[ConsolidadoMesEjecutivo_TEMP] ( jerarquiaDetalle_id ASC ) WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		--CREATE NONCLUSTERED INDEX [IX_producto_id] ON [dbo].[ConsolidadoMesEjecutivo_TEMP] ( producto_id ASC ) WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		CREATE NONCLUSTERED INDEX [IX_canal_id] ON [dbo].[ConsolidadoMesEjecutivo_TEMP] ( canal_id ASC ) WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		
		print @query
		print 'Tabla ConsolidadoMesEjecutivo_TEMP creada' print ''
	END
	
	IF @crear4 = 1 AND NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[PresupuestoEjecutado_TEMP]') AND type in (N'U'))
	BEGIN
		DECLARE @anio int = YEAR(@fecha_inicio)
		EXEC CalcularPresupuestoVsEjecutado @anio, @regla_id
		SET @query = 'SELECT * INTO PresupuestoEjecutado_TEMP FROM PresupuestoEjecutadoxMetaTemp WHERE '+ @whereDinamico
		EXEC (@query)
		
		print 'Tabla PresupuestoEjecutado_TEMP creada' print ''
	END
	
	SET ANSI_WARNINGS ON
END