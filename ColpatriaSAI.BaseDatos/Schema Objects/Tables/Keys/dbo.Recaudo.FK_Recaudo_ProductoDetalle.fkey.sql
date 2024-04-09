ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_Recaudo_ProductoDetalle] FOREIGN KEY ([productoDetalle_id]) REFERENCES [dbo].[ProductoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

