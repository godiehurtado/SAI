ALTER TABLE [integracion].[Ramo]
    ADD CONSTRAINT [FK_Ramo_Compania] FOREIGN KEY ([compania_id]) REFERENCES [integracion].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

