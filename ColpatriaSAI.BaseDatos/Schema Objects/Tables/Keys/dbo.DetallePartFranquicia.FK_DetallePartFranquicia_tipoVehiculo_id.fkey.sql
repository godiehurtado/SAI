ALTER TABLE [dbo].[DetallePartFranquicia]
    ADD CONSTRAINT [FK_DetallePartFranquicia_tipoVehiculo_id] FOREIGN KEY ([tipoVehiculo_id]) REFERENCES [dbo].[TipoVehiculo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

