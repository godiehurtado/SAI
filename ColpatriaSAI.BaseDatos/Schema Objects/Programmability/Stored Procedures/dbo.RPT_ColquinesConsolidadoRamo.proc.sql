-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 18/04/2012
-- Description:	Consulta que sirve como origen de datos al reporte de Colquines Consolidados por Ramo
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ColquinesConsolidadoRamo]
(
	@anio INT
	,@plazo_id INT = 0
	,@lineaNegocio_id INT = 0
	,@compania_id INT = 0
	,@canal_id INT = 0
)
AS
BEGIN
	SET NOCOUNT ON;

	TRUNCATE TABLE ReporteColquines;

	INSERT INTO ReporteColquines (
		zona
		,localidadProduccion
		,localidadOrigen
		,director
		,clave
		,canal
		,participanteNombre
		,categoria
		,tipoMedida_id
		,tipoMedida
		,segmento
		,companiaNombre
		,lineaNegocioNombre
		,ramoNombre
		,productoNombre
		,plazoNombre
		,amparo
		,modalidadPago
		,anio
		,enero
		,febrero
		,marzo
		,abril
		,mayo
		,junio
		,julio
		,agosto
		,septiembre
		,octubre
		,noviembre
		,diciembre
	)
	SELECT z.nombre
		,l1.nombre
		,l2.nombre
		,jPadre.nombre
		,RTRIM(LTRIM(pa.clave))
		,cl.nombre
		,RTRIM(LTRIM(pa.nombre)) + ' ' + RTRIM(LTRIM(pa.apellidos))
		,ca.nombre
		,tm.id
		,tm.nombre
		,s.nombre
		,c.nombre
		,ln.nombre
		,r.nombre
		,pr.nombre
		,pl.nombre
		,a.nombre
		,mp.nombre
		,cm.año
		,SUM(cm.Enero)
		,SUM(cm.Febrero)
		,SUM(cm.Marzo)
		,SUM(cm.Abril)
		,SUM(cm.Mayo)
		,SUM(cm.Junio)
		,SUM(cm.Julio)
		,SUM(cm.Agosto)
		,SUM(cm.Septiembre)
		,SUM(cm.Octubre)
		,SUM(cm.Noviembre)
		,SUM(cm.Diciembre)
	FROM ConsolidadoMes cm
	INNER JOIN TipoMedida tm ON tm.id = cm.tipoMedida_id
	INNER JOIN Participante pa ON pa.id = cm.participante_id
	INNER JOIN Canal cl ON cl.id = pa.canal_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = pa.id
	LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
	INNER JOIN Zona z ON z.id = cm.zona_id
	INNER JOIN Categoria ca ON ca.id = pa.categoria_id
	LEFT JOIN Localidad l1 ON l1.id = cm.localidad_id
	LEFT JOIN Localidad l2 ON l2.id = pa.localidad_id
	INNER JOIN Segmento s ON s.id = cm.segmento_id
	INNER JOIN Compania c ON c.id = cm.compania_id
	INNER JOIN Ramo r ON r.id = cm.ramo_id AND r.compania_id = cm.compania_id
	INNER JOIN Producto pr ON pr.id = cm.producto_id
	INNER JOIN Plazo pl ON pl.id = cm.plazo_id
	INNER JOIN LineaNegocio ln ON ln.id = cm.lineaNegocio_id
	INNER JOIN Amparo a ON a.id = cm.amparo_id
	INNER JOIN ModalidadPago mp ON mp.id = cm.modalidadPago_id
	WHERE cm.tipoMedida_id IN (2, 22, 23, 25, 26)
		AND cm.año = (@anio - 1)
		AND (@plazo_id = 0 OR pl.id = @plazo_id)
		AND (@lineaNegocio_id = 0 OR ln.id = @lineaNegocio_id)
		AND (@compania_id = 0 OR c.id = @compania_id)
		AND (@canal_id = 0 OR cl.id = @canal_id)
	GROUP BY z.nombre
		,l1.nombre
		,l2.nombre
		,jPadre.nombre
		,pa.clave
		,cl.nombre
		,pa.nombre
		,pa.apellidos
		,ca.nombre
		,tm.id
		,tm.nombre
		,s.nombre
		,c.nombre
		,ln.nombre
		,r.nombre
		,pr.nombre
		,pl.nombre
		,a.nombre
		,mp.nombre
		,cm.año
	ORDER BY tm.id
		,c.nombre
		,r.nombre
		,pr.nombre

	INSERT INTO ReporteColquines (
		zona
		,localidadProduccion
		,localidadOrigen
		,director
		,clave
		,canal
		,participanteNombre
		,categoria
		,tipoMedida_id
		,tipoMedida
		,segmento
		,companiaNombre
		,lineaNegocioNombre
		,ramoNombre
		,productoNombre
		,plazoNombre
		,amparo
		,modalidadPago
		,anio
		,enero
		,febrero
		,marzo
		,abril
		,mayo
		,junio
		,julio
		,agosto
		,septiembre
		,octubre
		,noviembre
		,diciembre
	)
	SELECT z.nombre
		,l1.nombre
		,l2.nombre
		,jPadre.nombre
		,RTRIM(LTRIM(pa.clave))
		,cl.nombre
		,RTRIM(LTRIM(pa.nombre)) + ' ' + RTRIM(LTRIM(pa.apellidos))
		,ca.nombre
		,tm.id
		,tm.nombre
		,s.nombre
		,c.nombre
		,ln.nombre
		,r.nombre
		,pr.nombre
		,pl.nombre
		,a.nombre
		,mp.nombre
		,cm.año
		,SUM(cm.Enero)
		,SUM(cm.Febrero)
		,SUM(cm.Marzo)
		,SUM(cm.Abril)
		,SUM(cm.Mayo)
		,SUM(cm.Junio)
		,SUM(cm.Julio)
		,SUM(cm.Agosto)
		,SUM(cm.Septiembre)
		,SUM(cm.Octubre)
		,SUM(cm.Noviembre)
		,SUM(cm.Diciembre)
	FROM ConsolidadoMes cm
	INNER JOIN TipoMedida tm ON tm.id = cm.tipoMedida_id
	INNER JOIN Participante pa ON pa.id = cm.participante_id
	INNER JOIN Canal cl ON cl.id = pa.canal_id
	LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = pa.id
	LEFT JOIN JerarquiaDetalle jPadre ON jd.padre_id = jPadre.id
	INNER JOIN Zona z ON z.id = cm.zona_id
	INNER JOIN Categoria ca ON ca.id = pa.categoria_id
	LEFT JOIN Localidad l1 ON l1.id = cm.localidad_id
	LEFT JOIN Localidad l2 ON l2.id = pa.localidad_id
	INNER JOIN Segmento s ON s.id = cm.segmento_id
	INNER JOIN Compania c ON c.id = cm.compania_id
	INNER JOIN Ramo r ON r.id = cm.ramo_id AND r.compania_id = cm.compania_id
	INNER JOIN Producto pr ON pr.id = cm.producto_id
	INNER JOIN Plazo pl ON pl.id = cm.plazo_id
	INNER JOIN LineaNegocio ln ON ln.id = cm.lineaNegocio_id
	INNER JOIN Amparo a ON a.id = cm.amparo_id
	INNER JOIN ModalidadPago mp ON mp.id = cm.modalidadPago_id
	WHERE cm.tipoMedida_id IN (2, 22, 23, 25, 26)
		AND cm.año = @anio
		AND (@plazo_id = 0 OR pl.id = @plazo_id)
		AND (@lineaNegocio_id = 0 OR ln.id = @lineaNegocio_id)
		AND (@compania_id = 0 OR c.id = @compania_id)
		AND (@canal_id = 0 OR cl.id = @canal_id)
	GROUP BY z.nombre
		,l1.nombre
		,l2.nombre
		,jPadre.nombre
		,pa.clave
		,cl.nombre
		,pa.nombre
		,pa.apellidos
		,ca.nombre
		,tm.id
		,tm.nombre
		,s.nombre
		,c.nombre
		,ln.nombre
		,r.nombre
		,pr.nombre
		,pl.nombre
		,a.nombre
		,mp.nombre
		,cm.año
	ORDER BY tm.id
		,c.nombre
		,r.nombre
		,pr.nombre

	UPDATE ReporteColquines
	SET totalAnio = inf.enero + inf.febrero + inf.marzo + inf.abril + inf.mayo + inf.junio + inf.julio + inf.agosto + inf.septiembre + inf.octubre + inf.noviembre + inf.diciembre
	FROM ReporteColquines
	INNER JOIN ReporteColquines inf ON inf.id = ReporteColquines.id
	WHERE ReporteColquines.tipoMedida_id IN (2, 26)
	
	UPDATE ReporteColquines
	SET totalAnio =
		CASE
			WHEN MONTH(GETDATE()) = 1 THEN inf.enero
			WHEN MONTH(GETDATE()) = 2 THEN inf.febrero
			WHEN MONTH(GETDATE()) = 3 THEN inf.marzo
			WHEN MONTH(GETDATE()) = 4 THEN inf.abril
			WHEN MONTH(GETDATE()) = 5 THEN inf.mayo
			WHEN MONTH(GETDATE()) = 6 THEN inf.junio
			WHEN MONTH(GETDATE()) = 7 THEN inf.julio
			WHEN MONTH(GETDATE()) = 8 THEN inf.agosto
			WHEN MONTH(GETDATE()) = 9 THEN inf.septiembre
			WHEN MONTH(GETDATE()) = 10 THEN inf.octubre
			WHEN MONTH(GETDATE()) = 11 THEN inf.noviembre
			WHEN MONTH(GETDATE()) = 12 THEN inf.diciembre
		END
	FROM ReporteColquines
	INNER JOIN ReporteColquines inf ON inf.id = ReporteColquines.id
	WHERE ReporteColquines.tipoMedida_id NOT IN (2, 26)

	SELECT zona
		,localidadProduccion
		,localidadOrigen
		,director
		,clave
		,canal
		,participanteNombre
		,categoria
		,tipoMedida
		,segmento
		,companiaNombre
		,lineaNegocioNombre
		,ramoNombre
		,productoNombre
		,plazoNombre
		,amparo
		,modalidadPago
		,anio
		,enero
		,febrero
		,marzo
		,abril
		,mayo
		,junio
		,julio
		,agosto
		,septiembre
		,octubre
		,noviembre
		,diciembre
		,totalAnio
	FROM ReporteColquines
	ORDER BY id
END