ALTER TABLE [dbo].[ParticipanteConcurso]
    ADD CONSTRAINT [FK_ParticipanteConcurso_concurso] FOREIGN KEY ([concurso_id]) REFERENCES [dbo].[Concurso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

