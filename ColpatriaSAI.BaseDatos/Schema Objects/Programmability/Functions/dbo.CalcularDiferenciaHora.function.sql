CREATE FUNCTION [dbo].[CalcularDiferenciaHora] (
	@Fecha1 DATETIME2
	,@Fecha2 DATETIME2
	)
RETURNS NVARCHAR(50)
AS
BEGIN
	DECLARE @resultado NVARCHAR(50);
	DECLARE @mili INT
		,@hor INT
		,@resthor INT
		,@min INT
		,@restmin INT
		,@seg INT

	SET @mili = (
			SELECT DATEDIFF(MILLISECOND, @Fecha2, @Fecha1)
			)

	SET @hor = @mili / 3600000
	SET @resthor = @mili % 3600000
	SET @min = @resthor / 60000
	SET @restmin = @resthor % 60000
	SET @seg = @restmin / 1000

	SELECT @resultado = CAST(@hor AS NVARCHAR (5)) + ' Hora(s)' + ' ' + CAST(@min AS NVARCHAR (5)) + ' Minuto(s)' + ' ' + CAST(@seg AS NVARCHAR (5)) + ' Segundo(s)'

	RETURN @resultado;
END;



