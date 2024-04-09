-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarFranquiciasExcepciones]
	-- Add the parameters for the stored procedure here
	@idLiquidacion int,
	@fechaini datetime,
	@fechafin datetime 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @idLiquidacionLocal as int
	declare @fechaIniLocal as datetime
	declare @fechaFinLocal as datetime
	
	SET @idLiquidacionLocal = @idLiquidacion
	SET @fechaIniLocal = @fechaini
	SET @fechaFinLocal = @fechafin

	-- LIQUIDAMOS LA EXCEPCIONES ESPECIALES CORRESPONDIENTES A LOCALIDADES QUE NO SON FRANQUICIAS.
	-- TIPO = 4
	-- Combinacion 1
	-- Participante
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 4
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND e.Estado = 1
	WHERE dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.negocio_id = '' and e.excepcion_recaudo = 1 and dlf.liquidadoPor = 4	

	-- Combinacion 2
	-- Participante + Negocio
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 4
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.numeroNegocio = e.negocio_id
		AND e.Estado = 1
	WHERE dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.excepcion_recaudo = 1 and dlf.liquidadoPor = 4

	-- LIQUIDAMOS EXCEPCIONES NORMALES
	-- Excepcion Combinacion 1
	-- Compañía
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.lineaNegocio_id = 0 and e.ramo_id = 0 and e.producto_id = 0 and e.clave = '' and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0
	
	-- Excepcion Combinacion 2
	-- Compañía + Codigo Agrupador
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND dlf.codigo_agrupador = e.codigoAgrupador
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and  dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.lineaNegocio_id = 0 and e.ramo_id = 0 and e.producto_id = 0 and e.clave = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0

	-- Excepcion Combinacion 3
	-- Compañía + Participante
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND dlf.claveParticipante = e.clave 
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.lineaNegocio_id = 0 and e.ramo_id = 0 and e.producto_id = 0 and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0

	-- Excepcion Combinacion 4
	-- Compañía + Ramo
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND rd.ramo_id = e.ramo_id 
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.lineaNegocio_id = 0 and e.producto_id = 0 and e.clave = '' and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0
	
	-- Excepcion Combinacion 5
	-- Compañía + Ramo + Producto
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN ProductoDetalle AS pd ON dlf.producto_id = pd.id 
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND rd.ramo_id = e.ramo_id 
		AND pd.producto_id = e.producto_id
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal	
	and e.lineaNegocio_id = 0 and e.clave = '' and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0
	
	-- Excepcion Combinacion 6
	-- Compañía + Ramo + Producto + Negocio
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN ProductoDetalle AS pd ON dlf.producto_id = pd.id 
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND rd.ramo_id = e.ramo_id 
		AND pd.producto_id = e.producto_id
		AND dlf.numeroNegocio = e.negocio_id
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal	
	and e.lineaNegocio_id = 0 and e.clave = '' and e.codigoAgrupador = '' and e.tipoVehiculo_id = 0

	-- Excepcion Combinacion 7
	-- Compañía + Ramo + Producto + Participante
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN ProductoDetalle AS pd ON dlf.producto_id = pd.id 
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND rd.ramo_id = e.ramo_id 
		AND pd.producto_id = e.producto_id
		AND dlf.claveParticipante = e.clave 
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.lineaNegocio_id = 0 and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0

	-- Excepcion Combinacion 7.1 
	-- ADICIONAL SOLICITUD JUAN DAVID PALACIOS NUEVA COMBINACION POR TIPO DE VEHICULO
	-- Compañía + Ramo + Producto + Participante
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN ProductoDetalle AS pd ON dlf.producto_id = pd.id 
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND rd.ramo_id = e.ramo_id 
		AND pd.producto_id = e.producto_id
		AND dlf.tipoVehiculo = e.tipoVehiculo_id 
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.lineaNegocio_id = 0 and e.codigoAgrupador = '' and e.negocio_id = '' and e.clave = ''

	-- Excepcion Combinacion 8
	-- Compañía + Línea de Negocio
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin
		AND dlf.localidad_id = e.localidad_id 
		AND dlf.compania_id = e.compania_id 
		AND dlf.lineaNegocio_id = e.lineaNegocio_id 
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.ramo_id = 0 and e.producto_id = 0 and e.clave = '' and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0
	
	-- Excepcion Combinacion 9
	-- Compañía + Línea de Negocio + Ramo 
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin 
		AND dlf.localidad_id = e.localidad_id
		AND dlf.compania_id = e.compania_id 
		AND dlf.lineaNegocio_id = e.lineaNegocio_id 
		AND rd.ramo_id = e.ramo_id 
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal	
	and e.producto_id = 0 and e.clave = '' and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0
	
	-- Excepcion Combinacion 10
	-- Compañía + Línea de Negocio + Participante 	
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin 
		AND dlf.localidad_id = e.localidad_id
		AND dlf.compania_id = e.compania_id 
		AND dlf.lineaNegocio_id = e.lineaNegocio_id 
		AND dlf.claveParticipante = e.clave 
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal	
	and e.ramo_id = 0 and e.producto_id = 0 and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0
	
	-- Excepcion Combinacion 11
	-- Compañía + Línea de Negocio + Código Agrupador 
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin 
		AND dlf.localidad_id = e.localidad_id
		AND dlf.compania_id = e.compania_id 
		AND dlf.lineaNegocio_id = e.lineaNegocio_id 
		AND dlf.codigo_agrupador = e.codigoAgrupador
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal	
	and e.ramo_id = 0 and e.producto_id = 0 and e.clave = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0		
	
	-- Excepcion Combinacion 12
	-- Compañía + Línea de Negocio + Ramo + Producto 
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN ProductoDetalle AS pd ON dlf.producto_id = pd.id 
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin 
		AND dlf.localidad_id = e.localidad_id
		AND dlf.compania_id = e.compania_id 
		AND dlf.lineaNegocio_id = e.lineaNegocio_id 
		AND rd.ramo_id = e.ramo_id 		
		AND pd.producto_id = e.producto_id
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal	
	and e.clave = '' and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0

	-- Excepcion Combinacion 13
	-- Compañía + Línea de Negocio + Ramo + Producto + Participante 
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN ProductoDetalle AS pd ON dlf.producto_id = pd.id		
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin 
		AND dlf.localidad_id = e.localidad_id
		AND dlf.compania_id = e.compania_id 
		AND dlf.lineaNegocio_id = e.lineaNegocio_id 
		AND rd.ramo_id = e.ramo_id 		
		AND pd.producto_id = e.producto_id
		AND dlf.claveParticipante = e.clave 		
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.codigoAgrupador = '' and e.negocio_id = '' and e.tipoVehiculo_id = 0
	
	-- Excepcion Combinacion 14
	-- Compañía + Línea de Negocio + Ramo + Producto + Negocio
	UPDATE DetalleLiquidacionFranquicia
	SET totalParticipacion = (dlf.valorRecaudo * e.Porcentaje) / 100, porcentajeParticipacion = e.Porcentaje, liquidadoPor = 1
	FROM 
		DetalleLiquidacionFranquicia AS dlf
		JOIN RamoDetalle AS rd ON dlf.ramo_id = rd.id 
		JOIN ProductoDetalle AS pd ON dlf.producto_id = pd.id			
		JOIN Excepcion AS e ON dlf.fechaContabl between e.fecha_ini AND e.fecha_fin 
		AND dlf.localidad_id = e.localidad_id
		AND dlf.compania_id = e.compania_id 
		AND dlf.lineaNegocio_id = e.lineaNegocio_id 
		AND dlf.numeroNegocio = e.negocio_id
		AND rd.ramo_id = e.ramo_id 		
		AND pd.producto_id = e.producto_id		
		AND e.Estado = 1
	WHERE dlf.liquidadoPor <> 4 and dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal
	and e.clave = '' and e.codigoAgrupador = '' and e.tipoVehiculo_id = 0
	
	return 1
END
