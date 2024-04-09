-- =============================================
-- Author:		Advantis
-- Create date: Enero de 2012
-- Description:	Procedimiento que permite obtener la información a mostrar en el Dashboard del sistema
--				A futuro es posible adicionar nueva información insertando información en las columnas de la tabla dashboard
--				Este proceso se ejecuta diariamente. Es posible parametrizar el periodo por el cuál se obtiene la información
-- =============================================
CREATE PROCEDURE [dbo].[getDashboard]
	-- Add the parameters for the stored procedure here
	@segmento_id AS INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET LANGUAGE Spanish

	TRUNCATE TABLE dashboard -- se elimina toda la información del dashboard ya que esta se cambia diariamente

	SELECT *
	INTO #dashboard
	FROM dashboard

	ALTER TABLE #dashboard ADD compania_id INT

	ALTER TABLE #dashboard ADD ramo_id INT

	-- Se obtiene la fecha del día para poder luego obtener el rango del periodo que se va a obtener
	DECLARE @hoy DATE = GETDATE () --'2012-06-12'
	DECLARE @periodo DATE = DATEADD (
		ww
		,- 1
		,@hoy
		) -- periodo semanal  '2012-06-05'
	DECLARE @mesActual AS INT = MONTH (GETDATE())
	DECLARE @anioActual AS INT = (SELECT valor FROM ParametrosApp WHERE id = 3)
	DECLARE @diaActual AS INT = DAY (GETDATE())

	-- Nuevos negocios por compañía/ramo periodo
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,tipoPanel_id
		)
	SELECT TOP 10 c.nombre + ' - ' + r.nombre
		,CONVERT(VARCHAR(50), CAST(COUNT(n.id) AS MONEY), 1) AS NuevosNegocios
		,1
	FROM Negocio n
	INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
	INNER JOIN Ramo r ON r.id = rd.ramo_id
	INNER JOIN Compania c ON c.id = n.compania_id
	INNER JOIN GrupoEndoso ge ON ge.id = n.grupoEndoso_id
	WHERE (
			-- VIDA y GENERALES			NUEVOS NEGOCIOS
			(
				n.compania_id IN (
					1
					,2
					)
				AND ge.claseEndoso = 1
				)
			OR n.compania_id IN (
				3
				,4
				,5
				) -- CAPI, ARP y SALUD 
			)
		AND n.lineaNegocio_id = 1
		AND n.mesCierre = @mesActual
		AND RTRIM(LTRIM(n.estadoNegocio)) = 'V'
		AND n.anioCierre = @anioActual
		AND n.segmento_id = @segmento_id
	GROUP BY c.nombre
		,r.nombre
	ORDER BY COUNT(n.id) DESC

	-- Total primas por compañía/ramo periodo
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,tipoPanel_id
		,compania_id
		,ramo_id
		)
	SELECT TOP 10 c.nombre + ' - ' + r.nombre
		,CONVERT(VARCHAR(50), CAST(STR(SUM(n.valorPrimaTotal), 13, 2) AS MONEY), 1) AS TotalPrimas
		,2
		,c.id
		,rd.ramo_id
	FROM Negocio n
	INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
	INNER JOIN Ramo r ON r.id = rd.ramo_id
	INNER JOIN Compania c ON c.id = n.compania_id
	WHERE YEAR(n.fechaCarga) = @anioActual
		AND MONTH(n.fechaCarga) = @mesActual
		AND DAY(n.fechaCarga) = @diaActual
		AND n.segmento_id = @segmento_id
	GROUP BY c.nombre
		,r.nombre
		,rd.id
		,c.id
		,n.segmento_id
		,r.id
		,rd.ramo_id
	ORDER BY SUM(n.valorPrimaTotal) DESC

	-- Total recaudos por compañía/ramo periodo
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,tipoPanel_id
		,compania_id
		,ramo_id
		)
	SELECT TOP 10 c.nombre + ' - ' + ra.nombre
		,CONVERT(VARCHAR(50), CAST(STR(SUM(r.valorRecaudo), 13, 2) AS MONEY), 1) AS TotalRecaudos
		,3
		,c.id
		,rd.ramo_id
	FROM Recaudo r
	INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
	INNER JOIN Ramo ra ON ra.id = rd.ramo_id
	INNER JOIN Compania c ON c.id = r.compania_id
	WHERE YEAR(r.fechaCarga) = @anioActual
		AND MONTH(r.fechaCarga) = @mesActual
		AND DAY(r.fechaCarga) = @diaActual
		AND r.segmento_id = @segmento_id
	GROUP BY c.nombre
		,ra.nombre
		,c.id
		,rd.ramo_id
	ORDER BY SUM(r.valorRecaudo) DESC

	-- Total Colquines por compañía/ramo periodo
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,tipoPanel_id
		,compania_id
		,ramo_id
		)
	SELECT TOP 10 c.nombre + ' - ' + ra.nombre
		,CONVERT(VARCHAR(50), CAST(STR(SUM(r.Colquines), 13, 3) AS MONEY), 1) AS TotalColquines
		,4
		,c.id
		,rd.ramo_id
	FROM Recaudo r
	INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
	INNER JOIN Ramo ra ON ra.id = rd.ramo_id
	INNER JOIN Compania c ON c.id = r.compania_id
	WHERE YEAR(r.fechaCarga) = @anioActual
		AND MONTH(r.fechaCarga) = @mesActual
		AND DAY(r.fechaCarga) = @diaActual
		AND r.segmento_id = @segmento_id
	GROUP BY c.nombre
		,ra.nombre
		,c.id
		,rd.ramo_id
	ORDER BY SUM(r.Colquines) DESC

	-- Colquines por asesor AÑO EN CURSO
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,valor2
		,valor3
		,tipoPanel_id
		)
	SELECT TOP 10 r.clave
		,(RTRIM(LTRIM(p.nombre)) + ' ' + RTRIM(LTRIM(p.apellidos))) AS asesor
		,l.nombre AS localidad
		,CAST(STR(SUM(r.Colquines), 13, 3) AS MONEY) AS colquines
		,5
	FROM Recaudo r
	INNER JOIN Participante p ON p.id = r.participante_id
	INNER JOIN Localidad l ON l.id = p.localidad_id
	WHERE r.anioCierre = @anioActual
		AND p.canal_id IN (
			4
			,7
			)
	GROUP BY r.clave
		,p.nombre
		,p.apellidos
		,l.nombre
	ORDER BY colquines DESC

	-- Vinculación asesores
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,valor2
		,valor3
		,tipoPanel_id
		)
	SELECT TOP 10 z.nombre AS zona
		,l.nombre AS localidad
		,COUNT(p.id) AS cantidad
		,@mesActual AS mes
		,6
	FROM Participante p
	INNER JOIN Localidad l ON l.id = p.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	WHERE YEAR(p.fechaIngreso) = @anioActual
		AND MONTH(p.fechaIngreso) <= @mesActual
	GROUP BY z.nombre
		,l.nombre
	ORDER BY COUNT(p.id) DESC

	-- Ramos sin agrupar
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,valor2
		,tipoPanel_id
		)
	SELECT TOP 10 Compania.nombre AS Compania
		,RamoDetalle.nombre AS Ramo
		,RamoDetalle.codigoCore
		,7
	FROM RamoDetalle
	INNER JOIN Compania ON Compania.id = RamoDetalle.compania_id
	WHERE ramo_id = 0
		AND RamoDetalle.id <> 0

	-- Productos sin agrupar
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,tipoPanel_id
		)
	SELECT TOP 10 Compania.nombre + '-' + RamoDetalle.nombre + '-' + ProductoDetalle.nombre AS Producto
		,ProductoDetalle.codigoCore
		,8
	FROM ProductoDetalle
	INNER JOIN RamoDetalle ON RamoDetalle.id = ProductoDetalle.ramoDetalle_id
	INNER JOIN Compania ON Compania.id = RamoDetalle.compania_id
	WHERE producto_id = 0
		AND ProductoDetalle.id <> 0

	-- Liquidacion Franquicias
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,valor2
		,valor3
		,tipoPanel_id
		)
	SELECT TOP 5 '$' + CONVERT(VARCHAR(50), CAST(STR(ROUND(SUM(dlf.totalParticipacion), 2), 13, 2) AS MONEY), 1) AS totalPagado
		,MONTH(lf.periodoLiquidacionIni) AS mes
		,CAST(lf.fechaLiquidacion AS DATE) AS fechaLiquidacion
		,el.nombre AS estadoLiquidacion
		,9
	FROM DetalleLiquidacionFranquicia dlf
	INNER JOIN LiquidacionFranquicia lf ON lf.id = dlf.liquidacionFranquicia_id
	INNER JOIN EstadoLiquidacion el ON el.id = lf.estado
	WHERE lf.estado IN (
			2
			,5
			) -- PAGADO Y RELIQUIDADO
		AND YEAR(lf.periodoLiquidacionIni) = @anioActual
	GROUP BY dlf.liquidacionFranquicia_id
		,el.nombre
		,MONTH(lf.periodoLiquidacionIni)
		,CAST(lf.fechaLiquidacion AS DATE)
	ORDER BY mes DESC
		,CAST(lf.fechaLiquidacion AS DATE) DESC

	-- Liquidacion Reglas
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,valor2
		,tipoPanel_id
		)
	SELECT TOP 5 '<b>Concurso:</b> ' + c.nombre + ' <b>Regla:</b> ' + r.nombre
		,(
			CASE 
				WHEN um.id = 2
					THEN '$' + CONVERT(VARCHAR(50), SUM(CAST(STR(lp.resultado, 13, 3) AS MONEY)), 1)
				ELSE CONVERT(VARCHAR(50), SUM(CAST(STR(lp.resultado, 13, 3) AS MONEY)), 1)
				END
			) AS cantidad
		,(
			CASE 
				WHEN um.id = 0
					THEN 'Cupos convención'
				ELSE CASE 
						WHEN um.id = 1
							THEN 'Colquines'
						ELSE CASE 
								WHEN um.id = 2
									THEN 'Pesos'
								END
						END
				END
			) AS unidadMedida
		,10
	FROM LiquidacionPremio lp
	INNER JOIN LiquidacionReglaxParticipante lrp ON lrp.id = lp.liquidacionReglaxParticipante_id
	INNER JOIN LiquidacionRegla lr ON lr.id = lrp.liquidacionRegla_id
	INNER JOIN Regla r ON r.id = lr.regla_id
	INNER JOIN Concurso c ON c.id = r.concurso_id
	INNER JOIN Premio p ON p.id = lp.premio_id
	INNER JOIN UnidadMedida um ON um.id = p.unidadmedida_id
	WHERE ISNUMERIC(lp.resultado) = 1
		AND YEAR(lr.fecha_liquidacion) = @anioActual
		AND lr.estado = 2 -- PAGADA
		--AND c.principal = 1
	GROUP BY r.nombre
		,c.nombre
		,um.nombre
		,um.id
	ORDER BY cantidad DESC

	-- Log Integracion
	INSERT INTO #dashboard (
		descripcion
		,valor1
		,valor2
		,tipoPanel_id
		)
	SELECT p.PackageName AS NombrePaquete
		,(
			CASE 
				WHEN RTRIM(LTRIM(pl.STATUS)) = 'S'
					THEN 'Termino'
				ELSE CASE 
						WHEN RTRIM(LTRIM(pl.STATUS)) = 'F'
							THEN 'Con error'
						ELSE CASE 
								WHEN RTRIM(LTRIM(pl.STATUS)) = 'R'
									THEN 'En ejecución'
								END
						END
				END
			) AS Estado
		,CAST(pl.StartDateTime AS DATE) AS fecha
		,11
	FROM PackageLog pl
	INNER JOIN PackageVersion pv ON pl.PackageVersionID = pv.PackageVersionID
	INNER JOIN Package p ON pv.PackageID = p.PackageID
	WHERE CAST(pl.StartDateTime AS DATE) = @hoy
		AND p.PackageName NOT LIKE '%Reporte_%'
	GROUP BY p.PackageName
		,pl.STATUS
		,CAST(pl.StartDateTime AS DATE)
		,pl.EndDateTime
	ORDER BY pl.EndDateTime

	-- Segmentación negocios
	INSERT INTO #dashboard (
		descripcion
		,valor3
		,tipoPanel_id
		)
	SELECT c.nombre + ' - ' + (
			CASE 
				WHEN s.nombre = ''
					THEN 'Sin Segmento'
				ELSE s.nombre
				END
			) AS segmento
		,CONVERT(VARCHAR(50), CAST(STR(SUM(n.valorPrimaTotal), 13, 3) AS MONEY), 1) AS valorPrima
		,12
	FROM Negocio n
	INNER JOIN Compania c ON c.id = n.compania_id
	INNER JOIN Segmento s ON s.id = n.segmento_id
	WHERE n.anioCierre = @anioActual
	GROUP BY c.nombre
		,s.nombre
	ORDER BY c.nombre
		,s.nombre

	-- Segmentación recaudos
	INSERT INTO #dashboard (
		descripcion
		,valor3
		,tipoPanel_id
		)
	SELECT c.nombre + ' - ' + (
			CASE 
				WHEN s.nombre = ''
					THEN 'Sin Segmento'
				ELSE s.nombre
				END
			) AS compania_segmento
		,CONVERT(VARCHAR(50), CAST(STR(SUM(r.valorRecaudo), 13, 3) AS MONEY), 1) AS valorPrima
		,13
	FROM Recaudo r
	INNER JOIN Compania c ON c.id = r.compania_id
	INNER JOIN Segmento s ON s.id = r.segmento_id
	WHERE r.anioCierre = @anioActual
	GROUP BY c.nombre
		,s.nombre
	ORDER BY c.nombre
		,s.nombre

	-- *********************************************************************************************************
	-- Actualización acumulados tipo panel 2,3,4
	-- *********************************************************************************************************--	
	UPDATE t1
	SET t1.valor2 = t2.ColquinesAcumulados
	FROM #dashboard t1
	INNER JOIN (
		SELECT CONVERT(VARCHAR(50), CAST(STR(SUM(r.Colquines), 13, 3) AS MONEY), 1) AS ColquinesAcumulados
			,rd.ramo_id
			,r.compania_id
		FROM Recaudo r
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		WHERE r.anioCierre = @anioActual
			AND r.mesCierre <= @mesActual
			AND r.segmento_id = @segmento_id
		GROUP BY r.compania_id
			,rd.ramo_id
		) t2 ON t1.compania_id = t2.compania_id
		AND t1.ramo_id = t2.ramo_id
		AND t1.tipoPanel_id = 4

	UPDATE t1
	SET t1.valor2 = t2.RecaudosAcumulados
	FROM #dashboard t1
	INNER JOIN (
		SELECT CONVERT(VARCHAR(50), CAST(STR(SUM(r.valorRecaudo), 13, 3) AS MONEY), 1) AS RecaudosAcumulados
			,rd.ramo_id
			,r.compania_id
		FROM Recaudo r
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		WHERE r.anioCierre = @anioActual
			AND r.mesCierre <= @mesActual
			AND r.segmento_id = @segmento_id
		GROUP BY r.compania_id
			,rd.ramo_id
		) t2 ON t1.compania_id = t2.compania_id
		AND t1.ramo_id = t2.ramo_id
		AND t1.tipoPanel_id = 3

	UPDATE t1
	SET t1.valor2 = t2.PrimasAcumuladas
	FROM #dashboard t1
	INNER JOIN (
		SELECT CONVERT(VARCHAR(50), CAST(STR(SUM(n.valorPrimaTotal), 13, 3) AS MONEY), 1) AS PrimasAcumuladas
			,rd.ramo_id
			,n.compania_id
		FROM Negocio n
		INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
		WHERE n.anioCierre = @anioActual
			AND n.mesCierre <= @mesActual
			AND n.segmento_id = @segmento_id
		GROUP BY n.compania_id
			,rd.ramo_id
		) t2 ON t1.compania_id = t2.compania_id
		AND t1.ramo_id = t2.ramo_id
		AND t1.tipoPanel_id = 2

	-- *********************************************************************************************************
	-- Insertar en Dashboard
	-- *********************************************************************************************************--	
	INSERT INTO Dashboard (
		descripcion
		,valor1
		,valor2
		,valor3
		,tipoPanel_id
		)
	SELECT descripcion
		,valor1
		,valor2
		,valor3
		,tipoPanel_id
	FROM #dashboard

	DROP TABLE #dashboard
END