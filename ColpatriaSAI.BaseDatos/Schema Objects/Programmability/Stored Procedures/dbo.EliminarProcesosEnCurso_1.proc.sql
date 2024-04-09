-- =============================================
-- Author:		Frank Payares
-- Create date: 21/20/2012
-- Description:	Obtiene una lista de los procesos de liquidación que se encuentran en curso
-- =============================================
CREATE PROCEDURE [dbo].[EliminarProcesosEnCurso]
AS
BEGIN

	DELETE FROM ProcesoLiquidacion WHERE estadoProceso_id = 4
	
	RETURN 1
END