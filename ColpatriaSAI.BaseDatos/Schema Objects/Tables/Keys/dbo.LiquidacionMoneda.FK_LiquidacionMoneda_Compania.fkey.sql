ALTER TABLE [dbo].[LiquidacionMoneda]
    ADD CONSTRAINT [FK_LiquidacionMoneda_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

