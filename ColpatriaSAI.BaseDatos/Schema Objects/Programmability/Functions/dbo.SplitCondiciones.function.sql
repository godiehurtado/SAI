
-- =============================================
-- Author:		Frank Payares
-- Create date: 10/10/2011
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[SplitCondiciones] (
	@Lista		varchar(MAX),
	@caracter	varchar(5)
)
RETURNS @Condiciones_id TABLE (id int IDENTITY(1,1), Item nvarchar(300))
AS
BEGIN
	--DECLARE @Condiciones_id TABLE (id int IDENTITY(1,1), Item varchar(300))
	--DECLARE @Lista varchar(MAX)='ROUND((MAX(CAST(personasACargoVenden) as float))*100) / MAX(CAST(personasACargo as float)).3) AS condicion_1354'
	--DECLARE @caracter varchar(5)=' AS '
	DECLARE @posicion int, @ubicacionLocal char(2048)
	
	IF RIGHT(@Lista, LEN(@caracter)) <> @caracter  SET @Lista = @Lista + @caracter

	WHILE CHARINDEX(@caracter, @Lista COLLATE Latin1_General_CS_AS) > 0
	BEGIN
		SELECT @posicion = CHARINDEX(@caracter, @Lista COLLATE Latin1_General_CS_AS)
		SELECT @ubicacionLocal = RTRIM(SUBSTRING(@Lista, 1, @posicion-1))
		INSERT INTO @Condiciones_id (Item) VALUES (@ubicacionLocal)
		SELECT @Lista = SUBSTRING(@Lista, @posicion + 1, LEN(@Lista))
	END
	--select * from @Condiciones_id
	RETURN
END