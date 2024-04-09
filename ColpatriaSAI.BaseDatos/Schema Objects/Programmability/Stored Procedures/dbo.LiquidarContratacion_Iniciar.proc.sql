-- =============================================
-- Author:		Frank Payares
-- Create date: 15/09/2011
-- Description:	Liquida un modelo de contratación por vigencia
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarContratacion_Iniciar]
	@idLiquidacion int,
	@FechaIniParam date,
	@FechaFinParam date,
	@usuarioParam varchar(50) = 'UINVERSION\',
	@idSegmentoParam int
AS
BEGIN

	SET NOCOUNT ON;

	DECLARE @FechaIni date= @FechaIniParam, @FechaFin date= @FechaFinParam, @usuario varchar(50)=@usuarioParam
	DECLARE @idLiqui int = @idLiquidacion, @idSegmento int = @idSegmentoParam
	DECLARE @jerarquiaDetalle_id int, @notaDefinitiva float, @factor float, @anio int, @mes int
	
	SET @anio = YEAR(@FechaIni)
	SET @mes = MONTH(@FechaIni)

	INSERT INTO ProcesoLiquidacion VALUES (2, @idLiqui, GETDATE(), 2)
	
	DECLARE @idPresupuesto int = (SELECT id FROM presupuesto WHERE segmento_id = @idSegmento AND YEAR(fechaInicio) = @anio)
		
	-- *********************************************************************************************************
	-- CREAMOS TABLA PARA AGRUPAR EL PRESUPUESTO Y ELE EJECUTADO DE UNA META POR NODO DEL PERIODO EN LIQUIDACION
	-- *********************************************************************************************************
	--DROP TABLE #PresupuestoVsEjecutadoMetas
	CREATE TABLE #PresupuestoVsEjecutadoMetas(
		presupuesto_id int NULL,
		meta_id int NULL,
		jerarquiaDetalle_id int NULL,
		anio int NULL,
		mes int NULL,
		presupuesto float NULL,
		ejecutado float NULL,
		porcentaje float
	)	

    Create Index i1 ON #PresupuestoVsEjecutadoMetas(meta_id)
	Create Index i2 ON #PresupuestoVsEjecutadoMetas(jerarquiaDetalle_id)
	Create Index i3 ON #PresupuestoVsEjecutadoMetas(anio)
	Create Index i4 ON #PresupuestoVsEjecutadoMetas(mes)

	-- LLAMAMOS PROCEDIMIENTO PARA GENERAR EL PRESUPUESTO VS EJECUTADO
	EXEC dbo.CalcularPresupuestoVsEjecutado @anio

	INSERT INTO #PresupuestoVsEjecutadoMetas
	SELECT
		presupuesto_id,meta_id,jerarquiaDetalle_id,anio,mes,presupuesto,ejecutado,porcentaje  
	FROM
		PresupuestoEjecutadoxMetaTemp as view_pexm
	WHERE presupuesto_id = @idPresupuesto AND /*Ejecutado is not null AND */ view_pexm.anio = @anio AND view_pexm.mes = @mes 
	-- SE COMENTA EL CAMPO DE EJECUTADO IS NOT NULL PARA GARANTIZAR QUE TODAS LAS METAS APAREZCAN ASI NO TENGAN PRESUPUESTO

	-- **********************************************************************************************************************************
	-- OBTENEMOS LOS MODELOS CON SUS METAS DE LA JERARQUIA QUE NO ES ASESOR Y ADEMAS INCLUIMOS:
	-- PRESUPUESTO Y EL EJECUTADO DE CADA META
	-- PORCENTAJE
	-- NOTA
	-- **********************************************************************************************************************************
	
	-- CREAMOS TABLA TEMPORAL PARA GUARDAR LOS DATOS DE MODELO X META X JERARQUIA
	--DROP TABLE #ModelosXMetasXJerarquia	
	CREATE TABLE #ModelosXMetasXJerarquia(
		modelo_id int NULL,		
		jerarquiaDetalle_id int NULL,
		meta_id int NULL,
		fatorxnota_id int NULL,
		tipoescala_id int NULL,		
		peso float NULL,
		presupuesto float NULL,
		ejecutado float NULL,
		porcentaje float NULL
	)
	
	Create Index i5 ON #ModelosXMetasXJerarquia(modelo_id)	
	Create Index i6 ON #ModelosXMetasXJerarquia(jerarquiaDetalle_id)
	Create Index i7 ON #ModelosXMetasXJerarquia(meta_id)
	Create Index i8 ON #ModelosXMetasXJerarquia(fatorxnota_id)	
	
	INSERT INTO #ModelosXMetasXJerarquia
	-- Combinacion Nivel
	SELECT md.modelo_id, jd.id as jerarquiaDetalle_id, mn.meta_id, mn.factorxnota_id, fn.tipoescala_id, mn.peso, COALESCE(pem.presupuesto, 0) as presupuesto, pem.ejecutado as ejecutado, COALESCE(pem.porcentaje, 0) as porcentaje
	FROM modeloxnodo as md
	INNER JOIN jerarquiaDetalle as jd ON md.nivel_id = jd.nivel_id
	INNER JOIN modeloxmeta as mn ON md.modelo_id = mn.modelo_id
	INNER JOIN factorxnota as fn ON mn.factorxnota_id = fn.id
	LEFT JOIN #PresupuestoVsEjecutadoMetas as pem ON jd.id = pem.jerarquiaDetalle_id AND mn.meta_id = pem.meta_id
	WHERE 
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
		AND jd.nivel_id <> 0 AND mn.factorxnota_id > 0 AND md.zona_id = 0 AND md.localidad_id = 0 AND md.jerarquiaDetalle_id = 0
	UNION	
	-- Combinacion Zona
	SELECT md.modelo_id, jd.id as jerarquiaDetalle_id, mn.meta_id, mn.factorxnota_id, fn.tipoescala_id, mn.peso, COALESCE(pem.presupuesto, 0) as presupuesto, pem.ejecutado as ejecutado, COALESCE(pem.porcentaje, 0) as porcentaje
	FROM modeloxnodo as md
	INNER JOIN jerarquiaDetalle as jd ON md.zona_id = jd.zona_id
	INNER JOIN modeloxmeta as mn ON md.modelo_id = mn.modelo_id
	INNER JOIN factorxnota as fn ON mn.factorxnota_id = fn.id
	LEFT JOIN #PresupuestoVsEjecutadoMetas as pem ON jd.id = pem.jerarquiaDetalle_id AND mn.meta_id = pem.meta_id
	WHERE 
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
		AND jd.nivel_id <> 0 AND mn.factorxnota_id > 0 AND md.nivel_id = 0 AND md.localidad_id = 0 AND md.jerarquiaDetalle_id = 0	
	UNION		
	-- Combinacion Jerarquia
	SELECT md.modelo_id, jd.id as jerarquiaDetalle_id, mn.meta_id, mn.factorxnota_id, fn.tipoescala_id, mn.peso, COALESCE(pem.presupuesto, 0) as presupuesto, pem.ejecutado as ejecutado, COALESCE(pem.porcentaje, 0) as porcentaje
	FROM modeloxnodo as md
	INNER JOIN jerarquiaDetalle as jd ON md.jerarquiaDetalle_id = jd.id
	INNER JOIN modeloxmeta as mn ON md.modelo_id = mn.modelo_id
	INNER JOIN factorxnota as fn ON mn.factorxnota_id = fn.id
	LEFT JOIN #PresupuestoVsEjecutadoMetas as pem ON jd.id = pem.jerarquiaDetalle_id AND mn.meta_id = pem.meta_id
	WHERE 
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
		AND jd.nivel_id <> 0 AND mn.factorxnota_id > 0 AND md.nivel_id = 0 AND md.localidad_id = 0 AND md.zona_id = 0	
	UNION	
	-- Combinacion Nivel, Zona		
	SELECT md.modelo_id, jd.id as jerarquiaDetalle_id, mn.meta_id, mn.factorxnota_id, fn.tipoescala_id, mn.peso, COALESCE(pem.presupuesto, 0) as presupuesto, pem.ejecutado as ejecutado, COALESCE(pem.porcentaje, 0) as porcentaje
	FROM modeloxnodo as md
	INNER JOIN jerarquiaDetalle as jd ON md.nivel_id = jd.nivel_id AND md.zona_id = jd.zona_id
	INNER JOIN modeloxmeta as mn ON md.modelo_id = mn.modelo_id
	INNER JOIN factorxnota as fn ON mn.factorxnota_id = fn.id
	LEFT JOIN #PresupuestoVsEjecutadoMetas as pem ON jd.id = pem.jerarquiaDetalle_id AND mn.meta_id = pem.meta_id
	WHERE 
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
		AND jd.nivel_id <> 0 AND mn.factorxnota_id > 0 AND md.jerarquiaDetalle_id = 0 AND md.localidad_id = 0
	UNION	
	-- Combinacion Zona, Localidad
	SELECT md.modelo_id, jd.id as jerarquiaDetalle_id, mn.meta_id, mn.factorxnota_id, fn.tipoescala_id, mn.peso, COALESCE(pem.presupuesto, 0) as presupuesto, pem.ejecutado as ejecutado, COALESCE(pem.porcentaje, 0) as porcentaje
	FROM modeloxnodo as md
	INNER JOIN jerarquiaDetalle as jd ON md.zona_id = jd.zona_id AND md.localidad_id = jd.localidad_id 
	INNER JOIN modeloxmeta as mn ON md.modelo_id = mn.modelo_id
	INNER JOIN factorxnota as fn ON mn.factorxnota_id = fn.id
	LEFT JOIN #PresupuestoVsEjecutadoMetas as pem ON jd.id = pem.jerarquiaDetalle_id AND mn.meta_id = pem.meta_id
	WHERE 
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
		AND jd.nivel_id <> 0 AND mn.factorxnota_id > 0 AND md.jerarquiaDetalle_id = 0 AND md.nivel_id = 0	
	UNION	
	-- Combinacion Nivel, Zona, Localidad			
	SELECT md.modelo_id, jd.id as jerarquiaDetalle_id, mn.meta_id, mn.factorxnota_id, fn.tipoescala_id, mn.peso, COALESCE(pem.presupuesto, 0) as presupuesto, pem.ejecutado as ejecutado, COALESCE(pem.porcentaje, 0) as porcentaje
	FROM modeloxnodo as md
	INNER JOIN jerarquiaDetalle as jd ON md.nivel_id = jd.nivel_id AND md.zona_id = jd.zona_id AND md.localidad_id = jd.localidad_id 
	INNER JOIN modeloxmeta as mn ON md.modelo_id = mn.modelo_id
	INNER JOIN factorxnota as fn ON mn.factorxnota_id = fn.id
	LEFT JOIN #PresupuestoVsEjecutadoMetas as pem ON jd.id = pem.jerarquiaDetalle_id AND mn.meta_id = pem.meta_id
	WHERE 
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
		AND jd.nivel_id <> 0 AND mn.factorxnota_id > 0 AND md.jerarquiaDetalle_id = 0
	UNION	
	-- Combinacion Nivel, Zona, Jerarquia
	SELECT md.modelo_id, jd.id as jerarquiaDetalle_id, mn.meta_id, mn.factorxnota_id, fn.tipoescala_id, mn.peso, COALESCE(pem.presupuesto, 0) as presupuesto, pem.ejecutado as ejecutado, COALESCE(pem.porcentaje, 0) as porcentaje
	FROM modeloxnodo as md
	INNER JOIN jerarquiaDetalle as jd ON md.nivel_id = jd.nivel_id AND md.zona_id = jd.zona_id AND md.jerarquiaDetalle_id = jd.id 
	INNER JOIN modeloxmeta as mn ON md.modelo_id = mn.modelo_id
	INNER JOIN factorxnota as fn ON mn.factorxnota_id = fn.id
	LEFT JOIN #PresupuestoVsEjecutadoMetas as pem ON jd.id = pem.jerarquiaDetalle_id AND mn.meta_id = pem.meta_id
	WHERE 
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
		AND jd.nivel_id <> 0 AND mn.factorxnota_id > 0 AND md.localidad_id = 0
	 UNION	
	-- Combinacion Nivel, Zona, Localidad, Jerarquia
	SELECT md.modelo_id, jd.id as jerarquiaDetalle_id, mn.meta_id, mn.factorxnota_id, fn.tipoescala_id, mn.peso, COALESCE(pem.presupuesto, 0) as presupuesto, pem.ejecutado as ejecutado, COALESCE(pem.porcentaje, 0) as porcentaje
	FROM modeloxnodo as md
	INNER JOIN jerarquiaDetalle as jd ON md.nivel_id = jd.nivel_id AND md.zona_id = jd.zona_id AND md.jerarquiaDetalle_id = jd.id AND md.localidad_id = jd.localidad_id  
	INNER JOIN modeloxmeta as mn ON md.modelo_id = mn.modelo_id
	INNER JOIN factorxnota as fn ON mn.factorxnota_id = fn.id
	LEFT JOIN #PresupuestoVsEjecutadoMetas as pem ON jd.id = pem.jerarquiaDetalle_id AND mn.meta_id = pem.meta_id
	WHERE 
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
		AND jd.nivel_id <> 0 AND mn.factorxnota_id > 0	

	UPDATE ProcesoLiquidacion SET estadoProceso_id = 5 WHERE tipo=2 AND liquidacion_id=@idLiqui
	
	-- ********************************************************************************************************************
	-- INSERTAMOS EN LIQUIDACION CONTRAT META SEGUN LA CONSULTA ANTERIOR Y ADEMAS OBTENEMOS LAS ESCALAS PARA HACER CALCULOS
	-- ********************************************************************************************************************
	INSERT INTO LiquiContratMeta (liqui_contrat_id,modelo_id,jerarquiaDetalle_id,meta_id,presupuesto,ejecutado,cumplimiento,nota,pesoNota,notaPonderada)		
	SELECT 
		@idLiqui,
		mxmxj.modelo_id, 
		mxmxj.jerarquiaDetalle_id, 
		mxmxj.meta_id, 
		--COALESCE(mxmxj.fatorxnota_id,0) as factorxnota_id, 
		COALESCE(mxmxj.presupuesto, 0) as presupuesto, 
		mxmxj.ejecutado, 
		COALESCE(mxmxj.porcentaje, 0) as porcentaje,
		CASE mxmxj.tipoescala_id
			WHEN 1 THEN
				CASE
					WHEN e.factorInf is not null AND e.notaSup <> e.notaInf THEN 
						e.notaInf + (porcentaje - e.factorInf) * ( (e.notaSup - e.notaInf ) / (e.factorSup - e.factorInf) )
					WHEN e.factorInf is not null AND e.notaSup = e.notaInf THEN 
						e.notaSup	
					WHEN e.factorInf is null THEN 
						COALESCE(e.notaSup, 0)		
					ELSE
						0
				END
			WHEN 2 THEN
				COALESCE(porcentaje,0)
		END as nota,
		mxmxj.peso, 
		0
	FROM #ModelosXMetasXJerarquia as mxmxj
	OUTER APPLY ObtenerEscalaCumplimiento(fatorxnota_id,porcentaje,@anio,@mes) as e	

	-- **************************************************************************************
	-- DETERMINAMOS SI EL PRESUPUESTO ES IGUAL A 0 PARA ACTUALIZAR EL PESO A ESTE MISMO VALOR
	-- **************************************************************************************
	UPDATE LiquiContratMeta SET pesoNota = 0, nota = 0 WHERE liqui_contrat_id = @idLiqui AND (presupuesto = 0 OR ejecutado is null)

	-- ******************************
	-- ACTUALIZAMOS LA NOTA PONDERADA
	-- ******************************
	UPDATE LiquiContratMeta SET notaPonderada = (nota * pesoNota) / 100 WHERE liqui_contrat_id = @idLiqui
	
	-- *********************************************************************************
	-- INSERTAMOS LA LIQUIDACION DE CONTRATACION POR PARTICIPANTE CON SU NOTA DEFINITIVA
	-- *********************************************************************************
	INSERT INTO LiquiContratFactorParticipante(liqui_contrat_id,modelo_id,jerarquiaDetalle_id,notaDefinitiva,factor,salarioBase,valorIncremento,salarioTotal,valorFVD,valorFVC,totalPago)	
	SELECT 
		@idLiqui,
		modelo_id,
		jerarquiaDetalle_id,
		CASE
			WHEN SUM(pesoNota) > 0 THEN 
				(100 * SUM(notaPonderada) / SUM(pesoNota))
			WHEN SUM(pesoNota) <= 0 THEN	
				0
		END as notaDefinitiva,
		0 as factor,
		0 as salarioBase,
		0 as valorIncremento,
		0 as salarioTotal,
		0 as valorFVD,
		0 as valorFVC,
		0 as totalPago
	FROM LiquiContratMeta
	WHERE liqui_contrat_id = @idLiqui
	GROUP BY jerarquiaDetalle_id, modelo_id
		
	-- ***************************************
	-- ACTUALIZAMOS EL FACTOR DE CONTRATACION
	-- ***************************************	
	UPDATE LiquiContratFactorParticipante
	SET factor = CASE
					WHEN e.factorInf is not null AND e.notaSup <> e.notaInf THEN 
						CASE 
							WHEN (e.factorSup - e.factorInf) = 0 THEN
								e.factorSup
							ELSE
								e.factorInf + (lcfp.notaDefinitiva - e.notaInf) * CAST((CAST((e.factorSup - e.factorInf) AS FLOAT) / CAST((e.notaSup - e.notaInf ) AS FLOAT)) AS FLOAT)
						END								
					WHEN e.factorInf is not null AND e.notaSup = e.notaInf THEN 
						e.factorSup	
					WHEN e.factorInf is null THEN 
						COALESCE(e.factorSup, 0)		
					ELSE
						0
				END
	FROM
    LiquiContratFactorParticipante as lcfp
	INNER JOIN modelo as m ON lcfp.modelo_id = m.id
	OUTER APPLY ObtenerEscalaCumplimientoModelo(m.factorxnota_id,lcfp.notaDefinitiva,@anio,@mes) as e
	WHERE lcfp.liqui_contrat_id = @idLiqui
	
	UPDATE ProcesoLiquidacion SET estadoProceso_id = 16 WHERE tipo=2 AND liquidacion_id=@idLiqui
	
	-- *************************************
	-- LIQUIDACIÓN DE GERENTES Y SUBGERENTES
	-- *************************************

		DECLARE  @salarioMinimo float = (SELECT smlv FROM salarioMinimo where anio = @anio)
		DECLARE  @salarioBaseMinimo float = (@salarioMinimo * 10)
	
		-- ********************************************************
		-- ACTUALIZAMOS LOS SALARIOS DE LA LIQUIDACION PARA GERENTES
		-- *********************************************************
		UPDATE LiquiContratFactorParticipante
		SET salarioBase = p.salario,
			valorIncremento = CASE
								WHEN  p.salario >= @salarioBaseMinimo THEN
									0
								ELSE
									p.salario * 0.3 
							  END,
			salarioTotal = (CASE
								WHEN  p.salario >= @salarioBaseMinimo THEN
									0
								ELSE
									p.salario * 0.3 
							END + p.salario)		 
		FROM LiquiContratFactorParticipante as lcfp
		INNER JOIN jerarquiaDetalle as jd ON lcfp.jerarquiaDetalle_id = jd.id
		INNER JOIN participante as p ON jd.participante_id = p.id
		WHERE lcfp.liqui_contrat_id = @idLiqui AND jd.nivel_id > 2	 

		-- ********************************************************
		-- ACTUALIZAMOS EL PAGO DE LA LIQUIDACION PARA GERENTES
		-- *********************************************************		
		UPDATE LiquiContratFactorParticipante
		SET totalPago = 
						CASE factor 
							WHEN 0 THEN
								salarioTotal
							ELSE
								salarioTotal + ((salarioTotal * factor) / 100)
						END	
		FROM LiquiContratFactorParticipante as lcfp
		INNER JOIN jerarquiaDetalle as jd ON lcfp.jerarquiaDetalle_id = jd.id													
		WHERE lcfp.liqui_contrat_id = @idLiqui AND jd.nivel_id > 2	  				
		
	-- *****************************************
	-- FIN LIQUIDACIÓN DE GERENTES Y SUBGERENTES
	-- *****************************************	
	
	-- *************************
	-- LIQUIDACIÓN DE DIRECTORES
	-- *************************
		
		-- *****************************************************
		-- OBTENEMOS LAS COMISIONES DEL MES Y AÑO EN LIQUIDACION		
		-- *****************************************************
		DECLARE @comisionTemp as ComisionTemp
		INSERT INTO @comisionTemp(companiaMovimiento_id,ramo_id,lineaNegocio_id,participante_id,segmento_id,año,mes,valorConcepto,numeroNegocio)		
		SELECT 
			companiaMovimiento_id,
			ramo_id,
			lineaNegocio_id,
			participante_id,
			segmento_id,
			año,
			mes,
			valorConcepto,
			numeroNegocio	
		FROM Comision
		WHERE año=@anio and mes=@mes 		
		
		UPDATE ProcesoLiquidacion SET estadoProceso_id = 17 WHERE tipo=2 AND liquidacion_id=@idLiqui
		
		-- *******************************************************************
		-- OBTENEMOS DIRECTORES Y LOS RECORREMOS PARA CALCULAR LAS PARTICIPACIONES A LOS DIRECTORES PARAMETRIZADOS (Tabla. participaciondirector)
		-- *******************************************************************			
		DECLARE @LiquiContratMetaLista CURSOR SET @LiquiContratMetaLista = CURSOR /*SCROLL*/ FAST_FORWARD FOR
		
		SELECT lcfp.jerarquiaDetalle_id, lcfp.notaDefinitiva, lcfp.factor
		FROM LiquiContratFactorParticipante as lcfp
		INNER JOIN 
		(
			SELECT distinct jerarquiaDetalle_id 
			FROM participaciondirector
		) as sub1 ON lcfp.jerarquiaDetalle_id = sub1.jerarquiaDetalle_id
		WHERE lcfp.liqui_contrat_id = @idLiqui
		OPEN @LiquiContratMetaLista FETCH NEXT FROM @LiquiContratMetaLista INTO @jerarquiaDetalle_id, @notaDefinitiva, @factor
		WHILE @@FETCH_STATUS = 0 BEGIN -- RECORRE LA LISTA DE DIRECTORES		
			
			-- LLAMAMOS PROCEDIMIENTO PARA CALCULAR LAS PARTICIPACIONES A PARTIR DE LAS COMISIONES DE DIRECTORES
			EXEC dbo.LiquidarContratacion_Directores @idLiqui, @jerarquiaDetalle_id, @factor, @anio, @mes, @comisionTemp
			
			--PARA HACER DEBUG
			INSERT INTO LiquidacionContratacionDebug(prueba1) values (@jerarquiaDetalle_id)
			
			FETCH NEXT FROM @LiquiContratMetaLista INTO @jerarquiaDetalle_id, @notaDefinitiva, @factor
		END CLOSE @LiquiContratMetaLista DEALLOCATE @LiquiContratMetaLista	
		
	-- *****************************
	-- FIN LIQUIDACIÓN DE DIRECTORES
	-- *****************************
	UPDATE ProcesoLiquidacion SET estadoProceso_id = 4 WHERE tipo=2 AND liquidacion_id=@idLiqui
	
	UPDATE LiquidacionContratacion SET estado = 1 WHERE id=@idLiqui
	
	DELETE FROM LiquidacionContratacionDebug
	
	DELETE FROM ProcesoLiquidacion WHERE tipo=2 AND liquidacion_id=@idLiqui
	
	return 1	
END
