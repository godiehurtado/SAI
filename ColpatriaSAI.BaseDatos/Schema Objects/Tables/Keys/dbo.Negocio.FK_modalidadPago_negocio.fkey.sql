ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_modalidadPago_negocio] FOREIGN KEY ([modalidadPago_id]) REFERENCES [dbo].[ModalidadPago] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

