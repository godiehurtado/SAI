ALTER TABLE [dbo].[Persistencia]
    ADD CONSTRAINT [FK_Persistencia_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

