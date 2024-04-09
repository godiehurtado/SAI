-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 17/02/2012
-- Description:	Procedimiento almacenado de origen para el reporte de pagos GP
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PagosGP]
(
	@FechaInicio DATETIME,
	@FechaFin DATETIME
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		pf.id AS detallePagos_id
		, c.nombre AS compania_nombre
		, p.clave
		, td.nombre AS TipoDocumento_nombre
		, p.documento
		, p.totalParticipacion
		, p.descripcion
		, lf.fechaLiquidacion AS fechaLiquidacion
		, lf.periodoLiquidacionIni AS periodoLiquidacionIni
		, lf.periodoLiquidacionFin AS periodoLiquidacionFin
		, p.fechaPago
	FROM Pago p
		INNER JOIN DetallePagosFranquicia dpf ON dpf.id = p.detallePagosFranquicia_id
		INNER JOIN PagoFranquicia pf ON pf.id = dpf.pagoFranquicia_id
		INNER JOIN LiquidacionFranquicia lf ON lf.id = pf.liquidacionFranquicia_id
		INNER JOIN TipoDocumento td ON td.id = p.tipoDocumento_id
		INNER JOIN Compania c ON c.id = p.compania_id
	WHERE
		p.fechaPago BETWEEN @FechaInicio AND @FechaFin
	UNION
	SELECT
		lr.id AS detallePagos_id
		, c.nombre AS compania_nombre
		, p.clave
		, td.nombre AS TipoDocumento_nombre
		, p.documento
		, p.totalParticipacion
		, p.descripcion
		, p.fechaPago
		, lr.fecha_liquidacion AS fechaLiquidacion
		, lr.fecha_final AS periodoLiquidacionIni
		, lr.fecha_final AS periodoLiquidacionFin
	FROM Pago p
		INNER JOIN DetallePagosRegla dpr ON dpr.id = p.detallePagosRegla_id
		INNER JOIN LiquidacionRegla lr ON lr.id = dpr.liquidacionRegla_id
		INNER JOIN TipoDocumento td ON td.id = p.tipoDocumento_id
		INNER JOIN Compania c ON c.id = p.compania_id
	WHERE
		p.fechaPago BETWEEN @FechaInicio AND @FechaFin
END
