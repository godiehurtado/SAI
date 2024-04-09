-- =============================================
-- Author:		Frank Payares
-- Create date: 10/10/2011
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[ObtenerHijosNodoNivel] (
	@idJerarquiaDetalle as int,
	@idNivel as int
)
RETURNS @Claves TABLE (clave nvarchar(50), canal_id int, id int, participante_id int)
AS
BEGIN

		WITH Childs AS 
		(
			SELECT id, padre_id, participante_id, nombre,nivel_id,canal_id, 1 AS hLevel, 
			CAST(CAST(id AS BINARY(4)) AS VARBINARY(8000)) AS SortPath
			FROM JerarquiaDetalle
			--WHERE nivel_id = 5
			WHERE id = @idJerarquiaDetalle
			UNION ALL
			SELECT jd.id, jd.padre_id, jd.participante_id, jd.nombre, jd.nivel_id, jd.canal_id, hLevel + 1 as hLevel,
			CAST(c.SortPath + CAST(jd.id AS BINARY(4)) AS VARBINARY(8000)) AS SortPath
			FROM JerarquiaDetalle AS jd
				INNER JOIN Childs AS c
				ON jd.padre_id = c.id      
		)
		INSERT INTO @Claves(clave, canal_id, id, participante_id)
		SELECT p.clave, Childs.canal_id, Childs.id, p.id
		FROM Childs
		INNER JOIN participante as p ON Childs.participante_id = p.id
		WHERE Childs.nivel_id=@idNivel	
		ORDER BY p.clave

	RETURN
END