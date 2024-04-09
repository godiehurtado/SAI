ALTER TABLE [dbo].[Concurso]
    ADD CONSTRAINT [FK_segmento_concurso] FOREIGN KEY ([segmento_id]) REFERENCES [dbo].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

