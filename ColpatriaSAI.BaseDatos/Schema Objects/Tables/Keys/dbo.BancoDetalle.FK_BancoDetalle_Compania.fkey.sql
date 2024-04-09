ALTER TABLE [dbo].[BancoDetalle]
    ADD CONSTRAINT [FK_BancoDetalle_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

