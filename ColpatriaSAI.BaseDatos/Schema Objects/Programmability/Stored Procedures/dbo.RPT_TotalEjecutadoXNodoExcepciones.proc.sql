-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 29/02/2012
-- Description:	Procedimiento almacenado de origen para el reporte de Total de colquines
-- =============================================
CREATE PROCEDURE [dbo].[RPT_TotalEjecutadoXNodoExcepciones]
	-- Add the parameters for the stored procedure here
	@codigo_nivel as varchar(80),
	@anio_param as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;
	
	DECLARE @jerarquiaDetalle_id int = 0
	DECLARE @anio as int = @anio_param

	-- TRAEMOS EL ID DEL NODO
	SELECT @jerarquiaDetalle_id = (SELECT id FROM jerarquiaDetalle WHERE codigoNivel = @codigo_nivel) 	

	-- TRAEMOS EL CONSOLIDADO MES DE LOS NODOS HIJOS DEL NODO
	-- DROP TABLE #ConsolidadoMes
	CREATE TABLE #ConsolidadoMes(
		destino_id int NOT NULL,
	    participante_id int NOT NULL,
	    codigoNivel varchar(250) NULL,
	    nombre varchar(250) NULL,
		compania_id int NOT NULL,
		ramo_id int NULL,
		producto_id int NULL,
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
		año int
	)
	
    Create Index i1 ON #ConsolidadoMes(compania_id)
	Create Index i2 ON #ConsolidadoMes(ramo_id)
	Create Index i3 ON #ConsolidadoMes(producto_id)
	Create Index i4 ON #ConsolidadoMes(segmento_id)
	Create Index i5 ON #ConsolidadoMes(tipoMedida_id)
	Create Index i7 ON #ConsolidadoMes(lineaNegocio_id)
	Create Index i8 ON #ConsolidadoMes(amparo_id)
	Create Index i9 ON #ConsolidadoMes(modalidadPago_id)
	Create Index i10 ON #ConsolidadoMes(año)	
	Create Index i11 ON #ConsolidadoMes(participante_id)	
	Create Index i12 ON #ConsolidadoMes(destino_id)

	INSERT INTO #ConsolidadoMes (destino_id, participante_id, /*codigoNivel, nombre,*/ compania_id, ramo_id, producto_id, lineaNegocio_id, amparo_id, modalidadPago_id, segmento_id, tipoMedida_id, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Septiembre, Octubre, Noviembre, Diciembre, año)
	SELECT
		sub2.excepcionJerarquiaDestino_id,
		cm.participante_id,
		--jd.codigoNivel as CodigoNivelHijoExcepcion,
		--jd.nombre as NodoHijoExcepcion,		
		cm.compania_id,
		cm.ramo_id,
		cm.producto_id,
		cm.lineanegocio_id,
		cm.amparo_id,
		cm.modalidadpago_id,
		cm.segmento_id,		
		cm.tipoMedida_id,
		SUM(cm.Enero) as Enero,
		SUM(cm.Febrero) as Febrero,
		SUM(cm.Marzo) as Marzo,
		SUM(cm.Abril) as Abril,
		SUM(cm.Mayo) as Mayo,
		SUM(cm.Junio) as Junio,
		SUM(cm.Julio) as Julio,
		SUM(cm.Agosto) as Agosto,
		SUM(cm.Septiembre) as Septiembre,
		SUM(cm.Octubre) as Octubre,
		SUM(cm.Noviembre) as Noviembre,
		SUM(cm.Diciembre) as Diciembre,
		cm.año
	FROM 
	(
		SELECT excepcionJerarquiaOrigen_id, excepcionJerarquiaDestino_id
		FROM excepcionJerarquiaDetalle
		WHERE excepcionJerarquiaOrigen_id = @jerarquiaDetalle_id
		GROUP BY excepcionJerarquiaOrigen_id,excepcionJerarquiaDestino_id
	) as sub2			
	CROSS APPLY ObtenerHijosNodo(sub2.excepcionJerarquiaDestino_id) as hijos
	INNER JOIN ConsolidadoMes AS cm ON hijos.participante_id = cm.participante_id	
	--INNER JOIN jerarquiaDetalle as jd ON hijos.participante_id = jd.participante_id
	WHERE cm.año = @anio
	GROUP BY 
		sub2.excepcionJerarquiaDestino_id,	
		cm.participante_id,
		--jd.codigoNivel,
		--jd.nombre,
		cm.compania_id,
		cm.ramo_id,
		cm.producto_id,
		cm.lineanegocio_id,
		cm.tipoMedida_id,
		cm.segmento_id,
		cm.amparo_id,
		cm.modalidadpago_id,
		cm.año 

	SELECT		
		jd1.codigoNivel as CodigoNivelExcepcion,
		cm.codigoNivel as CodigoNivelHijoExcepcion,
		cm.nombre as NodoHijoExcepcion,
		tm.nombre as TipoMedida,
		c.nombre as Compania,
		r.nombre as Ramo,
		p.nombre as Producto,
		ln.nombre as LineaNegocio,		
		s.nombre as Segmento,
		a.nombre as Amparo,
		mp.nombre as ModalidadPago,
		cm.Enero,
		cm.Febrero,
		cm.Marzo,
		cm.Abril,
		cm.Mayo,
		cm.Junio,
		cm.Julio,
		cm.Agosto,
		cm.Septiembre,
		cm.Octubre,
		cm.Noviembre,
		cm.Diciembre		
	FROM
		#ConsolidadoMes as cm
		INNER JOIN jerarquiaDetalle as jd1 ON cm.destino_id = jd1.id
		INNER JOIN compania as c ON cm.compania_id = c.id
		INNER JOIN ramo as r ON cm.ramo_id = r.id
		INNER JOIN producto as p ON cm.producto_id = p.id
		INNER JOIN lineaNegocio as ln ON cm.lineaNegocio_id = ln.id
		INNER JOIN tipoMedida as tm ON cm.tipoMedida_id = tm.id
		INNER JOIN segmento as s ON cm.segmento_id = s.id
		INNER JOIN amparo as a ON cm.amparo_id = a.id
		INNER JOIN modalidadPago as mp ON cm.modalidadpago_id = mp.id
	WHERE tm.esMeta = 1		
	ORDER BY jd1.codigoNivel,cm.codigoNivel,c.nombre,r.nombre,p.nombre,ln.nombre,tm.nombre		

	DROP TABLE #ConsolidadoMes
		
END