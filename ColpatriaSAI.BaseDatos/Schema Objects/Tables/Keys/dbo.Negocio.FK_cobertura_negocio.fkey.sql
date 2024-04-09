ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_cobertura_negocio] FOREIGN KEY ([cobertura_id]) REFERENCES [dbo].[Cobertura] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

