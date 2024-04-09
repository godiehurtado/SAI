-- =============================================
-- Author:		Juan Fernando Rojas
-- Modification date: 04/05/2012
-- Description:	Homologación de datos del archivo COMJJEO. Se insertan la jerarquia Comercial en la tabla jerarquiaDetalle
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Multijerarquia]
AS
BEGIN
	-- Se filtran los directores (nivel 2) en comun entre la Jerarquia y Multijerarquia y que existan en la tabla Participante.
	SELECT DISTINCT j.segmento_id AS segmentoJerarquia
		,RTRIM(LTRIM(m.documentoDirector)) AS documentoDirector
		,p.id AS participanteDirector_id
		,jd.id AS jerarquiaDetalle_id
		,RTRIM(LTRIM(m.clave)) AS claveParticipante
		,CAST(m.segmentoClave AS INT) AS segmentoAsesor_id
		,j.id AS jerarquia_id
		,CAST(m.companiaClave AS INT) AS companiaAsesor_id
	INTO #Multijerarquia
	FROM Multijerarquia m
	INNER JOIN Participante p ON RTRIM(LTRIM(p.documento)) = RTRIM(LTRIM(m.documentoDirector))
	INNER JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
	INNER JOIN Jerarquia j ON j.id = jd.jerarquia_id
		AND CAST(m.segmentoClave AS INT) = j.segmento_id
		AND p.canal_id = jd.canal_id
	WHERE j.tipoJerarquia_id = 1 --Comercial
		AND jd.nivel_id = 2 --Director			
		AND p.id > 0
		
	-- Tabla filtrada de canal por asesor: Tiene como objetivo comparar la información 
	-- del asesor entregada en multijerarquía, con la del director: (canal, segmento)	
	SELECT DISTINCT m.claveParticipante
	, CAST(m.segmentoAsesor_id AS INT) AS segmentoAsesor_id
	, p.canal_id
	, p.id AS participante_id
	, 0 AS segmentoJerarquia
	, 0 AS participanteDirector_id
	, 0 AS jerarquiaDetalle_id
	, 0 AS canalDirector_id
	, 0 AS zonaDirector_id
	, 0 AS localidadDirector_id
	INTO #MultijerarquiaxCanal
	FROM #Multijerarquia m
	INNER JOIN Participante p ON RTRIM(LTRIM(p.clave)) = RTRIM(LTRIM(m.claveParticipante))
	
	-- A cada asesor, le asigna el director de la tabla JerarquíaDetalle, teniendo en cuenta que
	-- el canal y el segmento sea el mismo entre asesor y director.
	UPDATE #MultijerarquiaxCanal
	SET jerarquiaDetalle_id =jd.id
	, canalDirector_id = jd.canal_id
	, zonaDirector_id = jd.zona_id
	, localidadDirector_id = jd.localidad_id
	, segmentojerarquia = j.segmento_id
	, participanteDirector_id = jd.participante_id
	FROM #MultijerarquiaxCanal t
	INNER JOIN #Multijerarquia m ON RTRIM(LTRIM(t.claveParticipante)) = RTRIM(LTRIM(m.claveParticipante))		
	INNER JOIN JerarquiaDetalle jd ON jd.canal_id = t.canal_id
	INNER JOIN Participante p ON p.id = jd.participante_id
		AND RTRIM(LTRIM(p.documento)) = RTRIM(LTRIM(m.documentoDirector))
	INNER JOIN Jerarquia j ON j.id = jd.jerarquia_id
	WHERE jd.nivel_id = 2

	-- Si un director cambio de canal, para que el asesor tome el cambio, el archivo NOM301O
	-- que carga los asesores debe traer el cambio de canal de los asesores.
	UPDATE JerarquiaDetalle
	SET padre_id = m.jerarquiaDetalle_id
		,zona_id = m.zonaDirector_id
		,localidad_id = m.localidadDirector_id
		,canal_id = m.canalDirector_id
		,codigoNivel = (RTRIM(LTRIM(p.clave)) + '_' + CAST(p.segmento_id AS NVARCHAR(5)))
	FROM #MultijerarquiaxCanal AS m
	INNER JOIN JerarquiaDetalle jd ON jd.participante_id = m.participante_id
	INNER JOIN Jerarquia j ON j.id = jd.jerarquia_id
		AND m.segmentoAsesor_id = j.segmento_id
	INNER JOIN Participante p ON p.id = jd.participante_id
	WHERE jd.nivel_id = 1 --> Nivel: Asesor	

	-- *********************************************************************************************************
	-- SE INSERTA EN JERARQUIADETALLE.	
	-- *********************************************************************************************************--	
	-- Se valida que toda la fila de jerarquia detalle sea diferente a los elementos que van en el insert desde #Multijerarquia. Si los elementos que van
	-- en el insert tiene por lo menos uno un valor diferente se inserta en la tabla JerarquiaDetalle
	INSERT INTO JerarquiaDetalle (
		jerarquia_id
		,nombre
		,padre_id
		,zona_id
		,localidad_id
		,canal_id
		,participante_id
		,nivel_id
		,codigoNivel
		,descripcion
		)
	SELECT DISTINCT jd.jerarquia_id
		,(RTRIM(LTRIM(p.clave)) + ' - ' + RTRIM(LTRIM(p.nombre)) + ' ' + RTRIM(LTRIM(p.apellidos))) AS nombre
		,jd.id AS padre_id
		,jd.zona_id
		,jd.localidad_id
		,jd.canal_id AS canalDirector_id
		,p.id AS participante_id
		,1 AS nivel_id --nivel_id = Asesor (1)		
		,(RTRIM(LTRIM(p.clave)) + '_' + CAST(p.segmento_id AS NVARCHAR(5))) AS codigoNivel
		,'' AS descripcion
	FROM #MultijerarquiaxCanal AS m
	INNER JOIN JerarquiaDetalle jd ON jd.participante_id = m.participanteDirector_id
		AND m.canalDirector_id = jd.canal_id
	INNER JOIN Participante p ON p.id = m.participante_id
	INNER JOIN Jerarquia j ON j.id = jd.jerarquia_id
		AND m.segmentoAsesor_id = j.segmento_id
		AND m.canal_id = jd.canal_id
	WHERE jd.nivel_id = 2 -- Director
		AND NOT EXISTS (
			SELECT *
			FROM JerarquiaDetalle AS jd1
			WHERE jd.id = jd1.padre_id
				AND jd.zona_id = jd1.zona_id
				AND jd.localidad_id = jd1.localidad_id
				AND jd.canal_id = jd1.canal_id
				AND p.id = jd1.participante_id
				AND m.canalDirector_id = jd1.canal_id				
				AND j.id = jd1.jerarquia_id
				AND jd1.nivel_id = 1 -- Asesor
			)

	DROP TABLE #MultijerarquiaxCanal
	DROP TABLE #Multijerarquia
END
