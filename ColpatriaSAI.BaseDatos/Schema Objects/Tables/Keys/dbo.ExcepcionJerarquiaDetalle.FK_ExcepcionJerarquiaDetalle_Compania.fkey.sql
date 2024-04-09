ALTER TABLE [dbo].[ExcepcionJerarquiaDetalle]
    ADD CONSTRAINT [FK_ExcepcionJerarquiaDetalle_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

