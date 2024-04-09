ALTER TABLE [dbo].[ParticipantexNivel]
    ADD CONSTRAINT [FK_participantexNivel_participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

