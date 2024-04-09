ALTER TABLE [dbo].[Plan]
    ADD CONSTRAINT [FK_Plan_Producto] FOREIGN KEY ([producto_id]) REFERENCES [dbo].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

