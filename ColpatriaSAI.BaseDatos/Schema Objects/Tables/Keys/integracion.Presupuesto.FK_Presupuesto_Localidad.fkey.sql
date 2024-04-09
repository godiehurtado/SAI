ALTER TABLE [integracion].[Presupuesto]
    ADD CONSTRAINT [FK_Presupuesto_Localidad] FOREIGN KEY ([localidad_id]) REFERENCES [integracion].[Localidad] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

