ALTER TABLE [dbo].[Persistencia]
    ADD CONSTRAINT [FK_Persistencia_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

