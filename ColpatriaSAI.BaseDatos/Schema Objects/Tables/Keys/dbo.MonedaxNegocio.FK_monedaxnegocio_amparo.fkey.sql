ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_monedaxnegocio_amparo] FOREIGN KEY ([amparo_id]) REFERENCES [dbo].[Amparo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

