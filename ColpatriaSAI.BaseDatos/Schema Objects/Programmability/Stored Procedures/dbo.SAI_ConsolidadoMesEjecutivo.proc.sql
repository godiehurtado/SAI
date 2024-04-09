-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SAI_ConsolidadoMesEjecutivo] 
	-- Add the parameters for the stored procedure here
	@fechaIni date,
	@fechaFin date
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @id int , @contNivel int, @orden int

	-- OBTENEMOS EL AÑO ACTUAL DE EJECUCION DE LA TABLA DE PARAMETROS
	DECLARE @anio int = (SELECT valor FROM parametrosapp WHERE id = 3)
	
	-- ELIMINAMOS CONSOLIDADO MES PARA LOS MESES A PROCESAR
	DELETE FROM ConsolidadoMesEjecutivo
	WHERE anio = @anio

	-- ********************************************************************************************************************
	-- OBTENEMOS LOS NEGOCIOS AGRUPADOS POR COMPAÑIA, RAMO, PRODUCTO PARTICIPANTE, FECHA EXPEDICION PARA EL RANGO DE FECHAS
	-- ********************************************************************************************************************
	-- DROP TABLE #NegociosAgrupados
	CREATE TABLE #NegociosAgrupados(
		compania_id int NULL,
		ramoDetalle_id int NULL,
		productoDetalle_id int NULL,
		participante_id int NULL,
		fechaExpedicion datetime NULL,
		numeroNegocio varchar(250) NULL,
		valorPrimaTotal float NULL,
		ramo_id int NULL,
		producto_id int NULL,
		segmento_id int NULL,
		anioCierre int NULL,
		mesCierre int NULL,
		lineaNegocio_id int NULL,
		estadoNegocio nvarchar(200) NULL,
		grupoEndoso_id int NULL
	)
	
    Create Index i1 ON #NegociosAgrupados(compania_id)
    Create Index i2 ON #NegociosAgrupados(ramoDetalle_id)
	Create Index i3 ON #NegociosAgrupados(productoDetalle_id)
	Create Index i4 ON #NegociosAgrupados(anioCierre)
	Create Index i5 ON #NegociosAgrupados(mesCierre)
	Create Index i6 ON #NegociosAgrupados(participante_id)
	Create Index i7 ON #NegociosAgrupados(segmento_id)
	select COUNT(*) from Negocio where anioCierre = 2012 and segmento_id = 1 and productoDetalle_id = 1
	select COUNT(*) from #NegociosAgrupados where productoDetalle_id = 1
	INSERT INTO #NegociosAgrupados (compania_id, ramoDetalle_id, productoDetalle_id, participante_id, fechaExpedicion, segmento_id, anioCierre, mesCierre, lineaNegocio_id, estadoNegocio, grupoEndoso_id)
	SELECT
		n.compania_id
		,n.ramoDetalle_id
		,n.productoDetalle_id
		,n.participante_id
		,n.fechaExpedicion
		,n.segmento_id
		,n.anioCierre
		,n.mesCierre
		,n.lineaNegocio_id
		,n.estadoNegocio
		,n.grupoEndoso_id
	FROM Negocio as n
	WHERE anioCierre = @anio and n.segmento_id = 1
	AND NOT EXISTS (SELECT n1.id
					FROM Negocio n1
					INNER JOIN RamoDetalle rd ON rd.id = n1.ramoDetalle_id
					INNER JOIN ExcepcionesConsolidados ec ON ec.compania_id = n1.compania_id
						 AND ec.ramo_id = rd.ramo_id
						 AND ec.lineaNegocio_id = n1.lineaNegocio_id
					WHERE n1.segmento_id = 1 AND MONTH(n1.fechaEmisionMaximoEndoso) > n1.mesCierre
						AND YEAR(n1.fechaEmisionMaximoEndoso) >= @anio
						AND n1.anioCierre = @anio
						AND n1.id = n.id)
	GROUP BY
		n.compania_id
		,n.ramoDetalle_id
		,n.productoDetalle_id
		,n.participante_id
		,n.fechaExpedicion
		,n.segmento_id
		,n.anioCierre
		,n.mesCierre
		,n.lineaNegocio_id
		,n.estadoNegocio
		,n.grupoEndoso_id
	
	update #NegociosAgrupados SET ramo_id = (select RamoDetalle.ramo_id from RamoDetalle
	where #NegociosAgrupados.ramoDetalle_id = RamoDetalle.id)

	update #NegociosAgrupados SET producto_id = (select ProductoDetalle.producto_id from ProductoDetalle
	where #NegociosAgrupados.productoDetalle_id = ProductoDetalle.id)

	-- ********************************************************************************************************************
	-- FIN OBTENER NEGOCIOS AGRUPADOS POR COMPAÑIA, RAMO, PRODUCTO PARTICIPANTE, FECHA EXPEDICION PARA EL RANGO DE FECHAS
	-- ********************************************************************************************************************

	-- ********************************************************************************************************************
	-- OBTENEMOS LOS RECAUDOS AGRUPADOS POR COMPAÑIA, RAMO, PRODUCTO PARTICIPANTE, FECHA RECAUDO PARA EL RANGO DE FECHAS
	-- ********************************************************************************************************************
	-- DROP TABLE #RecaudosAgrupados
	CREATE TABLE #RecaudosAgrupados(
		compania_id int NULL,
		ramoDetalle_id int NULL,
		productoDetalle_id int NULL,
		participante_id int NULL,
		fechaRecaudo datetime NULL,
		valorRecaudo float NULL,
		ramo_id int NULL,
		producto_id int NULL,
		Colquines float NULL,
		segmento_id int NULL,
		anioCierre int NULL,
		mesCierre int NULL
	)
	
	Create Index i1 ON #RecaudosAgrupados(compania_id)
    Create Index i2 ON #RecaudosAgrupados(ramoDetalle_id)
	Create Index i3 ON #RecaudosAgrupados(productoDetalle_id)
	Create Index i4 ON #RecaudosAgrupados(anioCierre)
	Create Index i5 ON #RecaudosAgrupados(mesCierre)
	Create Index i6 ON #RecaudosAgrupados(participante_id)
	Create Index i7 ON #RecaudosAgrupados(segmento_id)
	
	INSERT INTO #RecaudosAgrupados (compania_id, ramoDetalle_id, productoDetalle_id, participante_id, fechaRecaudo, segmento_id, valorRecaudo, Colquines, anioCierre, mesCierre)
	SELECT
		compania_id
		,ramoDetalle_id
		,productoDetalle_id
		,participante_id
		,fechaRecaudo
		,segmento_id
		,SUM(valorRecaudo) as valorRecaudo
		,SUM(Colquines) as Colquines
		,anioCierre
		,mesCierre
	FROM Recaudo r
	WHERE anioCierre = @anio and r.segmento_id = 1
	GROUP BY
		compania_id
		,ramoDetalle_id
		,productoDetalle_id
		,participante_id
		,fechaRecaudo
		,segmento_id
		,anioCierre
		,mesCierre
  
	update #RecaudosAgrupados SET ramo_id = (select RamoDetalle.ramo_id from RamoDetalle
	where #RecaudosAgrupados.ramoDetalle_id = RamoDetalle.id)

	update #RecaudosAgrupados SET producto_id = (select ProductoDetalle.producto_id from ProductoDetalle
	where #RecaudosAgrupados.productoDetalle_id = ProductoDetalle.id)

	-- ********************************************************************************************************************
	-- FIN OBTENER RECAUDOS AGRUPADOS POR COMPAÑIA, RAMO, PRODUCTO PARTICIPANTE, FECHA RECAUDO PARA EL RANGO DE FECHAS
	-- ********************************************************************************************************************

	-- ********************************************************************************************************************
	-- OBTENEMOS NEGOCIOS AGRUPADOS POR COMPAÑIA, RAMO, PRODUCTO PARTICIPANTE, FECHA EXPEDICION SUMANDO SU PRIMA TOTAL PARA EL RANGO DE FECHAS
	-- ********************************************************************************************************************
	-- DROP TABLE #NegociosAgrupadosPrimas
	CREATE TABLE #NegociosAgrupadosPrimas(
		compania_id int NULL,
		ramoDetalle_id int NULL,
		productoDetalle_id int NULL,
		participante_id int NULL,
		fechaExpedicion datetime NULL,
		numeroNegocio varchar(250) NULL,
		valorPrimaTotal float NULL,
		ramo_id int NULL,
		producto_id int NULL,
		segmento_id int NULL,
		anioCierre int NULL,
		mesCierre int NULL,
		lineaNegocio_id int NULL,
		estadoNegocio nvarchar(200) NULL,
		grupoEndoso_id int NULL
	)
	
	Create Index i6 ON #NegociosAgrupadosPrimas(compania_id)
    Create Index i1 ON #NegociosAgrupadosPrimas(ramoDetalle_id)
	Create Index i2 ON #NegociosAgrupadosPrimas(productoDetalle_id)
	Create Index i3 ON #NegociosAgrupadosPrimas(anioCierre)
	Create Index i4 ON #NegociosAgrupadosPrimas(mesCierre)
	Create Index i5 ON #NegociosAgrupadosPrimas(participante_id)
	Create Index i7 ON #NegociosAgrupadosPrimas(segmento_id)
	Create Index i8 ON #NegociosAgrupadosPrimas(numeroNegocio)
	
	INSERT INTO #NegociosAgrupadosPrimas (compania_id, ramoDetalle_id, productoDetalle_id, participante_id, fechaExpedicion, numeroNegocio, segmento_id, valorPrimaTotal, anioCierre, mesCierre, lineaNegocio_id, estadoNegocio, grupoEndoso_id)
	SELECT
		n.compania_id
		,n.ramoDetalle_id
		,n.productoDetalle_id
		,n.participante_id
		,n.fechaExpedicion
		,n.numeroNegocio
		,n.segmento_id
		,SUM(n.valorPrimaTotal)
		,n.anioCierre
		,n.mesCierre
		,n.lineaNegocio_id
		,n.estadoNegocio
		,n.grupoEndoso_id
    FROM Negocio as n
	WHERE anioCierre = @anio and n.segmento_id = 1
	AND NOT EXISTS (SELECT n1.id
					FROM Negocio n1
					INNER JOIN RamoDetalle rd ON rd.id = n1.ramoDetalle_id
					INNER JOIN ExcepcionesConsolidados ec ON ec.compania_id = n1.compania_id
						 AND ec.ramo_id = rd.ramo_id
						 AND ec.lineaNegocio_id = n1.lineaNegocio_id
					WHERE n1.segmento_id = 1 AND MONTH(n1.fechaEmisionMaximoEndoso) > n1.mesCierre
						AND YEAR(n1.fechaEmisionMaximoEndoso) >= @anio
						AND n1.anioCierre = @anio
						AND n1.id = n.id)
	GROUP BY
		n.compania_id
		,n.ramoDetalle_id
		,n.productoDetalle_id
		,n.participante_id
		,n.fechaExpedicion
		,n.numeroNegocio
		,n.segmento_id
		,n.anioCierre
		,n.mesCierre
		,n.lineaNegocio_id
		,n.estadoNegocio
		,n.grupoEndoso_id
	
	update #NegociosAgrupadosPrimas SET ramo_id = (select RamoDetalle.ramo_id from RamoDetalle
	where #NegociosAgrupadosPrimas.ramoDetalle_id = RamoDetalle.id)

	update #NegociosAgrupadosPrimas SET producto_id = (select ProductoDetalle.producto_id from ProductoDetalle
	where #NegociosAgrupadosPrimas.productoDetalle_id = ProductoDetalle.id)
	
	-- ********************************************************************************************************************
	-- FIN OBTENER NEGOCIOS AGRUPADOS POR COMPAÑIA, RAMO, PRODUCTO PARTICIPANTE, FECHA EXPEDICION SUMANDO SU PRIMA TOTAL PARA EL RANGO DE FECHAS
	-- ********************************************************************************************************************
	DECLARE @Ejecutivos CURSOR SET @Ejecutivos = CURSOR /*SCROLL*/ FAST_FORWARD FOR
	
	-- Traemos toda la jerarquia detalle que sean ejecutivos
	SELECT jd.id, n.orden FROM jerarquiaDetalle as jd INNER JOIN nivel as n ON jd.nivel_id = n.id WHERE jd.nivel_id <> 1 AND jd.nivel_id <> 0
	
	-- RECORRIDO DE EJECUTIVOS
	OPEN @Ejecutivos FETCH NEXT FROM @Ejecutivos INTO @id, @orden
	WHILE @@FETCH_STATUS = 0 BEGIN
	    
	    INSERT INTO ConsolidadoMesEjecutivo(jerarquiaDetalle_id, compania_id, ramo_id, producto_id, mes, anio, nivel_id)
	    -- TRAEMOS COMPAÑIA, RAMO, PRODUCTO, MES AÑO TENIENDO EN CUENTA LOS NEGOCIOS DE SUS NODOS HIJOS DE NIVEL ASESOR 
		SELECT
			@id,
			n.compania_id,
			n.ramo_id,
			n.producto_id,
			MONTH(n.fechaExpedicion),
			YEAR(n.fechaExpedicion),
			1
		FROM #NegociosAgrupados as n
		CROSS APPLY ObtenerHijosNodo(@id) as hijos
		INNER JOIN jerarquia as j ON hijos.jerarquia_id = j.id AND n.segmento_id = j.segmento_id
		WHERE n.participante_id <> 0 AND n.participante_id = hijos.participante_id
		GROUP BY
			n.compania_id,
			n.ramo_id,
			n.producto_id,
			YEAR(n.fechaExpedicion),
			MONTH(n.fechaExpedicion)
		UNION
		-- TRAEMOS COMPAÑIA, RAMO, PRODUCTO, MES AÑO TENIENDO EN CUENTA LOS RECAUDOS DE SUS NODOS HIJOS DE NIVEL ASESOR 			
		SELECT
			@id,
			r.compania_id,
			r.ramo_id,
			r.producto_id,
			MONTH(r.fechaRecaudo),
			YEAR(r.fechaRecaudo),
			1
		FROM #RecaudosAgrupados as r
		CROSS APPLY ObtenerHijosNodo(@id) as hijos
		INNER JOIN jerarquia as j ON hijos.jerarquia_id = j.id AND r.segmento_id = j.segmento_id
		WHERE r.participante_id <> 0 AND r.participante_id = hijos.participante_id
		GROUP BY
			r.compania_id,
			r.ramo_id,
			r.producto_id,
			YEAR(r.fechaRecaudo),
			MONTH(r.fechaRecaudo)

		-- INSERTAMOS TANTOS REGISTROS COMO EL NIVEL DE LA JERARQUIA LO PERMITA
		-- INICIAMOS EN 2 POR QUE LOS DE NIVEL 1 YA FUERON INGRESADOS ANTERIORMENTE
		SET @contNivel = 2
		WHILE (@contNivel <= @orden) BEGIN
			
			-- TRAEMOS EL NIVEL ID DEL ORDEN QUE SE ESTA RECORRIENDO
			DECLARE @nivel_id int = (SELECT TOP 1 id FROM nivel WHERE orden = @contNivel)

			INSERT INTO ConsolidadoMesEjecutivo(jerarquiaDetalle_id, compania_id, ramo_id, producto_id, mes, anio, nivel_id)
			SELECT
				@id,
				cme.compania_id,
				cme.ramo_id,
				cme.producto_id,
				cme.mes,
				cme.anio,
				@nivel_id
			FROM ConsolidadoMesEjecutivo as cme
			WHERE cme.jerarquiaDetalle_id = @id AND cme.nivel_id = 1 AND cme.anio = @anio

			SET @contNivel = @contNivel + 1
		END
		
		FETCH NEXT FROM @Ejecutivos INTO @id, @orden
	END CLOSE @Ejecutivos DEALLOCATE @Ejecutivos

	-- **************************************************
	-- CREAMOS EL LISTADO AGRUPADO DE JERARQUIA Y NIVELES
	-- **************************************************
	--DROP TABLE #JerarquiaNiveles
	CREATE TABLE #JerarquiaNiveles(
		jerarquiaDetalle_id int NULL,
		nivel_id int NULL
	)
	
    Create Index i1 ON #JerarquiaNiveles(jerarquiaDetalle_id)
	Create Index i2 ON #JerarquiaNiveles(nivel_id)

	INSERT INTO #JerarquiaNiveles
	SELECT jerarquiaDetalle_id, nivel_id
	FROM ConsolidadoMesEjecutivo
	WHERE anio = @anio
	GROUP BY jerarquiaDetalle_id, nivel_id
	
	-- *************************************************************************************************
	-- OBTENEMOS EL LISTADO DE ASESORES POR CADA EJECUTIVO CON SU NIVEL AGRUPADO POR NEGOCIOS Y RECAUDOS
	-- *************************************************************************************************
	--DROP TABLE #HijosAsesoresNodoNivel
	CREATE TABLE #HijosAsesoresNodoNivel(
		jerarquiaDetalle_id_padre int NULL,
		clave varchar(30) NULL,
		canal_id int NULL,
	    id int NULL,
	    participante_id int NULL,
	    jerarquia_id int NULL,
	    nivel_id int NULL
	)
	
    Create Index i1 ON #HijosAsesoresNodoNivel(jerarquiaDetalle_id_padre)
	Create Index i2 ON #HijosAsesoresNodoNivel(clave)
	Create Index i3 ON #HijosAsesoresNodoNivel(canal_id)
	Create Index i4 ON #HijosAsesoresNodoNivel(id)
	Create Index i5 ON #HijosAsesoresNodoNivel(participante_id)
	Create Index i6 ON #HijosAsesoresNodoNivel(jerarquia_id)
	Create Index i7 ON #HijosAsesoresNodoNivel(nivel_id)
	
	INSERT INTO #HijosAsesoresNodoNivel
	SELECT
		jn.jerarquiaDetalle_id,
		hijos.clave,
		hijos.canal_id,
		hijos.id, 
		hijos.participante_id,
		hijos.jerarquia_id,
		jn.nivel_id
	FROM
	#JerarquiaNiveles as jn
	CROSS APPLY ObtenerHijosAsesoresNodoNivel(jn.jerarquiaDetalle_id,jn.nivel_id) as hijos

	-- ************************************************************
	-- CALCULO PERSONAS A CARGO
	-- ************************************************************

	TRUNCATE TABLE ConsolidadoMesEjecutivoTemp
	
	UPDATE ConsolidadoMesEjecutivo SET personasACargo = 0 
	WHERE anio = @anio

	UPDATE ConsolidadoMesEjecutivo
	SET personasACargo = pcn.cantidad
	FROM
	ConsolidadoMesEjecutivo as cme
	INNER JOIN PersonasACargoNivel as pcn ON cme.jerarquiaDetalle_id = pcn.jerarquiaDetalle_id AND 
	cme.mes = pcn.mes AND cme.anio = pcn.anio AND cme.nivel_id = pcn.nivel_id
	WHERE cme.anio = @anio

	-- ************************************************************
	-- CALCULO PERSONAS A CARGO VENDEN
	-- ************************************************************

	INSERT INTO ConsolidadoMesEjecutivoTemp(personasACargoVenden,jerarquiaDetalle_id,compania_id,ramo_id,producto_id,mes,anio,nivel_id)
	SELECT
		COUNT(sub1.participante_id) as personasACargoVenden,
		sub1.jerarquiaDetalle_id,
		sub1.compania_id,
		sub1.ramo_id,
		sub1.producto_id,
		sub1.mes,
		sub1.anio,
		sub1.nivel_id
	FROM
	(	
		SELECT
			hijos.participante_id,
			cme.jerarquiaDetalle_id,
			cme.compania_id,
			cme.ramo_id,
			cme.producto_id,
			cme.mes,
			cme.anio,
			cme.nivel_id
		FROM
		ConsolidadoMesEjecutivo as cme
		INNER JOIN #NegociosAgrupados as n ON cme.compania_id = n.compania_id AND cme.ramo_id = n.ramo_id AND cme.producto_id = n.producto_id AND n.mesCierre = cme.mes AND n.anioCierre = cme.anio
		INNER JOIN #HijosAsesoresNodoNivel as hijos ON n.participante_id = hijos.participante_id  AND hijos.jerarquiaDetalle_id_padre = cme.jerarquiaDetalle_id AND hijos.nivel_id = cme.nivel_id
		INNER JOIN jerarquia as j ON hijos.jerarquia_id = j.id AND n.segmento_id = j.segmento_id
		INNER JOIN GrupoEndoso ge ON n.grupoEndoso_id = ge.id
		WHERE cme.anio = @anio
			AND ((n.compania_id IN (1,2) AND ge.claseEndoso = 1) -- VIDA y GENERALES
				OR
				n.compania_id IN (3,4,5) -- CAPI, ARP y SALUD 
			)
			AND (n.estadoNegocio = 'V' AND n.lineaNegocio_id = 1) -- NUEVOS NEGOCIOS
		GROUP BY
			hijos.participante_id,
			cme.jerarquiaDetalle_id,
			cme.compania_id,
			cme.ramo_id,
			cme.producto_id,
			cme.mes,
			cme.anio,
			cme.nivel_id
	) as sub1
	GROUP BY
		sub1.jerarquiaDetalle_id,
		sub1.compania_id,
		sub1.ramo_id,
		sub1.producto_id,
		sub1.mes,
		sub1.anio,
		sub1.nivel_id
	order by sub1.mes, sub1.anio

	UPDATE ConsolidadoMesEjecutivo SET personasACargoVenden = 0 
	WHERE anio = @anio

	UPDATE ConsolidadoMesEjecutivo
	SET personasACargoVenden = cmet.personasACargoVenden
	FROM
	ConsolidadoMesEjecutivo as cme
	INNER JOIN ConsolidadoMesEjecutivoTemp as cmet ON cme.jerarquiaDetalle_id = cmet.jerarquiaDetalle_id AND
	cme.compania_id = cmet.compania_id AND cme.ramo_id = cmet.ramo_id AND cme.producto_id = cmet.producto_id AND cme.mes = cmet.mes AND cme.anio = cmet.anio AND cme.nivel_id = cmet.nivel_id
	WHERE cme.anio = @anio
	
	TRUNCATE TABLE ConsolidadoMesEjecutivoTemp
	
	-- ************************************************************
	-- CALCULO DE NUMERO DE NEGOCIOS
	-- ************************************************************

	INSERT INTO ConsolidadoMesEjecutivoTemp(numeroNegocios,jerarquiaDetalle_id,compania_id,ramo_id,producto_id,mes,anio,nivel_id)
	SELECT
		COUNT(sub1.totalNegocios) as numeroNegocios,
		sub1.jerarquiaDetalle_id,
		sub1.compania_id,
		sub1.ramo_id,
		sub1.producto_id,
		sub1.mes,
		sub1.anio,
		sub1.nivel_id
	FROM
	(	
		SELECT
			COUNT(DISTINCT n.numeroNegocio) as totalNegocios,
			cme.jerarquiaDetalle_id,
			cme.compania_id,
			cme.ramo_id,
			cme.producto_id,
			cme.mes,
			cme.anio,
			cme.nivel_id
		FROM
		ConsolidadoMesEjecutivo as cme
		INNER JOIN #NegociosAgrupadosPrimas as n ON cme.compania_id = n.compania_id AND cme.ramo_id = n.ramo_id AND cme.producto_id = n.producto_id AND n.mesCierre = cme.mes AND n.anioCierre = cme.anio
		INNER JOIN #HijosAsesoresNodoNivel as hijos ON n.participante_id = hijos.participante_id  AND hijos.jerarquiaDetalle_id_padre = cme.jerarquiaDetalle_id AND hijos.nivel_id = cme.nivel_id
		INNER JOIN jerarquia as j ON hijos.jerarquia_id = j.id AND n.segmento_id = j.segmento_id
		INNER JOIN GrupoEndoso ge ON n.grupoEndoso_id = ge.id
		WHERE cme.anio = @anio
			AND ((n.compania_id IN (1,2) AND ge.claseEndoso = 1) -- VIDA y GENERALES
				OR
				n.compania_id IN (3,4,5) -- CAPI, ARP y SALUD 
			)
			AND (n.estadoNegocio = 'V' AND n.lineaNegocio_id = 1) -- NUEVOS NEGOCIOS
		GROUP BY
			cme.jerarquiaDetalle_id,
			cme.compania_id,
			cme.ramo_id,
			cme.producto_id,
			cme.mes,
			cme.anio,
			cme.nivel_id,
			n.numeroNegocio
	) as sub1
	GROUP BY
		sub1.jerarquiaDetalle_id,
		sub1.compania_id,
		sub1.ramo_id,
		sub1.producto_id,
		sub1.mes,
		sub1.anio,
		sub1.nivel_id
	order by sub1.mes, sub1.anio

	UPDATE ConsolidadoMesEjecutivo SET numeroNegocios = 0
	WHERE anio = @anio

	UPDATE ConsolidadoMesEjecutivo
	SET numeroNegocios = cmet.numeroNegocios
	FROM
	ConsolidadoMesEjecutivo as cme
	INNER JOIN ConsolidadoMesEjecutivoTemp as cmet ON cme.jerarquiaDetalle_id = cmet.jerarquiaDetalle_id AND 
	cme.compania_id = cmet.compania_id AND cme.ramo_id = cmet.ramo_id AND cme.producto_id = cmet.producto_id AND cme.mes = cmet.mes AND cme.anio = cmet.anio AND cme.nivel_id = cmet.nivel_id
	WHERE cme.anio = @anio

	TRUNCATE TABLE ConsolidadoMesEjecutivoTemp
	
	-- ************************************************************
	-- CALCULO DE TOTAL PRIMAS, PROMEDIO PRIMAS
	-- ************************************************************
	
	-- GENERAMOS UNA TABLA TEMPORAL AGRUPANDO LAS PRIMAS SIN TENER EN CUENTA LOS NUMERO DE NEGOCIO
	-- DROP TABLE #NegociosAgrupadosPrimasSinNN
	CREATE TABLE #NegociosAgrupadosPrimasSinNN(
		compania_id int NULL,
		ramo_id int NULL,
		producto_id int NULL,
		segmento_id int NULL,
		participante_id int NULL,
		valorPrimaTotal float NULL,
		anioCierre int NULL,
		mesCierre int NULL
	)
	
	Create Index i1 ON #NegociosAgrupadosPrimasSinNN(compania_id)
	Create Index i2 ON #NegociosAgrupadosPrimasSinNN(ramo_id)
	Create Index i3 ON #NegociosAgrupadosPrimasSinNN(producto_id)
	Create Index i4 ON #NegociosAgrupadosPrimasSinNN(anioCierre)
	Create Index i5 ON #NegociosAgrupadosPrimasSinNN(mesCierre)
	Create Index i6 ON #NegociosAgrupadosPrimasSinNN(participante_id)
	Create Index i7 ON #NegociosAgrupadosPrimasSinNN(segmento_id)

	INSERT INTO #NegociosAgrupadosPrimasSinNN
	SELECT
		compania_id,
		ramo_id,
		producto_id,
		segmento_id,
		participante_id,
		sum(valorPrimaTotal) as valorPrimaTotal,
		anioCierre,
		mesCierre
	FROM #NegociosAgrupadosPrimas
	GROUP BY 
		compania_id,
		ramo_id,
		producto_id,
		segmento_id,
		participante_id,
		anioCierre,
		mesCierre
	
	INSERT INTO ConsolidadoMesEjecutivoTemp(primaTotal,promedioPrimas,jerarquiaDetalle_id,compania_id,ramo_id,producto_id,mes,anio,nivel_id)
	SELECT
		sum(n.valorPrimaTotal) as valorPrimaTotal,
		avg(n.valorPrimaTotal) as promedioPrimaTotal,
		cme.jerarquiaDetalle_id,
		cme.compania_id,
		cme.ramo_id,
		cme.producto_id,
		cme.mes,
		cme.anio,
		cme.nivel_id
	FROM
	ConsolidadoMesEjecutivo as cme
	INNER JOIN #NegociosAgrupadosPrimasSinNN as n ON cme.compania_id = n.compania_id AND cme.ramo_id = n.ramo_id AND cme.producto_id = n.producto_id AND n.mesCierre = cme.mes AND n.anioCierre = cme.anio
	INNER JOIN #HijosAsesoresNodoNivel as hijos ON n.participante_id = hijos.participante_id AND hijos.jerarquiaDetalle_id_padre = cme.jerarquiaDetalle_id AND hijos.nivel_id = cme.nivel_id
	INNER JOIN jerarquia as j ON hijos.jerarquia_id = j.id AND n.segmento_id = j.segmento_id
	WHERE cme.anio = @anio
	GROUP BY
		cme.jerarquiaDetalle_id,
		cme.compania_id,
		cme.ramo_id,
		cme.producto_id,
		cme.mes,
		cme.anio,
		cme.nivel_id

	
	UPDATE ConsolidadoMesEjecutivo SET primaTotal = 0, promedioPrimas = 0
	WHERE anio = @anio

	
	UPDATE ConsolidadoMesEjecutivo
	SET primaTotal = cmet.primaTotal , promedioPrimas = cmet.promedioPrimas
	FROM
	ConsolidadoMesEjecutivo as cme
	INNER JOIN ConsolidadoMesEjecutivoTemp as cmet ON cme.jerarquiaDetalle_id = cmet.jerarquiaDetalle_id AND 
	cme.compania_id = cmet.compania_id AND cme.ramo_id = cmet.ramo_id AND cme.producto_id = cmet.producto_id AND cme.mes = cmet.mes AND cme.anio = cmet.anio AND cme.nivel_id = cmet.nivel_id
	WHERE cme.anio = @anio
	
	
	
	TRUNCATE TABLE ConsolidadoMesEjecutivoTemp
	
	-- ********************************************
	-- CALCULO DE TOTAL COLQUINES Y TOTAL RECAUDOS
	-- ********************************************

	INSERT INTO ConsolidadoMesEjecutivoTemp(totalRecaudos,totalColquines,jerarquiaDetalle_id,compania_id,ramo_id,producto_id,mes,anio,nivel_id)
	SELECT
		SUM(r.valorRecaudo) as valorRecaudo,
		SUM(r.Colquines) as Colquines,
		cme.jerarquiaDetalle_id,
		cme.compania_id,
		cme.ramo_id,
		cme.producto_id,
		cme.mes,
		cme.anio,
		cme.nivel_id
	FROM
	ConsolidadoMesEjecutivo as cme
	INNER JOIN #RecaudosAgrupados as r ON cme.compania_id = r.compania_id AND cme.ramo_id = r.ramo_id AND cme.producto_id = r.producto_id AND cme.mes = r.mesCierre AND cme.anio = r.anioCierre
	INNER JOIN #HijosAsesoresNodoNivel as hijos ON r.participante_id = hijos.participante_id AND hijos.jerarquiaDetalle_id_padre = cme.jerarquiaDetalle_id AND hijos.nivel_id = cme.nivel_id
	INNER JOIN jerarquia as j ON hijos.jerarquia_id = j.id AND r.segmento_id = j.segmento_id
	WHERE cme.anio = @anio
	GROUP BY
		cme.jerarquiaDetalle_id,
		cme.compania_id,
		cme.ramo_id,
		cme.producto_id,
		cme.mes,
		cme.anio,
		cme.nivel_id
    ORDER BY
		cme.compania_id,
		cme.ramo_id,
		cme.producto_id,
		cme.mes, cme.anio
	
	
	UPDATE ConsolidadoMesEjecutivo SET totalColquines = 0, totalRecaudos = 0
	WHERE anio = @anio

	UPDATE ConsolidadoMesEjecutivo
	SET totalColquines = cmet.totalColquines, totalRecaudos = cmet.totalRecaudos
	FROM
	ConsolidadoMesEjecutivo as cme
	INNER JOIN ConsolidadoMesEjecutivoTemp as cmet ON cme.jerarquiaDetalle_id = cmet.jerarquiaDetalle_id AND 
	cme.compania_id = cmet.compania_id AND cme.ramo_id = cmet.ramo_id AND cme.producto_id = cmet.producto_id AND cme.mes = cmet.mes AND cme.anio = cmet.anio AND cme.nivel_id = cmet.nivel_id
	WHERE cme.anio = @anio
	
	TRUNCATE TABLE ConsolidadoMesEjecutivoTemp
	
	-- ********************************************
	-- CALCULO DE PROMEDIO DE NEGOCIOS
	-- ********************************************
	UPDATE ConsolidadoMesEjecutivo
	SET promedioNegocios = ROUND(CAST(numeroNegocios as float) / CAST(personasACargo as float), 2)
	WHERE personasACargo <> 0 AND anio = @anio
	
	UPDATE ConsolidadoMesEjecutivo
	SET promedioNegocios = 0 
	WHERE personasACargo = 0 AND anio = @anio
	
	-- ***************************************************
	-- ACTUALIZAMOS CODIGO NIVEL Y CATEGORIA DEL EJECUTIVO
	-- ***************************************************
	
	UPDATE ConsolidadoMesEjecutivo
	SET codigoNivel = jd.codigoNivel, categoria_id = p.categoria_id, canal_id = jd.canal_id 
	FROM ConsolidadoMesEjecutivo cme
	INNER JOIN JerarquiaDetalle jd ON jd.id = cme.jerarquiaDetalle_id
	INNER JOIN Participante p ON jd.participante_id = p.id
	WHERE anio = @anio

	-- ***************************************************
	-- ACTUALIZAMOS EL PLAZO
	-- ***************************************************
	
	UPDATE ConsolidadoMesEjecutivo
	SET plazo_id = p.plazo_id
	FROM ConsolidadoMesEjecutivo cme
	INNER JOIN Producto p ON cme.producto_id = p.id
	WHERE anio = @anio		

	-- ***************************************************
	-- PRECALCULO PERSITENCIA CAPI ACUMULADA
	-- ***************************************************
	UPDATE ConsolidadoMesEjecutivo SET ColquinesDescontarPC = 0, RecaudosDescontarPC = 0 
	WHERE anio = @anio
		
	UPDATE ConsolidadoMesEjecutivo
	SET ColquinesDescontarPC = pca.colquinesDescontar, RecaudosDescontarPC = pca.recaudosDescontar
	FROM ConsolidadoMesEjecutivo cme
	INNER JOIN PersistenciadeCAPIAcumulada pca ON cme.anio = pca.anioCierreNegocio and cme.mes = pca.ultimoPeriodo and cme.plazo_id = pca.plazo_id and cme.jerarquiaDetalle_id = pca.jerarquiaDetalle_id and cme.ramo_id = pca.ramo_id
	WHERE cme.anio = @anio and cme.compania_id = 3 and cme.ramo_id = 17

	-- ***************************************************
	-- PRECALCULO PERSITENCIA VIDA ACUMULADA
	-- ***************************************************
	UPDATE ConsolidadoMesEjecutivo SET ColquinesDescontarPV = 0, RecaudosDescontarPV = 0 
	WHERE anio = @anio
		
	UPDATE ConsolidadoMesEjecutivo
	SET ColquinesDescontarPV = pv.colquinesDescontar, RecaudosDescontarPV = pv.recaudosDescontar
	FROM ConsolidadoMesEjecutivo cme
	INNER JOIN PersistenciadeVida pv ON cme.anio = pv.añoAMedir and cme.mes = pv.mesCorte and cme.jerarquiaDetalle_id = pv.jerarquiaDetalle_id and cme.ramo_id = pv.ramo_id
	WHERE cme.anio = @anio and cme.compania_id = 2 and cme.ramo_id = 11

	-- ***************************************************
	-- PRECALCULO SINIESTRALIDAD ACUMULADA
	-- ***************************************************
	UPDATE ConsolidadoMesEjecutivo SET ColquinesDescontarS = 0, RecaudosDescontarS = 0 
	WHERE anio = @anio
		
	UPDATE ConsolidadoMesEjecutivo
	SET ColquinesDescontarS = s.colquinesDescontar, RecaudosDescontarS = s.recaudosDescontar
	FROM ConsolidadoMesEjecutivo cme
	INNER JOIN RamoDetalle rd ON cme.ramo_id = rd.ramo_id
	INNER JOIN SiniestralidadAcumulada s ON cme.anio = s.anio and cme.mes = s.ultimoMes and cme.jerarquiaDetalle_id = s.jerarquiaDetalle_id AND rd.id = s.ramoDetalle_id
	WHERE cme.anio = @anio and cme.compania_id = 1 and cme.ramo_id = 8
	
	DROP TABLE #NegociosAgrupados
	DROP TABLE #RecaudosAgrupados
	DROP TABLE #NegociosAgrupadosPrimas
	DROP TABLE #JerarquiaNiveles
	DROP TABLE #HijosAsesoresNodoNivel
	DROP TABLE #NegociosAgrupadosPrimasSinNN

END
