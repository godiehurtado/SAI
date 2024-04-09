ALTER TABLE [dbo].[ProductoConcurso]
    ADD CONSTRAINT [FK_productoConcurso_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

