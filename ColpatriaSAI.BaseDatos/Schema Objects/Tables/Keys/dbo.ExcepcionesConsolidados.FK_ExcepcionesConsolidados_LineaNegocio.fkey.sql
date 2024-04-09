ALTER TABLE [dbo].[ExcepcionesConsolidados]
    ADD CONSTRAINT [FK_ExcepcionesConsolidados_LineaNegocio] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

