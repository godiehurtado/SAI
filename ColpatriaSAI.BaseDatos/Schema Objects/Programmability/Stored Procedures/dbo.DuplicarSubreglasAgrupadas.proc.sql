-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 19/04/2012
-- Description:	Duplica las Subreglas Agrupadas simples y complejas.
-- =============================================
CREATE PROCEDURE [dbo].[DuplicarSubreglasAgrupadas]

AS
BEGIN

	-- *********************************************************************************************************
	-- INICIO CURSOR 0 (Duplica las Subreglas Agrupadas Simples en la tabla Condicion Agrupada).
	-- *********************************************************************************************************--
-- Tabla de Agrupaciones x CondicionesAgrupadas simples
	CREATE TABLE AgrupacionxCA(
    CAActual INT NULL,
    subregla_id INT NULL,
    CANueva INT NULL,
    subregla_idNueva INT NULL)    

	DECLARE @cAgrupadaNueva AS INT
 
--  Cursor que recorre las reglas del concurso. 
	DECLARE @cursorxregla CURSOR			
	SET @cursorxregla = cursor FOR
	
	SELECT DISTINCT reglaActual, reglaNueva FROM DuplicarSubreglas ORDER BY reglaActual, reglaNueva
	
	DECLARE @reglaActual AS INT, @reglaNueva AS INT
	OPEN @cursorxregla

	FETCH NEXT FROM @cursorxregla
	INTO @reglaActual, @reglaNueva

	WHILE @@fetch_status = 0
	BEGIN
	
				--  Cursor que inserta en CondicionAgrupada. 
					DECLARE @cursor CURSOR					
					SET @cursor = cursor FOR
					
				-- Se obtiene las agrupaciones simples, es decir, las subreglas que agrupan subreglas simples.
					SELECT ca.id AS condicionAgrupada, sr.id AS subregla FROM CondicionAgrupada ca
					INNER JOIN SubRegla sr1 ON sr1.id = ca.subregla_id1
					INNER JOIN SubRegla sr2 ON sr2.id = ca.subregla_id2
					INNER JOIN SubRegla sr ON sr.condicionAgrupada_id = ca.id
					WHERE ca.regla_id = @reglaActual --> reglaActual
					AND sr1.condicionAgrupada_id IS NULL
					AND sr2.condicionAgrupada_id IS NULL
					ORDER BY condicionAgrupada, subregla
					
					DECLARE @id AS INT, @subregla_id AS INT
					OPEN @cursor

					FETCH NEXT FROM @cursor
					INTO @id, @subregla_id

					WHILE @@fetch_status = 0
					BEGIN	

								INSERT INTO CondicionAgrupada(subregla_id1, subregla_id2, operador_id, regla_id, nombre)
								SELECT 
								(SELECT subreglaNueva FROM DuplicarSubreglas ds WHERE ds.subreglaActual = ca.subregla_id1)
								, (SELECT subreglaNueva FROM DuplicarSubreglas ds WHERE ds.subreglaActual = ca.subregla_id2)
								, ca.operador_id
								, @reglaNueva --> @reglaNueva
								, ca.nombre
								FROM CondicionAgrupada ca
								WHERE ca.id = @id
								
								SET @cAgrupadaNueva = (SELECT MAX(ca.id) FROM CondicionAgrupada ca WHERE ca.regla_id = @reglaNueva) --> @reglaNueva
																			
								PRINT 'El id de CA Actual es: ' + CAST(@id AS NVARCHAR (10)) + ' y la subregla: ' + CAST(@subregla_id AS NVARCHAR (10)) + ' El id de CA Nueva es: ' + CAST(@cAgrupadaNueva AS NVARCHAR (10))
							       
								INSERT INTO AgrupacionxCA (CAActual, subregla_id, CANueva)
								VALUES (@id, @subregla_id, @cAgrupadaNueva) 

								FETCH NEXT FROM @cursor
								INTO @id, @subregla_id

					END

					CLOSE @cursor
					DEALLOCATE @cursor
					
	FETCH NEXT FROM @cursorxregla
	INTO @reglaActual, @reglaNueva

	END

	CLOSE @cursorxregla
	DEALLOCATE @cursorxregla
	
	-- *********************************************************************************************************
	-- INICIO CURSOR 1 (Duplicar Subreglas Agrupadas Simples en la tabla Subregla).
	-- *********************************************************************************************************--
	DECLARE @subreglaNueva AS INT
				
