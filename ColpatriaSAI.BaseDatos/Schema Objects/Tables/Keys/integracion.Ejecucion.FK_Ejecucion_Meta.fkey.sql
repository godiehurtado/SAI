ALTER TABLE [integracion].[Ejecucion]
    ADD CONSTRAINT [FK_Ejecucion_Meta] FOREIGN KEY ([meta_id]) REFERENCES [integracion].[Meta] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

