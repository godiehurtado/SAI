ALTER TABLE [dbo].[Moneda]
    ADD CONSTRAINT [FK_Moneda_unidadMedida] FOREIGN KEY ([unidadmedida_id]) REFERENCES [dbo].[UnidadMedida] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

