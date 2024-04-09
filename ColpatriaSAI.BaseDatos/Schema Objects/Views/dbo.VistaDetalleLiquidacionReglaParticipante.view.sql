CREATE VIEW dbo.VistaDetalleLiquidacionReglaParticipante
AS
SELECT     dbo.DetalleLiquidacionSubRegla.id, dbo.LiquidacionReglaxParticipante.liquidacionRegla_id, dbo.Regla.nombre AS Regla, 
                      dbo.LiquidacionReglaxParticipante.id AS LiquidacionReglaxParticipante_id, dbo.Participante.id AS participante_id, dbo.Participante.nombre, 
                      dbo.Participante.apellidos, dbo.Participante.documento, dbo.DetalleLiquidacionRegla.subregla_id, dbo.SubRegla.descripcion, dbo.SubRegla.principal, 
                      dbo.DetalleLiquidacionRegla.resultado AS Gano, dbo.DetalleLiquidacionSubRegla.resultado, dbo.DetalleLiquidacionSubRegla.condicion_id, 
                      dbo.CondicionesVariables.nombre AS Variable, dbo.CondicionesVariables.expresion, dbo.CondicionesVariables.valor, dbo.CondicionesVariables.textoSeleccion, 
                      dbo.CondicionesVariables.fecha
FROM         dbo.LiquidacionRegla INNER JOIN
                      dbo.Regla ON dbo.LiquidacionRegla.regla_id = dbo.Regla.id INNER JOIN
                      dbo.LiquidacionReglaxParticipante ON dbo.LiquidacionRegla.id = dbo.LiquidacionReglaxParticipante.liquidacionRegla_id INNER JOIN
                      dbo.Participante ON dbo.LiquidacionReglaxParticipante.participante_id = dbo.Participante.id INNER JOIN
                      dbo.DetalleLiquidacionRegla ON dbo.LiquidacionReglaxParticipante.id = dbo.DetalleLiquidacionRegla.liquidacionReglaxParticipante_id INNER JOIN
                      dbo.SubRegla ON dbo.Regla.id = dbo.SubRegla.regla_id AND dbo.DetalleLiquidacionRegla.subregla_id = dbo.SubRegla.id INNER JOIN
                      dbo.DetalleLiquidacionSubRegla ON dbo.DetalleLiquidacionRegla.id = dbo.DetalleLiquidacionSubRegla.detalleLiquidacionRegla_id INNER JOIN
                      dbo.CondicionesVariables ON dbo.DetalleLiquidacionSubRegla.condicion_id = dbo.CondicionesVariables.condicion_id
