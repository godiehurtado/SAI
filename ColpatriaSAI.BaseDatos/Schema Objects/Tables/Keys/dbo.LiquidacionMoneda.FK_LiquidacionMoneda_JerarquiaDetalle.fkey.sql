ALTER TABLE [dbo].[LiquidacionMoneda]
    ADD CONSTRAINT [FK_LiquidacionMoneda_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

