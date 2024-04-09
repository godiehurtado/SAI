ALTER TABLE [dbo].[PersistenciadeCAPIPeriodo]
    ADD CONSTRAINT [FK_PersistenciadeCAPI_Plazo] FOREIGN KEY ([plazo_id]) REFERENCES [dbo].[Plazo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

