ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_estadoParticipante_participante] FOREIGN KEY ([estadoParticipante_id]) REFERENCES [dbo].[EstadoParticipante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

