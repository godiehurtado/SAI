ALTER TABLE [dbo].[ReglaxConceptoDescuento]
    ADD CONSTRAINT [FK_ReglaxConceptoDescuento_Regla] FOREIGN KEY ([regla_id]) REFERENCES [dbo].[Regla] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