--  Cursor que inserta en SubRegla. 
	DECLARE @cursor1 CURSOR
	SET @cursor1 = cursor FOR	
							
	SELECT ac.CANueva FROM AgrupacionxCA ac	ORDER BY ac.CANueva
	DECLARE @reglaxCA AS INT
							
	DECLARE @id1 AS INT
	OPEN @cursor1

	FETCH NEXT FROM @cursor1
	INTO @id1

	WHILE @@fetch_status = 0
	BEGIN
	
	SET @reglaxCA = (SELECT ca.regla_id FROM CondicionAgrupada ca WHERE ca.id = @id1)
									
						-- Inserta las subreglas relacionadas con las condicionesAgrupadas simples duplicadas
							INSERT INTO SubRegla (regla_id, descripcion, principal, tipoSubregla, condicionAgrupada_id)
							SELECT @reglaxCA as r
							, (SELECT sr.descripcion FROM SubRegla sr WHERE sr.id = ac.subregla_id) as s1
							, (SELECT sr.principal FROM SubRegla sr WHERE sr.id = ac.subregla_id)  as s2--> Principal
							, 2 as ts --> tipoSubRegla: Agrupada 
							, @id1 as ca
							FROM AgrupacionxCA ac
							WHERE ac.CANueva = @id1
										
							PRINT 'El id es: ' + CAST(@id1 AS NVARCHAR (10))
							
							SET @subreglaNueva = (SELECT MAX(sr.id) FROM SubRegla sr WHERE sr.regla_id = @reglaxCA)
									
						-- Toma el valor de la nueva subregla para reutilizarla en la inserción de CondicionAgrupada
							UPDATE AgrupacionxCA
							SET subregla_idNueva = @subreglaNueva
							WHERE CANueva = @id1
							
						-- Inserta los premiosxsubregla relacionados con las subreglas agrupadas simples duplicadas
							INSERT INTO PremioxSubregla (subregla_id, premio_id)
							SELECT ac.subregla_idNueva
							, (SELECT ps.premio_id FROM PremioxSubregla ps WHERE ac.subregla_id = ps.subregla_id)
							FROM AgrupacionxCA ac
							WHERE ac.CANueva = @id1
												
			FETCH NEXT FROM @cursor1
			INTO @id1

		END

	CLOSE @cursor1
	DEALLOCATE @cursor1
				
	DELETE FROM PremioxSubregla WHERE premio_id IS NULL
--
	-- *********************************************************************************************************
	-- INICIO CURSOR 2 (Duplicar Subreglas Agrupadas Complejas)
	-- *********************************************************************************************************--
	DECLARE @cursorxregla1 CURSOR			
	SET @cursorxregla1 = cursor FOR
	
	SELECT DISTINCT reglaActual, reglaNueva FROM DuplicarSubreglas ORDER BY reglaActual, reglaNueva
	
	DECLARE @reglaActual1 AS INT, @reglaNueva1 AS INT
	OPEN @cursorxregla1

	FETCH NEXT FROM @cursorxregla1
	INTO @reglaActual1, @reglaNueva1

	WHILE @@fetch_status = 0
	BEGIN
	
	CREATE TABLE #AgrupacionSimple(CAActual INT NULL,
	subregla_id INT NULL)
				
	CREATE TABLE #AgrupacionCompleja(CAActual INT NULL,
	subregla_id INT NULL)
				
-- Se obtiene el listado de Agrupaciones Simples.
	INSERT INTO #AgrupacionSimple(CAActual, subregla_id)
	SELECT ca.id AS condicionAgrupada, sr.id AS subregla
	FROM CondicionAgrupada ca
	INNER JOIN SubRegla sr1 ON sr1.id = ca.subregla_id1
	INNER JOIN SubRegla sr2 ON sr2.id = ca.subregla_id2
	INNER JOIN SubRegla sr ON sr.condicionAgrupada_id = ca.id
	WHERE ca.regla_id = @reglaActual1 --> reglaActual
	AND sr1.condicionAgrupada_id IS NULL
	AND sr2.condicionAgrupada_id IS NULL				
	ORDER BY condicionAgrupada, subregla

