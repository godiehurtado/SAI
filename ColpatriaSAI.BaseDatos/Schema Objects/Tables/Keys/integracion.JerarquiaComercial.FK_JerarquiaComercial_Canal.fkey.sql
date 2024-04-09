ALTER TABLE [integracion].[JerarquiaComercial]
    ADD CONSTRAINT [FK_JerarquiaComercial_Canal] FOREIGN KEY ([canal_id]) REFERENCES [integracion].[Canal] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

