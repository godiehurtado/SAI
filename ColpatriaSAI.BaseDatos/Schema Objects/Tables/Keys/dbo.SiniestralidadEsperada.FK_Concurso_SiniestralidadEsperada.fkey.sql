ALTER TABLE [dbo].[SiniestralidadEsperada]
    ADD CONSTRAINT [FK_Concurso_SiniestralidadEsperada] FOREIGN KEY ([concurso_id]) REFERENCES [dbo].[Concurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

