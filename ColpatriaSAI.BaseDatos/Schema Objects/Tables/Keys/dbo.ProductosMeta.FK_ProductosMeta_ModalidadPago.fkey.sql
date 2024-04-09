ALTER TABLE [dbo].[ProductosMeta]
    ADD CONSTRAINT [FK_ProductosMeta_ModalidadPago] FOREIGN KEY ([modalidadPago_id]) REFERENCES [dbo].[ModalidadPago] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

