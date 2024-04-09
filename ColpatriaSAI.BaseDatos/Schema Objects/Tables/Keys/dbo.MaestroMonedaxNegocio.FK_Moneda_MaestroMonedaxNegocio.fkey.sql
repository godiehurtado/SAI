ALTER TABLE [dbo].[MaestroMonedaxNegocio]
    ADD CONSTRAINT [FK_Moneda_MaestroMonedaxNegocio] FOREIGN KEY ([moneda_id]) REFERENCES [dbo].[Moneda] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

