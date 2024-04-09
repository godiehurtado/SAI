ALTER TABLE [dbo].[ProductoConcurso]
    ADD CONSTRAINT [FK_productoConcurso_producto] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

