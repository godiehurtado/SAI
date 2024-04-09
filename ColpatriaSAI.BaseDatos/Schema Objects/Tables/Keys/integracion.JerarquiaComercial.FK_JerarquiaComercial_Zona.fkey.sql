ALTER TABLE [integracion].[JerarquiaComercial]
    ADD CONSTRAINT [FK_JerarquiaComercial_Zona] FOREIGN KEY ([zona_id]) REFERENCES [integracion].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

