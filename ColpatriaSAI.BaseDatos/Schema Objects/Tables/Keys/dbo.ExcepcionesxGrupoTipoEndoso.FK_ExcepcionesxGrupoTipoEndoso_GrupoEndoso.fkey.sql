ALTER TABLE [dbo].[ExcepcionesxGrupoTipoEndoso]
    ADD CONSTRAINT [FK_ExcepcionesxGrupoTipoEndoso_GrupoEndoso] FOREIGN KEY ([grupoEndoso_id]) REFERENCES [dbo].[GrupoEndoso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

