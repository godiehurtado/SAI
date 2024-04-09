ALTER TABLE [dbo].[ExcepcionJerarquiaDetalle]
    ADD CONSTRAINT [FK_ExcepcionJerarquiaDetalle_JerarquiaDetalle] FOREIGN KEY ([excepcionJerarquiaDestino_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

