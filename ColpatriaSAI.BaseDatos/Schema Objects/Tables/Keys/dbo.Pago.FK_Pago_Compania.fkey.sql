ALTER TABLE [dbo].[Pago]
    ADD CONSTRAINT [FK_Pago_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;



