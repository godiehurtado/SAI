ALTER TABLE [dbo].[TopexEdad]
    ADD CONSTRAINT [FK_TopexEdad_Producto] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

