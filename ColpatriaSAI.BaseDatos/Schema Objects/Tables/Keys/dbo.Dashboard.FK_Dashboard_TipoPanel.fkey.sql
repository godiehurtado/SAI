ALTER TABLE [dbo].[Dashboard]
    ADD CONSTRAINT [FK_Dashboard_TipoPanel] FOREIGN KEY ([tipoPanel_id]) REFERENCES [dbo].[TipoPanel] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;







