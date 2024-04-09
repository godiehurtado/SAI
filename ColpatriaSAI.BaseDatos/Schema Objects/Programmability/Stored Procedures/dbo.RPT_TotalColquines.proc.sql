-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 29/02/2012
-- Description:	Procedimiento almacenado de origen para el reporte de Total de colquines
-- =============================================
CREATE PROCEDURE [dbo].[RPT_TotalColquines]
(
	@anio INT
)
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		p.clave
		, LTRIM(RTRIM(p.nombre)) + SPACE(1) + LTRIM(RTRIM(p.apellidos)) AS nombreParticipante
		, CASE
			WHEN lm.tipo = 1 THEN 'Colquines comerciales'
			WHEN lm.tipo = 2 THEN 'Descuento de colquines por Siniestralidad'
			WHEN lm.tipo = 3 THEN 'Pago premio'
			WHEN lm.tipo = 4 THEN 'Colquines manuales'
			WHEN lm.tipo = 5 THEN 'Descuento de colquines por Persistencia'
		END AS Tipo
		, c.nombre AS nombreCompania
		, SUM(lm.cantidad) AS Cantidad
	FROM LiquidacionMoneda lm
		INNER JOIN Participante p ON p.id = lm.participante_id
		LEFT JOIN Compania c ON c.id = lm.compania_id
	WHERE
		lm.tipo IN (1,3,4)
		AND anioCierreRecaudo = @anio
	GROUP BY p.clave, p.nombre, p.apellidos, lm.tipo, c.nombre
END
GO