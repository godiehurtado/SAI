ALTER TABLE [dbo].[PersistenciadeCAPIDetalle]
    ADD CONSTRAINT [FK_PersistenciadeCAPIDetalle_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

