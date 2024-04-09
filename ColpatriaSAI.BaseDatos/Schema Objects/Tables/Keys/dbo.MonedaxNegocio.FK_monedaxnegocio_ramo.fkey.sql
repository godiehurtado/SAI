ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_monedaxnegocio_ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

