ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_monedaxnegocio_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

