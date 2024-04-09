ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_monedaxnegocio_lineanegocio] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

