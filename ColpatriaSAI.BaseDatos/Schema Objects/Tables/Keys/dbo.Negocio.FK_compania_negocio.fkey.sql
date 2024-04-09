ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_compania_negocio] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

