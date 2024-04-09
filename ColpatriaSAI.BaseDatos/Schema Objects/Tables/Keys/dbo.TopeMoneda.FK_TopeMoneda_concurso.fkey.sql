ALTER TABLE [dbo].[TopeMoneda]
    ADD CONSTRAINT [FK_TopeMoneda_concurso] FOREIGN KEY ([concurso_id]) REFERENCES [dbo].[Concurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

