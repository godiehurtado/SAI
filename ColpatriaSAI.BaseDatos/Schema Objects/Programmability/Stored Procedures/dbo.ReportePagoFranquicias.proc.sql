-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ReportePagoFranquicias]
	-- Add the parameters for the stored procedure here
	@Compania_id NVARCHAR(200) = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	 SELECT
	            	dtp.compania_id,
	            	c.nombre nombrecia,
	            	clave,
	            	tipoDocumento_id,
	            	documento,
	            	numeroNegocio,
	            	dtp.ramo_id,
	            	r.nombre ramo,
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
