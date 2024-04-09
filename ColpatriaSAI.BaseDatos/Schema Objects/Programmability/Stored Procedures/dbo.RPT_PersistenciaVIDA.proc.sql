
-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Reporte con el detalle de la persistencia de VIDA, recibe los parametros de Año (Obligatorio)
--				y clave (opcional).
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PersistenciaVIDA] @clave AS NVARCHAR(50) = NULL
	,@anioMedida AS INT
	,@canal_id AS INT = 0
	,@tipoPersistencia AS NVARCHAR(50) = NULL
	,@mesCorte AS INT
AS
BEGIN
	DECLARE @PersistenciaAñoAnterior AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 1)
	DECLARE @PersistenciaAñoActual AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 2)
	DECLARE @FactorxPolizas AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 3)
	DECLARE @FactorxPrimas AS FLOAT = (SELECT factor FROM ParametrosPersistenciaVIDA WHERE id = 4)

	SELECT (
			CASE 
				WHEN pv.tipoPersistencia = 1
					THEN 'Periodo'
				ELSE 'Definitiva'
				END
			) AS tipoPersistencia
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
		,ROUND(pv.persistenciaDefinitiva, 3) AS persistenciaDefinitiva
		,p.clave
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
		,l.nombre AS localidad
		,z.nombre AS zona
		,jPadre.nombre AS director
		,c.nombre AS canal
	FROM PersistenciadeVIDA pv
	INNER JOIN Participante p ON p.id = pv.participante_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
	LEFT JOIN JerarquiaDetalle jPadre ON jPadre.id = jd.padre_id
	INNER JOIN Localidad l ON l.id = p.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	INNER JOIN Canal c ON c.id = p.canal_id
	WHERE añoAMedir = @anioMedida
		AND (
			@clave IS NULL
			OR RTRIM(LTRIM(p.clave)) = @clave
			)
		AND (
			@tipoPersistencia IS NULL
			OR RTRIM(LTRIM(pv.tipoPersistencia)) = (
				CASE 
					WHEN @tipoPersistencia = 'Definitiva'
						THEN 2
					ELSE 1
					END
				)
			)
		AND pv.mesCorte = @mesCorte
		AND (
			@canal_id = 0
			OR c.id = @canal_id
			)
		AND pv.participante_id IS NOT NULL
END
