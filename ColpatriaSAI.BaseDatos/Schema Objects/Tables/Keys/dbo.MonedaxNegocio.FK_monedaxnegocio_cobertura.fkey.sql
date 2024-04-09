ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_monedaxnegocio_cobertura] FOREIGN KEY ([cobertura_id]) REFERENCES [dbo].[Cobertura] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

