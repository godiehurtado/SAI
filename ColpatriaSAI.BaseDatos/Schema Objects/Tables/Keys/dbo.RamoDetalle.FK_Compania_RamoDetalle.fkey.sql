ALTER TABLE [dbo].[RamoDetalle]
    ADD CONSTRAINT [FK_Compania_RamoDetalle] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

