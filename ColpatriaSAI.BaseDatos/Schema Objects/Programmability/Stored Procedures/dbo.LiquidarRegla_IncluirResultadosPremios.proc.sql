
-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 07/06/2012
-- Description:	Guarda premios de magrugadores en las tablas temporales filtradas sumando colquines cuando se liquida una regla que se deba sumar
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_IncluirResultadosPremios]
	@reglaId int
AS
BEGIN
	--DECLARE @reglaId int=301
	DECLARE @regla_id int=@reglaId, @variablesTablaMaestra int=0, @variablesConsolidado int=0, @registrosTablaMaestra int=0, @registrosConsolidado int=0, @anioEnCurso int = (SELECT valor FROM ParametrosApp WHERE id=3)
	
	-- Se valida de que la regla a liquidar sea periódica (Tipo de Regla 2)
	IF EXISTS( SELECT * FROM Regla WHERE id=@regla_id AND tipoRegla_id=2 ) BEGIN

		DECLARE @ultimaPremioAIncluir int = (SELECT TOP 1 lr.id FROM Regla r INNER JOIN LiquidacionRegla lr ON r.regla_id=lr.regla_id WHERE r.id=@regla_id ORDER BY lr.id DESC)
		
		-- Validamos si existe una última liquidación de la regla a sumar premios que esta parametrizada en la regla a liquidar
		IF @ultimaPremioAIncluir IS NOT NULL BEGIN
		
			SET @variablesTablaMaestra = ( SELECT COUNT(v.id) FROM SubRegla sr INNER JOIN Condicion c ON sr.id = c.subregla_id INNER JOIN Variable v ON v.id = c.variable_id WHERE sr.regla_id=@regla_id AND v.esFiltro=0 AND v.id = 3 )
			SET @variablesConsolidado = ( SELECT COUNT(v.id) FROM SubRegla sr INNER JOIN Condicion c ON sr.id = c.subregla_id INNER JOIN Variable v ON v.id = c.variable_id WHERE sr.regla_id=@regla_id AND v.esFiltro=0 AND v.id IN (172,186,187,188,189) )
			
			-- Validamos que las variables de la regla a liquidar son colquines
			IF @variablesTablaMaestra > 0 OR @variablesConsolidado > 0 BEGIN
				
				-- Se guardan los resultados de los premios de la regla a sumar
				SELECT * INTO #PremiosAIncluir FROM (
					SELECT -1 compania_id, p.id participante_id, p.clave, p.fechaIngreso, p.categoria_id, lp.resultado
					FROM LiquidacionRegla lr
						INNER JOIN LiquidacionReglaxParticipante lrxp ON lr.id = lrxp.liquidacionRegla_id AND lr.id = @ultimaPremioAIncluir
						INNER JOIN Participante p ON p.id = lrxp.participante_id
						INNER JOIN DetalleLiquidacionRegla dlr ON lrxp.id = dlr.liquidacionReglaxParticipante_id
						INNER JOIN PremioxSubregla pxs ON pxs.subregla_id = dlr.subregla_id
						INNER JOIN LiquidacionPremio lp ON lp.premio_id = pxs.premio_id AND lp.subregla_id = dlr.subregla_id AND lp.liquidacionReglaxParticipante_id = lrxp.id  --order by p.clave
				) AS T1
				
				-- Si esta creada la tabla 'TablaMaestra_TEMP' se guardan allí los premios de la regla a sumar
				IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[TablaMaestra_TEMP]') AND type in (N'U')) AND @variablesTablaMaestra > 0 BEGIN
					SELECT @registrosTablaMaestra = COUNT(id) FROM TablaMaestra_TEMP WHERE compania_id=-1
					
					-- Se valida de que ya se hayan ingresado esos datos
					IF  @registrosTablaMaestra = 0 BEGIN
						
						INSERT INTO TablaMaestra_TEMP (compania_id, participante_id, clave, fechaIngresoAsesor, categoria_id, cantidadColquines, conceptoDescuento_id)
						SELECT *, 0 FROM #PremiosAIncluir
						
						PRINT 'Premios de la ultima liquidación de Madrugadores con id '+ CAST(@ultimaPremioAIncluir AS varchar(10)) +' incluidos en la tabla TablaMaestra_TEMP'
					END
				END
				
				-- Si esta creada la tabla 'ConsolidadoMes_TEMP' se guardan allí los premios de la regla a sumar
				IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[ConsolidadoMes_TEMP]') AND type in (N'U')) AND @variablesConsolidado > 0 BEGIN
					SELECT @registrosConsolidado = COUNT(id) FROM ConsolidadoMes_TEMP WHERE compania_id=-1
					
					-- Se valida de que ya se hayan ingresado esos datos
					IF @registrosConsolidado = 0 BEGIN
						
						INSERT INTO ConsolidadoMes_TEMP (compania_id, tipoMedida_id, participante_id, clave, categoria_id, Etapa_1, Etapa_2, Etapa_3, Etapa_4, Etapa_5, año, fechaIngresoAsesor)
						SELECT compania_id, 2, participante_id, clave, categoria_id, resultado, resultado, resultado, resultado, resultado, @anioEnCurso, fechaIngreso FROM #PremiosAIncluir
						
						PRINT 'Premios de la ultima liquidación de Madrugadores con id '+ CAST(@ultimaPremioAIncluir AS varchar(10)) +' incluidos en la tabla ConsolidadoMes_TEMP'
					END
				END
				
				DROP TABLE #PremiosAIncluir
				
			END
			
		END
	END

END