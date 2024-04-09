ALTER TABLE [integracion].[Producto]
    ADD CONSTRAINT [FK_Producto_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [integracion].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

