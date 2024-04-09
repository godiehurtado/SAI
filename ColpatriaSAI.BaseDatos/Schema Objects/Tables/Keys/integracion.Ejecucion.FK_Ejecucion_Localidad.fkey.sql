ALTER TABLE [integracion].[Ejecucion]
    ADD CONSTRAINT [FK_Ejecucion_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [integracion].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

