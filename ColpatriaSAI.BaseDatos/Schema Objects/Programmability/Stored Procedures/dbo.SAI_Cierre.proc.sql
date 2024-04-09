
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Al terminar la carga de negocios y recaudos por compañía valida si la fecha del día actual es la fecha de cierre
--              parametrizada en la tabla PeriodoCierre. Si es el día de cierre actualiza el estado de cierre abierto (1) a cerrado
--              y la siguiente fecha de cierre a abierta (2)			
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Cierre] @compania_id AS INT
	,@sistema AS NVARCHAR(20)
AS
BEGIN
	DECLARE @fechaDia AS DATE = (SELECT CONVERT(DATE, CONVERT(VARCHAR(10), GETDATE(), 103), 103))
	DECLARE @fechaCierre AS DATE = (
		SELECT CONVERT(DATE, CONVERT(VARCHAR(10), fechaCierre, 103), 103) FROM PeriodoCierre WHERE compania_id = @compania_id
		AND estado = 1
		)
	DECLARE @anioCierre AS INT = (
		SELECT anioCierre FROM PeriodoCierre WHERE compania_id = @compania_id
		AND estado = 1
		)
	DECLARE @mesCierre AS INT = (
		SELECT mesCierre FROM PeriodoCierre WHERE compania_id = @compania_id
		AND estado = 1
		)
	DECLARE @mesSiguienteCierre AS INT
	DECLARE @anioSiguienteCierre AS INT = @anioCierre

	SET @mesSiguienteCierre = @mesCierre + 1

	IF (@mesCierre = 12)
	BEGIN
		SET @mesSiguienteCierre = 1
		SET @anioSiguienteCierre = @anioCierre + 1
	END

	IF (@fechaDia = @fechaCierre)
	BEGIN
		IF (
				@compania_id IN (
					1
					,2
					,3
					,4
					,5
					)
				)
		BEGIN
			DECLARE @cantidadRegistrosRecaudo AS INT = (
				SELECT COUNT(*) FROM Recaudo WHERE estadoCierre = 2
				AND compania_id = @compania_id
				AND sistema = @sistema
				AND mesCierre = @mesCierre
				AND anioCierre = @anioCierre
				)
			DECLARE @cantidadRegistrosNegocio AS INT = (
				SELECT COUNT(*) FROM Negocio WHERE estadoCierre = 2
				AND compania_id = @compania_id
				AND sistema = @sistema
				AND mesCierre = @mesCierre
				AND anioCierre = @anioCierre
				)

			IF (@cantidadRegistrosNegocio > 0)
			BEGIN
				IF (@cantidadRegistrosRecaudo > 0)
				BEGIN
					--  Actualiza el estado a cerrado de la Tabla dbo.PeriodoCierre cuando sea el día del cierre por compania y cuando se haya cerrado la información en Negocio y Recaudo.
					UPDATE PeriodoCierre
					SET estado = 2
					WHERE compania_id = @compania_id
						AND mesCierre = @mesCierre
						AND anioCierre = @anioCierre
						AND estado = 1

					--  Actualiza el estado a abierto de la Tabla dbo.PeriodoCierre cuando sea el día del cierre por compania y cuando se haya cerrado la información en Negocio y Recaudo.
					UPDATE PeriodoCierre
					SET estado = 1
					WHERE compania_id = @compania_id
						AND mesCierre = @mesSiguienteCierre
						AND anioCierre = @anioSiguienteCierre
						AND estado = 0
				END
			END
		END
		ELSE
			IF (@compania_id = 0)
			BEGIN
				UPDATE PeriodoCierre
				SET estado = 2
				WHERE compania_id = @compania_id
					AND mesCierre = @mesCierre
					AND anioCierre = @anioCierre
					AND estado = 1

				--  Actualiza el estado a abierto de la Tabla dbo.PeriodoCierre cuando sea el día del cierre por compania y cuando se haya cerrado la información en Negocio y Recaudo.
				UPDATE PeriodoCierre
				SET estado = 1
				WHERE compania_id = @compania_id
					AND mesCierre = @mesSiguienteCierre
					AND anioCierre = @anioSiguienteCierre
					AND estado = 0
			END
	END
END