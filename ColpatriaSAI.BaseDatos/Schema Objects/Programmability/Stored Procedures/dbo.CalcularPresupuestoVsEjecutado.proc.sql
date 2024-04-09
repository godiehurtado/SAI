-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcularPresupuestoVsEjecutado] 
	-- Add the parameters for the stored procedure here
	@anio int,
	@regla_id int = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @anioTemp int = @anio, @idRegla int = @regla_id

	-- **********************************************************
	-- BORRAMOS LA TABLA TEMPORAL PresupuestoEjecutadoxMetaTemp
	-- **********************************************************
	DELETE FROM PresupuestoEjecutadoxMetaTemp

	-- **********************************************************
	-- OBTENEMOS EL PRESUPUESTO POR AÑO
	-- **********************************************************
	INSERT INTO PresupuestoEjecutadoxMetaTemp(presupuesto_id,meta_id,jerarquiaDetalle_id,anio,mes,presupuesto,ejecutado,porcentaje)
	SELECT 
		dp.presupuesto_id, 
		dp.meta_id, 
		dp.jerarquiaDetalle_id, 
		YEAR(dp.fechaIni) AS anio, 
		MONTH(dp.fechaIni) AS mes, 
		dp.valor AS Presupuesto,
		null,
		null
	FROM DetallePresupuesto AS dp
	WHERE YEAR(dp.fechaIni) = @anioTemp

	-- **********************************************************
	-- ACTUALIZAMOS LA EJECUCION DEL PRESUPUESTO 
	-- **********************************************************
	UPDATE PresupuestoEjecutadoxMetaTemp
	SET ejecutado = sub1.Ejecutado
	FROM
		PresupuestoEjecutadoxMetaTemp AS pe
		INNER JOIN
		(
			SELECT SUM(ed.valor) AS Ejecutado, e.presupuesto_id, ed.meta_id, ed.nodo_id, YEAR(ed.periodo) AS anio, MONTH(ed.periodo) as mes
			FROM 
			Ejecucion AS e 
			LEFT JOIN EjecucionDetalle AS ed ON e.id = ed.ejecucion_id 
			WHERE YEAR(ed.periodo) = @anioTemp
			GROUP BY e.presupuesto_id, ed.meta_id, ed.nodo_id, ed.periodo 
		) as sub1 ON pe.presupuesto_id = sub1.presupuesto_id AND pe.meta_id = sub1.meta_id AND pe.jerarquiaDetalle_id = sub1.nodo_id AND pe.anio = sub1.anio AND pe.mes = sub1.mes
	WHERE pe.anio = @anioTemp
	
	
	-- **********************************************************
	-- DETERMINAMOS SI SE EJECUTAN LOS PRECALCULOS DE DESCUENTOS
	-- **********************************************************	
	IF @idRegla <> 0 BEGIN
		
		-- TRAEMOS LAS METAS CON SU PARAMETRIZACION QUE DEBERÍAN TENER DESCUENTOS
		CREATE TABLE #MetasDescuentos(
			meta_id int NULL,
			tipoMedida_id inT NULL,
			compania_id int NULL,
			ramo_id int NULL,
			producto_id int NULL
		)
		Create Index i1 ON #MetasDescuentos(meta_id)
		Create Index i2 ON #MetasDescuentos(tipoMedida_id)
		Create Index i3 ON #MetasDescuentos(compania_id)
		Create Index i4 ON #MetasDescuentos(ramo_id)
		Create Index i5 ON #MetasDescuentos(producto_id)	

		INSERT INTO #MetasDescuentos
		SELECT m.id,
			m.tipoMedida_id,
			pm.compania_id,
			pm.ramo_id,
			pm.producto_id
		FROM ProductosMeta pm
		INNER JOIN Meta m on m.id=pm.meta_id
		INNER JOIN TipoMedida tm on tm.id=m.tipoMedida_id
		WHERE tm.id in (1,21) and pm.compania_id in (1,2,3) and pm.ramo_id in (8,11,17)	

		
		-- Obtener la parametrización de categorias de ejecutivos a descuentar colquines y reacudos a través de la regla
		SELECT categoria_id INTO #CategoriasColquin FROM CategoriaxRegla wHERE regla_id = @idRegla AND esColquin=1
		SELECT categoria_id INTO #CategoriasRecaudo FROM CategoriaxRegla wHERE regla_id = @idRegla AND esRecaudo=1
		
		
		IF EXISTS (SELECT * FROM #CategoriasColquin) BEGIN -- Si hay categorias parametrizadas para descontar colquines
		
			-- DESCUENTO PERSISTENCIA ACUMULADA CAPI COLQUINES
			UPDATE PresupuestoEjecutadoxMetaTemp 
			SET ejecutado = 
				CASE 
					WHEN ROUND(pe.ejecutado, 2) < 0 AND ROUND(pca.colquinesDescontar, 2) = 0 THEN ROUND(pe.ejecutado, 2)
				ELSE CASE 
					WHEN (ROUND(pe.ejecutado, 2) + ROUND(pca.colquinesDescontar, 2)) < 0 THEN 0
					ELSE (ROUND(pe.ejecutado, 2) + ROUND(pca.colquinesDescontar, 2)) END
				END
			FROM
				PresupuestoEjecutadoxMetaTemp AS pe
				INNER JOIN #MetasDescuentos as md ON pe.meta_id = md.meta_id
				INNER JOIN #CategoriasColquin c ON pe.categoria_id = c.categoria_id
				INNER JOIN (
					SELECT 
						SUM(colquinesDescontar) as colquinesDescontar,
						anioCierreNegocio,
						ultimoPeriodo,
						jerarquiaDetalle_id,
						ramo_id
					FROM
						PersistenciadeCAPIAcumulada 
					GROUP BY
					anioCierreNegocio,
					ultimoPeriodo,
					jerarquiaDetalle_id,
					ramo_id		
				)
				as pca ON pe.anio = pca.anioCierreNegocio and pe.mes = pca.ultimoPeriodo and pe.jerarquiaDetalle_id = pca.jerarquiaDetalle_id and md.ramo_id = pca.ramo_id
			WHERE pe.anio = @anioTemp and md.tipoMedida_id = 21 and md.compania_id = 3 and pca.ramo_id = 17
			
			
			-- DESCUENTO PERSISTENCIA ACUMULADA VIDA COLQUINES
			UPDATE PresupuestoEjecutadoxMetaTemp 
			SET ejecutado = 
				CASE 
					WHEN ROUND(pe.ejecutado, 2) < 0 AND ROUND(pv.colquinesDescontar, 2) = 0 THEN ROUND(pe.ejecutado, 2)
				ELSE CASE 
					WHEN (ROUND(pe.ejecutado, 2) + ROUND(pv.colquinesDescontar, 2)) < 0 THEN 0
					ELSE (ROUND(pe.ejecutado, 2) + ROUND(pv.colquinesDescontar, 2)) END
				END
			FROM
				PresupuestoEjecutadoxMetaTemp AS pe
				INNER JOIN #MetasDescuentos as md ON pe.meta_id = md.meta_id
				INNER JOIN #CategoriasColquin c ON pe.categoria_id = c.categoria_id
				INNER JOIN PersistenciadeVida as pv ON pe.anio = pv.añoAMedir and pe.mes = pv.mesCorte and pe.jerarquiaDetalle_id = pv.jerarquiaDetalle_id and md.ramo_id = pv.ramo_id
			WHERE pe.anio = @anioTemp and md.tipoMedida_id = 21 and md.compania_id = 2 and pv.ramo_id = 11
			
			
			-- DESCUENTO SINIESTRALIDAD ACUMULADA COLQUINES
			UPDATE PresupuestoEjecutadoxMetaTemp 
			SET ejecutado = 
				CASE 
					WHEN ROUND(pe.ejecutado, 2) < 0 AND ROUND(s.colquinesDescontar, 2) = 0 THEN ROUND(pe.ejecutado, 2)
				ELSE CASE 
					WHEN (ROUND(pe.ejecutado, 2) + ROUND(s.colquinesDescontar, 2)) < 0 THEN 0
					ELSE (ROUND(pe.ejecutado, 2) + ROUND(s.colquinesDescontar, 2)) END
				END
			FROM
				PresupuestoEjecutadoxMetaTemp AS pe
				INNER JOIN #MetasDescuentos as md ON pe.meta_id = md.meta_id
				INNER JOIN #CategoriasColquin c ON pe.categoria_id = c.categoria_id
				INNER JOIN RamoDetalle rd ON md.ramo_id = rd.ramo_id
				INNER JOIN SiniestralidadAcumulada as s ON pe.anio = s.anio and pe.mes = s.ultimoMes and pe.jerarquiaDetalle_id = s.jerarquiaDetalle_id AND rd.id = s.ramoDetalle_id
			WHERE pe.anio = @anioTemp and md.tipoMedida_id = 21 and md.compania_id = 1 and md.ramo_id = 8 and s.colquinesDescontar <= 0
			
			PRINT 'Descuentos de Colquines aplicado a la tabla PresupuestoEjecutadoxMetaTemp'
		END
		
		
		IF EXISTS (SELECT * FROM #CategoriasRecaudo) BEGIN -- Si hay categorias parametrizadas para descontar recaudos
		
			-- DESCUENTO PERSISTENCIA ACUMULADA CAPI RECAUDOS
			UPDATE PresupuestoEjecutadoxMetaTemp 
			SET ejecutado = 
				CASE 
					WHEN ROUND(pe.ejecutado, 2) < 0 AND ROUND(pca.recaudosDescontar, 2) = 0 THEN ROUND(pe.ejecutado, 2)
				ELSE CASE 
					WHEN (ROUND(pe.ejecutado, 2) + ROUND(pca.recaudosDescontar, 2)) < 0 THEN 0
					ELSE (ROUND(pe.ejecutado, 2) + ROUND(pca.recaudosDescontar, 2)) END
				END
			FROM
				PresupuestoEjecutadoxMetaTemp AS pe
				INNER JOIN #MetasDescuentos as md ON pe.meta_id = md.meta_id
				INNER JOIN #CategoriasRecaudo c ON pe.categoria_id = c.categoria_id
				INNER JOIN (
					SELECT 
						SUM(recaudosDescontar) as recaudosDescontar,
						anioCierreNegocio,
						ultimoPeriodo,
						jerarquiaDetalle_id,
						ramo_id
					FROM
						PersistenciadeCAPIAcumulada
					GROUP BY
					anioCierreNegocio,
					ultimoPeriodo,
					jerarquiaDetalle_id,
					ramo_id		
				)
				as pca ON pe.anio = pca.anioCierreNegocio and pe.mes = pca.ultimoPeriodo and pe.jerarquiaDetalle_id = pca.jerarquiaDetalle_id and md.ramo_id = pca.ramo_id
			WHERE pe.anio = @anioTemp and md.tipoMedida_id = 1 and md.compania_id = 3 and pca.ramo_id = 17
			
			
			-- DESCUENTO PERSISTENCIA ACUMULADA VIDA RECAUDOS
			UPDATE PresupuestoEjecutadoxMetaTemp 
			SET ejecutado = 
				CASE 
					WHEN ROUND(pe.ejecutado, 2) < 0 AND ROUND(pv.recaudosDescontar, 2) = 0 THEN ROUND(pe.ejecutado, 2)
				ELSE CASE 
					WHEN (ROUND(pe.ejecutado, 2) + ROUND(pv.recaudosDescontar, 2)) < 0 THEN 0
					ELSE (ROUND(pe.ejecutado, 2) + ROUND(pv.recaudosDescontar, 2)) END
				END
			FROM
				PresupuestoEjecutadoxMetaTemp AS pe
				INNER JOIN #MetasDescuentos as md ON pe.meta_id = md.meta_id
				INNER JOIN #CategoriasRecaudo c ON pe.categoria_id = c.categoria_id
				INNER JOIN PersistenciadeVida as pv ON pe.anio = pv.añoAMedir and pe.mes = pv.mesCorte and pe.jerarquiaDetalle_id = pv.jerarquiaDetalle_id and md.ramo_id = pv.ramo_id
			WHERE pe.anio = @anioTemp and md.tipoMedida_id = 1 and md.compania_id = 2 and pv.ramo_id = 11
			
			
			-- DESCUENTO SINIESTRALIDAD ACUMULADA RECAUDOS
			UPDATE PresupuestoEjecutadoxMetaTemp 
			SET ejecutado = 
				CASE 
					WHEN ROUND(pe.ejecutado, 2) < 0 AND ROUND(s.recaudosDescontar, 2) = 0 THEN ROUND(pe.ejecutado, 2)
				ELSE CASE 
					WHEN (ROUND(pe.ejecutado, 2) + ROUND(s.recaudosDescontar, 2)) < 0 THEN 0
					ELSE (ROUND(pe.ejecutado, 2) + ROUND(s.recaudosDescontar, 2)) END
				END
			FROM
				PresupuestoEjecutadoxMetaTemp AS pe
				INNER JOIN #MetasDescuentos as md ON pe.meta_id = md.meta_id
				INNER JOIN #CategoriasRecaudo c ON pe.categoria_id = c.categoria_id
				INNER JOIN RamoDetalle rd ON md.ramo_id = rd.ramo_id
				INNER JOIN SiniestralidadAcumulada as s ON pe.anio = s.anio and pe.mes = s.ultimoMes and pe.jerarquiaDetalle_id = s.jerarquiaDetalle_id AND rd.id = s.ramoDetalle_id
			WHERE pe.anio = @anioTemp and md.tipoMedida_id = 1 and md.compania_id = 1 and md.ramo_id = 8 and s.recaudosDescontar <= 0
			
			PRINT 'Descuentos de Recaudos aplicado a la tabla PresupuestoEjecutadoxMetaTemp'
		END
		
		DROP TABLE #MetasDescuentos
		DROP TABLE #CategoriasColquin
		DROP TABLE #CategoriasRecaudo
	END	
	
	
	-- **********************************************************
	-- ACTUALIZAMOS EL PORCENTAJE DE LA EJECUCION VS PRESUPUESTO DETERMINANDO LOS DIFERENTES CASOS
	-- **********************************************************
	UPDATE PresupuestoEjecutadoxMetaTemp
	SET porcentaje = round(((ejecutado * 100) / presupuesto),2)	
	WHERE presupuesto <> 0 AND anio = @anioTemp

	-- PRESUPUESTO NEGATIVO Y EJECUCION POSITIVO
	UPDATE PresupuestoEjecutadoxMetaTemp
	SET porcentaje = round((1 - ( ejecutado / presupuesto )) * 100,2)	
	WHERE presupuesto < 0 AND ejecutado >= 0 AND anio = @anioTemp
	
	-- PRESUPUESTO Y EJECUCION NEGATIVO
	UPDATE PresupuestoEjecutadoxMetaTemp
	SET porcentaje = round((1 - ( ejecutado / presupuesto ) + 1) * 100,2)	
	WHERE presupuesto < 0 AND ejecutado < 0 AND anio = @anioTemp	

	UPDATE PresupuestoEjecutadoxMetaTemp
	SET porcentaje = 0
	WHERE presupuesto = 0 AND anio = @anioTemp	
	
	-- **********************************************************
	-- ACTUALIZAMOS CATEGORIA Y CANAL
	-- **********************************************************
	UPDATE PresupuestoEjecutadoxMetaTemp
	SET categoria_id = p.categoria_id, canal_id = jd.canal_id
	FROM
		PresupuestoEjecutadoxMetaTemp AS pe
		INNER JOIN jerarquiaDetalle AS jd ON pe.jerarquiaDetalle_id = jd.id
		INNER JOIN participante AS p ON jd.participante_id = p.id
	WHERE pe.anio = @anioTemp	

END