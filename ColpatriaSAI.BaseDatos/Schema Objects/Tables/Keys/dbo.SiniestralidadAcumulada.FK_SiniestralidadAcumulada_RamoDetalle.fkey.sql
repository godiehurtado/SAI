ALTER TABLE [dbo].[SiniestralidadAcumulada]
    ADD CONSTRAINT [FK_SiniestralidadAcumulada_RamoDetalle] FOREIGN KEY ([ramoDetalle_id]) REFERENCES [dbo].[RamoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

