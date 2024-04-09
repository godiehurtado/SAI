-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Reporte con el detalle de la persistencia de VIDA (Ejecutivos), recibe los parametros de Año (Obligatorio)
--				y codigoNivel (opcional).
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PersistenciaVIDAEjecutivo] @codigoNivel AS NVARCHAR(50) = NULL
	,@anioMedida AS INT
	,@canal_id AS INT = 0
	,@nivel_id AS INT = 0
	,@tipoPersistencia AS NVARCHAR(50) = NULL
	,@mesCorte AS INT
AS
BEGIN
	DECLARE @PersistenciaAñoAnterior AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 1)
	DECLARE @PersistenciaAñoActual AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 2)
	DECLARE @FactorxPolizas AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 3)
	DECLARE @FactorxPrimas AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 4)

	SELECT pv.tipoPersistencia
		,pv.añoAMedir
		,pv.añoAnterior
		,pv.cantidadNegociosAñoActual AS PolizasExpedidasAñoActual
		,pv.cantidadNegociosVigentesAñoActual AS PolizasVigentesAñoActual
		,ROUND(pv.cumplimientoNegociosAñoActual, 3) AS cumplimientoNegociosAñoActual
		,@FactorxPolizas AS FactorPolizas
		,ROUND(pv.ponderacionNegociosAñoActual, 3) AS ponderacionNegociosAñoActual
		,ROUND(pv.ponderadaNegocios, 3) AS ponderadaNegocios
		,pv.sumaPrimasAñoActual AS PrimasExpedidas
		,pv.sumaPrimasVigentesAñoActual AS PrimasVigentesAñoActual
		,ROUND(pv.cumplimientoPrimasAñoActual, 3) AS cumplimientoPrimasAñoActual
		,@FactorxPrimas AS FactorPrimas
		,ROUND(pv.ponderacionPrimasAñoActual, 3) AS ponderacionPrimasAñoActual
		,ROUND(pv.ponderadaPrimas, 3) AS ponderadaPrimas
		,pv.persistenciaDefinitiva
		,pv.cantidadNegociosAñoAnterior
		,pv.cantidadNegociosVigentesAñoAnterior
		,ROUND(pv.cumplimientoNegociosAñoAnterior, 3) AS cumplimientoNegociosAñoAnterior
		,ROUND(pv.cumplimientoPrimasAñoAnterior, 3) AS cumplimientoPrimasAñoAnterior
		,ROUND(pv.ponderacionNegociosAñoAnterior, 3) AS ponderacionNegociosAñoAnterior
		,ROUND(pv.ponderacionPrimasAñoAnterior, 3) AS ponderacionPrimasAñoAnterior
		,pv.sumaPrimasAñoAnterior
		,pv.sumaPrimasVigentesAñoAnterior
		,pv.subtotalNegocios
		,pv.subtotalPrimas
		,pv.mesCorte
		,pv.colquinesDescontar
		,pv.recaudosDescontar
		,l.nombre AS localidad
		,z.nombre AS zona
		,c.nombre AS canal
		,jd.nombre AS ejecutivo
		,n.nombre AS nivel
	FROM PersistenciadeVIDA pv	
	INNER JOIN JerarquiaDetalle jd ON jd.id = pv.jerarquiaDetalle_id	
	INNER JOIN Localidad l ON l.id = jd.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	INNER JOIN Canal c ON c.id = jd.canal_id
	INNER JOIN Nivel n ON n.id = jd.nivel_id
	WHERE añoAMedir = @anioMedida
		AND (
			@codigoNivel IS NULL
			OR RTRIM(LTRIM(jd.codigoNivel)) = @codigoNivel
			)
		AND (
			@tipoPersistencia IS NULL
			OR RTRIM(LTRIM(pv.tipoPersistencia)) = @tipoPersistencia
			)
		AND pv.mesCorte = @mesCorte
		AND (
			@canal_id = 0
			OR c.id = @canal_id
			)
		AND (
			@nivel_id = 0
			OR n.id = @nivel_id
			)
		AND pv.jerarquiaDetalle_id IS NOT NULL
END
