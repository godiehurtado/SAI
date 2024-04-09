ALTER TABLE [dbo].[Comision]
    ADD CONSTRAINT [FK_comision_lineaNegocio] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

