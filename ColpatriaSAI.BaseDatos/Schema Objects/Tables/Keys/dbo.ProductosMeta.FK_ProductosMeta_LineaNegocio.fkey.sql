ALTER TABLE [dbo].[ProductosMeta]
    ADD CONSTRAINT [FK_ProductosMeta_LineaNegocio] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

