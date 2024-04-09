ALTER TABLE [dbo].[Recaudo]
    ADD CONSTRAINT [FK_tipoRecaudo_recaudo] FOREIGN KEY ([tipoRecaudo_id]) REFERENCES [dbo].[TipoRecaudo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

