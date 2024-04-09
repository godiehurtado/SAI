ALTER TABLE [dbo].[ProductoDetalle]
    ADD CONSTRAINT [FK_RamoDetalle_ProductoDetalle] FOREIGN KEY ([ramoDetalle_id]) REFERENCES [dbo].[RamoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

