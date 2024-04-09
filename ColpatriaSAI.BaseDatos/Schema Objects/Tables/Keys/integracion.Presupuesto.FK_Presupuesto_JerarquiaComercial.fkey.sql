ALTER TABLE [integracion].[Presupuesto]
    ADD CONSTRAINT [FK_Presupuesto_JerarquiaComercial] FOREIGN KEY ([nodo_id]) REFERENCES [integracion].[JerarquiaComercial] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

