-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 23/02/2012
-- Description:	Consulta que sirve como origen de datos al reporte de Liquidacion de Participaciones
-- =============================================
CREATE PROCEDURE [dbo].[RPT_LiquidacionParticipaciones]
(
	@liquidacionContratacion_id INT
)
AS
BEGIN
	SET NOCOUNT ON;
	-- NO SE MUESTRAN LOS REGISTROS CUYO PORCENTAJE DE PARTICIPACION NO HA SIDO PARAMETRIZADO ES DECIR ES CERO.
	SELECT
		lc.id,
		CAST(YEAR(lc.FechaIni) as varchar) + '-' + CAST(MONTH(lc.FechaIni) as varchar) AS Periodo,
		jd.nombre AS nodo
		, pa.nombre + SPACE(1) + pa.apellidos AS nombreDirector		
		, pa.documento as cedula
		, jd.codigoNivel 
		, co.nombre AS compania
		, r.nombre AS ramo
		, pr.nombre AS producto
		, ln.nombre AS lineaNegocio
		, ca.nombre AS canal
		, dlcp.clave
		, dlcp.fecha
		, dlcp.numNegocio
		, dlcp.valorComision
		, s.nombre AS Segmento
		, dlcp.porcentajeParticipacion
		, dlcp.valorParticipacion
		, z.nombre AS nombreZona
		, l.nombre AS nombreLocalidad
	FROM DetalleLiquiContratPpacionPpante dlcp
		INNER JOIN JerarquiaDetalle jd ON jd.id = dlcp.jerarquiaDetalle_id
		INNER JOIN Participante pa ON pa.id = jd.participante_id
		LEFT JOIN Localidad l ON l.id = jd.localidad_id
		LEFT JOIN Zona z ON z.id = jd.zona_id
		INNER JOIN Canal ca ON ca.id = dlcp.canal_id
		INNER JOIN Compania co ON co.id = dlcp.compania_id
		INNER JOIN Ramo r ON r.id = dlcp.ramo_id
		INNER JOIN Producto pr ON pr.id = dlcp.producto_id
		INNER JOIN LineaNegocio ln ON ln.id = dlcp.lineaNegocio_id
		INNER JOIN Segmento s ON s.id = dlcp.segmento_id
		INNER JOIN LiquidacionContratacion lc ON dlcp.liqui_contrat_id = lc.id
	WHERE
		dlcp.liqui_contrat_id = @liquidacionContratacion_id and dlcp.porcentajeParticipacion <> 0
END
