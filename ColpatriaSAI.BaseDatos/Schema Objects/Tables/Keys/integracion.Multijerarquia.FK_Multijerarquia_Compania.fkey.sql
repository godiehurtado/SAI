ALTER TABLE [integracion].[Multijerarquia]
    ADD CONSTRAINT [FK_Multijerarquia_Compania] FOREIGN KEY ([compania_id]) REFERENCES [integracion].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

