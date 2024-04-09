/*CREATE PROCEDURE [dbo].[SAI_Negociostemp_SISEVIDA_CONS]
AS
BEGIN

update Negociostemp set fechaExpedicion = '1900-01-01' where (fechaExpedicion is NULL or fechaExpedicion = '') and sistema = 'SISE VIDA' and compania_id = '2'
update Negociostemp set fechaCancelacion = '1900-01-01' where (fechaCancelacion is NULL or fechaCancelacion = '') and sistema = 'SISE VIDA' and compania_id = '2'
update Negociostemp set fechaEmisionMaximoEndoso = '1900-01-01' where (fechaEmisionMaximoEndoso is NULL or fechaEmisionMaximoEndoso = '') and sistema = 'SISE VIDA' and compania_id = '2'
update Negociostemp set fechaRecaudoInicial = '1900-01-01' where (fechaRecaudoInicial is NULL or fechaRecaudoInicial = '') and sistema = 'SISE VIDA' and compania_id = '2'
update Negociostemp set fechaGrabacion = '1900-01-01' where (fechaGrabacion is NULL or fechaGrabacion = '') and sistema = 'SISE VIDA' and compania_id = '2'

CREATE TABLE [dbo].[#NegociostempVida](
	id int IDENTITY(1,1) NOT NULL,
	compania_id nvarchar(50) NULL,
	lineaNegocio_id nvarchar(50) NULL,
	ramo_id nvarchar(50) NULL,
	amparo_id nvarchar(50) NULL,
	cobertura_id nvarchar(50) NULL,
	modalidadPago_id nvarchar(50) NULL,
	productoCodigo nvarchar(50) NULL,
	plan_id nvarchar(50) NULL,
	numeroNegocio nvarchar(50) NULL,
	fechaExpedicion datetime NULL,
	fechaCancelacion datetime NULL,
	fechaEmisionMaximoEndoso datetime NULL,
	fechaRecaudoInicial datetime NULL,
	formaPago_id int NULL,
	cuotasVencidas float NULL,
	cuotasPagadas float NULL,
	valorAsegurado float NULL,
	valorProteccion float NULL,
	valorAhorro float NULL,
	valorPrimaPensiones float NULL,
	valorPrimaTotal float NULL,
	nombreSuscriptor nvarchar(250) NULL,
	fechaNacimientoSuscriptor nvarchar(50) NULL,
	actividadEconomica_id nvarchar(50) NULL,
	generoSuscriptor nvarchar(50) NULL,
	zona_id int NULL,
	localidad_id int NULL,
	clave nvarchar(250) NULL,
	porcentajeParticipacion nvarchar(250) NULL,
	grupoEndoso_id nvarchar(50) NULL,
	tipoEndoso_id nvarchar(50) NULL,
	marcaVehiculo nvarchar(50) NULL,
	tipoVehiculo nvarchar(50) NULL,
	modeloVehiculo nvarchar(50) NULL,
	sistema nvarchar(50) NULL,
	Usuarios int NULL,
	codigoAgrupador nvarchar(50) NULL,
	estado nvarchar(50) NULL,
	numeroSolicitud nvarchar(50) NULL,
	identificacionSuscriptor nvarchar(250) NULL,
	tipoDocumento_id nvarchar (50),
	fechaGrabacion datetime NULL
)

update Negociostemp set tipoDocumento_id = '0' where tipoDocumento_id = '' and Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA'
update Negociostemp set actividadEconomica_id = cast(actividadEconomica_id as int) where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and actividadEconomica_id is NULL
update Negociostemp set zona_id = '0' where Negociostemp.compania_id = '1' and Negociostemp.sistema = 'SISE VIDA' and zona_id is NULL
update Negociostemp set grupoEndoso_id = cast(grupoEndoso_id as int) where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and grupoEndoso_id is NULL
update Negociostemp set tipoEndoso_id = cast(tipoEndoso_id as int) where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and tipoEndoso_id is NULL
update Negociostemp set marcaVehiculo = cast(marcaVehiculo as int) where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and marcaVehiculo is NULL
update Negociostemp set tipoVehiculo = cast(tipoVehiculo as int) where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and tipoVehiculo is NULL
update Negociostemp set modeloVehiculo = cast(modeloVehiculo as int) where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and modeloVehiculo is NULL
update Negociostemp set Usuarios = cast(Usuarios as int) where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and Usuarios is NULL
update Negociostemp set codigoAgrupador = '0' where codigoAgrupador = 'NULL' and Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and codigoAgrupador is NULL
update Negociostemp set numeroSolicitud = cast(numeroSolicitud as int) where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA' and numeroSolicitud is NULL

INSERT INTO #NegociostempVida (compania_id, lineaNegocio_id, ramo_id, amparo_id,cobertura_id, modalidadPago_id, productoCodigo, plan_id, numeroNegocio, valorAsegurado, fechaExpedicion, fechaCancelacion, fechaEmisionMaximoEndoso, fechaRecaudoInicial, cuotasVencidas, cuotasPagadas, valorProteccion, valorAhorro, valorPrimaPensiones, valorPrimaTotal, nombreSuscriptor, fechaNacimientoSuscriptor, actividadEconomica_id, generoSuscriptor, zona_id, localidad_id, clave, porcentajeParticipacion, grupoEndoso_id, tipoEndoso_id, marcaVehiculo, tipoVehiculo, modeloVehiculo, sistema, Usuarios, codigoAgrupador, estado, numeroSolicitud, identificacionSuscriptor, tipoDocumento_id, fechaGrabacion)
Select 
compania_id
,lineaNegocio_id
,ramo_id
,amparo_id
,cobertura_id
,modalidadPago_id
,productoCodigo
,plan_id
,numeroNegocio
,MAX(convert(float, replace(valorAsegurado, ',','.'))) as valorAsegurado
,MAX(convert(datetime, fechaExpedicion, 103)) as fechaExpedicion
,MAX(convert(datetime, fechaCancelacion, 103)) as fechaCancelacion
,MAX(convert(datetime,fechaEmisionMaximoEndoso, 103)) as fechaEmisionMaximoEndoso
,MAX(convert(datetime,fechaRecaudoInicial, 103)) as fechaRecaudoInicial
,MAX(convert(float, replace(cuotasVencidas, ',','.'))) as cuotasVencidas
,MAX(convert(float, replace(cuotasPagadas, ',','.'))) as cuotasPagadas
,sum(Convert(float, replace(valorProteccion, ',','.'))) as valorProteccion
,sum(Convert(float, replace(valorAhorro, ',','.'))) as valorAhorro
,sum(Convert(float, replace(valorPrimaPensiones, ',','.'))) as valorPrimaPensiones
,sum(cast(replace(valorPrimaTotal, ',','.') as float)) as valorPrimaTotal
,nombreSuscriptor
,MAX(fechaNacimientoSuscriptor) as fechaNacimientoSuscriptor
,MAX(convert(int, actividadEconomica_id)) actividadEconomica_id
,generoSuscriptor
,MAX(convert(int, zona_id)) as zona_id
,MAX(convert(int, localidad_id)) as localidad_id
,clave
,porcentajeParticipacion
,MAX(grupoEndoso_id) as grupoEndoso_id
,MAX(tipoEndoso_id) as tipoEndoso_id
,MAX(convert(int, marcaVehiculo)) marcaVehiculo
,MAX(cast(tipoVehiculo as int)) tipoVehiculo
,MAX(convert(int, modeloVehiculo)) modeloVehiculo
,('SISE VIDA') as sistema
,MAX(convert(int, Usuarios)) Usuarios
,MAX(convert(int, codigoAgrupador)) codigoAgrupador
,estado
,MAX(convert(bigint, numeroSolicitud)) numeroSolicitud
,identificacionSuscriptor
,tipoDocumento_id
,MAX(convert(datetime, fechaGrabacion, 103)) as fechaGrabacion

From  Negociostemp 
Where Negociostemp.compania_id = '2' and Negociostemp.sistema = 'SISE VIDA'
Group by compania_id, lineaNegocio_id, ramo_id, amparo_id, cobertura_id, modalidadPago_id
,productoCodigo, plan_id, numeroNegocio, nombreSuscriptor, generoSuscriptor, clave, porcentajeParticipacion
,estado, identificacionSuscriptor, tipoDocumento_id

delete from Negociostemp where compania_id = '2' and sistema = 'SISE VIDA'

insert into Negociostemp (compania_id, lineaNegocio_id, ramo_id, amparo_id,cobertura_id, modalidadPago_id, productoCodigo, plan_id, numeroNegocio, fechaExpedicion, fechaCancelacion, fechaEmisionMaximoEndoso, fechaRecaudoInicial, cuotasVencidas, cuotasPagadas, valorAsegurado, valorProteccion, valorAhorro, valorPrimaPensiones, valorPrimaTotal, nombreSuscriptor, fechaNacimientoSuscriptor, actividadEconomica_id, generoSuscriptor, zona_id, localidad_id, clave, porcentajeParticipacion, grupoEndoso_id, tipoEndoso_id, marcaVehiculo, tipoVehiculo, modeloVehiculo, sistema, Usuarios, codigoAgrupador, estado, numeroSolicitud, identificacionSuscriptor, tipoDocumento_id, fechaGrabacion)
Select compania_id
,lineaNegocio_id
,ramo_id
,amparo_id
,cobertura_id
,modalidadPago_id
,productoCodigo
,plan_id
,numeroNegocio
,fechaExpedicion
,fechaCancelacion
,fechaEmisionMaximoEndoso
,fechaRecaudoInicial
,RTRIM(LTRIM(str(cast(cuotasVencidas as float),13,2))) AS cuotasVencidas
,RTRIM(LTRIM(str(cast(cuotasPagadas as float),13,2))) AS cuotasPagadas
,RTRIM(LTRIM(str(cast(valorAsegurado as float),13,2))) AS valorAsegurado
,RTRIM(LTRIM(str(cast(valorProteccion as float),13,2))) AS valorProteccion
,RTRIM(LTRIM(str(cast(valorAhorro as float),13,2))) AS valorAhorro
,RTRIM(LTRIM(str(cast(valorPrimaPensiones as float),13,2))) AS valorPrimaPensiones
,RTRIM(LTRIM(str(cast(valorPrimaTotal as float),13,2))) AS valorPrimaTotal
,nombreSuscriptor
,fechaNacimientoSuscriptor
,actividadEconomica_id
,generoSuscriptor
,zona_id
,localidad_id
,clave
,porcentajeParticipacion
,grupoEndoso_id
,tipoEndoso_id
,marcaVehiculo
,tipoVehiculo
,modeloVehiculo
,'SISE VIDA'
,Usuarios
,codigoAgrupador
,estado
,numeroSolicitud
,identificacionSuscriptor
,tipoDocumento_id
,fechaGrabacion

From  #NegociostempVida 

drop table #NegociostempVida

END*/