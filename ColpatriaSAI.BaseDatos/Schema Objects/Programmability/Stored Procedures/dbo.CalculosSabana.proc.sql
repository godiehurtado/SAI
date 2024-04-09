CREATE PROCEDURE [dbo].[CalculosSabana]

AS
BEGIN

CREATE TABLE #Negocio(
	[id] [int] NOT NULL,
	[producto_id] [int] NULL,
	[localidad_id] [int] NULL,
	[cliente_id] [int] NULL,
	[numeroNegocio] [nchar](50) NULL,
	[fechaExpedicion] [datetime] NULL,
	[fechaCancelacion] [datetime] NULL,
	[formaPago] [int] NULL,
	[segmento_id] [int] NULL,
	[estadoNegocio_id] [int] NULL,
	[tipoEndoso_id] [int] NULL,
	[grupoEndoso_id] [int] NULL,
	[codigoAgrupador] [nchar](10) NULL,
	[valorAsegurado] [float] NULL,
	[lineaNegocio_id] [int] NULL,
	[compania_id] [int] NULL,
	[ramo_id] [int] NULL,
	[amparo_id] [int] NULL,
	[cobertura_id] [int] NULL,
	[modalidadPago_id] [int] NULL,
	[plan_id] [int] NULL,
	[zona_id] [int] NULL,
	[participante_id] [int] NULL,
	[red_id] [int] NULL,
	[clave] [varchar](100) NULL,
	[fechaGrabacion] [datetime] NULL,
	[fechaEmisionMaximoEndoso] [datetime] NULL,
	[fechaRecaudoInicial] [datetime] NULL,
	[numeroSolicitud] [int] NULL,
	[cuotasPagadas] [int] NULL,
	[cuotasVencidas] [int] NULL,
	[valorProteccion] [varchar](100) NULL,
	[valorAhorro] [varchar](100) NULL,
	[valorPrimaPensiones] [varchar](100) NULL,
	[valorPrimaTotal] [varchar](100) NULL,
	[identificacionSuscriptor] [varchar](100) NULL,
	[nombreSuscriptor] [varchar](100) NULL,
	[direccionSuscriptor] [varchar](100) NULL,
	[telefonoSuscriptor] [varchar](100) NULL,
	[fechaNacimientoSuscriptor] [datetime] NULL,
	[generoSuscriptor] [varchar](100) NULL,
	[edadSuscriptor] [varchar](100) NULL,
	[codigoFranquicia] [varchar](100) NULL,
	[marcaVehiculo] [varchar](100) NULL,
	[tipoVehiculo] [varchar](100) NULL,
	[modeloVehiculo] [varchar](100) NULL,
	[sistema] [varchar](100) NULL,
	[porcentajeParticipacion] [float] NULL,
	[actividadEconomica_id] [int] NULL,
	[formaPago_id] [int] NULL)
	

	CREATE TABLE #Recaudo(
	[id] [int] NOT NULL,
	[negocio_id] [int] NULL,
	[red_id] [int] NULL,
	[valor] [float] NULL,
	[fecha_recaudo] [datetime] NULL,
	[tipoPago_id] [int] NULL,
	[compania_id] [int] NULL,
	[lineaNegocio_id] [int] NULL,
	[ramo_id] [int] NULL,
	[amparo_id] [int] NULL,
	[cobertura_id] [int] NULL,
	[modalidadpago_id] [int] NULL,
	[producto_id] [int] NULL,
	[plan_id] [int] NULL,
	[tipoRecaudo_id] [int] NULL,
	[formaPago_id] [int] NULL,
	[zona_id] [int] NULL,
	[localidad_id] [int] NULL,
	[participante_id] [int] NULL,
	[clave] [varchar](100) NULL,
	[numeroNegocio] [varchar](100) NULL,
	[fechaGrabacion] [datetime] NULL,
	[fechaCobranza] [datetime] NULL,
	[valorRecaudo] [float] NULL,
	[numeroRecibo] [varchar](100) NULL,
	[periodoFacturado] [int] NULL,
	[Estado] [varchar](100) NULL,
	[Altura] [varchar](100) NULL,
	[porcentajeParticipacion] [float] NULL,
	[Concepto] [varchar](100) NULL,
	[porcentajeAhorro_Inversion] [float] NULL,
	[codigoOcupacion] [varchar](100) NULL,
	[sistema] [varchar](100) NULL)


	
declare @st datetime
SET @st =getdate()
CREATE TABLE #Actualizar (negocioId int, cantidad_recaudosxnegocios int, cantidad_recaudo float, cantidad_colquines float)
INSERT INTO #Actualizar SELECT #negocio.id, count(#recaudo.id), SUM(#recaudo.valor), SUM(LiquidacionMoneda.cantidad)   
	FROM #Recaudo inner join #Negocio on #Recaudo.negocio_id = #negocio.id 
				 left join LiquidacionMoneda on #recaudo.id = LiquidacionMoneda.recaudo_id where #negocio.id >  0 GROUP BY #negocio.id
 
	
PRINT 'Operacion completada en: '  + RTRIM(cast(datediff(ms,@st,getdate()) as char(10)))  
	+ ' milisegundos'	
	
	UPDATE Negocio 
	set cantidad_recaudosxnegocio = #Actualizar.cantidad_recaudosxnegocios 
	from Negocio
	inner join #Actualizar on #Actualizar.negocioId = negocio.id 
	
	UPDATE Negocio 
	set cantidad_recaudo = #Actualizar.cantidad_recaudo 
	from Negocio
	inner join #Actualizar on #Actualizar.negocioId = negocio.id 
	
	UPDATE Negocio 
	set cantidad_colquines = #Actualizar.cantidad_colquines 
	from Negocio
	inner join #Actualizar on #Actualizar.negocioId = negocio.id 
	

	DROP TABLE #Actualizar
	DROP TABLE #Negocio
	DROP TABLE #Recaudo
	
END