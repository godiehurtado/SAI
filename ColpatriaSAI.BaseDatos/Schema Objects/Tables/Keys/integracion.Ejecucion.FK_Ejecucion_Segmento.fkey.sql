ALTER TABLE [integracion].[Ejecucion]
    ADD CONSTRAINT [FK_Ejecucion_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [integracion].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

