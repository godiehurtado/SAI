ALTER TABLE [dbo].[RamoDetalle]
    ADD CONSTRAINT [FK_Ramo_RamoDetalle] FOREIGN KEY ([ramo_id]) REFERENCES [dbo].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

