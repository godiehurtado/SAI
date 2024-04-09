ALTER TABLE [integracion].[TipoEndoso]
    ADD CONSTRAINT [FK_TipoEndoso_Compania] FOREIGN KEY ([compania_id]) REFERENCES [integracion].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

