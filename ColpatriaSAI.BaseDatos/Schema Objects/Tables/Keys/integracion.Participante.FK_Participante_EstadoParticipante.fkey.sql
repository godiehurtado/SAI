ALTER TABLE [integracion].[Participante]
    ADD CONSTRAINT [FK_Participante_EstadoParticipante] FOREIGN KEY ([estadoParticipante_id]) REFERENCES [integracion].[EstadoParticipante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

