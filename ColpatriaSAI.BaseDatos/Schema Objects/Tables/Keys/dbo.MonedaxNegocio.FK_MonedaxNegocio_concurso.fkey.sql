ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_MonedaxNegocio_concurso] FOREIGN KEY ([concurso_id]) REFERENCES [dbo].[Concurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

