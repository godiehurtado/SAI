ALTER TABLE [dbo].[ModalidadPagoDetalle]
    ADD CONSTRAINT [FK_ModalidadPagoDetalle_ModalidadPago] FOREIGN KEY ([modalidadPago_id]) REFERENCES [dbo].[ModalidadPago] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

