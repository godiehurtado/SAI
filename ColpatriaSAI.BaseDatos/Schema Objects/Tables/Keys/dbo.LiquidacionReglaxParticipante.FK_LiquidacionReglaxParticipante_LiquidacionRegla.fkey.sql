ALTER TABLE [dbo].[LiquidacionReglaxParticipante]
    ADD CONSTRAINT [FK_LiquidacionReglaxParticipante_LiquidacionRegla] FOREIGN KEY ([liquidacionRegla_id]) REFERENCES [dbo].[LiquidacionRegla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

