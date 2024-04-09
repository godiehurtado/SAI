-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 19/04/2012
-- Description:	Duplicalas Subreglas Agrupadas complejas.
-- =============================================
CREATE PROCEDURE [dbo].[DuplicarAgrupacionesDeAgrupaciones]

@reglaNueva AS INT

AS
BEGIN

	-- *********************************************************************************************************
	-- INICIO CURSOR 3 (Duplica las Subreglas Agrupadas Complejas).
	-- *********************************************************************************************************--	
					DECLARE @cAgrupadaNueva AS INT
					DECLARE @subreglaNueva AS INT

					DECLARE @cursor3 CURSOR
					SET @cursor3= cursor FOR
					
					SELECT ac.CANueva FROM AgrupacionxCA ac	WHERE ac.subregla_idNueva IS NULL
								
					DECLARE @id3 AS INT
					OPEN @cursor3

					FETCH NEXT FROM @cursor3
					INTO @id3

					WHILE @@fetch_status = 0
					BEGIN
										
							-- Inserta las subreglas relacionadas con las condicionesAgrupadas simples duplicadas
								INSERT INTO SubRegla (regla_id, descripcion, principal, tipoSubregla, condicionAgrupada_id)
								SELECT @reglaNueva
								, (SELECT sr.descripcion FROM SubRegla sr WHERE sr.id = ac.subregla_id)
								, (SELECT sr.principal FROM SubRegla sr WHERE sr.id = ac.subregla_id) --> Principal
								, 2 --> tipoSubRegla: Agrupada
								, @id3
								FROM AgrupacionxCA ac
								WHERE ac.CANueva = @id3
											
								PRINT 'El id es: ' + CAST(@id3 AS NVARCHAR (10))
								
							-- Obtiene el id de la última subregla insertada.
								SET @subreglaNueva = (SELECT MAX(sr.id) FROM SubRegla sr WHERE sr.regla_id = @reglaNueva)
										
								UPDATE AgrupacionxCA
								SET subregla_idNueva = @subreglaNueva
								WHERE CANueva = @id3
								
							-- Inserta los premiosxsubregla relacionados con las subreglas agrupadas simples duplicadas
								INSERT INTO PremioxSubregla (subregla_id, premio_id)
								SELECT ac.subregla_idNueva
								, (SELECT ps.premio_id FROM PremioxSubregla ps WHERE ac.subregla_id = ps.subregla_id)
								FROM AgrupacionxCA ac
								WHERE ac.CANueva = @id3
													
								FETCH NEXT FROM @cursor3
								INTO @id3

					END

					CLOSE @cursor3
					DEALLOCATE @cursor3
					
					DELETE FROM PremioxSubregla WHERE premio_id IS NULL
	
END