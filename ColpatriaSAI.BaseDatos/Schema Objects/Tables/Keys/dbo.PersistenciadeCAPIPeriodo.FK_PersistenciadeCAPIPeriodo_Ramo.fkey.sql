ALTER TABLE [dbo].[PersistenciadeCAPIPeriodo]
    ADD CONSTRAINT [FK_PersistenciadeCAPIPeriodo_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

