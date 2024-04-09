-- =============================================
-- Author:		Diegop Armando Bautista Lagos
-- Create date: 06/03/2012
-- Description:	Procedimiento almacenado de origen para el reporte de Metas Jerarquía Comercial
-- =============================================
CREATE PROCEDURE [dbo].[RPT_MetasJerarquiaComercial] 
(
	@anio INT,
	@segmento_id INT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	SELECT
		mxn.anio
		, jd.codigoNivel
		, jd.nombre AS jerarquiaNombre
		, m.id
		, m.nombre AS metaNombre
		, CASE m.tipoMetaCalculo_id
			WHEN 1 THEN 'Simple'
			ELSE 'Calculada'
		END AS tipoMeta
	FROM MetaxNodo mxn
		INNER JOIN Meta m ON m.id = mxn.meta_id
		INNER JOIN JerarquiaDetalle jd ON jd.id = mxn.jerarquiaDetalle_id
		INNER JOIN Jerarquia j ON j.id = jd.jerarquia_id
	WHERE
		mxn.anio = @anio
		AND j.segmento_id = @segmento_id
	ORDER BY mxn.jerarquiaDetalle_id
END