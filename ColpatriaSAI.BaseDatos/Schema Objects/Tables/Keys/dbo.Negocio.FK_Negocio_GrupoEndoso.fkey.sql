ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_Negocio_GrupoEndoso] FOREIGN KEY ([grupoEndoso_id]) REFERENCES [dbo].[GrupoEndoso] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

