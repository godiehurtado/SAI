-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 23/03/2011
-- Description:	Consulta de detalles de la contratación para reporte de Detalles
-- =============================================
CREATE PROCEDURE [dbo].[RPT_DetalleContratacion]
(
	@liquidacionContratacion_id INT
)
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		jd.nombre
		, jd.codigoNivel
		, lcm.meta_id
		, mo.id AS ModeloId
		, mo.descripcion AS Modelo
		, m.nombre AS Meta
		, round(lcm.pesoNota, 2) as pesoNota
		, round(lcm.presupuesto, 2) as presupuesto
		, round(lcm.ejecutado, 2) as ejecutado
		, round(lcm.nota,2) as nota
		, round(lcm.notaPonderada,2) as notaPonderada
		, lcfp.notaDefinitiva AS Liquidacion
		, lcfp.factor AS Factor		
	FROM LiquiContratMeta lcm
	INNER JOIN LiquiContratFactorParticipante lcfp on lcfp.liqui_contrat_id = lcm.liqui_contrat_id AND lcfp.modelo_id = lcm.modelo_id AND lcfp.jerarquiaDetalle_id = lcm.jerarquiaDetalle_id
	INNER JOIN JerarquiaDetalle jd ON jd.id = lcm.jerarquiaDetalle_id
	INNER JOIN Meta m ON m.id = lcm.meta_id
	INNER JOIN Modelo mo ON mo.id = lcm.modelo_id
	WHERE lcm.liqui_contrat_id = @liquidacionContratacion_id

END
