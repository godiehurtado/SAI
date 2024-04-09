ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_tipoVehiculo_id] FOREIGN KEY ([tipoVehiculo_id]) REFERENCES [dbo].[TipoVehiculo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

