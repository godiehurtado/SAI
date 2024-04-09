ALTER TABLE [integracion].[Ejecucion]
    ADD CONSTRAINT [FK_Ejecucion_Zona] FOREIGN KEY ([zona_id]) REFERENCES [integracion].[Zona] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

