ALTER TABLE [dbo].[Persistencia]
    ADD CONSTRAINT [FK_Persistencia_Producto] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

