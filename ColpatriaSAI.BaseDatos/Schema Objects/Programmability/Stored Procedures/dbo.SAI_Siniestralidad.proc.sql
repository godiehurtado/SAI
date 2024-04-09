-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 26/04/2012
-- Description:	Homologación e inserción de los datos de siniestralidad del ramo AUTOS.
-- Modificación:Ajuste en el calculo final del indSiniestralidad para tomar las primasDevengadas = (primasEmitidas + reservaTecnica)
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Siniestralidad]
AS
BEGIN
	-- *********************************************************************************************************
	-- LOG DE ERRORES.
	-- *********************************************************************************************************--
	DECLARE @cantidadInicial AS INT = (SELECT COUNT(*) FROM Siniestralidad)
	DECLARE @mesCorte AS INT = (SELECT TOP 1 CAST(SUBSTRING(fechaCorte, 5, 2) AS INT) FROM Siniestralidadtemp)
	DECLARE @añoVigente AS INT = (SELECT CAST(pa.valor AS INT) FROM ParametrosApp pa WHERE pa.id = 3)
	DECLARE @baseMonedaActual AS FLOAT = (
		SELECT DISTINCT Bm.base FROM BaseMoneda Bm WHERE YEAR(bm.fecha_inicioVigencia) = @añoVigente
		AND YEAR(bm.fecha_finVigencia) = @añoVigente
		AND Bm.id > 0
		AND Bm.moneda_id = 1
		)
	DECLARE @factorSiniestralidad AS FLOAT = (SELECT CAST(p.valor AS FLOAT) FROM ParametrosApp p WHERE p.id = 12)
	DECLARE @factorAutos AS FLOAT = (
		SELECT mn.factor FROM MonedaxNegocio mn INNER JOIN MaestroMonedaxNegocio mmn ON mmn.id = mn.maestromoneda_id WHERE mn.ramo_id = 8
		AND mn.producto_id = 10
		AND YEAR(mmn.fecha_inicial) = @añoVigente
		AND YEAR(mmn.fecha_final) = @añoVigente
		)

	-- *********************************************************************************************************
	-- Normalización de campos.
	-- *********************************************************************************************************--
	--  Normalización campos con '" "'.
	UPDATE Siniestralidadtemp
	SET compania_id = REPLACE(compania_id, '"', '')

	UPDATE Siniestralidadtemp
	SET fechaCorte = REPLACE(fechaCorte, '"', '')

	UPDATE Siniestralidadtemp
	SET clave = REPLACE(clave, '"', '')

	UPDATE Siniestralidadtemp
	SET ramodetalle_id = REPLACE(ramodetalle_id, '"', '')

	IF (@cantidadInicial > 0)
	BEGIN
		DELETE
		FROM Siniestralidad
		WHERE MONTH(fechaCorte) = @mesCorte
			AND YEAR(fechaCorte) = @añoVigente
	END

	UPDATE Siniestralidadtemp
	SET siniestrosIncurridos = (CAST(siniestrosIncurridos AS FLOAT) * (- 1))

	-- *********************************************************************************************************
	-- Se inserta en la tabla dbo.Siniestralidad -- Ramo AUTOS. Asesores x mes
	-- *********************************************************************************************************--
	INSERT INTO Siniestralidad (
		participante_id
		,compania_id
		,fechaCorte
		,ramodetalle_id
		,clave
		,siniestrosIncurridos
		,primasEmitidas
		,reservaTecnica
		)
	SELECT p.id
		,s.compania_id
		,CONVERT(DATE, s.fechaCorte, 103) AS fechaCorte
		,21 AS ramoDetalle_id --id SAI AUTOMOVILES
		,RTRIM(LTRIM(s.clave)) AS clave
		,SUM(s.siniestrosIncurridos) AS siniestrosIncurridos
		,SUM(s.primasEmitidas) AS primasEmitidas
		,SUM(s.reservaTecnica) AS reservaTecnica
	FROM siniestralidadtemp s
	INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(s.clave))
	WHERE RTRIM(LTRIM(ramodetalle_id)) = '00000210'
		AND s.compania_id = 1
	GROUP BY p.id
		,s.compania_id
		,CONVERT(DATE, s.fechaCorte, 103)
		,s.clave

	-- *********************************************************************************************************
	-- CALCULO INDICE DE SINIESTRALIDAD X MES
	-- *********************************************************************************************************--
	UPDATE Siniestralidad
	SET indSiniestralidad = (
			CASE 
				WHEN (
						siniestrosIncurridos = 0
						AND (primasEmitidas + reservaTecnica) = 0
						)
					THEN 0
				ELSE CASE 
						WHEN (
								siniestrosIncurridos > 0
								AND (primasEmitidas + reservaTecnica) = 0
								)
							THEN 99
						ELSE CASE 
								WHEN (
										siniestrosIncurridos < 0
										AND (primasEmitidas + reservaTecnica) = 0
										)
									THEN 0
								ELSE CASE 
										WHEN (
												siniestrosIncurridos < 0
												AND (primasEmitidas + reservaTecnica) < 0
												)
											THEN 0
										ELSE CASE 
												WHEN (
														siniestrosIncurridos < 0
														AND (primasEmitidas + reservaTecnica) > 0
														)
													THEN 0
												ELSE CASE 
														WHEN (
																siniestrosIncurridos > 0
																AND (primasEmitidas + reservaTecnica) <= 0
																)
															THEN 99
														ELSE CASE 
																WHEN ((siniestrosIncurridos / (primasEmitidas + reservaTecnica)) > CAST(0.99 AS FLOAT))
																	THEN (ROUND((siniestrosIncurridos / (primasEmitidas + reservaTecnica)), 5) * 100)
																ELSE (ROUND((siniestrosIncurridos / (primasEmitidas + reservaTecnica)), 5) * 100)
																END
														END
												END
										END
								END
						END
				END
			)
	WHERE indSiniestralidad IS NULL

	-- *********************************************************************************************************
	-- Se inserta en la tabla dbo.Siniestralidad -- Ramo AUTOS. EJECUTIVOS x NODO DE LA JERARQUIA COMERCIAL
	-- *********************************************************************************************************--
	INSERT INTO Siniestralidad (
		jerarquiaDetalle_id
		,compania_id
		,ramoDetalle_id
		,fechaCorte
		,indSiniestralidad
		)
	SELECT jd.id AS jerarquiaDetalle_id
		,s.compania_id
		,s.ramoDetalle_id
		,s.fechaCorte
		,ROUND((SUM(s.indSiniestralidad) / COUNT(s.participante_id)), 3) AS indSiniestralidad
	FROM JerarquiaDetalle AS jd
	CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
	INNER JOIN Siniestralidad AS s ON hijos.participante_id = s.participante_id
	WHERE jd.nivel_id NOT IN (
			0
			,1
			)
		AND MONTH(s.fechaCorte) = 1
		AND YEAR(s.fechaCorte) = 2012
	GROUP BY jd.id
		,s.compania_id
		,s.ramoDetalle_id
		,s.fechaCorte
	ORDER BY jd.id ASC

	DELETE
	FROM SiniestralidadAcumulada
	WHERE anio = @añoVigente
		AND ultimoMes = @mesCorte

	-- *********************************************************************************************************
	-- CALCULO INDICE DE SINIESTRALIDAD ACUMULADA: ASESORES
	-- *********************************************************************************************************--
	INSERT INTO SiniestralidadAcumulada (
		participante_id
		,compania_id
		,anio
		,ramodetalle_id
		,clave
		,siniestrosIncurridos
		,primasEmitidas
		,reservaTecnica
		,ultimoMes
		,fechaCalculo
		)
	SELECT s.participante_id
		,s.compania_id
		,YEAR(s.fechaCorte) AS anio
		,s.ramoDetalle_id --id SAI AUTOMOVILES
		,RTRIM(LTRIM(s.clave)) AS clave
		,SUM(s.siniestrosIncurridos) AS siniestrosIncurridos
		,SUM(s.primasEmitidas) AS primasEmitidas
		,SUM(s.reservaTecnica) AS reservaTecnica
		,@mesCorte AS ultimoMes
		,GETDATE() AS fechaCalculo
	FROM siniestralidad s
	WHERE s.participante_id IS NOT NULL
		AND YEAR(s.fechaCorte) = @añoVigente
		AND MONTH(s.fechaCorte) <= @mesCorte
	GROUP BY s.participante_id
		,s.compania_id
		,YEAR(s.fechaCorte)
		,s.clave
		,s.ramoDetalle_id

	UPDATE SiniestralidadAcumulada
	SET indSiniestralidad = (
			CASE 
				WHEN (
						siniestrosIncurridos = 0
						AND (primasEmitidas + reservaTecnica) = 0
						)
					THEN 0
				ELSE CASE 
						WHEN (
								siniestrosIncurridos > 0
								AND (primasEmitidas + reservaTecnica) = 0
								)
							THEN 99
						ELSE CASE 
								WHEN (
										siniestrosIncurridos < 0
										AND (primasEmitidas + reservaTecnica) = 0
										)
									THEN 0
								ELSE CASE 
										WHEN (
												siniestrosIncurridos < 0
												AND (primasEmitidas + reservaTecnica) < 0
												)
											THEN 0
										ELSE CASE 
												WHEN (
														siniestrosIncurridos < 0
														AND (primasEmitidas + reservaTecnica) > 0
														)
													THEN 0
												ELSE CASE 
														WHEN (
																siniestrosIncurridos > 0
																AND (primasEmitidas + reservaTecnica) <= 0
																)
															THEN 99
														ELSE CASE 
																WHEN ((siniestrosIncurridos / (primasEmitidas + reservaTecnica)) > CAST(0.99 AS FLOAT))
																	THEN (ROUND((siniestrosIncurridos / (primasEmitidas + reservaTecnica)), 5) * 100)
																ELSE (ROUND((siniestrosIncurridos / (primasEmitidas + reservaTecnica)), 5) * 100)
																END
														END
												END
										END
								END
						END
				END
			)
	WHERE anio = @añoVigente
		AND indSiniestralidad IS NULL

	-- *********************************************************************************************************
	-- CALCULO INDICE DE SINIESTRALIDAD ACUMULADA: EJECUTIVOS
	-- *********************************************************************************************************--
	INSERT INTO SiniestralidadAcumulada (
		jerarquiaDetalle_id
		,compania_id
		,anio
		,ramodetalle_id
		,indSiniestralidad
		,ultimoMes
		,fechaCalculo
		,primasEmitidas
		,reservaTecnica
		,siniestrosIncurridos
		)
	SELECT jd.id AS jerarquiaDetalle_id
		,s.compania_id
		,YEAR(s.fechaCorte) AS anio
		,s.ramoDetalle_id --id SAI AUTOMOVILES	
		,ROUND((SUM(s.indSiniestralidad) / COUNT(s.participante_id)), 3) AS indSiniestralidad
		,@mesCorte AS ultimoMes
		,GETDATE() AS fechaCalculo
		,SUM(s.primasEmitidas) AS primasEmitidas
		,SUM(s.reservaTecnica) AS reservaTecnica
		,SUM(s.siniestrosIncurridos) AS siniestrosIncurridos
	FROM JerarquiaDetalle AS jd
	CROSS APPLY ObtenerHijosNodo(jd.id) AS hijos
	INNER JOIN Siniestralidad AS s ON hijos.participante_id = s.participante_id
	WHERE jd.nivel_id NOT IN (
			0
			,1
			)
		AND YEAR(s.fechaCorte) = @añoVigente
		AND MONTH(s.fechaCorte) <= @mesCorte
	GROUP BY s.compania_id
		,YEAR(s.fechaCorte)
		,s.ramoDetalle_id
		,jd.id
	ORDER BY jd.id ASC

	--  Colquines a descontar para asesores y ejecutivos
	UPDATE SiniestralidadAcumulada
	SET colquinesDescontar = (
			CASE 
				WHEN indSiniestralidad < 50
					THEN 0
				ELSE ((((siniestrosIncurridos - ((primasEmitidas + reservaTecnica) * 0.5)) * @factorSiniestralidad) / @baseMonedaActual) * (- 1))
				END
			)
	WHERE anio = @añoVigente
		AND colquinesDescontar IS NULL

	-- Recaudos a descontar para ejecutivos
	UPDATE SiniestralidadAcumulada
	SET recaudosDescontar = ((colquinesDescontar * @baseMonedaActual) / @factorAutos)
	WHERE anio = @añoVigente
		AND recaudosDescontar IS NULL
		AND jerarquiaDetalle_id IS NOT NULL

	--  Log Errores
	DECLARE @cantidadFinal AS INT = (SELECT COUNT(*) FROM Siniestralidad)
	DECLARE @delta AS INT = @cantidadFinal - @cantidadInicial
	DECLARE @idActualizacion AS INT = (
		SELECT MAX(id) FROM LogIntegracion WHERE proceso = 'Calculo Siniestralidad'
		AND estado = 1
		)

	UPDATE LogIntegracion
	SET fechaFin = GETDATE()
		,estado = 2
		,cantidad = @delta
	WHERE id = @idActualizacion
END
