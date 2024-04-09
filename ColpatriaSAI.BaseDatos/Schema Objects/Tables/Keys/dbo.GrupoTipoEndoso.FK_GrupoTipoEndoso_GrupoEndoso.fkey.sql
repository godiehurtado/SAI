ALTER TABLE [dbo].[GrupoTipoEndoso]
    ADD CONSTRAINT [FK_GrupoTipoEndoso_GrupoEndoso] FOREIGN KEY ([grupoEndoso_id]) REFERENCES [dbo].[GrupoEndoso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

