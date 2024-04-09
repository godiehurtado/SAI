ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_modalidadPago_recaudo] FOREIGN KEY ([modalidadpago_id]) REFERENCES [dbo].[ModalidadPago] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

