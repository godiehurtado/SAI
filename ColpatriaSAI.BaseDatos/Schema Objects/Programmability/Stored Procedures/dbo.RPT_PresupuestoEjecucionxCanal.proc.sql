-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PresupuestoEjecucionxCanal]
(
	@idPresupuesto INT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		vpd.id
		,vpd.presupuesto_id
		,vpd.nodo_id
		,vpd.nombreParticipante
		,vpd.nombreNivel
		,vpd.Anio
		,vpd.meta_id
		,vpd.nombreMeta
		,sub1.nombreCanal
		,ROUND(vpd.Enero,2) AS PresupuestoEnero
		,ROUND(COALESCE(sub1.Enero,0),2) AS EjecutadoEnero           
		,ROUND(vpd.Febrero,2) AS PresupuestoFebrero
		,ROUND(COALESCE(sub1.Febrero,0),2) AS EjecutadoFebrero
		,ROUND(vpd.Marzo,2) AS PresupuestoMarzo
		,ROUND(COALESCE(sub1.Marzo,0),2) AS EjecutadoMarzo
		,ROUND(vpd.Abril,2) AS PresupuestoAbril
		,ROUND(COALESCE(sub1.Abril,0),2) AS EjecutadoAbril
		,ROUND(vpd.Mayo,2) AS PresupuestoMayo
		,ROUND(COALESCE(sub1.Mayo,0),2) AS EjecutadoMayo
		,ROUND(vpd.Junio,2) AS PresupuestoJunio
		,ROUND(COALESCE(sub1.Junio,0),2) AS EjecutadoJunio
		,ROUND(vpd.Julio,2) AS PresupuestoJulio      
		,ROUND(COALESCE(sub1.Julio,0),2) AS EjecutadoJulio
		,ROUND(vpd.Agosto,2) AS PresupuestoAgosto
		,ROUND(COALESCE(sub1.Agosto,0),2) AS EjecutadoAgosto
		,ROUND(vpd.Septiembre,2) AS PresupuestoSeptiembre
		,ROUND(COALESCE(sub1.Septiembre,0),2) AS EjecutadoSeptiembre
		,ROUND(vpd.Octubre,2) AS PresupuestoOctubre
		,ROUND(COALESCE(sub1.Octubre,0),2) AS EjecutadoOctubre
		,ROUND(vpd.Noviembre,2) AS PresupuestoNoviembre
		,ROUND(COALESCE(sub1.Noviembre,0),2) AS EjecutadoNoviembre
		,ROUND(vpd.Diciembre,2) AS PresupuestoDiciembre
		,ROUND(COALESCE(sub1.Diciembre,0),2) AS EjecutadoDiciembre
		,z.nombre AS nombreZona
		,l.nombre AS nombreLocalidad
	FROM PresupuestoDetalle AS vpd
		LEFT JOIN
		(
		SELECT
			vpej.id
			,vpej.presupuesto_id
			,vpej.nodo_id
			,vpej.nombreParticipante
			,vpej.nombreNivel
			,vpej.Anio
			,vpej.meta_id
			,vpej.nombreMeta
			,vpej.nombreCanal
			,vpej.Enero 
			,vpej.Febrero 
			,vpej.Marzo 
			,vpej.Abril 
			,vpej.Mayo 
			,vpej.Junio 
			,vpej.Julio 
			,vpej.Agosto 
			,vpej.Septiembre 
			,vpej.Octubre 
			,vpej.Noviembre 
			,vpej.Diciembre 
		FROM PresupuestoEjecucionDetalle vpej
		) AS sub1 ON vpd.nodo_id = sub1.nodo_id AND vpd.meta_id = sub1.meta_id AND vpd.presupuesto_id = sub1.presupuesto_id
		INNER JOIN JerarquiaDetalle jd ON jd.id = vpd.nodo_id
		INNER JOIN Zona z ON z.id = jd.zona_id
		INNER JOIN Localidad l ON l.id = jd.localidad_id
	WHERE vpd.presupuesto_id = @idPresupuesto
END
