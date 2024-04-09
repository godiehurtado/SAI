ALTER TABLE [dbo].[Meta]
    ADD CONSTRAINT [FK_Meta_tipometa] FOREIGN KEY ([tipoMeta_id]) REFERENCES [dbo].[TipoMeta] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

