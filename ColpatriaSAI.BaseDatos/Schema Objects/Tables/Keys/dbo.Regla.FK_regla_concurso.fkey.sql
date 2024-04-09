ALTER TABLE [dbo].[Regla]
    ADD CONSTRAINT [FK_regla_concurso] FOREIGN KEY ([concurso_id]) REFERENCES [dbo].[Concurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

