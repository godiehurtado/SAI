



CREATE PROCEDURE [dbo].[ListarRecaudosPorFranquicias]
	-- Add the parameters for the stored procedure here
	@fechaini datetime ,
	@fechafin datetime 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- se borran estos datos para iniciar una liquidacion unicamemte en desarrollo en produccion favor comentar estas dos lineas
   --DELETE FROM DETALLELIQUIDACIONFRANQUICIA;
   --DELETE FROM LIQUIDACIONFRANQUICIA
    --esta consulta se hace para hacer una nueva liquidacion
select  r.id,
	
	r.red_id,
	r.valorRecaudo AS valor,
	r.compania_id,
	r.lineaNegocio_id,
	r.ramo_id,
	r.amparo_id,
	r.cobertura_id,
	r.modalidadpago_id,
	r.producto_id,
	r.plan_id,
	tipoRecaudo_id,
	r.formaPago_id,
	r.zona_id,
	r.localidad_id,
	r.participante_id,
	r.clave,
	r.numeroNegocio,
	fecharecaudo,
	r.fechaGrabacion,
	fechaCobranza,
	valorRecaudo,
	numeroRecibo,
	periodoFacturado,
	Altura,
	r.porcentajeParticipacion,
	Concepto,
	porcentajeAhorro_Inversion,
	codigoOcupacion,
	r.sistema,
		codigoBanco,
	 CAST(n.tipoVehiculo_id AS INT) AS tipoVehiculo
	from recaudo r
		
		LEFT JOIN Negocio n ON n.numeroNegocio = r.numeroNegocio 
		AND n.compania_id = r.compania_id 
		AND n.ramo_id = r.ramo_id
		AND n.localidad_id = r.localidad_id
		
WHERE fechaCobranza between @fechaini and @fechafin 
and r.localidad_id in (select id from localidad where tipo_localidad_id=2) 
ORDER BY r.id ASC
 
END
