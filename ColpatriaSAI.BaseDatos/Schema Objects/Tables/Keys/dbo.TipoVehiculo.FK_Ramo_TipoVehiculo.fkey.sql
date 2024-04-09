ALTER TABLE [dbo].[TipoVehiculo]
    ADD CONSTRAINT [FK_Ramo_TipoVehiculo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

