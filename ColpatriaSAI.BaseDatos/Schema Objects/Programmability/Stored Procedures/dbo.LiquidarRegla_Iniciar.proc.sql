-- =============================================
-- Author:		Frank Payares
-- Create date: 03/10/2011
-- Description:	Inicia y gestiona la liquidacion de una regla de un concurso
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_Iniciar]
	@IdConcurso int,
	@IdRegla int,
	@fechaInicio datetime,
	@fechaFinal datetime
AS
BEGIN
	BEGIN TRY
		-- DECLARE @IdConcurso int=260 DECLARE @IdRegla int=302,  @fechaInicio datetime='2012-01-01',  @fechaFinal datetime='2012-06-30'
		--**************************************************************************************************
		-- PREPARAR EL INICIO DE LA LIQUIDACIÓN. EN ESTE PASO SE CREAN LAS TABLAS DE LIQUIDACIÓN TEMPORALES PARA GUARDAR LOS DATOS Y AL FINAL INSERTAR EN LAS TABLAS DE LIQUIDACIÓN DEFINITIVAS
		--**************************************************************************************************
		SET NOCOUNT ON;		DELETE FROM ProcesoLiquidacion WHERE tipo=1		EXEC dbo.LiquidarRegla_EliminarTablasLiquidacion
		
		DECLARE @concurso_id int=@IdConcurso, @Id_Regla int=@IdRegla, @Fecha_Inicio datetime=@fechaInicio, @Fecha_Final datetime=@fechaFinal, @subregla_id int, @regla_id int, @idLiquiRegla int=0, @idLiquiReglaPpante int=0,
			@idDetLiquiRegla int=0, @idDetLiquiSubRegla int=0, @TimeStart datetime2(7)=GETDATE(), @registrosCM int=0
			
		-- Obtenemos el sigte id de las tablas de liquidación Definitivas para inicializar las llaves de las Temporales
		SET @idLiquiRegla		= ((SELECT ISNULL(MAX(id),0) FROM LiquidacionRegla)+1)
		SET @idLiquiReglaPpante	= ((SELECT ISNULL(MAX(id),0) FROM LiquidacionReglaxParticipante)+1)
		SET @idDetLiquiRegla	= ((SELECT ISNULL(MAX(id),0) FROM DetalleLiquidacionRegla)+1)
		SET @idDetLiquiSubRegla	= ((SELECT ISNULL(MAX(id),0) FROM DetalleLiquidacionSubRegla)+1)
		
		INSERT INTO ProcesoLiquidacion VALUES (1, @idLiquiRegla, GETDATE(), 1) -- Se coloca la liquidación actual en curso para que sea visible en el sistema
		DECLARE @tipoConcurso int = (SELECT tipoConcurso_id FROM Concurso WHERE id=@concurso_id)
		
		-- Creación de las tablas de liquidación Temporales
		CREATE TABLE LiquiRegla (id int, regla_id int, fecha_liquidacion datetime, fecha_inicial datetime, fecha_final datetime, estado int)
		CREATE TABLE LiquiReglaxPpante (id int IDENTITY(1,1), liquidacionRegla_id int, participante_id int, jerarquiaDetalle_id int)
		CREATE TABLE DetalleLiquiRegla (id int IDENTITY(1,1), liquidacionReglaxParticipante_id int, subregla_id int, resultado bit, ppante_id int)
		CREATE NONCLUSTERED INDEX [ppante_id_index] ON [dbo].[DetalleLiquiRegla] ( ppante_id ASC ) WITH (STATISTICS_NORECOMPUTE=OFF, SORT_IN_TEMPDB=OFF, IGNORE_DUP_KEY=OFF, DROP_EXISTING=OFF, ONLINE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON) ON [PRIMARY]
		CREATE TABLE DetalleLiquiSubRegla (id int IDENTITY(1,1), detalleLiquidacionRegla_id int, condicion_id int, resultado float)
		
		-- Inicialización de las llaves de las tablas Temporales
		DBCC CHECKIDENT('LiquiReglaxPpante', RESEED, @idLiquiReglaPpante) WITH NO_INFOMSGS
		DBCC CHECKIDENT('DetalleLiquiRegla', RESEED, @idDetLiquiRegla) WITH NO_INFOMSGS
		DBCC CHECKIDENT('DetalleLiquiSubRegla', RESEED, @idDetLiquiSubRegla) WITH NO_INFOMSGS
		
		
		--**************************************************************************************************
		-- OBTENER LA LISTA DE PARTICIPANTES DEL CONCURSO INDICADO
		--**************************************************************************************************
		EXEC dbo.LiquidarRegla_ObtenerParticipantes @concurso_id
		INSERT INTO LiquiRegla VALUES (@idLiquiRegla, @Id_Regla, GETDATE(), @Fecha_Inicio, @Fecha_Final, 1)
		SET NOCOUNT OFF;
		UPDATE LiquiReglaxPpante SET liquidacionRegla_id = @idLiquiRegla
		SET NOCOUNT ON;
		
		DECLARE @Participantes varchar(MAX)='', @Ppantes varchar(MAX)=''
		IF @tipoConcurso=1
			-- Se guarda en variable los participantes si el consurso es de Asesores o de Ejecutivos
			SELECT @Ppantes = @Ppantes + CAST(participante_id AS varchar(10)) +',' FROM LiquiReglaxPpante
		ELSE
			SELECT @Ppantes = @Ppantes + CAST(jerarquiaDetalle_id AS varchar(10)) +',' FROM LiquiReglaxPpante		--select @Ppantes--select count(id) from dbo.SplitCondiciones(@Ppantes, ',')
		
		
		--**************************************************************************************************
		-- OBTENER LISTA DE SUBREGLAS DE LA REGLA
		--**************************************************************************************************
		DECLARE @TablaQueries TablaQueries
		DECLARE @CondAgrup_id int, @SubReglaList CURSOR
		SELECT @CondAgrup_id=condicionAgrupada_id, @subregla_id=id FROM SubRegla WHERE regla_id=@Id_Regla AND principal = 1				--select @CondAgrup_id
		
		IF @CondAgrup_id IS NULL BEGIN
			-- Si la subregla inicial es simple, quiere decir de que la liquidación es Simple. Obtenemos las subreglas simples para liquidarlas
			SET @SubReglaList = CURSOR FAST_FORWARD FOR  SELECT DISTINCT S.id FROM SubRegla S JOIN Condicion C ON S.id = C.subregla_id WHERE S.regla_id=@Id_Regla AND condicionAgrupada_id IS NULL AND tipoSubregla <> 3
			
		END ELSE BEGIN -- Si la subregla inicial es agrupada, quiere decir de que la liquidación es Agrupada
			EXEC dbo.LiquidarRegla_GestionarExistentes 1, NULL
			-- También guardamos en la tabla 'liquidacionReglasAgrupadas' las agrupaciones de la regla para evaluar su liquidación
			EXEC dbo.LiquidarRegla_ConstruirQueryAgrupado @Id_Regla
			-- Y creamos una lista de las subreglas simples de la regla agrupada
			SET @SubReglaList = CURSOR FAST_FORWARD FOR  SELECT * FROM SubReglasTemp ORDER BY id
		END		--SELECT * FROM liquidacionReglasAgrupadas		--SELECT * FROM SubReglasTemp
		
		-- Se cambia de estado la liquidación actual para que sea visible en el sistema
		UPDATE ProcesoLiquidacion SET estadoProceso_id = 2 WHERE tipo=1 AND liquidacion_id=@idLiquiRegla
		
		OPEN @SubReglaList FETCH NEXT FROM @SubReglaList INTO @subregla_id
		-- Recorremos cada subregla simple de la regla
		WHILE @@FETCH_STATUS = 0 BEGIN
			IF @tipoConcurso=1 
				-- Definimos los participantes si el consurso de la regla es de Asesores
				INSERT INTO DetalleLiquiRegla  SELECT id, @subregla_id, NULL, participante_id FROM LiquiReglaxPpante
			ELSE
				-- Definimos los participantes si el consurso de la regla es de Ejecutivos
				INSERT INTO DetalleLiquiRegla  SELECT id, @subregla_id, NULL, jerarquiaDetalle_id FROM LiquiReglaxPpante
				
			-- Guardamos la(s) variable(s) de liquidación de la subregla que representan campos a consultar. A su vez se prefiltra la liquidación para optimizar el proceso
			EXEC dbo.LiquidarRegla_VerificarOrigenDatos @subregla_id, @Fecha_Inicio, @Fecha_Final
			FETCH NEXT FROM @SubReglaList INTO @subregla_id
		END CLOSE @SubReglaList DEALLOCATE @SubReglaList			--SELECT * FROM @TablaQueries		--select * from DetalleLiquiRegla --where ppante_id=5
		
		DECLARE @anioEnCurso int = YEAR(@Fecha_Inicio)
		-- Según la parametrización de descuentos que tenga, se deberá descontar los colquines de las tablas de liquidación
		EXEC dbo.LiquidarRegla_RecalcularTemporales @anioEnCurso, @Id_Regla
		
		EXEC dbo.LiquidarRegla_GestionarExistentes 0, NULL
		ALTER INDEX [ppante_id_index] ON [dbo].[DetalleLiquiRegla] REBUILD PARTITION = ALL WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON, ONLINE=OFF, SORT_IN_TEMPDB=OFF)
		

		--**************************************************************************************************
		-- GENERAR LIQUIDACIÓN DE LA REGLA INDICADA CON LAS VARIABLES DE LIQUIDACIÓN OBTENIDAS Y LAS AGRUPACIONES, SI LAS TIENE
		--**************************************************************************************************
		-- Se cambia de estado la liquidación actual para que sea visible en el sistema
		UPDATE ProcesoLiquidacion SET estadoProceso_id = 3 WHERE tipo=1 AND liquidacion_id=@idLiquiRegla 
		
		-- Se genera la liquidación de las subreglas simples generando queries a través de las variables de liquidación obtenidas
		EXEC dbo.LiquidarRegla_LiquidarSimples @Fecha_Inicio, @Fecha_Final, @Ppantes
		
		DECLARE @i int=1, @participante int, @detLiqRegla_id int=0, @resultado bit='', @resultado2 varchar(25)='', @totalPpantes int=0

		IF @CondAgrup_id IS NOT NULL BEGIN -- Se genera la liquidación de las subreglas agrupadas, si las tiene
			DECLARE @ParticipanteList CURSOR
			IF @tipoConcurso=1
				SET @ParticipanteList = CURSOR LOCAL SCROLL FOR SELECT participante_id FROM LiquiReglaxPpante
			ELSE
				SET @ParticipanteList = CURSOR LOCAL SCROLL FOR SELECT jerarquiaDetalle_id FROM LiquiReglaxPpante
				
			OPEN @ParticipanteList FETCH NEXT FROM @ParticipanteList INTO @participante
			-- Se recorre cada participante para evaluar las subreglas agrupadas que se encuentran en 'liquidacionReglasAgrupadas'
			WHILE @@FETCH_STATUS = 0 BEGIN  --print cast(@participante as varchar(10))
				DECLARE @DetLiquiReglaAgrup CURSOR
				SET @DetLiquiReglaAgrup = CURSOR FAST_FORWARD FOR   SELECT id, liquidacionReglaxParticipante_id, subregla_id, ppante_id, resultado FROM DetalleLiquiRegla WHERE ppante_id = @participante ORDER BY subregla_id
				
				OPEN @DetLiquiReglaAgrup FETCH NEXT FROM @DetLiquiReglaAgrup INTO @idDetLiquiSubRegla, @detLiqRegla_id, @subregla_id, @participante, @resultado
				-- Se recorre cada subregla simple para obtener los resultados y asi evaluar las subreglas agrupadas
				WHILE @@FETCH_STATUS = 0 BEGIN  --print cast(@resultado as varchar(1))
					-- Se acualiza el resultado de la subregla simple actual en la tabla 'liquidacionReglasAgrupadas'
					UPDATE liquidacionReglasAgrupadas SET resultado1=@resultado WHERE subregla_id1=@subregla_id
					UPDATE liquidacionReglasAgrupadas SET resultado2=@resultado WHERE subregla_id2=@subregla_id
					
					FETCH NEXT FROM @DetLiquiReglaAgrup INTO @idDetLiquiSubRegla, @detLiqRegla_id, @subregla_id, @participante, @resultado
				END CLOSE @DetLiquiReglaAgrup DEALLOCATE @DetLiquiReglaAgrup
				
				-- Una vez actualizados los resultados de las subreglas simples del participante actual, se procede a liquidar las subreglas agrupadas de dicho participante
				EXEC dbo.LiquidarRegla_LiquidarAgrupadas @detLiqRegla_id
				SET @totalPpantes = @totalPpantes + 1
				
				FETCH NEXT FROM @ParticipanteList INTO @participante
			END CLOSE @ParticipanteList DEALLOCATE @ParticipanteList
			
			PRINT '¡Liquidación de subreglas agrupadas a '+ CAST(@totalPpantes as varchar(10)) +' participantes completado!'  PRINT ''/**/
		END
		SET NOCOUNT OFF; --SELECT * FROM LiquiRegla  SELECT * FROM LiquiReglaxPpante  SELECT * FROM DetalleLiquiRegla  SELECT * FROM DetalleLiquiSubRegla
		

		--**************************************************************************************************
		-- UNA VEZ GENERADA LA INFO EN LAS TABLAS TEMPORALES, SE INSERTA ESA INFO EN LAS TABLAS DEFINITIVAS
		--**************************************************************************************************
		SET IDENTITY_INSERT LiquidacionRegla ON
		INSERT INTO LiquidacionRegla (id, regla_id, fecha_liquidacion, fecha_inicial, fecha_final, estado)  SELECT * FROM LiquiRegla
		SET IDENTITY_INSERT LiquidacionRegla OFF
		
		SET IDENTITY_INSERT LiquidacionReglaxParticipante ON
		INSERT INTO LiquidacionReglaxParticipante (id, liquidacionRegla_id, participante_id, jerarquiaDetalle_id)  SELECT id, liquidacionRegla_id, participante_id, jerarquiaDetalle_id FROM LiquiReglaxPpante
		SET IDENTITY_INSERT LiquidacionReglaxParticipante OFF
		
		SET IDENTITY_INSERT DetalleLiquidacionRegla ON
		INSERT INTO DetalleLiquidacionRegla (id, liquidacionReglaxParticipante_id, subregla_id, resultado)  SELECT id, liquidacionReglaxParticipante_id, subregla_id, resultado FROM DetalleLiquiRegla
		SET IDENTITY_INSERT DetalleLiquidacionRegla OFF
		
		SET IDENTITY_INSERT DetalleLiquidacionSubRegla ON
		INSERT INTO DetalleLiquidacionSubRegla (id, detalleLiquidacionRegla_id, condicion_id, resultado)  SELECT * FROM DetalleLiquiSubRegla
		SET IDENTITY_INSERT DetalleLiquidacionSubRegla OFF
		
		-- Al insertar, se reconstruyen los indices en las tablas donde contengan para obtimizar la liquidación de premios y los reportes
		ALTER INDEX [IX_liquidacionRegla_id_LiquidacionReglaxParticipante] ON [dbo].[LiquidacionReglaxParticipante] REBUILD PARTITION = ALL WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON, ONLINE=OFF, SORT_IN_TEMPDB=OFF)
		ALTER INDEX [IX_liquidacionReglaxParticipante_id_DetalleLiquidacionRegla] ON [dbo].[DetalleLiquidacionRegla] REBUILD PARTITION = ALL WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON, ONLINE=OFF, SORT_IN_TEMPDB=OFF)
		ALTER INDEX [IX_subregla_id_DetalleLiquidacionRegla] ON [dbo].[DetalleLiquidacionRegla] REBUILD PARTITION = ALL WITH (PAD_INDEX=OFF, STATISTICS_NORECOMPUTE=OFF, ALLOW_ROW_LOCKS=ON, ALLOW_PAGE_LOCKS=ON, ONLINE=OFF, SORT_IN_TEMPDB=OFF)
		
		-- Se les asignan premios a los participantes que cumplieron con las condiciones de la liquidación actual
		EXEC dbo.LiquidacionPremios @idLiquiRegla
		
		-- Se eliminan todas las tablas que se crearon para generar la liquidación
		EXEC dbo.LiquidarRegla_EliminarTablasLiquidacion
		
		SET NOCOUNT ON;
		-- Se le indica al sistema de que la liquidación actual terminó
		UPDATE ProcesoLiquidacion SET estadoProceso_id = 4 WHERE tipo=1 AND liquidacion_id=@idLiquiRegla		DELETE FROM ProcesoLiquidacion WHERE tipo=1
		SET NOCOUNT OFF;
		
		PRINT CHAR(13)+'¡LIQUIDACION FINALIZADA!  Tiempo transcurrido: ' + CAST((convert(float, DateDiff(ss, @TimeStart, GETDATE()))/60) as nvarchar(24)) + ' minutos'
		
		RETURN 1
	END TRY
	BEGIN CATCH
		UPDATE ProcesoLiquidacion SET estadoProceso_id = 6 WHERE tipo=1 AND liquidacion_id=@idLiquiRegla -- En caso de error en la liquidación se le indica al sistema de lo ocurrido
		RETURN 0
	END CATCH

END