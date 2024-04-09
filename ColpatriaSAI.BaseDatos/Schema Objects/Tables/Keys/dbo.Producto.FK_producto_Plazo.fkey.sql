ALTER TABLE [dbo].[Producto]
    ADD CONSTRAINT [FK_producto_Plazo] FOREIGN KEY ([plazo_id]) REFERENCES [dbo].[Plazo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

