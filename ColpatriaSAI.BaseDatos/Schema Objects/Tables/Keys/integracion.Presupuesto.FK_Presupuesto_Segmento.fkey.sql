ALTER TABLE [integracion].[Presupuesto]
    ADD CONSTRAINT [FK_Presupuesto_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [integracion].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

