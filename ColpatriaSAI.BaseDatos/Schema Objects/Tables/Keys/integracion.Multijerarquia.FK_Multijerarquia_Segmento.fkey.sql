ALTER TABLE [integracion].[Multijerarquia]
    ADD CONSTRAINT [FK_Multijerarquia_Segmento] FOREIGN KEY ([segmento_id]) REFERENCES [integracion].[Segmento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

