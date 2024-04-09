
CREATE PROCEDURE [dbo].[GetPagosLiquiFranquicias] 
	-- Add the parameters for the stored procedure here
	@idLiqFranquica int = 0
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT detalleliquidacionfranquicia.compania_id
	      ,l.clavePago AS claveParticipante
	      ,p.tipoDocumento_id AS tipoDocumento_id
	      ,p.documento AS documento
	      ,'' AS numeroNegocio
	      ,'00001' AS ramo_id
	      ,GETDATE() AS fechaRecaudo
	      ,detalleliquidacionfranquicia.localidad_id
	      ,SUM(totalParticipacion) AS totalParticipacion
	      ,'100' AS porcentajeParticipacion
	      ,'1' AS porcentajeComision
	      ,liquidacionFranquicia_id
	      ,conceptoPago.codigoFranquicias
	      ,'Participacion...' AS descripcion
	      ,Compania.nombre AS nombre
	FROM   detalleliquidacionfranquicia
	       INNER JOIN conceptoPago
	            ON  conceptoPago.compania_id = detalleliquidacionfranquicia.compania_id
	       INNER JOIN Compania
	            ON  Compania.id = detalleliquidacionfranquicia.compania_id
	       INNER JOIN Localidad l
	            ON l.id=detalleliquidacionfranquicia.localidad_id
	       INNER JOIN Participante p
	            ON p.clave=l.clavePago
	            
	WHERE  liquidacionFranquicia_id = @idLiqFranquica
	GROUP BY
	       detalleliquidacionfranquicia.localidad_id
	      ,detalleliquidacionfranquicia.compania_id
	      ,Compania.nombre
	      ,liquidacionFranquicia_id
	      ,conceptoPago.codigoFranquicias
	      ,l.clavePago
	      ,p.documento
	      ,p.tipoDocumento_id
	      
	      
	     
	ORDER BY
	       localidad_id
	      ,detalleliquidacionfranquicia.compania_id
	      ,liquidacionFranquicia_id
	       END 
