-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 29/02/2012
-- Description:	Procedimiento almacenado de origen para el reporte de Total de colquines
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ComisionesxNodo]
	-- Add the parameters for the stored procedure here
	@codigo_nivel as varchar(80),
	@anio_param as int,
	@mes_param as int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	
	SET NOCOUNT ON;
	
	DECLARE @jerarquiaDetalle_id int = 0
	DECLARE @anio as int = @anio_param
	DECLARE @mes as int = @mes_param

	-- TRAEMOS EL ID DEL NODO
	SELECT @jerarquiaDetalle_id = (SELECT id FROM jerarquiaDetalle WHERE codigoNivel = @codigo_nivel) 	

	-- TRAEMOS LAS COMISIONES DE LOS NODOS HIJOS DEL NODO
	-- DROP TABLE #Comisiones
	CREATE TABLE #Comisiones(
	    participante_id int NULL,
		compania_id int NULL,
		ramo_id int NULL,
		lineaNegocio_id int NULL,
		concepto int NULL,
		clave nvarchar(100) NULL,
		segmento_id int NULL,
		año int NULL,
		mes int NULL,
		valorConcepto nvarchar(100) NULL,
		numeroNegocio nvarchar(200) NULL,
		indicadorPago nvarchar(100) NULL,
	)
	
    Create Index i1 ON #Comisiones(compania_id)
	Create Index i2 ON #Comisiones(ramo_id)
	Create Index i3 ON #Comisiones(segmento_id)
	Create Index i4 ON #Comisiones(lineaNegocio_id)
	Create Index i5 ON #Comisiones(participante_id)	

	INSERT INTO #Comisiones (participante_id,compania_id, ramo_id, lineaNegocio_id, concepto, clave, segmento_id, año, mes, valorConcepto, numeroNegocio, indicadorPago)
	SELECT 
		sub1.participante_id,
		cm.companiaMovimiento_id,
		cm.ramo_id,
		cm.lineanegocio_id,
		cm.concepto,
		cm.clave,
		cm.segmento_id,		
		cm.año,
		cm.mes,
		cm.valorConcepto,
		cm.numeroNegocio,
		cm.indicadorPago
	FROM 
	(
		SELECT participante_id
		FROM Obtenerhijosnodo(@jerarquiaDetalle_id)	
	) as sub1
	INNER JOIN comision as cm ON sub1.participante_id = cm.participante_id	
	WHERE cm.año = @anio and cm.mes = @mes
	
	SELECT		
		jd.codigoNivel,
		jd.nombre as Nodo,
		s.nombre as Segmento,	
		c.nombre as Compania,
		r.nombre as Ramo,
		ln.nombre as LineaNegocio,				
		cm.año,
		cm.mes,
		cm.valorConcepto,
		cm.numeroNegocio,
		cm.indicadorPago				
	FROM
		#Comisiones as cm
		INNER JOIN jerarquiaDetalle as jd ON cm.participante_id = jd.participante_id
		INNER JOIN compania as c ON cm.compania_id = c.id
		INNER JOIN ramo as r ON cm.ramo_id = r.id
		INNER JOIN lineaNegocio as ln ON cm.lineaNegocio_id = ln.id
		INNER JOIN segmento as s ON cm.segmento_id = s.id
	ORDER BY jd.codigoNivel,c.nombre,r.nombre,ln.nombre
		
END
