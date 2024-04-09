ALTER TABLE [dbo].[TipoEndoso]
    ADD CONSTRAINT [FK_compania_TipoEndoso] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

