ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_Participante_TipoParticipante] FOREIGN KEY ([tipoParticipante_id]) REFERENCES [dbo].[TipoParticipante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

