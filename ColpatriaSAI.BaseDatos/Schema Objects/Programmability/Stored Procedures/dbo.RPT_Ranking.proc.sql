-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 23/02/2012
-- Description:	Procedimiento almacenado origen para el reporte de Ranking
-- =============================================
CREATE PROCEDURE [dbo].[RPT_Ranking]
(
	@fechaRanking DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		posicionRanking AS Posicion
		, Jerarquia AS Ejecutivo
		, categoria AS Categoria
		, participante As Participante
		, localidad AS Localidad
		, anio AS Anio
		, mes AS Mes
		, totalEvaluado AS TotalEvaluado
	FROM VistaRanking vr
	WHERE vr.anio = YEAR(@fechaRanking) AND vr.mes = MONTH(@fechaRanking)
END
