ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_Negocio_RamoDetalle] FOREIGN KEY ([ramoDetalle_id]) REFERENCES [dbo].[RamoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

