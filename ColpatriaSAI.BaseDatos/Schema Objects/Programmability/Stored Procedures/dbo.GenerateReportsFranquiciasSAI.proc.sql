-- =============================================
-- Author:		<Juan Fernando Castro>
-- Create date: <22/08/2011>
-- Description:	<Store procedure para la generacion de los reportes para sai
-- =============================================
CREATE PROCEDURE [dbo].[GenerateReportsFranquiciasSAI]
	@opcion INT = NULL,
	@Compania_id NVARCHAR(200) = NULL,
	@Localidad_id NVARCHAR(200) = NULL,
	@fechaini DATETIME = NULL,
	@fechafinal DATETIME = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	-- Insert statements for procedure here
		
	    IF @opcion = 0
	    BEGIN
	        IF @fechaini IS NULL
	        BEGIN
	            SET @fechaini = '1900-01-01'
	        END 
	        
	        
	        IF @fechafinal IS NULL
	        BEGIN
	            SET @fechafinal = GETDATE()
	        END 
	        
	        
	        
	        
	        SELECT LiquidacionFranquicia.id,
	               fechaLiquidacion,
	               periodoLiquidacionIni,
	               periodoLiquidacionFin,
	               porcentajeParticipacion,
	               totalParticipacion,
	               liquidacionFranquicia_id,
	               l.nombre localidad,
	               localidad_id,
	               dlf.compania_id compania_id,
	               c.nombre compania,
	               dlf.ramo_id ramo_id,
	               r.nombre ramo,
	               p.nombre producto,
	               producto_id,
	               valorRecaudo,
	               numeroNegocio,
	               nivelDirector,
	               claveParticipante,
	               mp.nombre modalidadpago,
	               modalidadPagoId,
	               numeroRecibo,
	               fechaRecaudo,
	               fechaContabl,
	               dlf.amparo_Id amparo_Id,
	               colquines,
	               lineaNegocio_id,
	               z.nombre zona,
	               dlf.zona_id,
	               codigo_agrupador,
	               tipoVehiculo
	        FROM   LiquidacionFranquicia
	               INNER JOIN DetalleLiquidacionFranquicia dlf
	                    ON  dlf.liquidacionFranquicia_id = LiquidacionFranquicia.id
	               INNER JOIN Compania c
	                    ON  dlf.compania_id = c.id
	               INNER JOIN Ramo r
	                    ON  dlf.ramo_id = r.id
	               INNER JOIN Producto p
	                    ON  dlf.producto_id = p.id
	               INNER JOIN Zona z
	                    ON  dlf.zona_id = Z.id
	               INNER JOIN Localidad l
	                    ON  dlf.localidad_id = l.id
	               INNER JOIN ModalidadPago mp
	                    ON  dlf.modalidadPagoId = mp.id
	        WHERE  dlf.compania_id IN (SELECT Item
	                                   FROM   SPLIT(@Compania_id, ','))
	               AND dlf.Localidad_id IN (SELECT Item
	                                        FROM   SPLIT(@Localidad_id, ','))
	               AND dlf.fechaContabl BETWEEN @fechaini AND @fechafinal
	                   
	                   --(ISNULL(dlf.compania_id,0) = ISNULL(@Compania_id,ISNULL(dlf.compania_id,0)))
	        ORDER BY
	               localidad_id
	    END
	    ELSE
	    BEGIN
	        IF @opcion = 1
	        BEGIN
	            SELECT
	            	dtp.compania_id,
	            	c.nombre nombrecia,
	            	clave,
	            	tipoDocumento_id,
	            	documento,
	            	numeroNegocio,
	            	ramo_id,
	            	fechaRecaudo,
	            	concepto_id,
	            	totalParticipacion,
	            	porcentajeComision,
	            	porcentajeParticipacion,
	            	descripcion,
	            	dtp.id
	            FROM
	            	DetallePagosFranquicia dtp
	            	INNER JOIN Compania c ON c.id = dtp.compania_id
	            	INNER JOIN Ramo r ON r.id= dtp.ramo_id
	            WHERE 
	            dtp.compania_id IN(SELECT ITEM FROM SPLIT(@Compania_id, ','))
	            ORDER BY dtp.compania_id
	            	
	        END
	    END
	END


--ELSE
--	BEGIN

--	END

