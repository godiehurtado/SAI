ALTER TABLE [integracion].[RamoDetalle]
    ADD CONSTRAINT [FK_RamoDetalle_Compania] FOREIGN KEY ([compania_id]) REFERENCES [integracion].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

