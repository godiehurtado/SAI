-- =============================================
-- Author:		<Enrique Gonzalez Araujo>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================


CREATE PROCEDURE [dbo].[ReporteParamFranquicias]
(
	@id_par_fran int
)
AS
	SET NOCOUNT ON;
SELECT  DetallePartFranquicia.id, DetallePartFranquicia.porcentaje, DetallePartFranquicia.rangoinferior, 
		DetallePartFranquicia.rangosuperior, 
        Ramo.nombre AS [Nombre Ramo], Producto.nombre AS [Nombre Producto], Compania.nombre AS [Nombre Compañia], 
        LineaNegocio.nombre AS [Lineda Negocio], 
        TipoVehiculo.Nombre AS [Tipo Vehiculo], ParticipacionFranquicia.fecha_ini AS [Fecha Inicial], 
        ParticipacionFranquicia.fecha_fin AS [Fecha Fin], 
        Amparo.nombre AS Amparo, Localidad.nombre AS Localidad, Localidad.tipo_localidad_id AS [Tipo Localidad], 
        [Plan].nombre AS [Nombre Plan], 
        DetallePartFranquicia.part_franquicia_id AS Id_ParFranquicia
FROM    DetallePartFranquicia 
		INNER JOIN       Ramo ON DetallePartFranquicia.ramo_id = Ramo.id 
		INNER JOIN       Producto ON DetallePartFranquicia.producto_id = Producto.id 
		INNER JOIN       Compania ON DetallePartFranquicia.compania_id = Compania.id 
		INNER JOIN       ParticipacionFranquicia ON DetallePartFranquicia.part_franquicia_id = ParticipacionFranquicia.id 
		LEFT JOIN        Localidad ON ParticipacionFranquicia.Localidad_id = Localidad.id 
		LEFT JOIN       [Plan] ON DetallePartFranquicia.plan_id = [Plan].id 
		LEFT JOIN       Amparo ON DetallePartFranquicia.amparo_id = Amparo.id  
		LEFT JOIN       TipoVehiculo ON DetallePartFranquicia.tipoVehiculo_id = TipoVehiculo.id 
		LEFT JOIN        LineaNegocio ON DetallePartFranquicia.lineaNegocio_id = LineaNegocio.id
WHERE        (DetallePartFranquicia.part_franquicia_id = @id_par_fran)
