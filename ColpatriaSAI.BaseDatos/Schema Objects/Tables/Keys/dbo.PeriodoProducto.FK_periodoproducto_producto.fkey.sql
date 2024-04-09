ALTER TABLE [dbo].[PeriodoProducto]
    ADD CONSTRAINT [FK_periodoproducto_producto] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

