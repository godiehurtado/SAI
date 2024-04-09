-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 01/02/2012
-- Description:	Función para obtener el nodo raiz del arbol de Jerarquia, partiendo de cualquier nodo hijo
-- =============================================
CREATE FUNCTION [dbo].[getRaizJerarquia]
(
	@jerarquia_id INT
)
RETURNS INT
AS
BEGIN
	DECLARE @padre_id INT
	
	SELECT @padre_id = padre_id
	FROM JerarquiaDetalle
	WHERE id = @jerarquia_id
	
	WHILE @padre_id IS NOT NULL
	BEGIN
		SET @jerarquia_id = @padre_id
		
		SELECT @padre_id = padre_id
		FROM JerarquiaDetalle
		WHERE id = @jerarquia_id
	END
	
	RETURN @jerarquia_id
END
