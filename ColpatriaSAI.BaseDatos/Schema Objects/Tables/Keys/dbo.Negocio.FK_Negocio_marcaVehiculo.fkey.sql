ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_Negocio_marcaVehiculo] FOREIGN KEY ([marcaVehiculo_id]) REFERENCES [dbo].[MarcaVehiculo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

