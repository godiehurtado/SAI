ALTER TABLE [dbo].[ParticipanteConcurso]
    ADD CONSTRAINT [FK_ParticipanteConcurso_JerarquiaDetalle] FOREIGN KEY ([jerarquiaDetalle_id]) REFERENCES [dbo].[JerarquiaDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

