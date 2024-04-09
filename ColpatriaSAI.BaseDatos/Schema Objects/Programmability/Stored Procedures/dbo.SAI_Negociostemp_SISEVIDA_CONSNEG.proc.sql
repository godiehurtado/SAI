/*CREATE PROCEDURE [dbo].[SAI_Negociostemp_SISEVIDA_CONSNEG]
AS
BEGIN

DECLARE @añoVigente AS INT = (SELECT CAST(p.valor AS INT) FROM ParametrosApp p WHERE p.id = 3)

CREATE TABLE [dbo].[#NegocioVida](
	id int IDENTITY(0,1) NOT NULL,
	producto_id int NULL,
	localidad_id int NULL,
	cliente_id int NULL,
	numeroNegocio nvarchar(250) NULL,
	fechaExpedicion datetime NULL,	
	tipoEndoso_id int NULL,
	grupoEndoso_id int NULL,
	valorAsegurado float NULL,
	lineaNegocio_id int NULL,
	compania_id int NULL,
	ramo_id int NULL,
	amparo_id int NULL,
	cobertura_id int NULL,
	modalidadPago_id int NULL,
	plan_id int NULL,
	zona_id int NULL,
	participante_id int NULL,
	clave nvarchar(250) NULL,
	--fechaGrabacion datetime NULL, -------------------------
	fechaRecaudoInicial datetime NULL,
	numeroSolicitud int NULL,
	cuotasPagadas float NULL,
	cuotasVencidas float NULL,
	identificacionSuscriptor nvarchar(250) NULL,
	nombreSuscriptor nvarchar(250) NULL,
	generoSuscriptor nvarchar(100) NULL,
	marcaVehiculo_id int NULL,
	tipoVehiculo_id int NULL,
	modeloVehiculo nvarchar(100) NULL,
	sistema nvarchar(100) NULL,
	porcentajeParticipacion float NULL,
	--actividadEconomica_id int NULL,------------------------
	formaPago_id int NULL,
	valorProteccion float NULL,
	valorAhorro float NULL,
	valorPrimaPensiones float NULL,
	valorPrimaTotal float NULL,
	estadoNegocio nvarchar(100) NULL,
	codigoAgrupador nvarchar(100) NULL,
	fechaEmisionMaximoEndoso datetime NULL,
	fechaCancelacion datetime NULL,
	Usuarios int NULL,
	fechaGrabacion datetime NULL
	)

INSERT INTO #NegocioVida (producto_id, localidad_id, cliente_id, numeroNegocio, fechaExpedicion, tipoEndoso_id, grupoEndoso_id, valorAsegurado, lineaNegocio_id, compania_id, ramo_id, amparo_id, cobertura_id, modalidadPago_id, plan_id, zona_id, participante_id, clave, fechaRecaudoInicial, numeroSolicitud, cuotasPagadas, cuotasVencidas, identificacionSuscriptor, nombreSuscriptor, generoSuscriptor, marcaVehiculo_id, tipoVehiculo_id, modeloVehiculo, sistema, porcentajeParticipacion, formaPago_id, valorProteccion, valorAhorro, valorPrimaPensiones, valorPrimaTotal, estadoNegocio, codigoAgrupador, fechaEmisionMaximoEndoso, fechaCancelacion, Usuarios, fechaGrabacion)
Select productoDetalle_id
,MAX(convert(int, localidad_id)) as localidad_id
,MAX(cliente_id) as cliente_id
,numeroNegocio
,MAX(fechaExpedicion) as fechaExpedicion
,MAX(tipoEndoso_id) as tipoEndoso_id
,MAX(grupoEndoso_id) as grupoEndoso_id
,MAX(convert(float,valorAsegurado)) as valorAsegurado
,lineaNegocio_id
,compania_id
,ramoDetalle_id
,amparo_id
,cobertura_id
,modalidadPago_id
,planDetalle_id
,MAX(convert(int, zona_id)) as zona_id
,MAX(participante_id)
,clave
,MAX(fechaRecaudoInicial) as fechaRecaudoInicial
,MAX(convert(int, numeroSolicitud)) numeroSolicitud
,MAX(convert(float, cuotasVencidas)) as cuotasVencidas
,MAX(convert(float, cuotasPagadas)) as cuotasPagadas
,identificacionSuscriptor
,nombreSuscriptor
,generoSuscriptor
,MAX(convert(int, marcaVehiculo_id)) marcaVehiculo_id
,MAX(convert(int, tipoVehiculo_id)) tipoVehiculo_id
,MAX(convert(int, modeloVehiculo)) modeloVehiculo
,('SISE VIDA') as sistema
,porcentajeParticipacion
,MAX(convert(int, formaPago_id)) formaPago_id
,sum(Convert(float, valorProteccion)) as valorProteccion
,sum(Convert(float, valorAhorro)) as valorAhorro
,sum(Convert(float, valorPrimaPensiones)) as valorPrimaPensiones
,sum(cast(valorPrimaTotal as float)) as valorPrimaTotal
,estadoNegocio
,MAX(convert(int, codigoAgrupador)) codigoAgrupador
,MAX(fechaEmisionMaximoEndoso) as fechaEmisionMaximoEndoso
,MAX(fechaCancelacion) as fechaCancelacion
,MAX(convert(int, Usuarios)) Usuarios
,MAX(fechaGrabacion) as fechaGrabacion

From  Negocio
Where Negocio.compania_id = 2 and Negocio.sistema = 'SISE VIDA' and YEAR(fechaExpedicion) = @añoVigente
Group by compania_id, lineaNegocio_id, ramoDetalle_id, amparo_id, cobertura_id, modalidadPago_id
,productoDetalle_id, planDetalle_id, numeroNegocio, nombreSuscriptor, generoSuscriptor, clave, porcentajeParticipacion
,estadoNegocio, identificacionSuscriptor

delete from Negocio where compania_id = 2 and sistema = 'SISE VIDA' and YEAR(fechaExpedicion) = @añoVigente

insert into Negocio (productoDetalle_id, localidad_id, cliente_id, numeroNegocio, fechaExpedicion, tipoEndoso_id, grupoEndoso_id, valorAsegurado, lineaNegocio_id, compania_id, ramoDetalle_id, amparo_id, cobertura_id, modalidadPago_id, planDetalle_id, zona_id, participante_id, clave, fechaRecaudoInicial, numeroSolicitud, cuotasPagadas, cuotasVencidas, identificacionSuscriptor, nombreSuscriptor, generoSuscriptor, marcaVehiculo_id, tipoVehiculo_id, modeloVehiculo, sistema, porcentajeParticipacion, formaPago_id, valorProteccion, valorAhorro, valorPrimaPensiones, valorPrimaTotal, estadoNegocio, codigoAgrupador, fechaEmisionMaximoEndoso, fechaCancelacion, Usuarios, fechaGrabacion)
Select producto_id
,localidad_id
,cliente_id
,numeroNegocio
,fechaExpedicion
,tipoEndoso_id
,grupoEndoso_id
,valorAsegurado
,lineaNegocio_id
,compania_id
,ramo_id
,amparo_id
,cobertura_id
,modalidadPago_id
,plan_id
,zona_id
,participante_id
,clave
,fechaRecaudoInicial
,numeroSolicitud
,cuotasPagadas
,cuotasVencidas
,identificacionSuscriptor
,nombreSuscriptor
,generoSuscriptor
,marcaVehiculo_id
,tipoVehiculo_id
,modeloVehiculo
,sistema
,porcentajeParticipacion
,formaPago_id
,valorProteccion
,valorAhorro
,valorPrimaPensiones
,valorPrimaTotal
,estadoNegocio
,codigoAgrupador
,fechaEmisionMaximoEndoso
,fechaCancelacion
,Usuarios
,fechaGrabacion
From  #NegocioVida 

drop table #NegocioVida

update Negocio set actividadEconomica_id = 0 where actividadEconomica_id is NULL and Negocio.compania_id = 2

END*/