ALTER TABLE [dbo].[DetalleLiquidacionRegla]
    ADD CONSTRAINT [FK_DetalleLiquidacionRegla_LiquidacionReglaxParticipante] FOREIGN KEY ([liquidacionReglaxParticipante_id]) REFERENCES [dbo].[LiquidacionReglaxParticipante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

