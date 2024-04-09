ALTER TABLE [dbo].[ProductosMeta]
    ADD CONSTRAINT [FK_ProductosMeta_Producto1] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

