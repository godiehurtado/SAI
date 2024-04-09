-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EliminarEjecucionDetalle] 
	-- Add the parameters for the stored procedure here
	@idEjecucion as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM EjecucionDetalle WHERE ejecucion_id = @idEjecucion AND tipo=3
	
	RETURN 1
END
