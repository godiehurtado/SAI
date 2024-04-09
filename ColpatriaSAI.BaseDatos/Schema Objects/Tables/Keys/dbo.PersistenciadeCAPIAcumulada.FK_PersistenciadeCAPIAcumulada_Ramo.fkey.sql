ALTER TABLE [dbo].[PersistenciadeCAPIAcumulada]
    ADD CONSTRAINT [FK_PersistenciadeCAPIAcumulada_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

