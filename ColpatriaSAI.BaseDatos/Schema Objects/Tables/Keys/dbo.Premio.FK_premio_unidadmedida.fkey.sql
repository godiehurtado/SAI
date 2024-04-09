ALTER TABLE [dbo].[Premio]
    ADD CONSTRAINT [FK_premio_unidadmedida] FOREIGN KEY ([unidadmedida_id]) REFERENCES [dbo].[UnidadMedida] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

