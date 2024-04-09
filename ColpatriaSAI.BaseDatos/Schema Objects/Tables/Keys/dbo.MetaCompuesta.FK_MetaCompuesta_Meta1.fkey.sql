ALTER TABLE [dbo].[MetaCompuesta]
    ADD CONSTRAINT [FK_MetaCompuesta_Meta1] FOREIGN KEY ([metaDestino_id]) REFERENCES [dbo].[Meta] ([id]) ON DELETE NO ACTION ON UPDATE NO ACTION;

