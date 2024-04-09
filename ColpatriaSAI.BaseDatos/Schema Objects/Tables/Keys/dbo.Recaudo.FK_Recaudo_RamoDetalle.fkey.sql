ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_Recaudo_RamoDetalle] FOREIGN KEY ([ramoDetalle_id]) REFERENCES [dbo].[RamoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

