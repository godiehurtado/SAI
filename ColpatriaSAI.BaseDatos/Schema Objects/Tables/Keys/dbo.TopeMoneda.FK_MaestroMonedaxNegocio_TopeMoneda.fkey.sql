ALTER TABLE [dbo].[TopeMoneda]
    ADD CONSTRAINT [FK_MaestroMonedaxNegocio_TopeMoneda] FOREIGN KEY ([maestromoneda_id]) REFERENCES [dbo].[MaestroMonedaxNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

