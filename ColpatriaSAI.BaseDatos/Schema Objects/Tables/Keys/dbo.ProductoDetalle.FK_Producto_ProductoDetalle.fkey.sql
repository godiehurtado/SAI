ALTER TABLE [dbo].[ProductoDetalle]
    ADD CONSTRAINT [FK_Producto_ProductoDetalle] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

