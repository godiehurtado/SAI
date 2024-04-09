-- =============================================
-- Author:		Frank Payares
-- Create date: 29/12/2011
-- Description:	Carga información de presupuesto por hoja de Excel leido
-- =============================================
CREATE PROCEDURE [dbo].[Presupuesto_CargarInfo]
	@año			int,
	@presupuesto_id int,
	@hoja			PresupuestoDetalle READONLY,
	@hojaActual		varchar(50),
	@esUltimaHoja   int
AS
BEGIN
	BEGIN TRY
		-- INSERTAR LA INFORMACION DE LA HOJA
		DECLARE @añoTemp int=@año, @presupuesto_idTemp int=@presupuesto_id, @hojaTemp PresupuestoDetalle, @hojaActualTemp varchar(50)=@hojaActual, @esUltimaHojaTemp int=@esUltimaHoja
		INSERT INTO @hojaTemp SELECT * FROM @hoja
		
		DECLARE @id int, @nombreNodo varchar(100), @nombre varchar(100), @codigoNivel varchar(50), @codigoMeta varchar(100), @anio varchar(4), @Enero float, @Febrero float, @Marzo float, @Abril float, @Mayo float, @Junio float,
			@Julio float, @Agosto float, @Septiembre float, @Octubre float, @Noviembre float, @Diciembre float, @i int=0, @detalle_id int=0, @meta_id int=0, @fecha1 datetime, @fecha2 datetime, @valorRetorno int=1
		DECLARE @HojaList CURSOR SET @HojaList = CURSOR LOCAL SCROLL FOR
		SELECT id, codigoNivel, codigoMeta, anio, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre FROM @hojaTemp
		
		OPEN @HojaList FETCH NEXT FROM @HojaList INTO @id, @codigoNivel, @codigoMeta, @anio, @Enero, @Febrero, @Marzo, @Abril, @Mayo, @Junio, @Julio, @Agosto, @Septiembre, @Octubre, @Noviembre, @Diciembre  --print @codigoNivel--cast(@id as varchar(9)) +' '+ cast(@nombreNodo as varchar(9)) +' '+ cast(@nombre as varchar(9)) +' cod'+ cast(@codigoNivel as varchar(9)) +' cod'+ cast(@codigoMeta as varchar(9)) +' '+ cast(@anio as varchar(9)) +' '+ cast(@Enero as varchar(9)) +' '+ cast(@Febrero as varchar(9)) +' '+ cast(@Marzo as varchar(9)) +' '+ cast(@Abril as varchar(9)) +' '+ cast(@Mayo as varchar(9)) +' '+ cast(@Junio as varchar(9)) +' '+ cast(@Julio as varchar(9)) +' '+ cast(@Agosto as varchar(9)) +' '+ cast(@Septiembre as varchar(9)) +' '+ cast(@Octubre as varchar(9)) +' '+ cast(@Noviembre as varchar(9)) +' '+ cast(@Diciembre as varchar(9))
		WHILE @@FETCH_STATUS = 0 BEGIN -- VALIDAR QUE LA FILA NO VENGA VACÍA
			IF @codigoMeta <> '' AND @codigoMeta IS NOT NULL AND @codigoNivel <> '' AND @codigoNivel IS NOT NULL BEGIN
				IF @i = 0 BEGIN
					SET @meta_id = (SELECT TOP 1 id FROM Meta WHERE id = @codigoMeta)  SET @i=1
					SET @fecha1 = '01/01/'+ CAST(@añoTemp AS varchar(4))		SET @fecha2 = '01/28/'+ CAST(@añoTemp AS varchar(4))
				END
				IF @meta_id <> 0 AND @meta_id <> '' AND @meta_id IS NOT NULL BEGIN -- CONTINUAR SI LA META ES VÁLIDA
					SET @detalle_id = (SELECT TOP 1 id FROM JerarquiaDetalle WHERE codigoNivel = @codigoNivel)
					
					IF @detalle_id <> 0 AND @detalle_id <> '' AND @detalle_id IS NOT NULL BEGIN -- CONTINUAR SI EL NODO DE LA JERARQUÍA ES VÁLIDO
						INSERT INTO DetallePresupuesto VALUES
							(@fecha1, @fecha2, @Enero, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 1, @fecha1), DATEADD(month, 1, @fecha2), @Febrero, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 2, @fecha1), DATEADD(month, 2, @fecha2), @Marzo, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 3, @fecha1), DATEADD(month, 3, @fecha2), @Abril, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 4, @fecha1), DATEADD(month, 4, @fecha2), @Mayo, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 5, @fecha1), DATEADD(month, 5, @fecha2), @Junio, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 6, @fecha1), DATEADD(month, 6, @fecha2), @Julio, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 7, @fecha1), DATEADD(month, 7, @fecha2), @Agosto, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 8, @fecha1), DATEADD(month, 8, @fecha2), @Septiembre, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 9, @fecha1), DATEADD(month, 9, @fecha2), @Octubre, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 10, @fecha1), DATEADD(month, 10, @fecha2), @Noviembre, @meta_id, @presupuesto_idTemp, @detalle_id),
							(DATEADD(month, 11, @fecha1), DATEADD(month, 11, @fecha2), @Diciembre, @meta_id, @presupuesto_idTemp, @detalle_id)
						/*
						IF NOT EXISTS(SELECT MXN.meta_id FROM MetaxNodo AS MXN JOIN DetallePresupuesto AS D ON MXN.jerarquiaDetalle_id = D.jerarquiaDetalle_id WHERE D.presupuesto_id = @presupuesto_idTemp AND MXN.meta_id = @meta_id)
							INSERT INTO MetaxNodo VALUES (@meta_id, @detalle_id, @añoTemp)
						*/	
					END ELSE BEGIN
						EXEC dbo.Presupuesto_InsertarLog @hojaActualTemp, @id, 'El código de nivel no es válido', @codigoNivel, @codigoMeta, @anio, @Enero, @Febrero, @Marzo, @Abril, @Mayo, @Junio, @Julio, @Agosto, @Septiembre, @Octubre, @Noviembre, @Diciembre, @presupuesto_idTemp
					END
				END ELSE BEGIN
					EXEC dbo.Presupuesto_InsertarLog @hojaActualTemp, @id, 'El código de meta no es válido', @codigoNivel, @codigoMeta, @anio, @Enero, @Febrero, @Marzo, @Abril, @Mayo, @Junio, @Julio, @Agosto, @Septiembre, @Octubre, @Noviembre, @Diciembre, @presupuesto_idTemp
				END
			END ELSE BEGIN
				EXEC dbo.Presupuesto_InsertarLog @hojaActualTemp, @id, 'No hay datos en esta fila', @codigoNivel, @codigoMeta, @anio, @Enero, @Febrero, @Marzo, @Abril, @Mayo, @Junio, @Julio, @Agosto, @Septiembre, @Octubre, @Noviembre, @Diciembre, @presupuesto_idTemp
			END
			SET @detalle_id=0  /**/
			FETCH NEXT FROM @HojaList INTO @id, @codigoNivel, @codigoMeta, @anio, @Enero, @Febrero, @Marzo, @Abril, @Mayo, @Junio, @Julio, @Agosto, @Septiembre, @Octubre, @Noviembre, @Diciembre
		END CLOSE @HojaList DEALLOCATE @HojaList
		--
		IF NOT EXISTS(SELECT presupuesto_id FROM Ejecucion WHERE presupuesto_id = @presupuesto_idTemp)  INSERT INTO Ejecucion VALUES (GETDATE(), @presupuesto_idTemp, @añoTemp)
			
		-- PROCESAR EL PRESUPUESTO CARGADO
		--IF @esUltimaHojaTemp = 1 BEGIN
			DELETE FROM DetallePresupuesto
			WHERE presupuesto_id = @presupuesto_idTemp AND id NOT IN (
				SELECT MAX(id) FROM DetallePresupuesto
				WHERE presupuesto_id = @presupuesto_idTemp
				GROUP BY fechaIni, fechaFin, meta_id, presupuesto_id, jerarquiaDetalle_id )
		--END
		/**/
		RETURN @valorRetorno
	END TRY
	BEGIN CATCH
		RETURN 0
	END CATCH
END