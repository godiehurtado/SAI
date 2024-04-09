-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarFranquiciasParticipacion]
	-- Add the parameters for the stored procedure here
	@idLiquidacion int,
	@fechaini date,
	@fechafin date 
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

		-- CALCULAMOS LA LIQUIDACION DE FRANQUICIA POR PORCENTAJES TENIENDO EN CUENTA TODAS LAS COMBINACIONES DE PARAMETRIZACION

		-- Porcentaje Combinacion 1
		-- Compañia + Ramo + Producto
		UPDATE DetalleLiquidacionFranquicia
		SET totalParticipacion = (dlf.valorRecaudo * dpf.porcentaje) / 100, porcentajeParticipacion = dpf.porcentaje, liquidadoPor = 2
		FROM 
			DetalleLiquidacionFranquicia AS dlf
			JOIN ParticipacionFranquicia AS pf ON dlf.fechaContabl between pf.fecha_ini AND pf.fecha_fin 
			AND dlf.localidad_id = pf.localidad_id	
			JOIN DetallePartFranquicia AS dpf ON pf.id = dpf.part_franquicia_id
			AND dlf.compania_id =  dpf.compania_id
			AND dpf.ramo_id = dlf.ramo_id_agrupado
			AND dpf.producto_id = dlf.producto_id_agrupado 
		WHERE dlf.liquidadoPor = 0 AND dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal and dpf.rangoinferior is null and dpf.rangosuperior is null
			and dpf.plan_id = 0 and dpf.lineaNegocio_id = 0 and dpf.tipoVehiculo_id = 0 and dpf.amparo_id = 0
			
		-- Porcentaje Combinacion 2
		-- Compañia + Ramo + Producto + Tipo de vehículo
		UPDATE DetalleLiquidacionFranquicia
		SET totalParticipacion = (dlf.valorRecaudo * dpf.porcentaje) / 100, porcentajeParticipacion = dpf.porcentaje, liquidadoPor = 2
		FROM 
			DetalleLiquidacionFranquicia AS dlf
			JOIN ParticipacionFranquicia AS pf ON dlf.fechaContabl between pf.fecha_ini AND pf.fecha_fin 
			AND dlf.localidad_id = pf.localidad_id				
			JOIN DetallePartFranquicia AS dpf ON pf.id = dpf.part_franquicia_id
			AND dlf.compania_id =  dpf.compania_id
			AND dpf.ramo_id = dlf.ramo_id_agrupado
			AND dpf.producto_id = dlf.producto_id_agrupado  
			AND dlf.tipoVehiculo = dpf.tipoVehiculo_id 
		WHERE dlf.liquidadoPor = 0 AND dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal and dpf.rangoinferior is null and dpf.rangosuperior is null
			and dpf.plan_id = 0 and dpf.lineaNegocio_id = 0 and dpf.amparo_id = 0

		-- Porcentaje Combinacion 3
		-- Compañia + Ramo + Producto + Linea de negocio
		UPDATE DetalleLiquidacionFranquicia
		SET totalParticipacion = (dlf.valorRecaudo * dpf.porcentaje) / 100, porcentajeParticipacion = dpf.porcentaje, liquidadoPor = 2
		FROM 
			DetalleLiquidacionFranquicia AS dlf
			JOIN ParticipacionFranquicia AS pf ON dlf.fechaContabl between pf.fecha_ini AND pf.fecha_fin 
			AND dlf.localidad_id = pf.localidad_id						
			JOIN DetallePartFranquicia AS dpf ON pf.id = dpf.part_franquicia_id
			AND dlf.compania_id =  dpf.compania_id
			AND dpf.ramo_id = dlf.ramo_id_agrupado
			AND dpf.producto_id = dlf.producto_id_agrupado
			AND dlf.lineaNegocio_id = dpf.lineaNegocio_id 
		WHERE dlf.liquidadoPor = 0 AND dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal and dpf.rangoinferior is null and dpf.rangosuperior is null	
			and dpf.plan_id = 0 and dpf.tipoVehiculo_id = 0 and dpf.amparo_id = 0

		-- Porcentaje Combinacion 4
		-- Compañia + Ramo + Producto + Linea de negocio + Tipo de vehículo
		UPDATE DetalleLiquidacionFranquicia
		SET totalParticipacion = (dlf.valorRecaudo * dpf.porcentaje) / 100, porcentajeParticipacion = dpf.porcentaje, liquidadoPor = 2
		FROM 
			DetalleLiquidacionFranquicia AS dlf
			JOIN ParticipacionFranquicia AS pf ON dlf.fechaContabl between pf.fecha_ini AND pf.fecha_fin 
			AND dlf.localidad_id = pf.localidad_id								
			JOIN DetallePartFranquicia AS dpf ON pf.id = dpf.part_franquicia_id
			AND dlf.compania_id =  dpf.compania_id
			AND dpf.ramo_id = dlf.ramo_id_agrupado
			AND dpf.producto_id = dlf.producto_id_agrupado  
			AND dlf.lineaNegocio_id = dpf.lineaNegocio_id 
			AND dlf.tipoVehiculo = dpf.tipoVehiculo_id 
		WHERE dlf.liquidadoPor = 0 AND dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal and dpf.rangoinferior is null and dpf.rangosuperior is null	
			and dpf.plan_id = 0 and dpf.amparo_id = 0

		-- Porcentaje Combinacion 5
		-- Compañia + Ramo + Producto + Linea de negocio + Amparo
		UPDATE DetalleLiquidacionFranquicia
		SET totalParticipacion = (dlf.valorRecaudo * dpf.porcentaje) / 100, porcentajeParticipacion = dpf.porcentaje, liquidadoPor = 2
		FROM 
			DetalleLiquidacionFranquicia AS dlf
			JOIN ParticipacionFranquicia AS pf ON dlf.fechaContabl between pf.fecha_ini AND pf.fecha_fin 
			AND dlf.localidad_id = pf.localidad_id									
			JOIN DetallePartFranquicia AS dpf ON pf.id = dpf.part_franquicia_id
			AND dlf.compania_id =  dpf.compania_id
			AND dpf.ramo_id = dlf.ramo_id_agrupado
			AND dpf.producto_id = dlf.producto_id_agrupado 
			AND dlf.lineaNegocio_id = dpf.lineaNegocio_id 
			AND dlf.amparo_id = dpf.amparo_id 
		WHERE dlf.liquidadoPor = 0 AND dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal and dpf.rangoinferior is null and dpf.rangosuperior is null	
			and dpf.plan_id = 0 and dpf.tipoVehiculo_id = 0

		-- Porcentaje Combinacion 6
		-- Compañia + Ramo + Producto + Linea de negocio + Tipo de vehículo + Amparo
		UPDATE DetalleLiquidacionFranquicia
		SET totalParticipacion = (dlf.valorRecaudo * dpf.porcentaje) / 100, porcentajeParticipacion = dpf.porcentaje, liquidadoPor = 2
		FROM 
			DetalleLiquidacionFranquicia AS dlf
			JOIN ParticipacionFranquicia AS pf ON dlf.fechaContabl between pf.fecha_ini AND pf.fecha_fin 
			AND dlf.localidad_id = pf.localidad_id											
			JOIN DetallePartFranquicia AS dpf ON pf.id = dpf.part_franquicia_id
			AND dlf.compania_id =  dpf.compania_id
			AND dpf.ramo_id = dlf.ramo_id_agrupado
			AND dpf.producto_id = dlf.producto_id_agrupado  
			AND dlf.lineaNegocio_id = dpf.lineaNegocio_id 
			AND dlf.tipoVehiculo = dpf.tipoVehiculo_id
			AND dlf.amparo_id = dpf.amparo_id 
		WHERE dlf.liquidadoPor = 0 AND dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal and dpf.rangoinferior is null and dpf.rangosuperior is null	
			and dpf.plan_id = 0
			
		-- Porcentaje Combinacion 7
		-- Compañia + Ramo + Producto + Amparo
		UPDATE DetalleLiquidacionFranquicia
		SET totalParticipacion = (dlf.valorRecaudo * dpf.porcentaje) / 100, porcentajeParticipacion = dpf.porcentaje, liquidadoPor = 2
		FROM 
			DetalleLiquidacionFranquicia AS dlf
			JOIN ParticipacionFranquicia AS pf ON dlf.fechaContabl between pf.fecha_ini AND pf.fecha_fin 
			AND dlf.localidad_id = pf.localidad_id									
			JOIN DetallePartFranquicia AS dpf ON pf.id = dpf.part_franquicia_id
			AND dlf.compania_id =  dpf.compania_id
			AND dpf.ramo_id = dlf.ramo_id_agrupado
			AND dpf.producto_id = dlf.producto_id_agrupado 
			AND dlf.amparo_id = dpf.amparo_id 
		WHERE dlf.liquidadoPor = 0 AND dlf.fechaContabl between @fechaIniLocal and @fechaFinLocal and liquidacionFranquicia_id = @idLiquidacionLocal and dpf.rangoinferior is null and dpf.rangosuperior is null	
			and dpf.plan_id = 0 and dpf.tipoVehiculo_id = 0	and dpf.lineaNegocio_id = 0	
	
	return 1
END
