ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_MonedaxNegocio_TipoVehiculo] FOREIGN KEY ([tipoVehiculo_id]) REFERENCES [dbo].[TipoVehiculo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

