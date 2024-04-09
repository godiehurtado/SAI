-- =============================================
-- Author:		<Juan Fernando Rojas>
-- Create date: <2012/11/12>
-- Description:	<Informe de productividad por ejecutivo, compania, ramo, producto>
-- =============================================
CREATE PROCEDURE [dbo].[RPT_InformeProductividad] @compania_id INT
	,@ramo_id INT
	,@producto_id INT
	,@jerarquiaDetalle_id AS VARCHAR(100) = NULL
	,@mes AS INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @anioVigente AS INT = (SELECT valor FROM ParametrosApp WHERE id = 3)

	-- Insert statements for procedure here
	SELECT jd.nombre AS ejecutivo
		,c.nombre AS compania
		,r.nombre AS ramo
		,p.nombre AS producto
		,l.nombre AS localidad
		,z.nombre AS zona
		,ip.cantidadNegociosAA
		,ip.asesoresAA
		,ip.productividadMensualAA
		,ip.primaPromedioAA
		,ip.cantidadNegociosAV
		,ip.asesoresAV
		,ip.productividadMensualAV
		,ip.primaPromedioAV
		,ip.asesoresVAA
		,ip.asesoresVAV
		,ip.primasAA
		,ip.primasAV
		,(
			CASE ip.mes
				WHEN 1
					THEN 'Enero'
				WHEN 2
					THEN 'Febrero'
				WHEN 3
					THEN 'Marzo'
				WHEN 4
					THEN 'Abril'
				WHEN 5
					THEN 'Mayo'
				WHEN 6
					THEN 'Junio'
				WHEN 7
					THEN 'Julio'
				WHEN 8
					THEN 'Agosto'
				WHEN 9
					THEN 'Septiembre'
				WHEN 10
					THEN 'Octubre'
				WHEN 11
					THEN 'Noviembre'
				WHEN 12
					THEN 'Diciembre'
				END
			) AS mes
		,@anioVigente AS anio		
	FROM InformeProductividad ip
	INNER JOIN Compania c ON c.id = ip.compania_id
	INNER JOIN Ramo r ON r.id = ip.ramo_id
	INNER JOIN Producto p ON p.id = ip.producto_id
	INNER JOIN JerarquiaDetalle jd ON jd.id = ip.jerarquiaDetalle_id
	INNER JOIN Localidad l ON l.id = jd.localidad_id
	INNER JOIN Zona z ON z.id = l.zona_id
	WHERE ip.compania_id = @compania_id
		AND (
			@ramo_id = 0
			OR ip.ramo_id = @ramo_id
			)
		AND (
			@producto_id = 0
			OR ip.producto_id = @producto_id
			)
		AND (
			@jerarquiaDetalle_id IS NULL
			OR jd.codigoNivel = @jerarquiaDetalle_id
			)
		AND ip.mes = @mes
	ORDER BY ip.jerarquiaDetalle_id
	,compania
	,ramo
	,producto
END
