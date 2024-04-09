ALTER TABLE [dbo].[PersistenciadeVIDA]
    ADD CONSTRAINT [FK_PersistenciadeVIda_ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

