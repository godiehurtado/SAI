ALTER TABLE [dbo].[PersistenciadeCAPIPeriodo]
    ADD CONSTRAINT [FK_PersistenciadeCAPI_Participante] FOREIGN KEY ([participante_id]) REFERENCES [dbo].[Participante] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

