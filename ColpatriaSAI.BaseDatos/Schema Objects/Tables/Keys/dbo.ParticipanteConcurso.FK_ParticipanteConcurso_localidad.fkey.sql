ALTER TABLE [dbo].[ParticipanteConcurso]
    ADD CONSTRAINT [FK_ParticipanteConcurso_localidad] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

