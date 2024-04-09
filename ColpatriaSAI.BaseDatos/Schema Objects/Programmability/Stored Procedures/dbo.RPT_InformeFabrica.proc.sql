-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 20/02/2012
-- Description:	Procedimiento almacenado origen para el reporte de Informe de Fábrica
-- =============================================
CREATE PROCEDURE [dbo].[RPT_InformeFabrica]
	@Periodo6 DATETIME
AS
BEGIN
	SET NOCOUNT ON;
	
	TRUNCATE TABLE InformeFabrica
    
	DECLARE
		@Periodo5 DATETIME,
		@Periodo4 DATETIME,
		@Periodo3 DATETIME,
		@Periodo2 DATETIME,
		@Periodo1 DATETIME,
		@FechaMaxima DATETIME,
		@FechaFiltro DATETIME,
		@SMLV FLOAT;
		
	SELECT
		@Periodo5 = DATEADD(MONTH, -1, @Periodo6),
		@Periodo4 = DATEADD(MONTH, -2, @Periodo6),
		@Periodo3 = DATEADD(MONTH, -3, @Periodo6),
		@Periodo2 = DATEADD(MONTH, -4, @Periodo6),
		@Periodo1 = DATEADD(MONTH, -5, @Periodo6),
		@FechaMaxima = DATEADD(YEAR, -2, @Periodo6),
		@FechaFiltro = DATEADD(s, -1, DATEADD(mm, DATEDIFF(m, 0, @Periodo6) + 1, 0));
		
	SELECT @SMLV = sm.smlv FROM SalarioMinimo sm WHERE sm.anio = YEAR(@Periodo6)
		
		INSERT INTO InformeFabrica
		(
			zona_nombre,
			localidad_id,
			localidad_nombre,
			codigoNivel,
			director_nombre,
			clave,
			asesor_nombre,
			abreviatura,
			fechaIngreso,
			fechaRevivido,
			fechaRetiro,
			ingreso1,
			ingreso2,
			ingreso3,
			ingreso4,
			ingreso5,
			ingreso6,
			antiguedadAnterior,
			antiguedad,
			nombreCanal
			)
		SELECT DISTINCT
			z.nombre AS zona_nombre
			, l.id AS localidad_id
			, l.nombre AS localidad_nombre
			, jdp.codigoNivel
			, jdp.nombre AS director_nombre
			, p.clave
			, LTRIM(RTRIM(p.nombre)) + SPACE(1) + LTRIM(RTRIM(p.apellidos)) AS asesor_nombre
			, ep.abreviatura
			, p.fechaIngreso
			, CONVERT(DATETIME, 0) AS fechaRevivido
			, p.fechaRetiro
			, ISNULL((SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = p.id AND YEAR(i.Periodo) = YEAR(@Periodo1) AND MONTH(i.Periodo) = MONTH(@Periodo1)),0) AS ingreso1
			, ISNULL((SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = p.id AND YEAR(i.Periodo) = YEAR(@Periodo2) AND MONTH(i.Periodo) = MONTH(@Periodo2)),0) AS ingreso2
			, ISNULL((SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = p.id AND YEAR(i.Periodo) = YEAR(@Periodo3) AND MONTH(i.Periodo) = MONTH(@Periodo3)),0) AS ingreso3
			, ISNULL((SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = p.id AND YEAR(i.Periodo) = YEAR(@Periodo4) AND MONTH(i.Periodo) = MONTH(@Periodo4)),0) AS ingreso4
			, ISNULL((SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = p.id AND YEAR(i.Periodo) = YEAR(@Periodo5) AND MONTH(i.Periodo) = MONTH(@Periodo5)),0) AS ingreso5
			, ISNULL((SELECT SUM(i.TotalComisiones) FROM Ingreso i WHERE i.participante_id = p.id AND YEAR(i.Periodo) = YEAR(@Periodo6) AND MONTH(i.Periodo) = MONTH(@Periodo6)),0) AS ingreso6
			, dbo.getAntiguedad(p.fechaIngreso, CONVERT(DATETIME, CAST(YEAR(@Periodo6) - 2 AS VARCHAR) + '-12-31')) AS antiguedadAnterior
			, dbo.getAntiguedad(p.fechaIngreso, CONVERT(DATETIME, CAST(YEAR(@Periodo6) - 1 AS VARCHAR) + '-12-31')) AS antiguedad
			, c.nombre AS nombreCanal
		FROM
			Participante p
			INNER JOIN Canal c ON c.id = p.canal_id
			LEFT JOIN Ingreso ing ON ing.participante_id = p.id
			INNER JOIN EstadoParticipante ep ON ep.id = p.estadoParticipante_id
			LEFT JOIN JerarquiaDetalle jd ON jd.participante_id = p.id
			LEFT JOIN JerarquiaDetalle jdp ON jdp.id = jd.padre_id and jdp.jerarquia_id = 1
			LEFT JOIN Zona z ON z.id = jdp.zona_id
			LEFT JOIN Localidad l ON l.id = jdp.localidad_id
		WHERE p.nivel_id = 1
			AND ep.id IN (1,3,4)
			AND p.fechaIngreso <= @FechaFiltro
		
	UPDATE InformeFabrica SET
		grupoAnterior = dbo.getGrupo(inf.antiguedadAnterior),
		grupo = dbo.getGrupo(inf.antiguedad),
		mesesMedidos = dbo.getMesesMedidos(dbo.getAntiguedad(inf.fechaIngreso, @Periodo6))
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id

	UPDATE InformeFabrica SET
		minimoExigidoAnterior = il.valor
	FROM InformeFabrica INNER JOIN IngresoLocalidad il ON il.grupo = InformeFabrica.grupoAnterior AND il.localidad_id = InformeFabrica.localidad_id AND il.año = YEAR(@Periodo6)-1
	
	UPDATE InformeFabrica SET
		minimoExigido = il.valor
	FROM InformeFabrica INNER JOIN IngresoLocalidad il ON il.grupo = InformeFabrica.grupo AND il.localidad_id = InformeFabrica.localidad_id AND il.año = YEAR(@Periodo6)
	
	UPDATE InformeFabrica SET
		ingresoSegunMes = CASE
			WHEN inf.mesesMedidos = 1 THEN -1--"EXENTOS"
			WHEN inf.mesesMedidos = 2 THEN inf.ingreso6
			WHEN inf.mesesMedidos = 3  THEN inf.ingreso6 + inf.ingreso5
			WHEN inf.mesesMedidos >= 4 AND inf.mesesMedidos < 7 THEN inf.ingreso6 + inf.ingreso5 + inf.ingreso4
			WHEN inf.mesesMedidos >= 7 THEN inf.ingreso6 + inf.ingreso5 + inf.ingreso4 + inf.ingreso3 + inf.ingreso2 + inf.ingreso1
		END,
		promedioIngreso = (inf.ingreso6 + inf.ingreso5 + inf.ingreso4 + inf.ingreso3 + inf.ingreso2 + inf.ingreso1)/6,
		ingresosExigidos = CASE
			WHEN inf.mesesMedidos = 1 THEN -1--"EXENTOS"
			WHEN inf.mesesMedidos = 2 THEN inf.minimoExigido
			WHEN inf.mesesMedidos = 3 THEN inf.minimoExigido
				+ dbo.getMinimoExigidoxAnio(@Periodo6, @Periodo5, inf.minimoExigido, inf.minimoExigidoAnterior)
			WHEN inf.mesesMedidos >= 4 AND inf.mesesMedidos < 7 THEN inf.minimoExigido
				+ dbo.getMinimoExigidoxAnio(@Periodo6, @Periodo5, inf.minimoExigido, inf.minimoExigidoAnterior)
				+ dbo.getMinimoExigidoxAnio(@Periodo6, @Periodo4, inf.minimoExigido, inf.minimoExigidoAnterior)
			WHEN inf.mesesMedidos >= 7 THEN inf.minimoExigido
				+ dbo.getMinimoExigidoxAnio(@Periodo6, @Periodo5, inf.minimoExigido, inf.minimoExigidoAnterior)
				+ dbo.getMinimoExigidoxAnio(@Periodo6, @Periodo4, inf.minimoExigido, inf.minimoExigidoAnterior)
				+ dbo.getMinimoExigidoxAnio(@Periodo6, @Periodo3, inf.minimoExigido, inf.minimoExigidoAnterior)
				+ dbo.getMinimoExigidoxAnio(@Periodo6, @Periodo2, inf.minimoExigido, inf.minimoExigidoAnterior)
				+ dbo.getMinimoExigidoxAnio(@Periodo6, @Periodo1, inf.minimoExigido, inf.minimoExigidoAnterior)
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id

	UPDATE InformeFabrica SET
		porceCumplimientoIng = CASE
			WHEN inf.ingresoSegunMes = -1 THEN -1--"EXENTOS"
			ELSE (inf.ingresoSegunMes / inf.ingresosExigidos) * 100
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		cumplenIngresos = CASE
			WHEN inf.porceCumplimientoIng = -1 THEN 'EXENTOS'
			WHEN inf.porceCumplimientoIng > 100 THEN 'CUMPLE'
			ELSE 'NO CUMPLE'
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		porceCumplimientoCol = CASE
			WHEN inf.porceCumplimientoIng = -1 THEN 0
			ELSE (inf.ingresoSegunMes / (1.5 * @SMLV * 6)) * 100
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		ingresoSum = 
		CASE WHEN inf.ingreso1 >= (@SMLV * 1.5) THEN 1 ELSE 0 END +
		CASE WHEN inf.ingreso2 >= (@SMLV * 1.5) THEN 1 ELSE 0 END +
		CASE WHEN inf.ingreso3 >= (@SMLV * 1.5) THEN 1 ELSE 0 END +
		CASE WHEN inf.ingreso4 >= (@SMLV * 1.5) THEN 1 ELSE 0 END +
		CASE WHEN inf.ingreso5 >= (@SMLV * 1.5) THEN 1 ELSE 0 END +
		CASE WHEN inf.ingreso6 >= (@SMLV * 1.5) THEN 1 ELSE 0 END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		coltitulos = CASE
			WHEN ((inf.porceCumplimientoCol >= 100) AND (inf.ingresoSum = 6) AND (inf.fechaIngreso <= @FechaMaxima)) THEN 'COLTITULOS'
			ELSE 'NO'
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		pos = CASE
			WHEN ((inf.mesesMedidos >= 6) AND (inf.porceCumplimientoIng >= 140)) THEN 'SI'
			ELSE 'NO'
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		mesesMedidosProy = CASE
			WHEN inf.mesesMedidos > 7 THEN inf.mesesMedidos
			ELSE inf.mesesMedidos + 1
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		ingresoSegunMesProy = CASE
			WHEN inf.mesesMedidosProy = 1 THEN -1--"EXENTOS"
			WHEN inf.mesesMedidosProy = 2 THEN inf.ingreso6
			WHEN inf.mesesMedidosProy = 3  THEN inf.ingreso6 + inf.ingreso5
			WHEN inf.mesesMedidosProy >= 4 AND inf.mesesMedidos < 7 THEN inf.ingreso6 + inf.ingreso5 + inf.ingreso4
			WHEN inf.mesesMedidosProy >= 7 THEN inf.ingreso6 + inf.ingreso5 + inf.ingreso4 + inf.ingreso3 + inf.ingreso2
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		proyIngresosExigidos = CASE
			WHEN inf.mesesMedidosProy = 1 THEN -1--"EXENTOS"
			WHEN inf.mesesMedidosProy = 2 THEN inf.minimoExigido
			WHEN inf.mesesMedidosProy = 3  THEN (inf.minimoExigido * 2)
			WHEN inf.mesesMedidosProy >= 4 AND inf.mesesMedidos < 7 THEN (inf.minimoExigido * 3)
			WHEN inf.mesesMedidosProy >= 7 THEN (inf.minimoExigido * 6)
		END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	UPDATE InformeFabrica SET
		proyIngresosProxMes = CASE
			WHEN ((inf.proyIngresosExigidos - inf.ingresoSegunMesProy) >= 0) THEN (inf.proyIngresosExigidos - inf.ingresoSegunMesProy)
			ELSE 0
	END
	FROM InformeFabrica INNER JOIN InformeFabrica inf ON inf.id = InformeFabrica.id
	
	SELECT
		zona_nombre
		, localidad_nombre
		, codigoNivel
		, director_nombre
		, clave
		, asesor_nombre
		, nombreCanal
		, ingreso1
		, ingreso2
		, ingreso3
		, ingreso4
		, ingreso5
		, ingreso6
		, fechaIngreso
		, minimoExigidoAnterior
		, minimoExigido
		, ingresoSegunMes
		, promedioIngreso
		, ingresosExigidos
		, porceCumplimientoIng
		, cumplenIngresos
		, porceCumplimientoCol
		, coltitulos
		, pos
		, mesesMedidosProy
		, ingresoSegunMesProy
		, proyIngresosExigidos
		, proyIngresosProxMes
	FROM InformeFabrica
END