-- Se obtiene el listado de Agrupaciones Complejas.
	INSERT INTO #AgrupacionCompleja(CAActual, subregla_id)
	SELECT sr.condicionAgrupada_id AS condicionAgrupada
	, sr.id AS subregla
	FROM Subregla sr				
	INNER JOIN CondicionAgrupada ca ON sr.condicionAgrupada_id = ca.id
	WHERE sr.regla_id = @reglaActual1 --> reglaActual
	AND sr.condicionAgrupada_id IS NOT NULL					
	ORDER BY condicionAgrupada, subregla

				-- Cursor que inserta en CondicionAgrupada. 	
					DECLARE @cursor2 CURSOR	
					SET @cursor2 = cursor FOR
					
				-- Se obtiene las agrupaciones (complejas), es decir, las subreglas que agrupan subreglas agrupadas quitando las agrupaciones simples y ya duplicadas.
					SELECT ac.CAActual, ac.subregla_id FROM #AgrupacionCompleja ac
					WHERE NOT EXISTS
					(SELECT * FROM #AgrupacionSimple ags
					WHERE ags.CAActual = ac.CAActual
					AND ags.subregla_id = ac.subregla_id)
					
					DECLARE @id2 AS INT, @subregla AS INT
					OPEN @cursor2

					FETCH NEXT FROM @cursor2
					INTO @id2, @subregla

					WHILE @@fetch_status = 0
					BEGIN
								
								CREATE TABLE #HomologacionSubreglas(
								subreglaActual INT NULL,
								subreglaNueva INT NULL,
								CAActual INT NULL,
								CANueva INT NULL)   
							   
						--   Tabla utilizada para unir la información de las subreglas simples (La nueva y la anterior) y las CondicionesAgrupadas (La nueva y la anterior) 
						--   con la información de las CondicionesAgrupadas, solamente para la inserción de las condiciones agrupadas complejas.
							  INSERT INTO #HomologacionSubreglas (subreglaActual , subreglaNueva, CAActual, CANueva)
							  SELECT subreglaActual, subreglaNueva, CAActual, CANueva
							  FROM (SELECT ds.subreglaActual AS subreglaActual
								, ds.subreglaNueva AS subreglaNueva
								, 0 AS CAActual
								, 0 AS CANueva
								FROM DuplicarSubreglas ds
								UNION
								SELECT ac.subregla_id AS subreglaActual
								, ac.subregla_idNueva AS subreglaNueva
								, ac.CAActual
								, ac.CANueva
								FROM AgrupacionxCA ac) q1
								ORDER BY subreglaActual, subreglaNueva

							-- Inserta en CondicionAgrupada
								INSERT INTO CondicionAgrupada(subregla_id1, subregla_id2, operador_id, regla_id, nombre)
								SELECT 
								(SELECT subreglaNueva FROM #HomologacionSubreglas hs WHERE hs.subreglaActual = ca.subregla_id1)
								, (SELECT subreglaNueva FROM #HomologacionSubreglas hs WHERE hs.subreglaActual = ca.subregla_id2)
								, ca.operador_id
								, @reglaNueva1
								, ca.nombre
								FROM CondicionAgrupada ca
								WHERE ca.id = @id2
								
							-- Obtiene el valor de la nueva condicion agrupada insertada.
								SET @cAgrupadaNueva = (SELECT MAX(ca.id) FROM CondicionAgrupada ca WHERE ca.regla_id = @reglaNueva1)
																			
								PRINT 'El id de CA Actual es: ' + CAST(@id2 AS NVARCHAR (10)) + ' y la subregla: ' + CAST(@subregla AS NVARCHAR (10)) + ' El id de CA Nueva es: ' + CAST(@cAgrupadaNueva AS NVARCHAR (10))
							       
							-- Tabla que acumula las subreglas y condicionesAgrupadas nuevas y anteriores.
								INSERT INTO AgrupacionxCA (CAActual, subregla_id, CANueva)
								VALUES (@id2, @subregla, @cAgrupadaNueva)   
								
							-- Ejecuta el procedimiento para insertar las subreglas Complejas Agrupadas en dbo.SubRegla.
								EXEC dbo.DuplicarAgrupacionesDeAgrupaciones @reglaNueva1
								
								DROP TABLE #HomologacionSubreglas

								FETCH NEXT FROM @cursor2
								INTO @id2, @subregla

					END

					CLOSE @cursor2
					DEALLOCATE @cursor2
					
		DROP TABLE #AgrupacionCompleja
		DROP TABLE #AgrupacionSimple
						
		FETCH NEXT FROM @cursorxregla1
		INTO @reglaActual1, @reglaNueva1

	END

	CLOSE @cursorxregla1
	DEALLOCATE @cursorxregla1
					
	TRUNCATE TABLE DuplicarSubreglas
	DROP TABLE AgrupacionxCA

END