ALTER TABLE [dbo].[Concurso]
    ADD CONSTRAINT [FK_Concurso_tipoConcurso] FOREIGN KEY ([tipoConcurso_id]) REFERENCES [dbo].[TipoConcurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

