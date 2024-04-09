ALTER TABLE [dbo].[Participante]
    ADD CONSTRAINT [FK_segmento_participante] FOREIGN KEY ([segmento_id]) REFERENCES [dbo].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

