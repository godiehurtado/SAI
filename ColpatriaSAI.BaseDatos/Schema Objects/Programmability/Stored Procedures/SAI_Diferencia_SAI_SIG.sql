
alter PROCEDURE SAI_Diferencia_SAI_SIG
 @anio int,@mes int 
AS
BEGIN

	SELECT n.cod_contr AS numeroNegocio
	, n.cod_jc0 AS clave
	, n.segmento_negocio_reas_sk AS segmento
	, SUM(n.imp_pyg) AS valorPrimaSIG
	INTO #tempSIGComparisson
	FROM SIG_DetalleDiario n
	WHERE MONTH(N.fec_report) = @mes
	AND YEAR(n.fec_report) = @anio
	AND n.segmento_negocio_reas_sk = 1
	GROUP BY n.cod_contr
	, n.cod_prod0
	, n.des_prod0
	, n.segmento_negocio_reas_sk
	, n.cod_jc0
	

	SELECT n.clave
	, n.numeroNegocio
	, n.compania_id
	, n.segmento_id
	, n.mesCierre
	, n.anioCierre
	, SUM(n.valorPrimaTotal) AS prima
	,n.ramoDetalle_id  as ramo
	INTO #tempComparisson
	FROM SAIvsSIGComparisson n
	WHERE n.mesCierre = @mes
	AND n.anioCierre = @anio
	GROUP BY n.clave
	, n.numeroNegocio
	, n.ramoDetalle_id
	, n.compania_id
	, n.segmento_id
	, n.mesCierre
	, n.anioCierre

-- # region sai - sig


	
		SELECT 
			n.clave as Clave
			,n.numeroNegocio as NumeroNegocio
			,cp.nombre as Compañia
			,seg.nombre As Segmento
			,n.mesCierre
			,n.anioCierre
			,n.prima
		FROM #tempComparisson n join SAI.dbo.Compania  cp
		on n.compania_id = cp.id join SAI.dbo.Segmento seg on n.segmento_id = seg.id
		WHERE NOT EXISTS
			(SELECT * 
			 FROM #tempSIGComparisson s
			 WHERE s.numeroNegocio = n.numeroNegocio)
	
	
 END
 
 
 
 