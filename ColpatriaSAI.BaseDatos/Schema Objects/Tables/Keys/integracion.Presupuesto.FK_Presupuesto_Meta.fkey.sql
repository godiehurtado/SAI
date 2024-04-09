ALTER TABLE [integracion].[Presupuesto]
    ADD CONSTRAINT [FK_Presupuesto_Meta] FOREIGN KEY ([meta_id]) REFERENCES [integracion].[Meta] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

