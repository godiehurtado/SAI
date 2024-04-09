ALTER TABLE [integracion].[Participante]
    ADD CONSTRAINT [FK_Participante_TipoParticipante] FOREIGN KEY ([tipoParticipante_id]) REFERENCES [integracion].[TipoParticipante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

