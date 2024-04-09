-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 26/03/2012
-- Description:	Cancela la liquidación actual de una regla
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarRegla_Cancelar]
	@tipo int
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @idTipo int = @tipo--, @idLiquidacion int = @id
	
	-- Elimina todas las tablas creadas en la liquidación para provocar un error y asi finalizar el proceso
	EXEC dbo.LiquidarRegla_EliminarTablasLiquidacion
	-- Se elimina de esta tabla todos los registros de tipo Liquidación de Concurso utilizados para visualizar al sistema los procesos en curso
	DELETE FROM ProcesoLiquidacion WHERE tipo=@idTipo
END