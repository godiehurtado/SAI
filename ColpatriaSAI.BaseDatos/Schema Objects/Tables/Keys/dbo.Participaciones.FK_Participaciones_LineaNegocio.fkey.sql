ALTER TABLE [dbo].[Participaciones]
    ADD CONSTRAINT [FK_Participaciones_LineaNegocio] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

