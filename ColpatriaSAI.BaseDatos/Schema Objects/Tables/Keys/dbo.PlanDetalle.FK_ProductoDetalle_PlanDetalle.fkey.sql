ALTER TABLE [dbo].[PlanDetalle]
    ADD CONSTRAINT [FK_ProductoDetalle_PlanDetalle] FOREIGN KEY ([productoDetalle_id]) REFERENCES [dbo].[ProductoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

