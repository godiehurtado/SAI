ALTER TABLE [dbo].[PersistenciadeVIDA]
    ADD CONSTRAINT [FK_PersistenciadeVIDA_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

