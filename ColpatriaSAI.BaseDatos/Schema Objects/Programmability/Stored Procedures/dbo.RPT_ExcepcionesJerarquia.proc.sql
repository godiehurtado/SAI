-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 01/02/2012
-- Description:	Procedimiento de consulta de todas las excepciones existentes para una Jerarquia dada
-- =============================================
CREATE PROCEDURE [dbo].[RPT_ExcepcionesJerarquia]
	@jerarquia_id INT
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		jd_o.nombre AS Origen,
		jd_d.nombre AS Destino,
		CASE
			WHEN c.nombre = '' THEN 'Todas'
			ELSE ISNULL(c.nombre, 'Todas')
		END AS Compania,
		CASE
			WHEN r.nombre = '' THEN 'Todos'
			ELSE ISNULL(r.nombre, 'Todos')
		END AS Ramo,
		CASE
			WHEN p.nombre = '' THEN 'Todos'
			ELSE ISNULL(p.nombre, 'Todos')
		END AS Producto
	FROM
		ExcepcionJerarquiaDetalle ejd INNER JOIN JerarquiaDetalle jd_o ON jd_o.id = ejd.excepcionJerarquiaOrigen_id
		INNER JOIN JerarquiaDetalle jd_d ON jd_d.id = ejd.excepcionJerarquiaDestino_id
		INNER JOIN Jerarquia j ON j.id = jd_o.jerarquia_id AND j.id = jd_d.jerarquia_id
		INNER JOIN Compania c ON c.id = ejd.compania_id
		INNER JOIN Ramo r ON r.id = ejd.ramo_id
		INNER JOIN Producto p ON p.id = ejd.producto_id
	WHERE j.id = @jerarquia_id;
END
