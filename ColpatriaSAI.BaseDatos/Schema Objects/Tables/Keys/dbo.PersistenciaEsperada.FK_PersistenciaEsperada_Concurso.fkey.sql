ALTER TABLE [dbo].[PersistenciaEsperada]
    ADD CONSTRAINT [FK_PersistenciaEsperada_Concurso] FOREIGN KEY ([concurso_id]) REFERENCES [dbo].[Concurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

