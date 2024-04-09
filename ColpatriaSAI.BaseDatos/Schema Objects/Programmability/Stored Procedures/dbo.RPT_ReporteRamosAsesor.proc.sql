
-- =============================================
-- Author:		Enrique 
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
	CREATE PROCEDURE [dbo].[RPT_ReporteRamosAsesor]
(
	@Compania nvarchar(100),
	@Ramo nvarchar(150),
	@Mes nvarchar(150),
	@Localidad nchar(100),
	@LineaNegocio nvarchar(100)
)
AS
	SET NOCOUNT ON;
	
	SELECT  Participante.nombre + ' ' + Participante.apellidos AS NombreAs
			, Compania.nombre AS Compañia
			, Ramo.nombre AS Ramo
			, Producto.nombre AS Producto
			, Zona.nombre AS Zona
			, LineaNegocio.nombre AS [Linea Negocio]
			, Localidad.nombre AS Localidad
			, Participante.clave
			, MONTH(Recaudo.fechaRecaudo) AS Mes
			, YEAR(Recaudo.fechaRecaudo) AS Año
			, SUM(Recaudo.valorRecaudo) AS TotalRecaudo
	FROM Recaudo 
		INNER JOIN Compania ON Recaudo.compania_id = Compania.id 
		INNER JOIN Participante ON Recaudo.clave = Participante.clave 
		INNER JOIN RamoDetalle ON RamoDetalle.id = Recaudo.ramoDetalle_id 
		INNER JOIN Ramo ON Ramo.id = RamoDetalle.ramo_id 
		INNER JOIN ProductoDetalle ON Recaudo.productoDetalle_id = ProductoDetalle.id 
		INNER JOIN Producto ON Producto.id = ProductoDetalle.producto_id  
		INNER JOIN Zona ON Recaudo.zona_id = Zona.id 
		INNER JOIN Localidad ON Recaudo.localidad_id = Localidad.id 
		INNER JOIN LineaNegocio ON Recaudo.lineaNegocio_id = LineaNegocio.id
	GROUP BY	Participante.clave, Recaudo.ramoDetalle_id, Compania.nombre, Localidad.nombre, LineaNegocio.nombre, Ramo.nombre, Zona.nombre, Producto.nombre, 
				MONTH(Recaudo.fechaRecaudo), YEAR(Recaudo.fechaRecaudo), Participante.nombre, Participante.apellidos
	HAVING      (Compania.nombre = @Compania) AND (Ramo.nombre = @Ramo) AND (MONTH(Recaudo.fechaRecaudo) = @Mes) AND (Localidad.nombre = @Localidad) AND 
				(LineaNegocio.nombre = @LineaNegocio)
	ORDER BY Participante.clave, Recaudo.ramoDetalle_id, Compañia, Localidad, [Linea Negocio], Ramo, Zona, Producto, Mes, Año, Participante.nombre, Participante.apellidos
