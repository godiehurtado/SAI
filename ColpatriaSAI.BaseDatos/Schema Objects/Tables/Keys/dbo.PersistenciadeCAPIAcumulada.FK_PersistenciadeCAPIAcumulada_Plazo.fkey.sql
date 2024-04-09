ALTER TABLE [dbo].[PersistenciadeCAPIAcumulada]
    ADD CONSTRAINT [FK_PersistenciadeCAPIAcumulada_Plazo] FOREIGN KEY ([plazo_id]) REFERENCES [dbo].[Plazo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

