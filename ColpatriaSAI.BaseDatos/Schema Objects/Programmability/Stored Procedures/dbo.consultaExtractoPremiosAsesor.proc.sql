-- =============================================
-- Author:		Frank Esteban Payares Ríos
-- Create date: 24/05/2012
-- Description:	Procedimiento almacenado para obtener el extracto de premios de un asesor
-- =============================================
CREATE PROCEDURE [dbo].[consultaExtractoPremiosAsesor]
(
	@clave NVARCHAR(250),
	@anio INT
)
AS
BEGIN
	SET NOCOUNT ON;
	
	DECLARE @claveTemp NVARCHAR(250)=@clave, @anioTemp int=@anio
	
	SELECT t1.dlrid, r.id codigoPremio, r.nombre premio, Subregla, t1.gano gano, t1.descripcionPremioGanado, t1.fechaCierrePremio
	FROM Regla r JOIN(
		SELECT
		  lr.regla_id as idr   
		, lr.fecha_inicial as fechaCierrePremio
		,(CASE dlr.resultado WHEN 0 THEN 'No' ELSE 'Si'	END) as gano--		
		,(CASE dlr.resultado WHEN 0 THEN '' ELSE Coalesce(sub1.descripcion, '')	END) as descripcionPremioGanado
		, dlr.id as dlrid
		, sr.descripcion as Subregla	 			
		FROM LiquidacionRegla AS lr 
			INNER JOIN LiquidacionReglaxParticipante AS lrp ON lr.id = lrp.liquidacionRegla_id 
			INNER JOIN DetalleLiquidacionRegla AS dlr ON lrp.id = dlr.liquidacionReglaxParticipante_id
			INNER JOIN SubRegla AS sr ON sr.id = dlr.subregla_id
			INNER JOIN Participante AS p ON p.id = lrp.participante_id			
			LEFT JOIN PremioxSubregla ps ON ps.subregla_id = sr.id
			LEFT JOIN (
				SELECT lp.liquidacionreglaxparticipante_id, pre.descripcion, lp.premio_id, lp.subregla_id
				FROM LiquidacionPremio AS lp 
					INNER JOIN Premio AS pre ON lp.premio_id = pre.id
					INNER JOIN DetalleLiquidacionRegla dlr ON dlr.subregla_id = lp.subregla_id AND dlr.liquidacionReglaxParticipante_id = lp.liquidacionReglaxParticipante_id
					INNER JOIN LiquidacionReglaxParticipante lxp ON lxp.id = dlr.liquidacionReglaxParticipante_id
				WHERE  lp.resultado IS NOT NULL
			)
			AS sub1 ON lrp.id = sub1.liquidacionreglaxparticipante_id AND ps.premio_id = sub1.premio_id AND sub1.subregla_id = dlr.subregla_id --AND c.variable_id = sub1.variable_id
			where p.clave = @claveTemp and YEAR(lr.fecha_inicial)=@anioTemp AND sr.condicionAgrupada_id IS NULL AND lr.estado = 2 --Nota: Esto debe adicionarse una vez existan liquidaciones pagadas y/o cuando se suba el SP a producción
		) AS t1 ON r.id = t1.idr
END