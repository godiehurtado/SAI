ALTER TABLE [dbo].[DetallePartFranquicia]
    ADD CONSTRAINT [FK_DetallePartFranquicia_producto_id] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

