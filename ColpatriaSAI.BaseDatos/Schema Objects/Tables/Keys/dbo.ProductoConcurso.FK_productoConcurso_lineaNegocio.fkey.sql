ALTER TABLE [dbo].[ProductoConcurso]
    ADD CONSTRAINT [FK_productoConcurso_lineaNegocio] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

