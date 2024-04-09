ALTER TABLE [integracion].[Participante]
    ADD CONSTRAINT [FK_Participante_Compania] FOREIGN KEY ([compania_id]) REFERENCES [integracion].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

