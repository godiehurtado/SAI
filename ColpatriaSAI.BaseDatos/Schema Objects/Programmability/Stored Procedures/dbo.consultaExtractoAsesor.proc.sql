-- =============================================
-- Author:		Andres Bravo
-- Create date: 14/05/2012
-- Description:	Procedimiento almacenado para obtener el extracto de asesor
-- =============================================
CREATE PROCEDURE [dbo].[consultaExtractoAsesor]
(
	@clave NVARCHAR(250),
	@anio INT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @anioAnterior INT = @anio - 1
	
	CREATE TABLE #ExtractoAsesor
	(
		idCompania INT NULL,
		compania NVARCHAR(250) NULL,
		idRamo INT NULL,
		ramo NVARCHAR(250) NULL,
		idMedida INT NULL,
		medida NVARCHAR(250) NULL,
		mes NVARCHAR(250) NULL,
		valorAnioAnterior FLOAT NULL,
		valorAnioActual FLOAT NULL,
		porcentajeCrecimiento FLOAT NULL
	)
	
	CREATE INDEX i1 ON #ExtractoAsesor(idCompania)
	CREATE INDEX i2 ON #ExtractoAsesor(idRamo)
	CREATE INDEX i3 ON #ExtractoAsesor(idMedida)
	
	INSERT INTO #ExtractoAsesor
	SELECT
		Unpvt1.idCompania,
		Unpvt1.compania,
		Unpvt1.idRamo,
		Unpvt1.ramo,
		Unpvt1.idMedida,
		Unpvt1.medida,
		Unpvt1.mes,
		0,
		0,
		80.2
	FROM
	(
		SELECT
			c.id AS idCompania
			, c.nombre AS Compania
			, r.id AS idRamo
			, r.nombre AS ramo
			, tm.id AS idMedida
			, tm.nombre AS medida
			, año
			, SUM(Enero) AS enero
			, SUM(Febrero) AS febrero
			, SUM(Marzo) AS marzo
			, SUM(Abril) AS abril
			, SUM(Mayo) AS mayo
			, SUM(Junio) AS junio
			, SUM(Julio) AS julio
			, SUM(Agosto) AS agosto
			, SUM(Septiembre) AS septiembre
			, SUM(Octubre) AS octubre
			, SUM(Noviembre) AS noviembre
			, SUM(Diciembre) AS diciembre
		FROM ConsolidadoMes cm
		INNER JOIN Participante p ON p.id = cm.participante_id
		INNER JOIN Compania c ON c.id = cm.compania_id
		INNER JOIN Ramo r ON r.id = cm.ramo_id
		INNER JOIN TipoMedida tm ON tm.id = cm.tipoMedida_id
		WHERE p.clave = @clave AND cm.tipoMedida_id IN (1, 2, 3, 4) AND año IN(@anioAnterior, @anio)
		GROUP BY c.id, r.id, tm.id, c.nombre, r.nombre, tm.nombre, año
	) AS p1 UNPIVOT (Valor FOR Mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS Unpvt1
	GROUP BY Unpvt1.idCompania, Unpvt1.Compania, Unpvt1.idRamo, Unpvt1.ramo, Unpvt1.idMedida, Unpvt1.medida, Unpvt1.mes
	ORDER BY compania, ramo, medida
	
	UPDATE #ExtractoAsesor
	SET valorAnioAnterior = sub3.anterior
	FROM
	#ExtractoAsesor AS ea
	INNER JOIN
	(
		SELECT
			pivots2.compania_id
			, pivots2.ramo_id
			, pivots2.tipoMedida_id
			, pivots2.mes
			, pivots2.valor AS anterior
		FROM
		(
			SELECT
				cm.compania_id
				, cm.ramo_id
				, cm.tipoMedida_id
				, año
				, SUM(Enero) AS enero
				, SUM(Febrero) AS febrero
				, SUM(Marzo) AS marzo
				, SUM(Abril) AS abril
				, SUM(Mayo) AS mayo
				, SUM(Junio) AS junio
				, SUM(Julio) AS julio
				, SUM(Agosto) AS agosto
				, SUM(Septiembre) AS septiembre
				, SUM(Octubre) AS octubre
				, SUM(Noviembre) AS noviembre
				, SUM(Diciembre) AS diciembre
			FROM ConsolidadoMes cm
			INNER JOIN Participante p ON p.id = cm.participante_id
			WHERE p.clave = @clave AND cm.tipoMedida_id IN (1, 2, 3, 4) AND año IN(@anioAnterior)
			GROUP BY cm.compania_id, cm.ramo_id, cm.tipoMedida_id, año
		) AS p1 UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS pivots2
	) AS sub3 ON ea.idCompania = sub3.compania_id AND ea.idRamo = sub3.ramo_id AND ea.idMedida = sub3.tipoMedida_id AND ea.mes COLLATE Modern_Spanish_CI_AS = sub3.mes
	
	UPDATE #ExtractoAsesor
	SET valorAnioActual = sub3.actual
	FROM
	#ExtractoAsesor AS ea
	INNER JOIN
	(
		SELECT
			pivots2.compania_id
			, pivots2.ramo_id
			, pivots2.tipoMedida_id
			, pivots2.mes
			, pivots2.valor AS actual
		FROM
		(
			SELECT
				cm.compania_id
				, cm.ramo_id
				, cm.tipoMedida_id
				, año
				, SUM(Enero) AS enero
				, SUM(Febrero) AS febrero
				, SUM(Marzo) AS marzo
				, SUM(Abril) AS abril
				, SUM(Mayo) AS mayo
				, SUM(Junio) AS junio
				, SUM(Julio) AS julio
				, SUM(Agosto) AS agosto
				, SUM(Septiembre) AS septiembre
				, SUM(Octubre) AS octubre
				, SUM(Noviembre) AS noviembre
				, SUM(Diciembre) AS diciembre
			FROM ConsolidadoMes cm
			INNER JOIN Participante p ON p.id = cm.participante_id
			WHERE p.clave = @clave AND cm.tipoMedida_id IN (1, 2, 3, 4) AND año IN(@anio)
			GROUP BY cm.compania_id, cm.ramo_id, cm.tipoMedida_id, año
		) AS p1 UNPIVOT (valor FOR mes IN (enero, febrero, marzo, abril, mayo, junio, julio, agosto, septiembre, octubre, noviembre, diciembre)) AS pivots2
	) AS sub3 ON ea.idCompania = sub3.compania_id AND ea.idRamo = sub3.ramo_id AND ea.idMedida = sub3.tipoMedida_id AND ea.mes COLLATE Modern_Spanish_CI_AS = sub3.mes
	
	SELECT
		ea.idCompania
		, ea.compania
		, ea.idRamo
		, ea.ramo
		, ea.medida
		, ea.mes
		, ea.valorAnioAnterior
		, ea.valorAnioActual
		, ea.porcentajeCrecimiento
	FROM
	(
		SELECT
			idCompania
			, compania
			, idRamo
			, ramo
			, medida
			, mes
			, valorAnioAnterior
			, valorAnioActual
			, porcentajeCrecimiento
			, CASE
				WHEN mes = 'enero' THEN 1
				WHEN mes = 'febrero' THEN 2
				WHEN mes = 'marzo' THEN 3
				WHEN mes = 'abril' THEN 4
				WHEN mes = 'mayo' THEN 5
				WHEN mes = 'junio' THEN 6
				WHEN mes = 'julio' THEN 7
				WHEN mes = 'agosto' THEN 8
				WHEN mes = 'septiembre' THEN 9
				WHEN mes = 'octubre' THEN 10
				WHEN mes = 'noviembre' THEN 11
				WHEN mes = 'diciembre' THEN 12
			END AS numeroMes
		FROM #ExtractoAsesor
	) AS ea
	ORDER BY ea.compania, ea.ramo, ea.medida, ea.numeroMes
END