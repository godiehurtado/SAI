
-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 24/05/2012
-- Description:	Procedimiento almacenado para obtener el extracto de siniestralidad de autos de un asesor
-- =============================================
CREATE PROCEDURE [dbo].[consultaExtractoSiniestralidadAutosAsesor] (
	@clave NVARCHAR(250)
	,@anio INT
	)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @ultimoMes AS INT = (SELECT MAX(ultimoMes) FROM SiniestralidadAcumulada WHERE anio = @anio)

	SELECT (s.primasEmitidas + s.reservaTecnica) AS primasDevengar
		,s.siniestrosIncurridos AS sinIncurrir
		,s.indSiniestralidad AS porcentajeSinIncurrir
		,s.colquinesDescontar AS colquinesDescontar
		,@ultimoMes AS mes
	FROM SiniestralidadAcumulada s
	WHERE s.anio = @anio
		AND RTRIM(LTRIM(s.clave)) = @clave
		AND s.ultimoMes = @ultimoMes
		AND s.colquinesDescontar < 0
END