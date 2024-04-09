ALTER TABLE [dbo].[Pago]
    ADD CONSTRAINT [FK_Pago_TipoDocumento] FOREIGN KEY ([tipoDocumento_id]) REFERENCES [dbo].[TipoDocumento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

