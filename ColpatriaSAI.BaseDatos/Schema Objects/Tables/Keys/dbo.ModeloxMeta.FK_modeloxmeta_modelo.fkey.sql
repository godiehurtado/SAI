ALTER TABLE [dbo].[ModeloxMeta]
    ADD CONSTRAINT [FK_modeloxmeta_modelo] FOREIGN KEY ([modelo_id]) REFERENCES [dbo].[Modelo] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

