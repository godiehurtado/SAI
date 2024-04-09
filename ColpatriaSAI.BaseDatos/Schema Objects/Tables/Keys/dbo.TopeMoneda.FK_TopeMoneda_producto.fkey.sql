ALTER TABLE [dbo].[TopeMoneda]
    ADD CONSTRAINT [FK_TopeMoneda_producto] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

