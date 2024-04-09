ALTER TABLE [dbo].[ExcepcionesxGrupoTipoEndoso]
    ADD CONSTRAINT [FK_ExcepcionesxGrupoTipoEndoso_Compania] FOREIGN KEY ([compania_id]) REFERENCES [dbo].[Compania] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

