-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 23/02/2012
-- Description:	Consulta que sirve como origen de datos al reporte de contratación
-- =============================================
CREATE PROCEDURE [dbo].[RPT_AjustesManualEjecucion]
	@anio INT,
	@mes INT = null
AS
BEGIN
	SET NOCOUNT ON;

	SELECT CAST(Year(ej.periodo) as varchar) + '-' + CAST(Month(ej.periodo) as varchar) as periodo, ej.valor, ej.descripcion, ej.fechaAjuste, ej.usuario, m.nombre, jd.codigoNivel
	FROM ejecuciondetalle as ej
	INNER JOIN meta as m ON m.id = ej.meta_id
	INNER JOIN jerarquiaDetalle as jd ON jd.id = ej.nodo_id
	WHERE year(ej.periodo) = @anio and month(ej.periodo) = Coalesce(@mes, month(ej.periodo)) and usuario is not null
	ORDER BY jd.codigoNivel
END