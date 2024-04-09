ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_MaestroMonedaxNegocio_MonedaxNegocio] FOREIGN KEY ([maestromoneda_id]) REFERENCES [dbo].[MaestroMonedaxNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

