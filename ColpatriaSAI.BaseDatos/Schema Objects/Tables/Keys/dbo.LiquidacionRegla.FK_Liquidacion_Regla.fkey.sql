ALTER TABLE [dbo].[LiquidacionRegla]
    ADD CONSTRAINT [FK_Liquidacion_Regla] FOREIGN KEY ([regla_id]) REFERENCES [dbo].[Regla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

