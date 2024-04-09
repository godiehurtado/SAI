ALTER TABLE [dbo].[BaseMoneda]
    ADD CONSTRAINT [FK_BaseMoneda_Moneda] FOREIGN KEY ([moneda_id]) REFERENCES [dbo].[Moneda] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

