ALTER TABLE [dbo].[Producto]
    ADD CONSTRAINT [FK_Producto_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

