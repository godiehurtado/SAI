-- =============================================
-- Author:		Frank Payares
-- Create date: 21/20/2012
-- Description:	Obtiene una lista de los procesos de liquidación que se encuentran en curso
-- =============================================
CREATE PROCEDURE [dbo].[ObtenerProcesosEnCurso]
AS
BEGIN
	SET LANGUAGE 'Spanish' -- SE CAMBIA EL LENGUAJE PARA QUE LAS FECHAS SE VISUALIZEN EN ESPAÑOL
	
	IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[LiquiRegla]') AND type in (N'U')) BEGIN
		
		DECLARE @procesoAgrupadas int = (SELECT COUNT(name) FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[liquidacionReglasAgrupadas]') AND type in (N'U'))
		--SELECT COUNT(LP.id) FROM LiquidacionPremio LP INNER JOIN DetalleLiquiRegla DLR ON LP.liquidacionReglaxParticipante_id=DLR.liquidacionReglaxParticipante_id
		
		DECLARE @porcentaje varchar(10) = (
			SELECT CASE WHEN COUNT(subregla_id) > 0 THEN
					(COUNT(subregla_id)*100) / (SELECT COUNT(id) + @procesoAgrupadas FROM SubRegla SR WHERE regla_id IN (SELECT regla_id FROM LiquiRegla) AND SR.condicionAgrupada_id IS NULL)
				ELSE 0 END
			FROM (
				SELECT DLR.subregla_id
				FROM LiquiRegla LR INNER JOIN LiquiReglaxPpante LRP ON LRP.liquidacionRegla_id=LR.id
					INNER JOIN DetalleLiquiRegla DLR ON DLR.liquidacionReglaxParticipante_id=LRP.id
					INNER JOIN DetalleLiquiSubRegla DLSR ON DLSR.detalleLiquidacionRegla_id=DLR.id
				GROUP BY DLR.subregla_id
			) AS T2)  --select @porcentaje
		/**/
		SELECT * FROM (	-- CONSULTA LIQUIDACIONES EN CURSO DE CUALQUIER TIPO
			SELECT DISTINCT P.liquidacion_id AS id, P.tipo,
				CASE P.tipo
					--WHEN 1 THEN 'Liquidación de la regla '+ R.nombre + '. Estado: ' + EP.nombre +'.'
					WHEN 1 THEN 'Liquidación de la regla '+ R.nombre + ' entre '+ CONVERT(varchar, LR.fecha_inicial, 106) +' y '+ CONVERT(varchar, LR.fecha_final, 106) + '. '+ @porcentaje+'% completado.<br /> Estado: ' + EP.nombre +'.'
					WHEN 2 THEN 'Liquidación de la Contratación en el periodo entre '+ CONVERT(varchar, LC.fechaIni, 106) +' y '+ CONVERT(varchar, LC.fechaFin, 106) + '. Estado: ' + EP.nombre +'.'
					WHEN 3 THEN 'Liquidación de Franquicias en el periodo entre '+ CONVERT(varchar, LF.periodoLiquidacionIni, 106) +' y '+ CONVERT(varchar, LF.periodoLiquidacionFin, 106) + '. Estado: ' + EP.nombre +'.'
					WHEN 4 THEN 'Cálculo del presupuesto del año '+ CAST(YEAR(PTO.fechaInicio) as varchar(4)) + '. Estado: ' + EP.nombre +'.'
					WHEN 5 THEN 'Cargue del Presupuesto del año '+ CAST(YEAR(PTO.fechaInicio) as varchar(4)) + '. Estado: ' + EP.nombre +'.'
					WHEN 6 THEN 'Cargue de ejecución de metas manuales para presupuesto del año '+ CAST(E.anio as varchar(4)) + '. Estado: ' + EP.nombre +'.'
					WHEN 7 THEN 'Ejecución reporte asincrono '+ ER.nombre + '. Estado: ' + EP.nombre +'.'
				END AS mensaje
			FROM ProcesoLiquidacion P
				LEFT JOIN LiquiRegla LR ON LR.id = P.liquidacion_id
				LEFT JOIN Regla R ON R.id = LR.regla_id
				LEFT JOIN LiquidacionContratacion LC ON LC.id = P.liquidacion_id
				LEFT JOIN LiquidacionFranquicia LF ON LF.id = P.liquidacion_id
				LEFT JOIN Presupuesto PTO ON PTO.id = P.liquidacion_id
				LEFT JOIN Ejecucion E ON E.id = P.liquidacion_id
				LEFT JOIN ETLRemota ER ON ER.id = p.liquidacion_id
				INNER JOIN EstadoProceso EP ON EP.id = P.estadoProceso_id
			WHERE P.estadoProceso_id <> 4
		)
		AS T1 WHERE mensaje IS NOT NULL
		
	END ELSE
		-- CONSULTA LIQUIDACIONES EN CURSO DE CUALQUIER TIPO ECEPTO LAS DEL PAI YA QUE LA TABLA DONDE SE ALMACENA ES TEMPORAL
		SELECT * FROM (	
			SELECT DISTINCT P.liquidacion_id AS id, P.tipo,
				CASE P.tipo
					WHEN 2 THEN 'Liquidación de la Contratación en el periodo entre '+ CONVERT(varchar, LC.fechaIni, 106) +' y '+ CONVERT(varchar, LC.fechaFin, 106) + '. Estado: ' + EP.nombre +'.'
					WHEN 3 THEN 'Liquidación de Franquicias en el periodo entre '+ CONVERT(varchar, LF.periodoLiquidacionIni, 106) +' y '+ CONVERT(varchar, LF.periodoLiquidacionFin, 106) + '. Estado: ' + EP.nombre +'.'
					WHEN 4 THEN 'Cálculo del presupuesto del año '+ CAST(YEAR(PTO.fechaInicio) as varchar(4)) + '. Estado: ' + EP.nombre +'.'
					WHEN 5 THEN 'Cargue del Presupuesto del año '+ CAST(YEAR(PTO.fechaInicio) as varchar(4)) + '. Estado: ' + EP.nombre +'.'
					WHEN 6 THEN 'Cargue de ejecución de metas manuales para presupuesto del año '+ CAST(E.anio as varchar(4)) + '. Estado: ' + EP.nombre +'.'
					WHEN 7 THEN 'Ejecución reporte asincrono '+ ER.nombre + '. Estado: ' + EP.nombre +'.'
				END AS mensaje
			FROM ProcesoLiquidacion P
				LEFT JOIN LiquidacionContratacion LC ON LC.id = P.liquidacion_id
				LEFT JOIN LiquidacionFranquicia LF ON LF.id = P.liquidacion_id
				LEFT JOIN Presupuesto PTO ON PTO.id = P.liquidacion_id
				LEFT JOIN Ejecucion E ON E.id = P.liquidacion_id
				LEFT JOIN ETLRemota ER ON ER.id = p.liquidacion_id
				INNER JOIN EstadoProceso EP ON EP.id = P.estadoProceso_id
			WHERE P.estadoProceso_id <> 4
		)
		AS T1 WHERE mensaje IS NOT NULL
	
	SET LANGUAGE 'us_english'
END