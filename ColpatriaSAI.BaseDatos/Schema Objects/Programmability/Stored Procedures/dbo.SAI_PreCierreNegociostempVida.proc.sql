CREATE PROCEDURE [dbo].[SAI_PreCierreNegociostempVida]

@compania_id AS INT,
@sistema AS NVARCHAR (20)

AS
BEGIN

	DECLARE @fechaDia AS DATETIME = (SELECT CONVERT(DATETIME,CONVERT(VARCHAR(10), GETDATE(), 103),103))
	DECLARE @fechaCierre AS DATETIME = (SELECT CONVERT(DATETIME,CONVERT(VARCHAR(10), fechaCierre, 103),103) FROM PeriodoCierre WHERE compania_id = 1 AND estado = 1)
	DECLARE @mesCierre AS INT = (SELECT mesCierre FROM PeriodoCierre WHERE compania_id = 1 AND estado = 1)
	DECLARE @anioCierre AS INT = (SELECT anioCierre FROM PeriodoCierre WHERE compania_id = 1 AND estado = 1)

--  Valida si hay información en NegociostempVida.
	IF EXISTS (SELECT * FROM NegociostempVida WHERE compania_id = @compania_id AND sistema = @sistema)
	BEGIN
			
	--  Actualiza los registros de la compania a estado abierto.
		UPDATE NegociostempVida
		SET estadoCierre = 1
		WHERE compania_id = @compania_id
		AND sistema = @sistema
	
		IF (@fechaDia = @fechaCierre)
		BEGIN
		
		--  Si existen registros en NegociostempVida éstos se actualizan a estado cerrado (2)
			UPDATE NegociostempVida
			SET estadoCierre = 2
			, mesCierre = @mesCierre
			, anioCierre = @anioCierre
			WHERE compania_id = @compania_id
			AND sistema = @sistema
			
		END	
	END
END