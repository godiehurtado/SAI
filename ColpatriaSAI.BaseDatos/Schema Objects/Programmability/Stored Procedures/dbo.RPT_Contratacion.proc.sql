-- =============================================
-- Author:		Diego Armando Bautista Lagos
-- Create date: 23/02/2012
-- Description:	Consulta que sirve como origen de datos al reporte de contratación
-- =============================================
CREATE PROCEDURE [dbo].[RPT_Contratacion]
	@liquidacionContratacion_id INT
AS
BEGIN
	SET NOCOUNT ON;

    SELECT
		jd.codigoNivel AS NivelDav
		, co.nombre AS CIA
		, jd.nombre AS Nodo
		, ca.nombre	AS Canal
		, l.nombre AS Loc
		, z.nombre AS Zona
		, p.nombre + SPACE(1) + p.apellidos AS EjecutivoPlanta
		, p.documento AS Cedula
		, lcfp.salarioBase AS SalarioBasico
		, lcfp.valorIncremento AS PorceIncremento
		, lcfp.salarioTotal AS BaseVariable
		, lcfp.valorFVD AS ParticipacionFVD
		, lcfp.valorFVC AS ParticipacionFVC
		, lc.fechaIni AS Fecha
		, lcfp.notaDefinitiva AS Liquidacion
		, lcfp.factor AS Factor
		, lcfp.totalPago AS TotalPago
	FROM
		LiquidacionContratacion lc
		INNER JOIN LiquiContratFactorParticipante lcfp on lcfp.liqui_contrat_id = lc.id
		INNER JOIN JerarquiaDetalle jd ON jd.id = lcfp.jerarquiaDetalle_id
		INNER JOIN Participante p ON p.id = jd.participante_id
		INNER JOIN Compania co ON co.id = p.compania_id
		INNER JOIN Canal ca ON ca.id = jd.canal_id
		INNER JOIN Localidad l ON l.id = jd.localidad_id
		INNER JOIN Zona z ON z.id = jd.zona_id
	WHERE lc.id = @liquidacionContratacion_id
END
