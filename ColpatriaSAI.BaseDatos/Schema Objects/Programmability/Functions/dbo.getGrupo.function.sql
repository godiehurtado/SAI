-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 21/02/2012
-- Description:	Calcula el Grupo en base a la antigüedad
-- =============================================
CREATE FUNCTION [dbo].[getGrupo]
(
	@Antiguedad FLOAT
)
RETURNS int
AS
BEGIN
	DECLARE @Grupo int
	
	SELECT @Grupo =
		CASE
			WHEN @Antiguedad <= 1 THEN 1
			WHEN @Antiguedad > 1 AND @Antiguedad <= 3 THEN 2
			ELSE 3
		END
	
	RETURN @Grupo
END
