ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_MonedaxNegocio_Moneda1] FOREIGN KEY ([moneda_id]) REFERENCES [dbo].[Moneda] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

