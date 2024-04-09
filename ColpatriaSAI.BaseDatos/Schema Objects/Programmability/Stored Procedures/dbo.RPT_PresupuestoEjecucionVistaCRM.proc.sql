-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 17/09/2012
-- Description:	Reporte Presupuesto Ejecucion CRM
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PresupuestoEjecucionVistaCRM]
AS
BEGIN
	SET NOCOUNT ON;
	SET ANSI_WARNINGS OFF;

	DECLARE @anioVigente AS INT = (SELECT valor FROM ParametrosApp WHERE id = 3)
	DECLARE @presupuestoActual AS INT = (SELECT id FROM Presupuesto WHERE YEAR(fechaInicio) = @anioVigente)
	DECLARE @presupuestoAnterior AS INT = (SELECT id FROM Presupuesto WHERE YEAR(fechaInicio) = (@anioVigente - 1))

	SELECT z.nombre AS nombreZona
		,l.nombre AS nombreLocalidad
		,vpd.nombreNivel
		,vpd.nombreParticipante
		,vpd.Anio
		,vpd.nombreMeta
		,ROUND(vpd.Enero, 2) AS PresupuestoEnero
		,ROUND(COALESCE(sub1.Enero, 0), 2) AS EjecutadoActualEnero
		,sub2.Enero AS ejecutadoAnteriorEnero
		,ROUND(vpd.Febrero, 2) AS PresupuestoFebrero
		,ROUND(COALESCE(sub1.Febrero, 0), 2) AS EjecutadoActualFebrero
		,sub2.Febrero AS ejecutadoAnteriorFebrero
		,ROUND(vpd.Marzo, 2) AS PresupuestoMarzo
		,ROUND(COALESCE(sub1.Marzo, 0), 2) AS EjecutadoActualMarzo
		,sub2.Marzo AS ejecutadoAnteriorMarzo
		,ROUND(vpd.Abril, 2) AS PresupuestoAbril
		,ROUND(COALESCE(sub1.Abril, 0), 2) AS EjecutadoActualAbril
		,sub2.Abril AS ejecutadoAnteriorAbril
		,ROUND(vpd.Mayo, 2) AS PresupuestoMayo
		,ROUND(COALESCE(sub1.Mayo, 0), 2) AS EjecutadoActualMayo
		,sub2.Mayo AS ejecutadoAnteriorMayo
		,ROUND(vpd.Junio, 2) AS PresupuestoJunio
		,ROUND(COALESCE(sub1.Junio, 0), 2) AS EjecutadoActualJunio
		,sub2.Junio AS ejecutadoAnteriorJunio
		,ROUND(vpd.Julio, 2) AS PresupuestoJulio
		,ROUND(COALESCE(sub1.Julio, 0), 2) AS EjecutadoActualJulio
		,sub2.Julio AS ejecutadoAnteriorJulio
		,ROUND(vpd.Agosto, 2) AS PresupuestoAgosto
		,ROUND(COALESCE(sub1.Agosto, 0), 2) AS EjecutadoActualAgosto
		,sub2.Agosto AS ejecutadoAnteriorAgosto
		,ROUND(vpd.Septiembre, 2) AS PresupuestoSeptiembre
		,ROUND(COALESCE(sub1.Septiembre, 0), 2) AS EjecutadoActualSeptiembre
		,sub2.Septiembre AS ejecutadoAnteriorSeptiembre
		,ROUND(vpd.Octubre, 2) AS PresupuestoOctubre
		,ROUND(COALESCE(sub1.Octubre, 0), 2) AS EjecutadoActualOctubre
		,sub2.Octubre AS ejecutadoAnteriorOctubre
		,ROUND(vpd.Noviembre, 2) AS PresupuestoNoviembre
		,ROUND(COALESCE(sub1.Noviembre, 0), 2) AS EjecutadoActualNoviembre
		,sub2.Noviembre AS ejecutadoAnteriorNoviembre
		,ROUND(vpd.Diciembre, 2) AS PresupuestoDiciembre
		,ROUND(COALESCE(sub1.Diciembre, 0), 2) AS EjecutadoActualDiciembre
		,sub2.Diciembre AS ejecutadoAnteriorDiciembre
	FROM PresupuestoDetalle AS vpd
	INNER JOIN Meta m ON m.id = vpd.meta_id
	LEFT JOIN (
		SELECT vpej.presupuesto_id
			,vpej.nodo_id
			,vpej.nombreParticipante
			,vpej.nombreNivel
			,vpej.Anio
			,vpej.meta_id
			,vpej.nombreMeta
			,SUM(vpej.Enero) AS Enero
			,SUM(vpej.Febrero) AS Febrero
			,SUM(vpej.Marzo) AS Marzo
			,SUM(vpej.Abril) AS Abril
			,SUM(vpej.Mayo) AS Mayo
			,SUM(vpej.Junio) AS Junio
			,SUM(vpej.Julio) AS Julio
			,SUM(vpej.Agosto) AS Agosto
			,SUM(vpej.Septiembre) AS Septiembre
			,SUM(vpej.Octubre) AS Octubre
			,SUM(vpej.Noviembre) AS Noviembre
			,SUM(vpej.Diciembre) AS Diciembre
		FROM PresupuestoEjecucionDetalle vpej
		GROUP BY presupuesto_id
			,nodo_id
			,nombreParticipante
			,nombreNivel
			,Anio
			,meta_id
			,nombreMeta
		) AS sub1 ON vpd.nodo_id = sub1.nodo_id
		AND vpd.meta_id = sub1.meta_id
		AND vpd.presupuesto_id = sub1.presupuesto_id
	LEFT JOIN (
		SELECT vpej.presupuesto_id
			,vpej.nodo_id
			,vpej.nombreParticipante
			,vpej.nombreNivel
			,vpej.Anio
			,vpej.meta_id
			,vpej.nombreMeta
			,SUM(vpej.Enero) AS Enero
			,SUM(vpej.Febrero) AS Febrero
			,SUM(vpej.Marzo) AS Marzo
			,SUM(vpej.Abril) AS Abril
			,SUM(vpej.Mayo) AS Mayo
			,SUM(vpej.Junio) AS Junio
			,SUM(vpej.Julio) AS Julio
			,SUM(vpej.Agosto) AS Agosto
			,SUM(vpej.Septiembre) AS Septiembre
			,SUM(vpej.Octubre) AS Octubre
			,SUM(vpej.Noviembre) AS Noviembre
			,SUM(vpej.Diciembre) AS Diciembre
		FROM PresupuestoEjecucionDetalle vpej
		GROUP BY presupuesto_id
			,nodo_id
			,nombreParticipante
			,nombreNivel
			,Anio
			,meta_id
			,nombreMeta
		) AS sub2 ON vpd.nodo_id = sub2.nodo_id
		AND vpd.meta_id = sub2.meta_id
		AND sub2.presupuesto_id = @presupuestoAnterior
	INNER JOIN JerarquiaDetalle jd ON jd.id = vpd.nodo_id
	LEFT JOIN Zona z ON z.id = jd.zona_id
	LEFT JOIN Localidad l ON l.id = jd.localidad_id
	WHERE vpd.presupuesto_id = @presupuestoActual
		AND m.tipoMedida_id IN (1, 21, 3, 4)
		AND m.meta_id IS NULL
END