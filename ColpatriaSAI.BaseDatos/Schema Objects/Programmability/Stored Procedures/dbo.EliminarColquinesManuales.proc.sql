-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[EliminarColquinesManuales]
	-- Add the parameters for the stored procedure here
	@fechaCargue as Datetime
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DELETE FROM LiquidacionMoneda WHERE YEAR(fechaCargue) = YEAR(@fechaCargue) AND
	MONTH(fechaCargue) = MONTH(@fechaCargue) AND
	DAY(fechaCargue) = DAY(@fechaCargue) AND
	DATEPART (hh,fechaCargue) = DATEPART (hh,@fechaCargue) AND
	DATEPART (mi,fechaCargue) = DATEPART (mi,@fechaCargue) AND
	DATEPART (ss,fechaCargue) = DATEPART (ss,@fechaCargue) AND
	tipo = 4
END
