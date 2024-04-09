ALTER TABLE [dbo].[ReglaxConceptoDescuento]
    ADD CONSTRAINT [FK_ReglaxConceptoDescuento_ConceptoDescuento] FOREIGN KEY ([conceptoDescuento_id]) REFERENCES [dbo].[ConceptoDescuento] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

