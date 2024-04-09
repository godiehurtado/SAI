ALTER TABLE [integracion].[Meta]
    ADD CONSTRAINT [FK_Meta_UnidadMedida] FOREIGN KEY ([unidadMedida_id]) REFERENCES [integracion].[UnidadMedida] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

