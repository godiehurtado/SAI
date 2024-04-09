
ALTER PROCEDURE SAI_Diferencia_SIG_SAI
  @anio int, @mes int
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

-- # region SIG - SAI
			
		SELECT 
			n.numeroNegocio  as NumeroNegocio
			,n.clave as Clave
			,seg.nombre as Segmento
			,n.valorPrimaSIG
		FROM #tempSIGComparisson n JOIN SAI.dbo.Segmento seg
		ON n.segmento = seg.id 
		WHERE NOT EXISTS
		(SELECT * FROM #tempComparisson s WHERE n.numeroNegocio = s.numeroNegocio)
	
 END
 
 
 
 