ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_Negocio_ProductoDetalle] FOREIGN KEY ([productoDetalle_id]) REFERENCES [dbo].[ProductoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

