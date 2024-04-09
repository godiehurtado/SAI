-- =============================================
-- Author:		<Enrique>
-- Create date: <25/11/2011>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DetallePagosFranquicia_]
(
	@compania nvarchar(100),
	@id int
)
AS
	SET NOCOUNT ON;


SELECT Compania.nombre AS Compañia, Localidad.nombre AS Franquicia, DetallePagosFranquicia.clave, DetallePagosFranquicia.documento AS Documento, DetallePagosFranquicia.fechaRecaudo, DetallePagosFranquicia.totalParticipacion, LiquidacionFranquicia.periodoLiquidacionIni, liquidacionFranquicia.periodoLiquidacionFin
FROM DetallePagosFranquicia 
INNER JOIN Compania ON DetallePagosFranquicia.compania_id = Compania.id 
LEFT JOIN Localidad ON DetallePagosFranquicia.clave = Localidad.clavePago 
INNER JOIN PagoFranquicia ON PagoFranquicia.id = DetallePagosFranquicia.pagoFranquicia_id
INNER JOIN LiquidacionFranquicia ON LiquidacionFranquicia.id = PagoFranquicia.liquidacionFranquicia_id
WHERE        (Compania.id = @compania) AND (LiquidacionFranquicia.id = @id)


