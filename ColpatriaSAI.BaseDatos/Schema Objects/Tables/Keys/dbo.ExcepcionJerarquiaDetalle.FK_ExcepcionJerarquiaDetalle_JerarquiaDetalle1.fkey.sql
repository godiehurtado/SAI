ALTER TABLE [dbo].[ExcepcionJerarquiaDetalle]
    ADD CONSTRAINT [FK_ExcepcionJerarquiaDetalle_JerarquiaDetalle1] FOREIGN KEY ([excepcionJerarquiaOrigen_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

