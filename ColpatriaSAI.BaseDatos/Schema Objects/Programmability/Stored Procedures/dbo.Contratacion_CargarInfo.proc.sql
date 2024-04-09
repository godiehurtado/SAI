-- =============================================
-- Author:		Frank Payares
-- Create date: 29/12/2011
-- Description:	Carga información de modelos de contratación por hoja de Excel leido
-- =============================================
CREATE PROCEDURE [dbo].[Contratacion_CargarInfo]
	@hoja			ModelosContratacion READONLY,
	@esUltimaHoja	int
AS
BEGIN
	BEGIN TRY /* DECLARE @hoja ModelosContratacion, @esUltimaHoja int=0
		INSERT INTO @hoja VALUES 
			('5', '17', 'CAPI INIC COLQ MES', '3.60', '2')
		*/
		-- INSERTAR LA INFORMACION DE LA HOJA
		DECLARE /*@id int,*/ @codModelo varchar(20), @codMeta varchar(20), @nombreMeta varchar(100), @peso float, @escala int, @guardar int=0, @meta_id int=0, @modelo_id int=0, @factorxnota int=0
		DECLARE @HojaList CURSOR SET @HojaList = CURSOR LOCAL SCROLL FOR  SELECT CodModelo, CodMeta, NombreMeta, Peso, CodEscala FROM @hoja
		
		OPEN @HojaList FETCH NEXT FROM @HojaList INTO @codModelo, @codMeta, @nombreMeta, @peso, @escala
		WHILE @@FETCH_STATUS = 0 BEGIN
			IF @peso <> 0 BEGIN
				SET @modelo_id = (SELECT id FROM Modelo WHERE id = @codModelo)
				IF @modelo_id <> 0 AND @modelo_id <> '' AND @modelo_id IS NOT NULL BEGIN -- CONTINUAR SI EL MODELO ES VÁLIDO ES VÁLIDA
					
					SET @meta_id = (SELECT id FROM Meta WHERE id = @codMeta)
					IF @meta_id <> 0 AND @meta_id <> '' AND @meta_id IS NOT NULL BEGIN -- CONTINUAR SI LA META ES VÁLIDA
						
						SET @factorxnota = (SELECT id FROM FactorxNota WHERE id = @escala)
						IF @factorxnota <> 0 AND @factorxnota <> '' AND @factorxnota IS NOT NULL BEGIN -- CONTINUAR SI LA ESCALA META ES VÁLIDA
						
							IF NOT EXISTS(SELECT * FROM ModeloxMeta WHERE modelo_id=@modelo_id AND meta_id=@meta_id)
								INSERT INTO ModeloxMeta VALUES (@peso, @modelo_id, @meta_id, @escala) -- INSERCIÓN DE LOS PESOS DEL MODELO DE CONTRATACIÓN
						END
					END
				END
				SET @modelo_id=0  SET @meta_id=0  SET @factorxnota=0
			END
			FETCH NEXT FROM @HojaList INTO @codModelo, @codMeta, @nombreMeta, @peso, @escala
		END CLOSE @HojaList DEALLOCATE @HojaList
		--
		
		-- PROCESAR LOS PESOS CARGADOS
		IF @esUltimaHoja = 1 BEGIN
			print ''
		END
		
		RETURN 1
	END TRY
	BEGIN CATCH
		RETURN 0
	END CATCH

END
/*
SELECT * FROM ModeloxMeta
delete from ModeloxMeta WHERE id > 2
DBCC CHECKIDENT('ModeloxMeta', RESEED, 2)
*/