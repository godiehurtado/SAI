ALTER TABLE [dbo].[LiquidacionReglaxParticipante]
    ADD CONSTRAINT [FK_LiquidacionReglaxParticipante_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

