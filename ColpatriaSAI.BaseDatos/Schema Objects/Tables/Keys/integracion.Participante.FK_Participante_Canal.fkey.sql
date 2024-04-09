ALTER TABLE [integracion].[Participante]
    ADD CONSTRAINT [FK_Participante_Canal] FOREIGN KEY ([canal_id]) REFERENCES [integracion].[Canal] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

