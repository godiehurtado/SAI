ALTER TABLE [dbo].[PersistenciadeCAPIDetalle]
    ADD CONSTRAINT [FK_PersistenciadeCAPIDetalle_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [dbo].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

