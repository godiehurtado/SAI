ALTER TABLE [dbo].[ExcepcionJerarquiaDetalle]
    ADD CONSTRAINT [FK_ExcepcionJerarquiaDetalle_Producto] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

