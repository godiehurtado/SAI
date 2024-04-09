ALTER TABLE [integracion].[RamoDetalle]
    ADD CONSTRAINT [FK_RamoDetalle_Ramo] FOREIGN KEY ([ramo_id]) REFERENCES [integracion].[Ramo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

