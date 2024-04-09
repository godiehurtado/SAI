ALTER TABLE [dbo].[ParticipanteConcurso]
    ADD CONSTRAINT [FK_ParticipanteConcurso_categoria] FOREIGN KEY ([categoria_id]) REFERENCES [dbo].[Categoria] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

