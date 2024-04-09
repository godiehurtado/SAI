-- =============================================
-- Author:		Frank Payares
-- Create date: 10/10/2011
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[ObtenerHijosAsesoresNodoNivel] (
	@idJerarquiaDetalle as int,
	@idNivel as int
)
RETURNS @Claves TABLE (jerarquiaDetalle_id_padre int, clave nvarchar(50), canal_id int, id int, participante_id int, jerarquia_id int)
AS
BEGIN

		INSERT INTO @Claves(jerarquiaDetalle_id_padre, clave, canal_id, id, participante_id, jerarquia_id)
		SELECT niveles.id, hijos.clave, hijos.canal_id, hijos.id, hijos.participante_id, hijos.jerarquia_id FROM  
		ObtenerHijosNodoNivel(@idJerarquiaDetalle,@idNivel) as niveles 
		CROSS APPLY ObtenerHijosNodo(niveles.id) as hijos

	RETURN
END