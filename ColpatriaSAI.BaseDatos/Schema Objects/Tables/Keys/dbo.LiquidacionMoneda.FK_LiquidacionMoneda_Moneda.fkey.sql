ALTER TABLE [dbo].[LiquidacionMoneda]
    ADD CONSTRAINT [FK_LiquidacionMoneda_Moneda] FOREIGN KEY ([moneda_id]) REFERENCES [dbo].[Moneda] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

