ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_participante_recaudo] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

