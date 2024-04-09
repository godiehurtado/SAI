-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PresupuestoEjecucion]
(
	@idPresupuesto INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		z.nombre AS nombreZona
		,l.nombre AS nombreLocalidad
		,vpd.nombreNivel
		,vpd.nombreParticipante
		,vpd.Anio
		,vpd.nombreMeta
		,ROUND(vpd.Enero,2) AS PresupuestoEnero
		,ROUND(COALESCE(sub1.Enero,0),2) AS EjecutadoEnero
		,CASE
			WHEN ROUND(vpd.Enero,2) = 0 THEN 0
			WHEN ROUND(vpd.Enero,2) < 0 AND ROUND(COALESCE(sub1.Enero,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Enero,0) / vpd.Enero )) * 100,2)
			WHEN ROUND(vpd.Enero,2) < 0 AND ROUND(COALESCE(sub1.Enero,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Enero,0) / vpd.Enero ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Enero,0),2)) * 100) / (ROUND(vpd.Enero,2)),2)
		END AS PorcentajeEjecucionEne
		,ROUND(vpd.Febrero,2) AS PresupuestoFebrero
		,ROUND(COALESCE(sub1.Febrero,0),2) AS EjecutadoFebrero
		,CASE
			WHEN ROUND(vpd.Febrero,2) = 0 THEN 0
			WHEN ROUND(vpd.Febrero,2) < 0 AND ROUND(COALESCE(sub1.Febrero,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Febrero,0) / vpd.Febrero )) * 100,2)
			WHEN ROUND(vpd.Febrero,2) < 0 AND ROUND(COALESCE(sub1.Febrero,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Febrero,0) / vpd.Febrero ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Febrero,0),2)) * 100) / (ROUND(vpd.Febrero,2)),2)
		END AS PorcentajeEjecucionFeb
		,ROUND(vpd.Marzo,2) AS PresupuestoMarzo
		,ROUND(COALESCE(sub1.Marzo,0),2) AS EjecutadoMarzo
		,CASE
			WHEN ROUND(vpd.Marzo,2) = 0 THEN 0
			WHEN ROUND(vpd.Marzo,2) < 0 AND ROUND(COALESCE(sub1.Marzo,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Marzo,0) / vpd.Marzo )) * 100,2)
			WHEN ROUND(vpd.Marzo,2) < 0 AND ROUND(COALESCE(sub1.Marzo,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Marzo,0) / vpd.Marzo ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Marzo,0),2)) * 100) / (ROUND(vpd.Marzo,2)),2)
		END AS PorcentajeEjecucionMar
		,ROUND(vpd.Abril,2) AS PresupuestoAbril
		,ROUND(COALESCE(sub1.Abril,0),2) AS EjecutadoAbril
		,CASE
			WHEN ROUND(vpd.Abril,2) = 0 THEN 0
			WHEN ROUND(vpd.Abril,2) < 0 AND ROUND(COALESCE(sub1.Abril,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Abril,0) / vpd.Abril )) * 100,2)
			WHEN ROUND(vpd.Abril,2) < 0 AND ROUND(COALESCE(sub1.Abril,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Abril,0) / vpd.Abril ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Abril,0),2)) * 100) / (ROUND(vpd.Abril,2)),2)
		END AS PorcentajeEjecucionAbr
		,ROUND(vpd.Mayo,2) AS PresupuestoMayo
		,ROUND(COALESCE(sub1.Mayo,0),2) AS EjecutadoMayo
		,CASE
			WHEN ROUND(vpd.Mayo,2) = 0 THEN 0
			WHEN ROUND(vpd.Mayo,2) < 0 AND ROUND(COALESCE(sub1.Mayo,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Mayo,0) / vpd.Mayo )) * 100,2)
			WHEN ROUND(vpd.Mayo,2) < 0 AND ROUND(COALESCE(sub1.Mayo,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Mayo,0) / vpd.Mayo ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Mayo,0),2)) * 100) / (ROUND(vpd.Mayo,2)),2)
		END AS PorcentajeEjecucionMay
		,ROUND(vpd.Junio,2) AS PresupuestoJunio
		,ROUND(COALESCE(sub1.Junio,0),2) AS EjecutadoJunio
		,CASE
			WHEN ROUND(vpd.Junio,2) = 0 THEN 0
			WHEN ROUND(vpd.Junio,2) < 0 AND ROUND(COALESCE(sub1.Junio,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Junio,0) / vpd.Junio )) * 100,2)
			WHEN ROUND(vpd.Junio,2) < 0 AND ROUND(COALESCE(sub1.Junio,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Junio,0) / vpd.Junio ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Junio,0),2)) * 100) / (ROUND(vpd.Junio,2)),2)
		END AS PorcentajeEjecucionJun
		,ROUND(vpd.Julio,2) AS PresupuestoJulio
		,ROUND(COALESCE(sub1.Julio,0),2) AS EjecutadoJulio
		,CASE
			WHEN ROUND(vpd.Julio,2) = 0 THEN 0
			WHEN ROUND(vpd.Julio,2) < 0 AND ROUND(COALESCE(sub1.Julio,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Julio,0) / vpd.Julio )) * 100,2)
			WHEN ROUND(vpd.Julio,2) < 0 AND ROUND(COALESCE(sub1.Julio,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Julio,0) / vpd.Julio ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Julio,0),2)) * 100) / (ROUND(vpd.Julio,2)),2)
		END AS PorcentajeEjecucionJul
		,ROUND(vpd.Agosto,2) AS PresupuestoAgosto
		,ROUND(COALESCE(sub1.Agosto,0),2) AS EjecutadoAgosto
		,CASE
			WHEN ROUND(vpd.Agosto,2) = 0 THEN 0
			WHEN ROUND(vpd.Agosto,2) < 0 AND ROUND(COALESCE(sub1.Agosto,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Agosto,0) / vpd.Agosto )) * 100,2)
			WHEN ROUND(vpd.Agosto,2) < 0 AND ROUND(COALESCE(sub1.Agosto,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Agosto,0) / vpd.Agosto ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Agosto,0),2)) * 100) / (ROUND(vpd.Agosto,2)),2)
		END AS PorcentajeEjecucionAgo
		,ROUND(vpd.Septiembre,2) AS PresupuestoSeptiembre
		,ROUND(COALESCE(sub1.Septiembre,0),2) AS EjecutadoSeptiembre
		,CASE
			WHEN ROUND(vpd.Septiembre,2) = 0 THEN 0
			WHEN ROUND(vpd.Septiembre,2) < 0 AND ROUND(COALESCE(sub1.Septiembre,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Septiembre,0) / vpd.Septiembre )) * 100,2)
			WHEN ROUND(vpd.Septiembre,2) < 0 AND ROUND(COALESCE(sub1.Septiembre,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Septiembre,0) / vpd.Septiembre ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Septiembre,0),2)) * 100) / (ROUND(vpd.Septiembre,2)),2)
		END AS PorcentajeEjecucionSep
		,ROUND(vpd.Octubre,2) AS PresupuestoOctubre
		,ROUND(COALESCE(sub1.Octubre,0),2) AS EjecutadoOctubre
		,CASE
			WHEN ROUND(vpd.Octubre,2) = 0 THEN 0
			WHEN ROUND(vpd.Octubre,2) < 0 AND ROUND(COALESCE(sub1.Octubre,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Octubre,0) / vpd.Octubre )) * 100,2)
			WHEN ROUND(vpd.Octubre,2) < 0 AND ROUND(COALESCE(sub1.Octubre,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Octubre,0) / vpd.Octubre ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Octubre,0),2)) * 100) / (ROUND(vpd.Octubre,2)),2)
		END AS PorcentajeEjecucionOct
		,ROUND(vpd.Noviembre,2) AS PresupuestoNoviembre
		,ROUND(COALESCE(sub1.Noviembre,0),2) AS EjecutadoNoviembre
		,CASE
			WHEN ROUND(vpd.Noviembre,2) = 0 THEN 0
			WHEN ROUND(vpd.Noviembre,2) < 0 AND ROUND(COALESCE(sub1.Noviembre,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Noviembre,0) / vpd.Noviembre )) * 100,2)
			WHEN ROUND(vpd.Noviembre,2) < 0 AND ROUND(COALESCE(sub1.Noviembre,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Noviembre,0) / vpd.Noviembre ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Noviembre,0),2)) * 100) / (ROUND(vpd.Noviembre,2)),2)
		END AS PorcentajeEjecucionNov
		,ROUND(vpd.Diciembre,2) AS PresupuestoDiciembre
		,ROUND(COALESCE(sub1.Diciembre,0),2) AS EjecutadoDiciembre
		,CASE
			WHEN ROUND(vpd.Diciembre,2) = 0 THEN 0
			WHEN ROUND(vpd.Diciembre,2) < 0 AND ROUND(COALESCE(sub1.Diciembre,0),2) > 0 THEN round((1 - ( COALESCE(sub1.Diciembre,0) / vpd.Diciembre )) * 100,2)
			WHEN ROUND(vpd.Diciembre,2) < 0 AND ROUND(COALESCE(sub1.Diciembre,0),2) < 0 THEN round((1 - ( COALESCE(sub1.Diciembre,0) / vpd.Diciembre ) + 1) * 100,2)
			ELSE ROUND(((ROUND(COALESCE(sub1.Diciembre,0),2)) * 100) / (ROUND(vpd.Diciembre,2)),2)
		END AS PorcentajeEjecucionDic
	FROM PresupuestoDetalle AS vpd
		LEFT JOIN
		(
		SELECT
			vpej.presupuesto_id
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
		GROUP BY presupuesto_id ,nodo_id ,nombreParticipante ,nombreNivel ,Anio ,meta_id ,nombreMeta
		) AS sub1 ON vpd.nodo_id = sub1.nodo_id AND vpd.meta_id = sub1.meta_id AND vpd.presupuesto_id = sub1.presupuesto_id
		INNER JOIN JerarquiaDetalle jd ON jd.id = vpd.nodo_id
		LEFT JOIN Zona z ON z.id = jd.zona_id
		LEFT JOIN Localidad l ON l.id = jd.localidad_id
	WHERE vpd.presupuesto_id = @idPresupuesto
	
END