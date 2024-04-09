ALTER TABLE [dbo].[ParticipantexNivel]
    ADD CONSTRAINT [FK_participantexNivel_nivel] FOREIGN KEY ([nivel_id]) REFERENCES [dbo].[Nivel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

