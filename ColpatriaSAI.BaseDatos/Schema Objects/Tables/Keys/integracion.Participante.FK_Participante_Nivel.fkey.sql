ALTER TABLE [integracion].[Participante]
    ADD CONSTRAINT [FK_Participante_Nivel] FOREIGN KEY ([nivel_id]) REFERENCES [integracion].[Nivel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

