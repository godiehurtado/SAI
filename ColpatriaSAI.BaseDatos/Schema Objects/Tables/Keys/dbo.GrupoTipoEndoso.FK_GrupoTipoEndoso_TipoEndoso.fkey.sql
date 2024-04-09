ALTER TABLE [dbo].[GrupoTipoEndoso]
    ADD CONSTRAINT [FK_GrupoTipoEndoso_TipoEndoso] FOREIGN KEY ([tipoEndoso_id]) REFERENCES [dbo].[TipoEndoso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

