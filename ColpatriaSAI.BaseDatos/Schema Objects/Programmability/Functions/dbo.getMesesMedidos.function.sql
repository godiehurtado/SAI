-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 21/02/2012
-- Description:	Calcula los meses medidos a partir de la antigüedad
-- =============================================
CREATE FUNCTION [dbo].[getMesesMedidos]
(
	@Antiguedad FlOAT
)
RETURNS INT
AS
BEGIN
	DECLARE @MesesMedidos INT
	
	SELECT @MesesMedidos = 
		CASE
			WHEN @Antiguedad <= 0.1 THEN 1
			WHEN @Antiguedad > 0.1 AND @Antiguedad <= 0.1999 THEN 2
			WHEN @Antiguedad > 0.199 AND @Antiguedad <= 0.299 THEN 3
			WHEN @Antiguedad > 0.299 AND @Antiguedad <= 0.399 THEN 4
			WHEN @Antiguedad > 0.399 AND @Antiguedad <= 0.499 THEN 5
			WHEN @Antiguedad > 0.499 AND @Antiguedad <= 0.579 THEN 6
			WHEN @Antiguedad > 0.65 THEN 8
			ELSE 7
		END
	
	RETURN @MesesMedidos
END
