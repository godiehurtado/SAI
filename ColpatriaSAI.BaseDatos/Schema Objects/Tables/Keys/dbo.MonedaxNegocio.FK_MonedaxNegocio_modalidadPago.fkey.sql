ALTER TABLE [dbo].[MonedaxNegocio]
    ADD CONSTRAINT [FK_MonedaxNegocio_modalidadPago] FOREIGN KEY ([modalidadPago_id]) REFERENCES [dbo].[ModalidadPago] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

