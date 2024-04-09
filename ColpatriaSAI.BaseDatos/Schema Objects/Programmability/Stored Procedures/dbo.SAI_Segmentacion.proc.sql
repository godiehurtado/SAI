
-- =============================================
-- Author:		Juan Fernando Rojas
-- Create date: 01/16/2012 07:50:57
-- Description:	Segmenta los negocios y recaudos del sistema con la información entregada en la tabla sig.COMJSN
-- =============================================
CREATE PROCEDURE [dbo].[SAI_Segmentacion]
AS
BEGIN
	/*******************
			SALUD = 011
			CAPI : 013
			VIDA : 014
			GENERALES : 015
			ARP = 016
			EMERMEDICA = 017
		*******************/
	--  Log de Errores
	INSERT INTO LogIntegracion (
		fechaInicio
		,proceso
		,estado
		,sistemaOrigen
		,sistemaDestino
		,tablaDestino
		)
	VALUES (
		GETDATE()
		,'Segmentacion Negocios - Recaudos'
		,1
		,'SIG'
		,'SAI'
		,'Negocio - Recaudo'
		)

	DECLARE @cantidadInicialNegocioss AS INT = (SELECT COUNT(*) FROM Negocio WHERE segmento_id IS NULL)
	DECLARE @cantidadInicialRecaudoss AS INT = (SELECT COUNT(*) FROM Recaudo WHERE segmento_id IS NULL)
	DECLARE @cantidadInicialNegociocs AS INT = (
		SELECT COUNT(*) FROM Negocio WHERE segmento_id IN (
			1
			,2
			,3
			)
		)
	DECLARE @cantidadInicialRecaudocs AS INT = (
		SELECT COUNT(*) FROM Recaudo WHERE segmento_id IN (
			1
			,2
			,3
			)
		)
	DECLARE @registrosSinSegmento AS INT = @cantidadInicialNegocioss + @cantidadInicialRecaudoss
	DECLARE @registrosConSegmento AS INT = @cantidadInicialNegociocs + @cantidadInicialRecaudocs
	/* SEGMENTACIÓN DE NEGOCIOS */
	DECLARE @anioVigente AS INT = (YEAR(GETDATE()) - 1)

	WHILE (@anioVigente <= YEAR(GETDATE()))
	BEGIN
		-- Para CAPI solamente se tiene en cuenta la combinación Negocio + Compañía
		UPDATE Negocio
		SET segmento_id = cm.segmentoNegocio
		FROM Negocio AS n
		INNER JOIN SIG.COMJSN AS cm ON SUBSTRING(n.numeroNegocio, 0, LEN(n.numeroNegocio) - 2) = cm.numeroNegocio
		WHERE n.compania_id = 3
			AND cm.codCompania = '013'
			AND n.anioCierre = @anioVigente

		-- Para GENERALES se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
		UPDATE Negocio
		SET segmento_id = cm.segmentoNegocio
		FROM Negocio AS n
		INNER JOIN SIG.COMJSN AS cm ON n.numeroNegocio = cm.numeroNegocio
		INNER JOIN Localidad l ON l.id = n.localidad_id
		INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
			AND RTRIM(LTRIM(cm.claveAsesor)) = RTRIM(LTRIM(n.clave))
		WHERE cm.codRamo = rd.codigoCore
			AND cm.codSucursal = l.[codigo SISE]
			AND n.compania_id = 1
			AND cm.codCompania = '015'
			AND n.anioCierre = @anioVigente

		-- Para VIDA se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
		UPDATE Negocio
		SET segmento_id = cm.segmentoNegocio
		FROM Negocio AS n
		INNER JOIN SIG.COMJSN AS cm ON n.numeroNegocio = cm.numeroNegocio
		INNER JOIN Localidad l ON l.id = n.localidad_id
		INNER JOIN RamoDetalle rd ON rd.id = n.ramoDetalle_id
			AND RTRIM(LTRIM(cm.claveAsesor)) = RTRIM(LTRIM(n.clave))
		WHERE cm.codRamo = rd.codigoCore
			AND cm.codSucursal = l.[codigo SISE]
			AND n.compania_id = 2
			AND cm.codCompania = '014'
			AND n.anioCierre = @anioVigente

		-- Para SALUD se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
		UPDATE Negocio
		SET segmento_id = cm.segmentoNegocio
		FROM Negocio AS n
		INNER JOIN SIG.COMJSN AS cm ON n.numeroNegocio = cm.numeroNegocio
			AND RTRIM(LTRIM(cm.claveAsesor)) = RTRIM(LTRIM(n.clave))
		WHERE n.compania_id = 5
			AND cm.codCompania = '011'
			AND n.sistema = 'BH'
			AND n.anioCierre = @anioVigente

		-- Para EMERMEDICA se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
		UPDATE Negocio
		SET segmento_id = cm.segmentoNegocio
		FROM Negocio AS n
		INNER JOIN SIG.COMJSN AS cm ON n.numeroNegocio = cm.numeroNegocio
			AND RTRIM(LTRIM(cm.claveAsesor)) = RTRIM(LTRIM(n.clave))
		WHERE n.compania_id = 5
			AND cm.codCompania = '017'
			AND n.sistema = 'EMERMEDICA'
			AND n.anioCierre = @anioVigente

		/* SEGMENTACIÓN DE RECAUDOS */
		-- Para CAPI solamente se tiene en cuenta la combinación Negocio + Compañía
		UPDATE Recaudo
		SET segmento_id = cm.segmentoNegocio
		FROM Recaudo AS r
		INNER JOIN SIG.COMJSN AS cm ON SUBSTRING(r.numeroNegocio, 0, LEN(r.numeroNegocio) - 2) = cm.numeroNegocio
		WHERE r.compania_id = 3
			AND cm.codCompania = '013'
			AND r.anioCierre = @anioVigente

		-- Para GENERALES se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
		UPDATE Recaudo
		SET segmento_id = cm.segmentoNegocio
		FROM Recaudo AS r
		INNER JOIN SIG.COMJSN AS cm ON r.numeroNegocio = cm.numeroNegocio
		INNER JOIN Localidad l ON l.id = r.localidad_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			AND RTRIM(LTRIM(cm.claveAsesor)) = RTRIM(LTRIM(r.clave))
		WHERE cm.codRamo = rd.codigoCore
			AND cm.codSucursal = l.[codigo SISE]
			AND r.compania_id = 1
			AND cm.codCompania = '015'
			AND r.anioCierre = @anioVigente

		-- Para VIDA se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
		UPDATE Recaudo
		SET segmento_id = cm.segmentoNegocio
		FROM Recaudo AS r
		INNER JOIN SIG.COMJSN AS cm ON r.numeroNegocio = cm.numeroNegocio
		INNER JOIN Localidad l ON l.id = r.localidad_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
			AND RTRIM(LTRIM(cm.claveAsesor)) = RTRIM(LTRIM(r.clave))
		WHERE cm.codRamo = rd.codigoCore
			AND cm.codSucursal = l.[codigo SISE]
			AND r.compania_id = 2
			AND cm.codCompania = '014'
			AND r.anioCierre = @anioVigente

		-- Para SALUD se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
		UPDATE Recaudo
		SET segmento_id = cm.segmentoNegocio
		FROM Recaudo AS r
		INNER JOIN SIG.COMJSN AS cm ON r.numeroNegocio = cm.numeroNegocio
			AND RTRIM(LTRIM(cm.claveAsesor)) = RTRIM(LTRIM(r.clave))
		WHERE r.compania_id = 5
			AND cm.codCompania = '011'
			AND r.sistema = 'BH'
			AND r.anioCierre = @anioVigente

		-- Para EMERMEDICA se tiene en cuenta la combinación Compañía + Negocio + Ramo + Localidad
		UPDATE Recaudo
		SET segmento_id = cm.segmentoNegocio
		FROM Recaudo AS r
		INNER JOIN SIG.COMJSN AS cm ON r.numeroNegocio = cm.numeroNegocio
			AND RTRIM(LTRIM(cm.claveAsesor)) = RTRIM(LTRIM(r.clave))
		WHERE r.compania_id = 5
			AND cm.codCompania = '017'
			AND r.sistema = 'EMERMEDICA'
			AND r.anioCierre = @anioVigente

		-- Los negocios y recaudos que no vienen con segmentación definida se actualiza con valor 0
		UPDATE Negocio
		SET segmento_id = 0
		WHERE segmento_id IS NULL

		UPDATE Recaudo
		SET segmento_id = 0
		WHERE segmento_id IS NULL

		/*  SEGMENTACION POR CANAL BH Y EMERMEDICA. */
		-- Se actualizan los recaudos de SALUD (BH + MPP) que tengan segmento = 0 a segmento = 3
		-- y donde la clave del recaudo pertenezca al canal SALUD O ARP
		-- y la compania de la clave sea SALUD.
		UPDATE Recaudo
		SET segmento_id = 3
		FROM Recaudo r
		INNER JOIN Participante p ON p.id = r.participante_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		WHERE p.compania_id = 5
			AND r.segmento_id = 0
			AND p.canal_id IN (
				3
				,5
				)
			AND r.anioCierre = @anioVigente
			AND r.compania_id = 5
			AND r.sistema = 'BH'
			AND rd.ramo_id = 19 -- MPP
			AND p.id > 0

		-- Se actualizan los recaudos de SALUD (EMERMEDICA + EMERMEDICA) que tengan segmento = 0 a segmento = 3
		-- y donde la clave del recaudo pertenezca al canal SALUD O ARP
		-- y la compania de la clave sea EMERMEDICA.
		UPDATE Recaudo
		SET segmento_id = 3
		FROM Recaudo r
		INNER JOIN Participante p ON p.id = r.participante_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		WHERE p.compania_id = 5
			AND r.segmento_id = 0
			AND p.canal_id IN (
				3
				,5
				)
			AND r.anioCierre = @anioVigente
			AND r.compania_id = 5
			AND r.sistema = 'EMERMEDICA'
			AND rd.ramo_id = 21 -- EMERMEDICA
			AND p.id > 0

		-- Se actualizan los recaudos de SALUD (BH + MPP) que tengan segmento = 0 a segmento = 1
		-- y la compania de la clave sea SALUD (BH).
		UPDATE Recaudo
		SET segmento_id = 1
		FROM Recaudo r
		INNER JOIN Participante p ON p.id = r.participante_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		WHERE p.compania_id = 5
			AND r.segmento_id = 0
			AND r.anioCierre = @anioVigente
			AND r.compania_id = 5
			AND r.sistema = 'BH'
			AND rd.ramo_id = 19 -- MPP
			AND p.id > 0

		-- Se actualizan los recaudos de SALUD (EMERMEDICA + EMERMEDICA) que tengan segmento = 0 a segmento = 1
		-- y la compania de la clave sea SALUD (EMERMEDICA).
		UPDATE Recaudo
		SET segmento_id = 1
		FROM Recaudo r
		INNER JOIN Participante p ON p.id = r.participante_id
		INNER JOIN RamoDetalle rd ON rd.id = r.ramoDetalle_id
		WHERE p.compania_id = 5
			AND r.segmento_id = 0
			AND r.anioCierre = @anioVigente
			AND r.compania_id = 5
			AND r.sistema = 'EMERMEDICA'
			AND rd.ramo_id = 21 -- EMERMEDICA
			AND p.id > 0

		-- Se actualizan los recaudos de CAPI y VIDA que tengan segmento = 0 a segmento = 1
		-- y donde la clave del recaudo pertenezca a la compania CAPI y VIDA	
		UPDATE Recaudo
		SET segmento_id = 1
		FROM Recaudo r
		INNER JOIN Participante p ON p.id = r.participante_id
		WHERE p.compania_id IN (
				2
				,3
				)
			AND r.segmento_id = 0
			AND r.anioCierre = @anioVigente
			AND r.compania_id IN (
				2
				,3
				)
			AND p.id > 0

		-- Se actualizan los negocios de CAPI y VIDA que tengan segmento = 0 a segmento = 1
		-- y donde la clave del recaudo pertenezca a la compania CAPI y VIDA	
		UPDATE Negocio
		SET segmento_id = 1
		FROM Negocio n
		INNER JOIN Participante p ON p.id = n.participante_id
		WHERE p.compania_id IN (
				2
				,3
				)
			AND n.segmento_id = 0
			AND n.anioCierre = @anioVigente
			AND n.compania_id IN (
				2
				,3
				)
			AND p.id > 0

		SET @anioVigente = @anioVigente + 1

		/*  SEGMENTACION POR JERARQUIA DE LA CLAVE. */
		UPDATE Negocio
		SET segmento_id = p.segmento_id
		FROM Negocio n
		INNER JOIN Participante p ON p.id = n.participante_id
		WHERE n.compania_id = 5
			AND n.segmento_id = 0
			AND n.anioCierre = @anioVigente

		UPDATE Recaudo
		SET segmento_id = p.segmento_id
		FROM Recaudo r
		INNER JOIN Participante p ON p.id = r.participante_id
		WHERE r.compania_id = 5
			AND r.segmento_id = 0
			AND r.anioCierre = @anioVigente
	END

	UPDATE Negocio
	SET segmento_id = 1
	WHERE compania_id = 3
		AND segmento_id = 0

	UPDATE Recaudo
	SET segmento_id = 1
	WHERE compania_id = 3
		AND segmento_id = 0

	--  Log Errores											  
	DECLARE @idActualizacion AS INT = (
		SELECT MAX(id) FROM LogIntegracion WHERE proceso = 'Segmentacion Negocios - Recaudos'
		AND estado = 1
		)

	UPDATE LogIntegracion
	SET fechaFin = GETDATE()
		,estado = 2
		,cantidad = (@registrosConSegmento - @registrosSinSegmento)
	WHERE id = @idActualizacion
END
