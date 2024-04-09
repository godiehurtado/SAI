ALTER TABLE [dbo].[CompaniaxEtapa]
    ADD CONSTRAINT [FK_CompaniaxEtapa_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

