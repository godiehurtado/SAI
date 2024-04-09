ALTER TABLE [dbo].[ParticipanteConcurso]
    ADD CONSTRAINT [FK_participanteconcurso_compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

