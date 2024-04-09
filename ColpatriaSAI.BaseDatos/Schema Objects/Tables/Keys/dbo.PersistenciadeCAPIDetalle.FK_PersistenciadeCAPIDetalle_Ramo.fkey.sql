ALTER TABLE [dbo].[PersistenciadeCAPIDetalle]
    ADD CONSTRAINT [FK_PersistenciadeCAPIDetalle_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

