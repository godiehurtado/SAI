-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 03/08/2012
-- Description:	Procedimiento almacenado de origen para el reporte de errores de Cargues
-- =============================================
CREATE PROCEDURE [dbo].[RPT_LogCargue] 
(
	@cargue_id INT,
	@cargue_tipo INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		lc.descripcion
	FROM
		LogCargue lc
	WHERE
		lc.cargue_id = @cargue_id
		AND lc.cargue_tipo = @cargue_tipo
		AND lc.descripcion IS NOT NULL
END