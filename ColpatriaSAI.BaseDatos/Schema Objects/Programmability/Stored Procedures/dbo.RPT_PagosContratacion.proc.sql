-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 23/02/2012
-- Description:	Consulta que sirve como origen de datos al reporte de Pagos de Contratación
-- =============================================
CREATE PROCEDURE [dbo].[RPT_PagosContratacion]
	@liquidacionContratacion_id INT
AS
BEGIN
	SET NOCOUNT ON;

	SELECT
		p.documento AS documentoEmpleado
		,  CONVERT(VARCHAR(10), GETDATE(), 103) AS fechaImputacion
		, '004' AS frecuenciaPago
		, '' AS codigoEmpresa
		, '' centroCosto
		, '50043' codigoConcepto
		, lcfp.totalPago AS valor
		, 'COP' AS Moneda
	FROM
		LiquiContratFactorParticipante lcfp
		INNER JOIN JerarquiaDetalle jd ON jd.id = lcfp.jerarquiaDetalle_id
		INNER JOIN Participante p ON p.id = jd.participante_id
	WHERE lcfp.liqui_contrat_id = @liquidacionContratacion_id
END
