ALTER TABLE [dbo].[ExcepcionesxGrupoTipoEndoso]
    ADD CONSTRAINT [FK_ExcepcionesxGrupoTipoEndoso_TipoEndoso] FOREIGN KEY ([tipoEndoso_id]) REFERENCES [dbo].[TipoEndoso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

