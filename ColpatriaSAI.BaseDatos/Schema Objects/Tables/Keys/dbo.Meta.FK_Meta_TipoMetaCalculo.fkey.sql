ALTER TABLE [dbo].[Meta]
    ADD CONSTRAINT [FK_Meta_TipoMetaCalculo] FOREIGN KEY ([tipoMetaCalculo_id]) REFERENCES [dbo].[TipoMetaCalculo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

