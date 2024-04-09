ALTER TABLE [dbo].[UnidadMedida]
    ADD CONSTRAINT [FK_UnidadMedida_tipounidadmedida] FOREIGN KEY ([tipounidadmedida_id]) REFERENCES [dbo].[TipoUnidadMedida] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

