ALTER TABLE [dbo].[Siniestralidad]
    ADD CONSTRAINT [FK_ramoDetalle_siniestralidad] FOREIGN KEY ([ramoDetalle_id]) REFERENCES [dbo].[RamoDetalle] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

