ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_lineanegocio_recaudo] FOREIGN KEY ([lineaNegocio_id]) REFERENCES [dbo].[LineaNegocio] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

