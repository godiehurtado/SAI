ALTER TABLE [dbo].[ParticipanteConcurso]
    ADD CONSTRAINT [FK_ParticipanteConcurso_nivel] FOREIGN KEY ([nivel_id]) REFERENCES [dbo].[Nivel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

