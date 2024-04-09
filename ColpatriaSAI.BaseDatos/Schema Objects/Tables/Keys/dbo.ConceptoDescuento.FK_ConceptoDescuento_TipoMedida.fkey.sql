ALTER TABLE [dbo].[ConceptoDescuento]
    ADD CONSTRAINT [FK_ConceptoDescuento_TipoMedida] FOREIGN KEY ([tipoMedida_id]) REFERENCES [dbo].[TipoMedida] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

