ALTER TABLE [dbo].[ProductoCombo]
    ADD CONSTRAINT [FK_ProductoCombo_Producto] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

