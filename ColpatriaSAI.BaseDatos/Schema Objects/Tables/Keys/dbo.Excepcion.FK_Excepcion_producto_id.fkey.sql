ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_producto_id] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

