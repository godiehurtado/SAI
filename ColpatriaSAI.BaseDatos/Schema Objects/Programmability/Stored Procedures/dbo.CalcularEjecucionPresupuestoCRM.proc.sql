﻿-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcularEjecucionPresupuestoCRM]
	-- Add the parameters for the stored procedure here
	@presupuesto_id as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	-- CAMPO TIPO: DETERMINA SI LA EJECUCION ES.
	-- 1 METAS AUTOMATICAS
	-- 2 METAS POR EXCEPCIONES
	-- 3 METAS MANUALES
	-- 4 METAS ACUMULADAS
	
	SET NOCOUNT ON;
	
	DECLARE @periodo date, @mes int = 0
	DECLARE @meta_id int = 0, @valor int = 0, @jerarquiaDetalle_id int = 0, @metasSimples varchar(50) = ''
	DECLARE @Sentencia nvarchar(max), @param nvarchar(20)
	DECLARE @anio as int
	DECLARE @idPresupuesto as int
	DECLARE @idEjecucion as int

	SET @idPresupuesto = @presupuesto_id

	-- TOMAMOS EL ANIO DEL PRESUPUESTO
	SELECT @anio = (SELECT YEAR(fechaInicio) as anio FROM Presupuesto WHERE id = @idPresupuesto) 	

	-- CREAMOS REGISTRO DE EJECUCION -- ESTO SE HACE AHORA DESDE EL CARGUE DEL PRESUPUESTO
	-- INSERT INTO Ejecucion(fecha_calculo, presupuesto_id, anio) VALUES (getdate(), @idPresupuesto, @anio)
	SELECT @idEjecucion = (SELECT TOP 1 id FROM Ejecucion WHERE presupuesto_id = @idPresupuesto ORDER BY id DESC)

	-- BORRAMOS TABLAS NECESARIAS
	-- BORRAMOS SOLO LA EJECUCION DE METAS AUTOMATICAS, METAS POR EXCEPCIONES Y METAS ACUMULADAS
	DELETE FROM EjecucionDetalleCRM WHERE ejecucion_id = @idEjecucion
	
	-- INSERTAMOS LA EJECUCION DE LA METAS MANUALES
	INSERT INTO EjecucionDetalleCRM(ejecucion_id,meta_id,nodo_id,periodo,valor,tipo,canal_id,descripcion,fechaAjuste,usuario)
	SELECT
		ejecucion_id,
		meta_id,
		nodo_id,
		periodo,
		valor,
		tipo,
		canal_id,
		descripcion,
		fechaAjuste,
		usuario	
	FROM
		EjecucionDetalle
	WHERE 
		ejecucion_id = @idEjecucion	and tipo = 3		
	
	-- TRAEMOS EL CONSOLIDADO MES DEL AÑO DEL PRESUPUESTO
	-- DROP TABLE #ConsolidadoMesEjecucion
	CREATE TABLE #ConsolidadoMesEjecucion(
		compania_id int NOT NULL,
		ramo_id int NULL,
		producto_id int NULL,
		clave nvarchar(100) COLLATE Modern_Spanish_CI_AS NULL,
		lineaNegocio_id int NULL,
		amparo_id int NULL,
		modalidadPago_id int NULL,
		segmento_id int NULL,
		tipoMedida_id int NULL,
		Enero float NULL,
		Febrero float NULL,
		Marzo float NULL,
		Abril float NULL,
		Mayo float NULL,
		Junio float NULL,
		Julio float NULL,
		Agosto float NULL,
		Septiembre float NULL,
		Octubre float NULL,
		Noviembre float NULL,
		Diciembre float NULL,
		año int NULL
	)
	
    Create Index i1 ON #ConsolidadoMesEjecucion(compania_id)
	Create Index i2 ON #ConsolidadoMesEjecucion(ramo_id)
	Create Index i3 ON #ConsolidadoMesEjecucion(producto_id)
	Create Index i4 ON #ConsolidadoMesEjecucion(segmento_id)
	Create Index i5 ON #ConsolidadoMesEjecucion(tipoMedida_id)
	Create Index i6 ON #ConsolidadoMesEjecucion(clave)
	Create Index i7 ON #ConsolidadoMesEjecucion(lineaNegocio_id)
	Create Index i8 ON #ConsolidadoMesEjecucion(amparo_id)
	Create Index i9 ON #ConsolidadoMesEjecucion(modalidadPago_id)
	Create Index i10 ON #ConsolidadoMesEjecucion(año)	
	
	INSERT INTO #ConsolidadoMesEjecucion (compania_id, ramo_id, producto_id, clave, lineaNegocio_id, amparo_id, modalidadPago_id, segmento_id, tipoMedida_id, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre, año)
	SELECT      
		compania_id,
		ramo_id,
		producto_id,
		clave,
		lineaNegocio_id,
		amparo_id,
		modalidadPago_id,
		segmento_id,
		tipoMedida_id,
		Enero,
		Febrero,
		Marzo,
		Abril,
		Mayo,
		Junio,
		Julio,
		Agosto,
		Septiembre,
		Octubre,
		Noviembre,
		Diciembre,
		año
	FROM consolidadomes c
	WHERE c.año = @anio
	
	-- TRAEMOS EL DETALLE PRESUPUESTO CON SUS METAS AUTOMATICAS
	-- DROP TABLE #DetallePresupuesto
	CREATE TABLE #DetallePresupuesto(
		jerarquiaDetalle_id int NOT NULL,
		meta_id int NULL,
		tipoMedida_id int NULL		
	)
	
    Create Index i1 ON #DetallePresupuesto(jerarquiaDetalle_id)
	Create Index i2 ON #DetallePresupuesto(meta_id)
	Create Index i3 ON #DetallePresupuesto(tipoMedida_id)	
	
	INSERT INTO #DetallePresupuesto (jerarquiaDetalle_id, meta_id, tipoMedida_id)
	SELECT jerarquiaDetalle_id , detallepresupuesto.meta_id, m.tipoMedida_id
	FROM detallepresupuesto 
	INNER JOIN meta as m ON detallepresupuesto.meta_id = m.id
	WHERE presupuesto_id = @idPresupuesto AND m.automatica = 1
	GROUP BY jerarquiaDetalle_id, detallepresupuesto.meta_id, m.tipoMedida_id

	-- INSERTAMOS TODOS LOS NODOS QUE NO TIENE PRESUPUESTO PERO QUE ESTAN EN LA JERARQUIA Y PUEDEN LLEGAR A TENER EJECUCION
	INSERT INTO #DetallePresupuesto (jerarquiaDetalle_id, meta_id, tipoMedida_id)
	SELECT sub1.id, sub2.meta_id, sub2.tipoMedida_id
	FROM
	(
		SELECT id 
		FROM JerarquiaDetalle 
		WHERE id not in (SELECT DISTINCT jerarquiaDetalle_id FROM #DetallePresupuesto) and nivel_id <> 0
	) as sub1,
	(
		SELECT 
			meta_id, tipoMedida_id 
		FROM #DetallePresupuesto 
		GROUP BY meta_id, tipoMedida_id 
	) as sub2
	ORDER BY sub1.id, sub2.meta_id
	
	-- REMOVEMOS TODOS LOS NODOS QUE SEAN DE EXCEPCIONES
	DELETE FROM #DetallePresupuesto WHERE jerarquiaDetalle_id in (SELECT excepcionJerarquiaOrigen_id FROM excepcionJerarquiaDetalle GROUP BY excepcionJerarquiaOrigen_id)
	
	-- TRAEMOS LOS NODOS HIJOS DE LO DIRECTORES QUE ESTAN EN EL DETALLE DEL PRESUPUESTO
	-- DROP TABLE #NodosPresupuesto
	CREATE TABLE #NodosPresupuesto(
		jerarquiadetalle_id int NOT NULL,
		jerarquia_id int NOT NULL,
		canal_id int NULL,
		segmento_id int NULL,
		clave nvarchar(100) COLLATE Modern_Spanish_CI_AS NULL		
	)
	
    Create Index i0 ON #NodosPresupuesto(jerarquiadetalle_id)
    Create Index i1 ON #NodosPresupuesto(jerarquia_id)
	Create Index i2 ON #NodosPresupuesto(canal_id)
	Create Index i3 ON #NodosPresupuesto(segmento_id)	
	Create Index i4 ON #NodosPresupuesto(clave)		
	
	INSERT INTO #NodosPresupuesto(jerarquiadetalle_id,jerarquia_id,canal_id,segmento_id,clave)
	SELECT
		dp.jerarquiaDetalle_id,
		hijos.jerarquia_id,
		hijos.canal_id,
		j.segmento_id,		
		hijos.clave
	FROM
		#DetallePresupuesto as dp
		CROSS APPLY ObtenerHijosNodo(dp.jerarquiaDetalle_id) as hijos
		INNER JOIN jerarquia as j ON hijos.jerarquia_id = j.id		
	GROUP BY	
		dp.jerarquiaDetalle_id,
		hijos.jerarquia_id,
		hijos.canal_id,
		j.segmento_id,		
		hijos.clave		
	
	--GENERAMOS LA PARAMETRIZACION DE LAS METAS DEL DETALLE PRESUPUESTO QUE TENGAN COMBINACION EN PRODUCTOS META	
	--DROP TABLE #ProductoMeta
	CREATE TABLE #ProductoMeta(
		jerarquiaDetalle_id int NOT NULL,
		meta_id int NOT NULL,
		tipoMedida_id int NOT NULL,
		compania_id int NULL,
		ramo_id int NULL,
		producto_id int NULL,
		lineaNegocio_id int NULL,
		modalidadPago_id int NULL,
		amparo_id int NULL
	)
	
    Create Index i1 ON #ProductoMeta(jerarquiaDetalle_id)
	Create Index i2 ON #ProductoMeta(meta_id)
	Create Index i3 ON #ProductoMeta(tipoMedida_id)		
	Create Index i4 ON #ProductoMeta(compania_id)	
	Create Index i5 ON #ProductoMeta(ramo_id)	
	Create Index i6 ON #ProductoMeta(producto_id)	
	Create Index i7 ON #ProductoMeta(lineaNegocio_id)	
	Create Index i8 ON #ProductoMeta(modalidadPago_id)	
	Create Index i9 ON #ProductoMeta(amparo_id)	
	
	INSERT INTO #ProductoMeta
	SELECT dp.jerarquiaDetalle_id,dp.meta_id,dp.tipoMedida_id,pm.compania_id,pm.ramo_id,pm.producto_id,pm.lineaNegocio_id,pm.modalidadPago_id,pm.amparo_id
	FROM
		#DetallePresupuesto as dp
		INNER JOIN productosmeta as pm ON dp.meta_id = pm.meta_id	
	GROUP BY 
		dp.jerarquiaDetalle_id,dp.meta_id,dp.tipoMedida_id,pm.compania_id,pm.ramo_id,pm.producto_id,pm.lineaNegocio_id,pm.modalidadPago_id,pm.amparo_id		
			

	-- ********************************************************************************
	-- CALCULAMOS EJECUCION METAS AUTOMATICAS TENIENDO EN CUENTA TODAS LAS COMBINACIONES
	-- ********************************************************************************

	-- Producto Meta Combinacion 1
	-- Compañía
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,		
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.ramo_id = 0 and dpm.producto_id = 0 and dpm.lineaNegocio_id = 0 and dpm.modalidadPago_id = 0 and dpm.amparo_id = 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp

	-- Producto Meta Combinacion 2
	-- Compañía + Ramo
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,		
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.ramo_id = c.ramo_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.producto_id = 0 and dpm.lineaNegocio_id = 0 and dpm.modalidadPago_id = 0 and dpm.amparo_id = 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	
	
	-- Producto Meta Combinacion 3
	-- Compañía + Modalidad Pago
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.modalidadPago_id = c.modalidadPago_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.producto_id = 0 and dpm.lineaNegocio_id = 0 and dpm.ramo_id = 0 and dpm.amparo_id = 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp 	

	-- Producto Meta Combinacion 4
	-- Compañía + Amparo
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.amparo_id = c.amparo_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.producto_id = 0 and dpm.lineaNegocio_id = 0 and dpm.ramo_id = 0 and dpm.modalidadPago_id = 0 and c.amparo_id <> 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp

	-- Producto Meta Combinacion 5
	-- Compañía + Linea Negocio
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.lineaNegocio_id = c.lineaNegocio_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.ramo_id = 0 and dpm.producto_id = 0 and dpm.modalidadPago_id = 0 and dpm.amparo_id = 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp

	-- Producto Meta Combinacion 6
	-- Compañía + Linea Negocio + Modalidad Pago
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.lineaNegocio_id = c.lineaNegocio_id AND dpm.modalidadPago_id = c.modalidadPago_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.ramo_id = 0 and dpm.producto_id = 0 and dpm.amparo_id = 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	

	-- Producto Meta Combinacion 7
	-- Compañía + Linea Negocio + Amparo
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.lineaNegocio_id = c.lineaNegocio_id AND dpm.amparo_id = c.amparo_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.ramo_id = 0 and dpm.producto_id = 0 and dpm.modalidadPago_id = 0 and c.amparo_id <> 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	

	-- Producto Meta Combinacion 8
	-- Compañía + Ramo + Producto
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.ramo_id = c.ramo_id AND dpm.producto_id = c.producto_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.lineaNegocio_id = 0 and dpm.modalidadPago_id = 0 and dpm.amparo_id = 0 and c.producto_id <> 0 
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id
	
	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp				

	-- Producto Meta Combinacion 8.1
	-- Compañía + Ramo + Linea Negocio
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.ramo_id = c.ramo_id AND dpm.lineaNegocio_id = c.lineaNegocio_id AND  dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.producto_id = 0 and dpm.modalidadPago_id = 0 and dpm.amparo_id = 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id	

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp

	-- Producto Meta Combinacion 9
	-- Compañía + Ramo + Producto + Linea Negocio
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.ramo_id = c.ramo_id AND dpm.producto_id = c.producto_id AND dpm.lineaNegocio_id = c.lineaNegocio_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.modalidadPago_id = 0 and dpm.amparo_id = 0 and c.producto_id <> 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp

	-- Producto Meta Combinacion 9.1
	-- Compañía + Ramo + Producto + Amparo
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.ramo_id = c.ramo_id AND dpm.producto_id = c.producto_id AND dpm.amparo_id = c.amparo_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.modalidadPago_id = 0 and dpm.lineaNegocio_id = 0 and c.producto_id <> 0 and c.amparo_id <> 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	
	
	-- Producto Meta Combinacion 10
	-- Compañía + Ramo + Producto + Linea Negocio + Amparo Id
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.ramo_id = c.ramo_id AND dpm.producto_id = c.producto_id AND dpm.lineaNegocio_id = c.lineaNegocio_id AND dpm.amparo_id = c.amparo_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.modalidadPago_id = 0 and c.producto_id <> 0 and c.amparo_id <> 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id	

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp
	
	-- Producto Meta Combinacion 11
	-- Compañía + Ramo + Producto + Linea Negocio + Modalidad Pago
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.ramo_id = c.ramo_id AND dpm.producto_id = c.producto_id AND dpm.lineaNegocio_id = c.lineaNegocio_id AND dpm.modalidadPago_id = c.modalidadPago_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and dpm.amparo_id = 0 and c.producto_id <> 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id	

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	

    -- Producto Meta Combinacion 12
	-- Compañía + Ramo + Producto + Linea Negocio + Modalidad Pago + Amparo
	INSERT INTO EjecucionTemp
	SELECT
		dpm.jerarquiaDetalle_id, 
		dpm.meta_id,
		np.canal_id,
		Coalesce(sum(c.Enero), 0) as totalEnero, 
		Coalesce(sum(c.Febrero),0) as totalFebrero,
		Coalesce(sum(c.Marzo),0) as totalMarzo,
		Coalesce(sum(c.Abril),0) as totalAbril,
		Coalesce(sum(c.Mayo),0) as totalMayo,
		Coalesce(sum(c.Junio),0) as totalJunio,
		Coalesce(sum(c.Julio),0) as totalJulio,
		Coalesce(sum(c.Agosto),0) as totalAgosto,
		Coalesce(sum(c.Septiembre),0) as totalSeptiembre,
		Coalesce(sum(c.Octubre),0) as totalOctubre,
		Coalesce(sum(c.Noviembre),0) as totalNoviembre,
		Coalesce(sum(c.Diciembre),0) as totalDiciembre	   
	FROM 
		#ProductoMeta as dpm
		INNER JOIN #ConsolidadoMesEjecucion AS c ON dpm.compania_id = c.compania_id AND dpm.ramo_id = c.ramo_id AND dpm.producto_id = c.producto_id AND dpm.lineaNegocio_id = c.lineaNegocio_id AND dpm.modalidadPago_id = c.modalidadPago_id AND  dpm.amparo_id = c.amparo_id AND dpm.tipoMedida_id = c.tipoMedida_id
		INNER JOIN #NodosPresupuesto AS np ON dpm.jerarquiaDetalle_id = np.jerarquiaDetalle_id AND c.segmento_id = np.segmento_id
	WHERE c.clave = np.clave and c.producto_id <> 0 and c.amparo_id <> 0
	GROUP BY dpm.jerarquiaDetalle_id, np.canal_id,dpm.meta_id

	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, valor, tipo, canal_id)
	SELECT 
	@idEjecucion,
	meta_id,
	jerarquiaDetalle_id, 
	CASE mes
		WHEN 'enero' THEN CAST(@anio as varchar) + '-01-01' 
		WHEN 'febrero' THEN CAST(@anio as varchar) + '-02-01' 
		WHEN 'marzo' THEN CAST(@anio as varchar) + '-03-01' 
		WHEN 'abril' THEN CAST(@anio as varchar) + '-04-01' 
		WHEN 'mayo' THEN CAST(@anio as varchar) + '-05-01' 
		WHEN 'junio' THEN CAST(@anio as varchar) + '-06-01' 
		WHEN 'julio' THEN CAST(@anio as varchar) + '-07-01' 
		WHEN 'agosto' THEN CAST(@anio as varchar) + '-08-01' 
		WHEN 'septiembre' THEN CAST(@anio as varchar) + '-09-01' 
		WHEN 'octubre' THEN CAST(@anio as varchar) + '-10-01' 
		WHEN 'noviembre' THEN CAST(@anio as varchar) + '-11-01' 
		WHEN 'diciembre' THEN CAST(@anio as varchar) + '-12-01' 
	END,
	valor,
	1,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp

	-- *************************************************
	-- CALCULAMOS EJECUCION METAS AUTOMATICAS COMPUESTAS
	-- *************************************************	
	INSERT INTO EjecucionDetalleCRM(periodo, valor, meta_id, ejecucion_id, nodo_id, tipo, canal_id)
	SELECT
		CAST(@anio as varchar) + '-' + CAST(sub1.mes as varchar) + '-01' as periodo,
		sub1.valor,
		sub1.metaOrigen_id,
		@idEjecucion as ejeucion_id,
		sub1.nodo_id,
		1,
		sub1.canal_id
	FROM
	(	
		SELECT ed.nodo_id, mc.metaOrigen_id, MONTH(ed.periodo) as mes, sum(ed.valor) as valor, ed.canal_id
		FROM EjecucionDetalleCRM as ed
		INNER JOIN metaCompuesta as mc ON ed.meta_id = mc.metaDestino_Id		
		WHERE ed.ejecucion_id = @idEjecucion
		GROUP BY ed.nodo_id, mc.metaOrigen_id, YEAR(ed.periodo), MONTH(ed.periodo), ed.canal_id
	) as sub1
	
	-- *********************************************
	-- CALCULAMOS EJECUCION METAS POR EXCEPCIONES
	-- *********************************************	
	EXEC dbo.CalcularEjecucionPresupuestoExcepcionesCRM @idPresupuesto,@idEjecucion,@anio

	-- *********************************************
	-- CALCULAMOS EJECUCION METAS ACUMULADAS
	-- *********************************************	
	INSERT INTO EjecucionDetalleCRM(ejecucion_id, meta_id, nodo_id, periodo, canal_id, valor, tipo)
	SELECT 
		ed.ejecucion_id,m.id, ed.nodo_id, ed.periodo, ed.canal_id,
		(
			SELECT sum(valor) 
			FROM EjecucionDetalleCRM 
			WHERE periodo <= ed.periodo and meta_id = ed.meta_id and nodo_id = ed.nodo_id and canal_id = ed.canal_id and ejecucion_id = @idEjecucion	 
		) as acumuladoTotal,
		4 as tipo
	FROM EjecucionDetalleCRM as ed
	INNER JOIN meta as m ON ed.meta_id = m.meta_id
	WHERE m.meta_id is not null and ed.ejecucion_id = @idEjecucion	
	ORDER BY ed.meta_id, ed.nodo_id,ed.canal_id	

	DROP TABLE #ConsolidadoMesEjecucion
	DROP TABLE #DetallePresupuesto
	DROP TABLE #NodosPresupuesto
	DROP TABLE #ProductoMeta
		
	RETURN 1
	
END
