-- =============================================
-- Author:		Frank Payares
-- Create date: 20/09/2011
-- Description:	Obtiene y liquida la información de las comisiones de los asesores por compañia y ramo
-- =============================================
CREATE PROCEDURE [dbo].[LiquidarContratacion_Directores]
	@idLiquiParam int,
	@jerarquiaDetalleIdParam int,
	@factorParam float,
	@anioParam int,
	@mesParam int,
	@comisionTempParam ComisionTemp readonly
AS
BEGIN
	
	SET NOCOUNT ON;
	
	DECLARE @idLiqui int = @idLiquiParam, @jerarquiaDetalle_id int = @jerarquiaDetalleIdParam, @factor float = @factorParam
	DECLARE @anio int = @anioParam, @mes int = @mesParam, @ValorFVD float, @ValorFVC float
	
	-- *******************************************************
	-- CREAMOS TABLA TEMPORAL PARA LAS COMISIONES
	-- *******************************************************		
	
	--DROP TABLE #ComisionesDirector
	CREATE TABLE #ComisionesDirector(
		compania_id int NULL,
		ramo_id int NULL,		
		lineaNegocio_id int NULL,
		participante_id int NULL,
		segmento_id int NULL,
		año int NULL,
		mes int NULL,
		valorConcepto float NULL,
		numeroNegocio nvarchar(250) NULL,
		canal_id int NULL,
		jerarquia_id int NULL,
		clave nvarchar(20) NULL
	)		

    Create Index i1 ON #ComisionesDirector(compania_id)
	Create Index i2 ON #ComisionesDirector(ramo_id)
	Create Index i3 ON #ComisionesDirector(lineaNegocio_id)
	Create Index i4 ON #ComisionesDirector(participante_id)
	Create Index i5 ON #ComisionesDirector(segmento_id)	
	Create Index i6 ON #ComisionesDirector(numeroNegocio)	
	Create Index i7 ON #ComisionesDirector(año)	
	Create Index i8 ON #ComisionesDirector(mes)	
	
	-- *******************************************************
	-- OBTENEMOS LA PRODUCCION DE TODOS LOS NODOS DEL DIRECTOR
	-- *******************************************************
		INSERT INTO #ComisionesDirector(compania_id,ramo_id,lineaNegocio_id,participante_id,segmento_id,año,mes,valorConcepto,numeroNegocio,canal_id,jerarquia_id, clave)
		SELECT c.companiaMovimiento_id, c.ramo_id, c.lineaNegocio_id, c.participante_id, c.segmento_id,c.año,c.mes,c.valorConcepto,
			c.numeroNegocio, hijos.canal_id, hijos.jerarquia_id, hijos.clave
		FROM
			Jerarquia as j 
			INNER JOIN ObtenerHijosNodo(@jerarquiaDetalle_id) AS hijos ON j.id = hijos.jerarquia_id
			INNER JOIN @comisionTempParam AS c ON hijos.participante_id = c.participante_id AND j.segmento_id = c.segmento_id
		WHERE c.año=@anio and c.mes=@mes
	
	-- **********************************************************************
	-- OBTENEMOS LA PRODUCCION DE TODOS LOS NODOS DE EXCEPCIONES DEL DIRECTOR
	-- **********************************************************************
	INSERT INTO #ComisionesDirector(compania_id,ramo_id,lineaNegocio_id,participante_id,segmento_id,año,mes,valorConcepto,numeroNegocio,canal_id,jerarquia_id, clave)
	SELECT c.companiaMovimiento_id, c.ramo_id, c.lineaNegocio_id, c.participante_id, c.segmento_id,c.año,c.mes,c.valorConcepto,
		c.numeroNegocio, sub1.canal_id, sub1.jerarquia_id, sub1.clave
	FROM
		Jerarquia as j
		INNER JOIN(
			SELECT hijosExcepciones.participante_id, hijosExcepciones.jerarquia_id, hijosExcepciones.canal_id, hijosExcepciones.clave
			FROM
			(			
				SELECT excepcionJerarquiaOrigen_id, excepcionJerarquiaDestino_id
				FROM excepcionJerarquiaDetalle
				WHERE excepcionJerarquiaOrigen_id = @jerarquiaDetalle_id
				GROUP BY excepcionJerarquiaOrigen_id,excepcionJerarquiaDestino_id
			)as dp 
			CROSS APPLY ObtenerHijosNodo(dp.excepcionJerarquiaDestino_id) as hijosExcepciones		    
		) as sub1 ON j.id = sub1.jerarquia_id		
		INNER JOIN @comisionTempParam AS c ON sub1.participante_id = c.participante_id AND j.segmento_id = c.segmento_id	
	WHERE c.año=@anio and c.mes=@mes

	-- **********************************************************************
	-- INSERTAMOS EL DETALLE DE LAS COMISIONES DE LA JERARQUIA
	-- **********************************************************************
	
	INSERT INTO DetalleLiquiContratPpacionPpante (liqui_contrat_id,jerarquiaDetalle_id,clave,canal_id, compania_id,ramo_id,producto_id,lineaNegocio_id,fecha,numNegocio,valorComision,segmento_id,porcentajeParticipacion,valorParticipacion)
	SELECT 
		@idLiqui,
		@jerarquiaDetalle_id,
		cd.clave, 
		cd.canal_id,
		cd.compania_id, 
		cd.ramo_id,
		0 as producto_id, 
		cd.lineaNegocio_id, 		
		CAST(cd.año as varchar) + '-' + CAST(cd.mes as varchar) + '-01' as fecha, 
		cd.numeroNegocio,
		cd.valorConcepto,	
		cd.segmento_id,
		0 as porcentaje,
		0 as valorParticipacion		
	FROM
		#ComisionesDirector as cd

	-- *************************************************************************************************************************
	-- 	OBTENEMOS LAS CLAVES CON SU ANTIGUEDAD EN MESES DE LOS HIJOS DEL DIRECTOR EN LIQUIDACION
	-- *************************************************************************************************************************	
	
	-- CREAMOS TABLA TEMPORAL PARA 
	--DROP TABLE #AntiguedadNodosTemp
	CREATE TABLE #AntiguedadNodosTemp(
		clave nvarchar(20) NULL,
		mesesAntiguedadNodo int NULL
	)		

    Create Index i1 ON #AntiguedadNodosTemp(clave)

	-- TOMAMOS LA FECHA DE ANTIGUEDAD A DICIEMBRE DEL AÑO PASADO
	DECLARE @fechaAntiguedad varchar(10) = CAST((@anio - 1) AS varchar) + '-12-31'
	
	-- CONSULTAMOS HIJOS CON SU ANTIGUEDAD
	INSERT INTO #AntiguedadNodosTemp(clave, mesesAntiguedadNodo)
		SELECT 
			p.clave,
			CASE 
				WHEN p.fechaIngreso IS NULL OR p.fechaIngreso = '' THEN
					0
				WHEN p.fechaIngreso IS NOT NULL THEN
					DATEDIFF(m, p.fechaIngreso, CAST(@fechaAntiguedad AS datetime))
			END AS mesesAntiguedad
		FROM 
		jerarquiaDetalle as jd 
		INNER JOIN participante as p ON jd.participante_id = p.id
		WHERE jd.padre_id = @jerarquiaDetalle_id
	UNION
		SELECT 
			hijosExcepciones.clave,
			CASE 
				WHEN p.fechaIngreso IS NULL OR p.fechaIngreso = '' THEN
					0
				WHEN p.fechaIngreso IS NOT NULL THEN
					DATEDIFF(m, p.fechaIngreso, CAST(@fechaAntiguedad AS datetime))
			END AS mesesAntiguedad			
		FROM
		(			
			SELECT excepcionJerarquiaOrigen_id, excepcionJerarquiaDestino_id
			FROM excepcionJerarquiaDetalle
			WHERE excepcionJerarquiaOrigen_id = @jerarquiaDetalle_id
			GROUP BY excepcionJerarquiaOrigen_id,excepcionJerarquiaDestino_id
		)as dp 
		CROSS APPLY ObtenerHijosNodo(dp.excepcionJerarquiaDestino_id) as hijosExcepciones	
		INNER JOIN participante as p ON hijosExcepciones.participante_id = p.id	
	ORDER BY clave	
	
	-- ****************************************************************************
	-- ACTUALIZAMOS EL DETALLE DE LAS COMISIONES POR COMBINACION Y SU PARTICIPACION
	-- ***************************************************************************	
	-- Combinacion Compania Ramo
	UPDATE DetalleLiquiContratPpacionPpante
	SET porcentajeParticipacion = COALESCE(par.porcentaje,0), valorParticipacion = COALESCE((CAST(dlcpp.valorComision as float) * par.porcentaje) / 100, 0)
	FROM DetalleLiquiContratPpacionPpante as dlcpp
	INNER JOIN #AntiguedadNodosTemp as p ON dlcpp.clave = p.clave COLLATE SQL_Latin1_General_CP1_CI_AS				
	CROSS APPLY ObtenerParticipacionMes(p.mesesAntiguedadNodo,@anio,@mes,dlcpp.compania_id,dlcpp.ramo_id,0) as par
	WHERE dlcpp.liqui_contrat_id = @idLiqui AND jerarquiaDetalle_id = @jerarquiaDetalle_id AND dlcpp.compania_id = par.compania_id AND dlcpp.ramo_id = par.ramo_id AND par.lineaNegocio_id = 0
	
	-- Combinacion Compania Ramo lineaNegocio
	UPDATE DetalleLiquiContratPpacionPpante
	SET porcentajeParticipacion = COALESCE(par.porcentaje,0), valorParticipacion = COALESCE((CAST(dlcpp.valorComision as float) * par.porcentaje) / 100, 0)
	FROM DetalleLiquiContratPpacionPpante as dlcpp
	INNER JOIN #AntiguedadNodosTemp as p ON dlcpp.clave = p.clave COLLATE SQL_Latin1_General_CP1_CI_AS		
	CROSS APPLY ObtenerParticipacionMes(p.mesesAntiguedadNodo,@anio,@mes,dlcpp.compania_id,dlcpp.ramo_id,dlcpp.lineaNegocio_id) as par 
	WHERE dlcpp.liqui_contrat_id = @idLiqui AND dlcpp.jerarquiaDetalle_id = @jerarquiaDetalle_id AND dlcpp.compania_id = par.compania_id AND dlcpp.ramo_id = par.ramo_id AND dlcpp.lineaNegocio_id = par.lineaNegocio_id	
	

	-- ***************************************************************************************************
	-- INSERTAMOS LA LIQUIDACION DE COMISIONES DEL PARTICIPANTE ACUMULANDO POR JERARQUIA, CANAL Y COMPANIA
	-- ***************************************************************************************************
	INSERT INTO LiquiContratPpacionPpante(liqui_contrat_id, jerarquiaDetalle_id, canal_id, compania_id, basePpanteOriginal, peso, basePpantePonderada)	
	SELECT 
		@idLiqui,
		jerarquiaDetalle_id, 
		canal_id, 
		compania_id,
		sum(valorParticipacion) as basePpanteOriginal, 		
		0 as peso,
		0 as basePpantePonderada
	FROM DetalleLiquiContratPpacionPpante
	WHERE liqui_contrat_id = @idLiqui AND jerarquiaDetalle_id = @jerarquiaDetalle_id
	GROUP BY jerarquiaDetalle_id, canal_id, compania_id
	
	-- ******************************************************************************************************************************************
	-- ACTUALIZAMOS LA LIQUIDACION DE COMISIONES DEL PARTICIPANTE ACUMULANDO TENIENDO EN CUENTA LA PARTICIPACION DEL DIRECTOR Y SUS COMBINACIONES
	-- ******************************************************************************************************************************************	
	
	-- Combinacion Compania
	UPDATE LiquiContratPpacionPpante
	SET peso = COALESCE(par.porcentaje,0), basePpantePonderada = COALESCE((CAST(lcpp.basePpanteOriginal as float) * par.porcentaje) / 100, 0)
	FROM LiquiContratPpacionPpante as lcpp
	INNER JOIN
	(
		SELECT compania_id, canal_id, jerarquiaDetalle_id, porcentaje
		FROM participacionDirector
		WHERE
		jerarquiaDetalle_id = @jerarquiaDetalle_id AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
	) as par ON lcpp.compania_id = par.compania_id
	WHERE lcpp.liqui_contrat_id = @idLiqui AND lcpp.jerarquiaDetalle_id = @jerarquiaDetalle_id AND par.canal_id = 0	
	
	-- Combinacion Compania Canal
	UPDATE LiquiContratPpacionPpante
	SET peso = COALESCE(par.porcentaje,0), basePpantePonderada = COALESCE((CAST(lcpp.basePpanteOriginal as float) * par.porcentaje) / 100, 0)
	FROM LiquiContratPpacionPpante as lcpp
	INNER JOIN
	(
		SELECT compania_id, canal_id, jerarquiaDetalle_id, porcentaje
		FROM participacionDirector
		WHERE
		jerarquiaDetalle_id = @jerarquiaDetalle_id AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) >= (CAST(YEAR(fechaIni) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaIni)) = 1 then '0' + CAST(MONTH(fechaIni) AS NVARCHAR) ELSE CAST(MONTH(fechaIni) AS NVARCHAR) END))
		AND
		(CAST(@anio AS NVARCHAR) + (CASE WHEN LEN(@mes) = 1 then '0' + CAST(@mes AS NVARCHAR) ELSE CAST(@mes AS NVARCHAR) END)) <= (CAST(YEAR(fechaFin) AS NVARCHAR) + (CASE WHEN LEN(MONTH(fechaFin)) = 1 then '0' + CAST(MONTH(fechaFin) AS NVARCHAR) ELSE CAST(MONTH(fechaFin) AS NVARCHAR) END))				
	) as par ON lcpp.compania_id = par.compania_id AND lcpp.canal_id = par.canal_id
	WHERE lcpp.liqui_contrat_id = @idLiqui AND lcpp.jerarquiaDetalle_id = @jerarquiaDetalle_id	
	
	-- EL DETALLE DE LA LIQUIDACION DE PARTICIPACIONES SE REPONDERA CON LOS PORCENTAJES DEFINIDOS POR DIRECTOR POR COMPAÑIA
	-- 2012-04-24
	UPDATE DetalleLiquiContratPpacionPpante
	SET porcentajeParticipacion = (porcentajeParticipacion * lcpp.peso) / 100, valorParticipacion = (valorParticipacion * lcpp.peso) / 100
	FROM DetalleLiquiContratPpacionPpante as dlcpp	
	INNER JOIN LiquiContratPpacionPpante as lcpp ON dlcpp.compania_id = lcpp.compania_id AND dlcpp.canal_id = lcpp.canal_id AND dlcpp.jerarquiaDetalle_id = lcpp.jerarquiaDetalle_id
	WHERE lcpp.liqui_contrat_id = @idLiqui AND lcpp.jerarquiaDetalle_id = @jerarquiaDetalle_id	
	

	-- ***************************************************************************************************
	-- SUMAMOS LA BASE DEL PARTICIPANTE PODERADA
	-- ***************************************************************************************************	
	DECLARE @BaseRecalculada float = (
							SELECT SUM(basePpantePonderada)
							FROM LiquiContratPpacionPpante
							WHERE liqui_contrat_id = @idLiqui AND jerarquiaDetalle_id = @jerarquiaDetalle_id)

	-- ***************************************************************************************************
	-- CALCULAMOS VALORES Y GUARDAMOS LA LIQUIDACION POR FACTOR
	-- ***************************************************************************************************	
	SET @ValorFVD = @BaseRecalculada * 0.25
	SET @ValorFVC = ((@BaseRecalculada * 0.75) * @factor) / 100

	-- ********************************************************
	-- ACTUALIZAMOS EL PAGO DE LA LIQUIDACION PARA DIRECTORES
	-- EL SALARIO BASE Y EL VALOR INCREMENTO YA NO SE ACTUALIZAN A 0 Y AHORA SE GUARDA EL VALOR DE PARTICIPACIONES
	-- Y EL TOTAL PAGO NO SE ACTUALIZA SI NO HASTA DESPUES DE REVISAR LOS PORCENTAJES QUE SE APLICAN
	-- PARA LAS PARTICIPACIONES Y EL SALARIO
	-- *********************************************************
	--ANTES DEL AJUSTE
	--UPDATE LiquiContratFactorParticipante
	--SET salarioBase = 0, valorIncremento = 0, salarioTotal = @BaseRecalculada, valorFVD = @ValorFVD, valorFVC = @ValorFVC, totalPago = (@ValorFVD + @ValorFVC)
	--WHERE liqui_contrat_id = @idLiqui AND jerarquiaDetalle_id = @jerarquiaDetalle_id

	UPDATE LiquiContratFactorParticipante
	SET salarioTotal = @BaseRecalculada, valorFVD = @ValorFVD, valorFVC = @ValorFVC, totalPago = 0
	WHERE liqui_contrat_id = @idLiqui AND jerarquiaDetalle_id = @jerarquiaDetalle_id
	
	--OBTENEMOS LOS PORCENTAJES GENERALES PARA SALARIO Y PARTICIPACIONES
	DECLARE @porcentajeSalario int = (SELECT valor FROM ParametrosApp WHERE parametro = 'Porcentaje General Salario')
	DECLARE @porcentajeParticipaciones int = (SELECT valor FROM ParametrosApp WHERE parametro = 'Porcentaje General Participaciones')
	
	--OBTENEMOS LOS PORCENTAJES ESPECIFICOS DEL DIRECTOR
	DECLARE @porcentajeSalarioDir int = (SELECT p.porcentajeSalario FROM Participante as p INNER JOIN JerarquiaDetalle as jd ON p.id = jd.participante_id WHERE jd.id = @jerarquiaDetalle_id)
	DECLARE @porcentajeParticipacionesDir int = (SELECT p.porcentajeParticipacion FROM Participante as p INNER JOIN JerarquiaDetalle as jd ON p.id = jd.participante_id WHERE jd.id = @jerarquiaDetalle_id)
	
	IF (@porcentajeSalarioDir <> 0 OR @porcentajeParticipacionesDir <> 0 )
	BEGIN
		SET @porcentajeSalario = 0
		SET @porcentajeParticipaciones = 0
	
		IF (@porcentajeSalarioDir <> 0)
		BEGIN
			SET @porcentajeSalario = @porcentajeSalarioDir
		END
		
		IF (@porcentajeParticipacionesDir <> 0)
		BEGIN
			SET @porcentajeParticipaciones = @porcentajeParticipacionesDir
		END	
	END
				
	--ACTUALIZAMOS EL TOTAL PAGADO DEPENDIENDO DE LOS PORCENTAJES DE PESO
	UPDATE LiquiContratFactorParticipante
	SET porcentajeSalario = @porcentajeSalario, porcentajeParticipaciones = @porcentajeParticipaciones, totalPago = ((salarioTotal * @porcentajeParticipaciones) / 100) + (((salarioBase * @porcentajeSalario) / 100) * @factor / 100)
	WHERE liqui_contrat_id = @idLiqui AND jerarquiaDetalle_id = @jerarquiaDetalle_id	
	
	RETURN 1
	
END