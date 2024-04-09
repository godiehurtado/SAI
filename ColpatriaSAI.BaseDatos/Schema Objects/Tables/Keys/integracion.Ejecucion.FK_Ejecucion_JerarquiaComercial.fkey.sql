ALTER TABLE [integracion].[Ejecucion]
    ADD CONSTRAINT [FK_Ejecucion_JerarquiaComercial] FOREIGN KEY ([nodo_id]) REFERENCES [integracion].[JerarquiaComercial] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

