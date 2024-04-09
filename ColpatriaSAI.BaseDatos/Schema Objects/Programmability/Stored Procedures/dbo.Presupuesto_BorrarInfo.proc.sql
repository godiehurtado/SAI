-- =============================================
-- Author:		Frank Payares
-- Create date: 05/01/2012
-- Description:	
-- =============================================
CREATE PROCEDURE [dbo].[Presupuesto_BorrarInfo]
	@año			int,
	@segmento_id	int
AS
BEGIN
	BEGIN TRY		
		--DECLARE @año int=2011, @segmento_id int=1
		-- BORRADO DEL LOG DE ERRORES
		DELETE FROM LC
		--SELECT LC.*
		FROM LogCargue LC INNER JOIN Presupuesto P ON P.id = LC.cargue_id
		WHERE YEAR(P.fechaInicio) = @año AND P.segmento_id = @segmento_id AND LC.cargue_tipo = 1
		
		DECLARE @logCargue_id int = (SELECT ISNULL(MAX(id), 0) FROM LogCargue)
		DBCC CHECKIDENT('LogCargue', RESEED, @logCargue_id) WITH NO_INFOMSGS
		---
		
		-- BORRADO DEL EJECUTADO
		DELETE FROM ED
		FROM EjecucionDetalle ED
			INNER JOIN Ejecucion E ON E.id = ED.ejecucion_id
			INNER JOIN Presupuesto P ON P.id = E.presupuesto_id
		WHERE YEAR(P.fechaInicio) = @año AND P.segmento_id = @segmento_id
		
		DELETE FROM E
		FROM Ejecucion E INNER JOIN Presupuesto P ON P.id = E.presupuesto_id
		WHERE YEAR(P.fechaInicio) = @año AND P.segmento_id = @segmento_id
		---
		
		-- ESTO SE OMITIO YA QUE ACTUALMENTE SE REALIZA EN LA LIQUIDACION DE LA CONTRATACION
		/*-- BORRADO DE METAS POR NODO
		DELETE --SELECT MXN.* 
		FROM MXN
		FROM MetaxNodo AS MXN
			INNER JOIN DetallePresupuesto AS D ON MXN.jerarquiaDetalle_id = D.jerarquiaDetalle_id
			INNER JOIN Presupuesto AS P ON P.id = D.presupuesto_id
			INNER JOIN Meta AS M ON M.id = MXN.meta_id
		WHERE YEAR(P.fechaInicio) = @año AND P.segmento_id = @segmento_id AND M.tipoMetaCalculo_id = 1
		---*/
		
		-- BORRADO DEL PRESUPUESTO
		DELETE FROM D
		FROM DetallePresupuesto D
			INNER JOIN Presupuesto P ON P.id = D.presupuesto_id
		WHERE YEAR(fechaInicio) = @año AND P.segmento_id = @segmento_id
		
		DECLARE @detalle_id int = (SELECT ISNULL(MAX(id), 0) FROM DetallePresupuesto)
		DBCC CHECKIDENT('DetallePresupuesto', RESEED, @detalle_id) WITH NO_INFOMSGS
		
		DELETE FROM Presupuesto WHERE YEAR(fechaInicio) = @año AND segmento_id = @segmento_id
		---
		
		RETURN 1
	END TRY
	BEGIN CATCH
		
		RETURN 0
	END CATCH
END