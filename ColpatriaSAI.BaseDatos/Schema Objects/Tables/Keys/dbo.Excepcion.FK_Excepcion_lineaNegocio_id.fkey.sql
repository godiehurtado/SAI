ALTER TABLE [dbo].[Excepcion]
    ADD CONSTRAINT [FK_Excepcion_lineaNegocio_id] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

