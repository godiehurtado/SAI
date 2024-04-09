ALTER TABLE [dbo].[LiquidacionPremio]
    ADD CONSTRAINT [FK_LiquidacionPremio_LiquidacionReglaxParticipante] FOREIGN KEY ([liquidacionReglaxParticipante_id]) REFERENCES [dbo].[LiquidacionReglaxParticipante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

