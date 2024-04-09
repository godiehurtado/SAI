ALTER TABLE [integracion].[Plan]
    ADD CONSTRAINT [FK_Plan_Producto] FOREIGN KEY ([producto_id]) REFERENCES [integracion].[Producto] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

