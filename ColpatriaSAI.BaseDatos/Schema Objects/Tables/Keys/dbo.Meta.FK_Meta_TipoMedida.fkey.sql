ALTER TABLE [dbo].[Meta]
    ADD CONSTRAINT [FK_Meta_TipoMedida] FOREIGN KEY ([tipoMedida_id]) REFERENCES [dbo].[TipoMedida] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

