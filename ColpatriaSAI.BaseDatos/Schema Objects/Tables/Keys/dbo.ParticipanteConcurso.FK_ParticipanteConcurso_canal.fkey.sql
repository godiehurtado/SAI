ALTER TABLE [dbo].[ParticipanteConcurso]
    ADD CONSTRAINT [FK_ParticipanteConcurso_canal] FOREIGN KEY ([canal_id]) REFERENCES [dbo].[Canal] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

