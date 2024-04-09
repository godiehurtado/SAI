ALTER TABLE [integracion].[JerarquiaComercial]
    ADD CONSTRAINT [FK_JerarquiaComercial_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [integracion].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

