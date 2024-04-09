-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CalcularEjecucionPresupuestoExcepcionesCRM]
	-- Add the parameters for the stored procedure here
	@presupuesto_id as int,
	@ejecucion_id as int,
	@anioParam as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @periodo date, @mes int = 0
	DECLARE @meta_id int = 0, @valor int = 0, @jerarquiaDetalle_id int = 0, @metasSimples varchar(max) = ''
	DECLARE @Sentencia nvarchar(max) = '', @param nvarchar(20) = ''
	DECLARE @anio as int
	DECLARE @idPresupuesto as int
	DECLARE @idEjecucion as int

	SET @idPresupuesto = @presupuesto_id
	SET @idEjecucion = @ejecucion_id
	SET @anio = @anioParam

	-- TRAEMOS EL CONSOLIDADO MES DEL AÑO DEL PRESUPUESTO
	-- DROP TABLE #ConsolidadoMesTemp
	CREATE TABLE #ConsolidadoMesTemp(
		id int NULL,
		compania_id int NULL,
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
	
    Create Index i1 ON #ConsolidadoMesTemp(compania_id)
	Create Index i2 ON #ConsolidadoMesTemp(ramo_id)
	Create Index i3 ON #ConsolidadoMesTemp(producto_id)
	Create Index i4 ON #ConsolidadoMesTemp(segmento_id)
	Create Index i5 ON #ConsolidadoMesTemp(tipoMedida_id)
	Create Index i6 ON #ConsolidadoMesTemp(clave)
	Create Index i7 ON #ConsolidadoMesTemp(lineaNegocio_id)
	Create Index i8 ON #ConsolidadoMesTemp(amparo_id)
	Create Index i9 ON #ConsolidadoMesTemp(modalidadPago_id)
	Create Index i10 ON #ConsolidadoMesTemp(año)	
	
	INSERT INTO #ConsolidadoMesTemp (id, compania_id, ramo_id, producto_id, clave, lineaNegocio_id, amparo_id, modalidadPago_id, segmento_id, tipoMedida_id, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre, año)
	SELECT
		id,      
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

	-- TRAEMOS EL LAS METAS DE LAS EXCEPCIONES DEL DETALLE PRESUPUESTO
	-- DROP TABLE #DetallePresupuesto
	CREATE TABLE #DetallePresupuesto(
		jerarquiaDetalle_id int NOT NULL,
		meta_id int NULL,
		tipoMedida_id int NULL		
	)
	
    Create Index i1 ON #DetallePresupuesto(jerarquiaDetalle_id)
	Create Index i2 ON #DetallePresupuesto(meta_id)
	Create Index i3 ON #DetallePresupuesto(tipoMedida_id)	

	INSERT INTO #DetallePresupuesto(jerarquiaDetalle_id, meta_id, tipoMedida_id)
	SELECT
	dp.excepcionJerarquiaOrigen_id,
	dp.meta_id,
	m.tipoMedida_id
	FROM
		(
			SELECT excepcionJerarquiaOrigen_id, meta_id 
			FROM excepcionJerarquiaDetalle
			GROUP BY excepcionJerarquiaOrigen_id, meta_id 
		)as dp
		INNER JOIN (
			SELECT dp1.meta_id, m1.tipoMedida_id, m1.automatica
			FROM DetallePresupuesto as dp1
			INNER JOIN Meta as m1 ON dp1.meta_id = m1.id
			WHERE presupuesto_id = @idPresupuesto
			GROUP BY dp1.meta_id, m1.tipoMedida_id, m1.automatica
		) as m ON dp.meta_id = m.meta_id
	WHERE m.automatica = 1
	GROUP BY
	dp.excepcionJerarquiaOrigen_id,
	dp.meta_id,
	m.tipoMedida_id		

	DELETE FROM ConsolidadoMesTemp
	INSERT INTO ConsolidadoMesTemp
	-- Agrupamos y sumamos todos los meses por jerarquia e insertamos en la tabla temporal de consolidado mes
	SELECT 
		sub3.jerarquiaDetalle_id,
		sub3.clave,
		sub3.compania_id,
		sub3.ramo_id,
		sub3.producto_id,
		sub3.tipoMedida_id, 		
		sub3.canal_id, 
		sub3.lineaNegocio_id,
		sub3.modalidadPago_id,
		sub3.amparo_id,
		Coalesce(sum(sub3.Enero), 0) as Enero, 
		Coalesce(sum(sub3.Febrero),0) as Febrero,
		Coalesce(sum(sub3.Marzo),0) as Marzo,
		Coalesce(sum(sub3.Abril),0) as Abril,
		Coalesce(sum(sub3.Mayo),0) as Mayo,
		Coalesce(sum(sub3.Junio),0) as Junio,
		Coalesce(sum(sub3.Julio),0) as Julio,
		Coalesce(sum(sub3.Agosto),0) as Agosto,
		Coalesce(sum(sub3.Septiembre),0) as Septiembre,
		Coalesce(sum(sub3.Octubre),0) as Octubre,
		Coalesce(sum(sub3.Noviembre),0) as Noviembre,
		Coalesce(sum(sub3.Diciembre),0) as Diciembre
	FROM
	(
		-- Obtenemos toda la produccion para los nodos de la jerarquia de la excepcion
		SELECT
			distinct
			c.id,
			dp.jerarquiaDetalle_id,
			hijos.canal_id,
			c.clave,
			c.compania_id,
			c.ramo_id,
			c.producto_id,
			c.tipoMedida_id, 
			c.lineaNegocio_id,		
			c.modalidadPago_id,		
			c.amparo_id,		
			c.Enero, 
			c.Febrero,
			c.Marzo,
			c.Abril,
			c.Mayo,
			c.Junio,
			c.Julio,
			c.Agosto,
			c.Septiembre,
			c.Octubre,
			c.Noviembre,
			c.Diciembre
		FROM 
			(
				-- Obtenemos la jerarquia detalle del presupuesto que tengan excepciones
				SELECT sub1.jerarquiaDetalle_id, sub2.excepcionJerarquiaDestino_id
				FROM
				(
					SELECT jerarquiaDetalle_id 
					FROM detallepresupuesto 
					WHERE presupuesto_id = @idPresupuesto 
					GROUP BY jerarquiaDetalle_id
				) as sub1
				INNER JOIN
				(
					SELECT excepcionJerarquiaOrigen_id, excepcionJerarquiaDestino_id
					FROM excepcionJerarquiaDetalle
					GROUP BY excepcionJerarquiaOrigen_id,excepcionJerarquiaDestino_id
				) as sub2 ON sub1.jerarquiaDetalle_id = sub2.excepcionJerarquiaOrigen_id 
			)as dp
			INNER JOIN #ConsolidadoMesTemp AS c ON c.compania_id = c.compania_id
			CROSS APPLY ObtenerHijosNodo(dp.excepcionJerarquiaDestino_id) as hijos
			INNER JOIN jerarquia as j ON hijos.jerarquia_id = j.id AND c.segmento_id = j.segmento_id
		WHERE c.clave = hijos.clave		
	) as sub3
	GROUP BY sub3.jerarquiaDetalle_id,
		sub3.clave,
		sub3.compania_id,
		sub3.ramo_id,
		sub3.producto_id,
		sub3.tipoMedida_id,
		sub3.canal_id,
		sub3.lineaNegocio_id,
		sub3.modalidadPago_id,
		sub3.amparo_id
	
	-- Sumamos todas los meses de ConsolidadoMesTemp agrupados por jerarquia y meta teniendo en cuentan 
	-- que los parametros de excepcionesjerarquia(compania, ramo, producto) sean iguales a los parametros de
	-- productometa y consolidado mes temp. Si hay match entre estas tablas se calcularan metas de excepciones.
	-- Ademas se debe tener en cuenta todas las combinaciones para la excepcion de jerarquia	

	-- 05/07/2012
	-- Se cambia el modulo de las excepciones de la jerarquia y se elimina la parametrizacion de compañia, ramo y producto
	-- y se incluye ahora solo la meta la cual se va a medir. Por esta razon la tabla temporal tiene en cuenta
	-- la parametrizacion de las metas a evaluar por cada nodo.

	-- CREAMOS TABLA TEMPORAL PARA OPTIMIZAR EL PROCESO DE CALCULO DE EJECUCION POR EXCEPCIONES
	-- DROP TABLE #ParametrizacionTemp
	CREATE TABLE #ParametrizacionTemp(
		jerarquiaDetalle_id int NOT NULL,
		meta_id int NULL,		
		tipoMedida_id int NULL,		
		compania_id int NULL,
		ramo_id int NULL,
		producto_id int NULL,
		lineaNegocio_id int NULL,
		modalidadPago_id int NULL,
		amparo_id int NULL		
	)
	
    Create Index i1 ON #ParametrizacionTemp(jerarquiaDetalle_id)
	Create Index i2 ON #ParametrizacionTemp(meta_id)
	Create Index i3 ON #ParametrizacionTemp(tipoMedida_id)		
	Create Index i5 ON #ParametrizacionTemp(lineaNegocio_id)	
	Create Index i4 ON #ParametrizacionTemp(compania_id)	
	Create Index i6 ON #ParametrizacionTemp(ramo_id)	
	Create Index i7 ON #ParametrizacionTemp(producto_id)	
	Create Index i8 ON #ParametrizacionTemp(modalidadPago_id)	
	Create Index i9 ON #ParametrizacionTemp(amparo_id)	

	INSERT INTO #ParametrizacionTemp
	SELECT
		dp.jerarquiaDetalle_id, 
		dp.meta_id,		
		dp.tipoMedida_id,
		pm.compania_id,
		pm.ramo_id,
		pm.producto_id,		
		pm.lineaNegocio_id,
		pm.modalidadPago_id,
		pm.amparo_id
	FROM
		productosmeta as pm 
		INNER JOIN #DetallePresupuesto as dp ON pm.meta_id = dp.meta_id
	/*
	No parece ser necesario por que en #DetallePresupuesto la meta solo viene una vez por jerarquia
	GROUP BY
		dp.jerarquiaDetalle_id, 
		dp.meta_id,	
		dp.tipoMedida_id,
		pm.compania_id,
		pm.ramo_id,
		pm.producto_id,		
		pm.lineaNegocio_id,
		pm.modalidadPago_id,
		pm.amparo_id*/

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía		
	INSERT INTO EjecucionTemp
	SELECT 
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id					
	where sub1.producto_id = 0 and sub1.lineaNegocio_id = 0 and sub1.modalidadPago_id = 0 and sub1.amparo_id = 0 and sub1.ramo_id = 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id				
		
	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	
	
	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía	+ Ramo
	INSERT INTO EjecucionTemp
	SELECT 
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.ramo_id = c.ramo_id				
	WHERE sub1.producto_id = 0 and sub1.lineaNegocio_id = 0 and sub1.modalidadPago_id = 0 and sub1.amparo_id = 0		
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id				
	
	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp		
	
	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Modalidad Pago
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id  AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.modalidadPago_id = c.modalidadPago_id
	WHERE sub1.producto_id = 0 and sub1.lineaNegocio_id = 0 and sub1.ramo_id = 0 and sub1.amparo_id = 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id 
	
	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp
	
	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Amparo	
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.amparo_id = c.amparo_id 
	WHERE sub1.producto_id = 0 and sub1.lineaNegocio_id = 0 and sub1.ramo_id = 0 and sub1.modalidadPago_id = 0 and c.amparo_id <> 0	 	
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id	

	
	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	--  Compañía + Linea Negocio	
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.lineaNegocio_id = c.lineaNegocio_id
	WHERE sub1.ramo_id = 0 and sub1.producto_id = 0 and sub1.modalidadPago_id = 0 and sub1.amparo_id = 0	
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id	
	
	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Linea Negocio + Modalidad Pago	
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.lineaNegocio_id = c.lineaNegocio_id AND sub1.modalidadPago_id = c.modalidadPago_id
	WHERE sub1.ramo_id = 0 and sub1.producto_id = 0 and sub1.amparo_id = 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id
	
	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	
	
    -- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Linea Negocio + Amparo
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.lineaNegocio_id = c.lineaNegocio_id AND sub1.amparo_id = c.amparo_id
	WHERE sub1.ramo_id = 0 and sub1.producto_id = 0 and sub1.modalidadPago_id = 0 and c.amparo_id <> 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id
	
	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id	
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Ramo + Producto
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.ramo_id = c.ramo_id AND sub1.producto_id = c.producto_id
	WHERE sub1.lineaNegocio_id = 0 and sub1.modalidadPago_id = 0 and sub1.amparo_id = 0 and c.producto_id <> 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id

	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Ramo + Linea Negocio
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.ramo_id = c.ramo_id AND sub1.lineaNegocio_id = c.lineaNegocio_id
	WHERE sub1.producto_id = 0 and sub1.modalidadPago_id = 0 and sub1.amparo_id = 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id
	
	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp		

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Ramo + Producto + Linea Negocio
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.ramo_id = c.ramo_id AND sub1.producto_id = c.producto_id AND sub1.lineaNegocio_id = c.lineaNegocio_id
	WHERE sub1.modalidadPago_id = 0 and sub1.amparo_id = 0 and c.producto_id <> 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id

	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp	
	
	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Ramo + Producto + Amparo
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.ramo_id = c.ramo_id AND sub1.producto_id = c.producto_id AND sub1.amparo_id = c.amparo_id
	WHERE sub1.modalidadPago_id = 0 and sub1.lineaNegocio_id = 0 and c.producto_id <> 0 and c.amparo_id <> 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id

	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id	
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp
			

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Ramo + Producto + Linea Negocio + Amparo Id
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.ramo_id = c.ramo_id AND sub1.producto_id = c.producto_id AND sub1.lineaNegocio_id = c.lineaNegocio_id AND sub1.amparo_id = c.amparo_id
	WHERE sub1.modalidadPago_id = 0 and c.producto_id <> 0 and c.amparo_id <> 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id

	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp		

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Ramo + Producto + Linea Negocio + Modalidad Pago
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.ramo_id = c.ramo_id AND sub1.producto_id = c.producto_id AND sub1.lineaNegocio_id = c.lineaNegocio_id AND sub1.modalidadPago_id = c.modalidadPago_id
	WHERE sub1.amparo_id = 0 and c.producto_id <> 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id

	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id
	
	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp		

	-- Excepciones Jerarquia teniendo en cuenta la combinacion de #ParametrizacionTemp por
	-- Compañía + Ramo + Producto + Linea Negocio + Modalidad Pago + Amparo
	INSERT INTO EjecucionTemp
	SELECT
		sub1.jerarquiaDetalle_id, 
		sub1.meta_id,
		c.canal_id,
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
		#ParametrizacionTemp as sub1 	
		INNER JOIN ConsolidadoMesTemp AS c ON sub1.jerarquiaDetalle_id = c.jerarquiaDetalle_id AND sub1.compania_id = c.compania_id AND sub1.tipoMedida_id = c.tipoMedida_id AND sub1.ramo_id = c.ramo_id AND sub1.producto_id = c.producto_id AND sub1.lineaNegocio_id = c.lineaNegocio_id AND sub1.modalidadPago_id = c.modalidadPago_id AND sub1.amparo_id = c.amparo_id
	WHERE c.producto_id <> 0 and c.amparo_id <> 0
	GROUP BY sub1.jerarquiaDetalle_id, c.canal_id, sub1.meta_id

	-- Insertamos en Ejecucion Detalle desde la Ejecucion Temp Convirtiendo las columnas en filas
	-- utilizando UNPIVOT
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
	2,
	canal_id
	FROM
	(SELECT jerarquiaDetalle_id, meta_id, canal_id, enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre FROM EjecucionTemp) ET
	UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt
	ORDER BY jerarquiaDetalle_id, meta_id

	-- BORRAMOS TABLA TEMPORAL
	DELETE FROM EjecucionTemp
	
	-- ***********************************************************************
	-- CALCULAMOS EJECUCION METAS COMPUESTAS PARA LAS EXCEPCIONES DE JERARQUIA
	-- ***********************************************************************	
	INSERT INTO EjecucionDetalleCRM(periodo, valor, meta_id, ejecucion_id, nodo_id, tipo, canal_id)
	SELECT
		CAST(@anio as varchar) + '-' + CAST(sub1.mes as varchar) + '-01' as periodo,
		sub1.valor,
		sub1.metaOrigen_id,
		@idEjecucion as ejeucion_id,
		sub1.nodo_id,
		2,
		sub1.canal_id
	FROM
	(	
		SELECT ed.nodo_id, mc.metaOrigen_id, MONTH(ed.periodo) as mes, sum(ed.valor) as valor, ed.canal_id
		FROM EjecucionDetalleCRM as ed
		INNER JOIN metaCompuesta as mc ON ed.meta_id = mc.metaDestino_Id		
		WHERE ed.ejecucion_id = @idEjecucion and ed.tipo=2
		GROUP BY ed.nodo_id, mc.metaOrigen_id, YEAR(ed.periodo), MONTH(ed.periodo), ed.canal_id
	) as sub1	
	
	DROP TABLE #ConsolidadoMesTemp
	DROP TABLE #DetallePresupuesto
	DROP TABLE #ParametrizacionTemp
	
	RETURN 1
END
		