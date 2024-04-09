ALTER TABLE [dbo].[BasexParticipante]
    ADD CONSTRAINT [FK_basexparticipante_participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

