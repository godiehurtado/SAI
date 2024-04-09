ALTER TABLE [integracion].[JerarquiaComercial]
    ADD CONSTRAINT [FK_JerarquiaComercial_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [integracion].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

