ALTER TABLE [dbo].[ConsolidadoMes]
    ADD CONSTRAINT [FK_lineaNegocio_ConsolidadoMes] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

