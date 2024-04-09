ALTER TABLE [dbo].[ProductoConcurso]
    ADD CONSTRAINT [FK_productoConcurso_concurso] FOREIGN KEY ([concurso_id]) REFERENCES [dbo].[Concurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

