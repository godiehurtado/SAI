-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarFranquiciasPagos] 
	-- Add the parameters for the stored procedure here
	@idLiquidacion int,
	@usuario varchar(200)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @idPago int;	
	
	--INSERTAMOS EL REGISTRO MESTRO
	INSERT INTO PagoFranquicia(fechaPago,liquidacionFranquicia_id, anticipo_id, usuario)
	VALUES
	(getdate(),@idLiquidacion,null,@usuario)
	
	SET @idPago = (SELECT max(id) FROM PagoFranquicia WHERE liquidacionFranquicia_id = @idLiquidacion)

	--INSERTAMOS LOS REGISTROS DETALLE
	INSERT INTO DetallePagosFranquicia (compania_id,clave,tipoDocumento_id,documento,totalParticipacion, descripcion, pagoFranquicia_id)
	SELECT 
	dlf.compania_id,
	l.clavePago,
	p.tipoDocumento_id,
	p.documento,
	sum(totalParticipacion) as totalParticipacion,
	'Participación ' + l.nombre as descipcion,
	@idPago
	FROM DetalleLiquidacionFranquicia AS dlf
	INNER JOIN Localidad AS l ON dlf.localidad_id = l.id
	INNER JOIN Participante AS p ON dlf.localidad_id = p.id
	WHERE dlf.liquidacionFranquicia_id = @idLiquidacion
	GROUP BY dlf.compania_id,l.clavePago,p.tipoDocumento_id,p.documento,l.nombre
	
	--ACTUALIZAMOS EL ESTADO DE LA FRANQUICIA A PAGADA
	--UPDATE LiquidacionFranquicia SET estado = 2 WHERE id = @idLiquidacion

END
