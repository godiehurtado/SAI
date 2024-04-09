ALTER TABLE [dbo].[PersistenciadeVIDA]
    ADD CONSTRAINT [FK_PersistenciadeVIda_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

