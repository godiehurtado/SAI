ALTER TABLE [dbo].[Negocio]
    ADD CONSTRAINT [FK_Negocio_Lineanegocio] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

