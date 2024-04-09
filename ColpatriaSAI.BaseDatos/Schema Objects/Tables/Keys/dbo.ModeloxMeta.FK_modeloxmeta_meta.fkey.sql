ALTER TABLE [dbo].[ModeloxMeta]
    ADD CONSTRAINT [FK_modeloxmeta_meta] FOREIGN KEY ([meta_id]) REFERENCES [dbo].[Meta] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

