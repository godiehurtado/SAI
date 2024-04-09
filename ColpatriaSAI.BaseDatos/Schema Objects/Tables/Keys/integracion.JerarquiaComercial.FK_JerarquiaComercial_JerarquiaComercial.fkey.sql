ALTER TABLE [integracion].[JerarquiaComercial]
    ADD CONSTRAINT [FK_JerarquiaComercial_JerarquiaComercial] FOREIGN KEY ([padre_id]) REFERENCES [integracion].[JerarquiaComercial] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

