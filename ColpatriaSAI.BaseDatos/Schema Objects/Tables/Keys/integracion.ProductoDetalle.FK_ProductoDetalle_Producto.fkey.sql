ALTER TABLE [integracion].[ProductoDetalle]
    ADD CONSTRAINT [FK_ProductoDetalle_Producto] FOREIGN KEY ([producto_id]) REFERENCES [integracion].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

