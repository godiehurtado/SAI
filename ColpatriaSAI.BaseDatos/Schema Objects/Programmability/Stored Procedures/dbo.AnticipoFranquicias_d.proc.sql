-- =============================================
-- Author:		<Enrique Andres Gonzalez Araujo>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AnticipoFranquicias_d]
(
	@fecha datetime 
)
AS
	SET NOCOUNT ON;
SELECT	Compania.nombre AS Compañia, Localidad.nombre AS Localidad, AnticipoFranquicia.fecha_anticipo AS FechaAnticipo, 
		AnticipoFranquicia.valorAnti AS ValorAnticipo, 
		CASE AnticipoFranquicia.estado WHEN 1 THEN 'Creado' WHEN 2 THEN 'Pagado' WHEN 3 THEN 'Anulado' END AS Estado
FROM	AnticipoFranquicia INNER JOIN
		Localidad ON AnticipoFranquicia.localidad_id = Localidad.id LEFT OUTER JOIN
		Compania ON AnticipoFranquicia.compania_id = Compania.id
WHERE	(YEAR(AnticipoFranquicia.fecha_anticipo) = @fecha)


