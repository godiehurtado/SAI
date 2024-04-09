-- =============================================
-- Author:		<Juan Fernando Rojas>
-- Create date: <2012-09-06>
-- Description:	<En una tabla temporal hace el join entre Negocio y Recaudo para sacar los suscriptores
--               y fecha de expedición del negocio asociado al recaudo. Posterior, se inserta la información
--               en la tabla portal.TotalProduccion>
-- =============================================
CREATE PROCEDURE [SAI_portalTotalProduccion]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Insert statements for procedure here
	DECLARE @añoVigente AS INT = (SELECT valor FROM ParametrosApp WHERE id = 3)

	SELECT r.clave
		,r.compania_id
		,c.nombre AS compania
		,rd.ramo_id
		,ra.nombre AS ramo
		,r.lineaNegocio_id
		,ln.nombre AS lineaNegocio
		,pd.producto_id
		,p.nombre AS producto
		,r.numeroNegocio
		,r.fechaRecaudo
		,r.numeroRecibo
		,r.valorRecaudo
		,r.Colquines
		,r.Altura
		,r.amparo_id
		,r.modalidadpago_id
		,r.formaPago_id
		,CAST(n.nombreSuscriptor AS NVARCHAR(50)) AS nombreSuscriptor
		,CAST(n.fechaExpedicion AS DATE) AS fechaExpedicion
	INTO #RecaudosPortal
	FROM Recaudo r
	INNER JOIN Compania c ON c.id = r.compania_id
	INNER JOIN LineaNegocio ln ON ln.id = r.lineaNegocio_id
	INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
	INNER JOIN Ramo ra ON ra.id = rd.ramo_id
	INNER JOIN ProductoDetalle pd ON pd.id = r.productoDetalle_id
	INNER JOIN Producto p ON p.id = pd.producto_id
	LEFT JOIN Negocio n ON CAST(n.numeroNegocio AS BIGINT) = CAST(r.numeroNegocio AS BIGINT)
		AND n.compania_id = r.compania_id
		AND n.ramoDetalle_id = r.ramoDetalle_id
		AND n.productoDetalle_id = r.productoDetalle_id
		AND n.localidad_id = r.localidad_id
		AND n.participante_id = r.participante_id
	WHERE r.anioCierre = @añoVigente
		AND n.anioCierre = @añoVigente

	TRUNCATE TABLE portal.TotalProduccion

	INSERT INTO portal.TotalProduccion (
		clave
		,compania_id
		,nombreCompania
		,ramo_id
		,nombreRamo
		,lineaNegocio_id
		,nombreLineaNegocio
		,producto_id
		,nombreProducto
		,numeroNegocio
		,fechaRecaudo
		,numeroRecibo
		,valorRecaudo
		,colquines
		,altura
		,amparo_id
		,modalidadPago_id
		,nombreSuscriptor
		,fechaExpedicionNegocio
		,formaPago_id
		)
	SELECT rp.clave
		,rp.compania_id
		,rp.compania
		,rp.ramo_id
		,rp.ramo
		,rp.lineaNegocio_id
		,rp.lineaNegocio
		,rp.producto_id
		,rp.producto
		,rp.numeroNegocio
		,rp.fechaRecaudo
		,rp.numeroRecibo
		,rp.valorRecaudo
		,rp.Colquines
		,rp.Altura
		,rp.amparo_id
		,rp.modalidadpago_id
		,rp.nombreSuscriptor
		,rp.fechaExpedicion
		,rp.formaPago_id
	FROM #RecaudosPortal rp
END