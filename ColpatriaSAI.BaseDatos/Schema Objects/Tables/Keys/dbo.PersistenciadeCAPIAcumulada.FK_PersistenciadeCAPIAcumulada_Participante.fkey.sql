ALTER TABLE [dbo].[PersistenciadeCAPIAcumulada]
    ADD CONSTRAINT [FK_PersistenciadeCAPIAcumulada_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

