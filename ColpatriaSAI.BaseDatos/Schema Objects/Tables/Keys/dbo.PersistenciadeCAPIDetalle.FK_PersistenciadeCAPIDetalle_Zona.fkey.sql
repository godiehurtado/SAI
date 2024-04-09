ALTER TABLE [dbo].[PersistenciadeCAPIDetalle]
    ADD CONSTRAINT [FK_PersistenciadeCAPIDetalle_Zona] FOREIGN KEY ([zona_id]) REFERENCES [dbo].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

